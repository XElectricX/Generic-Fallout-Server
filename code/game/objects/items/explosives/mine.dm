/*
Mines

Mines use invisible /obj/effect/mine_trigger objects that tell the mine to explode when something crosses over it

Shrapnel-based explosives (like claymores) will not actually hit anything standing on the same tile due to fire_at() not
taking that kind of thing into account, setting buffer_range = 0 or making them pressure activated is useless
*/

/* Flags for mine_features */
///For pressure mines that trigger when something crosses them
#define MINE_PRESSURE_SENSITIVE (1<<0)
///For pressure mines that only trigger when heavy objects cross them
#define MINE_PRESSURE_WEIGHTED (1<<1)
///For mines that only trigger when conscious mobs cross them
#define MINE_DISCERN_LIVING (1<<2)
///For mines that can be disabled by EMPs
#define MINE_ELECTRONIC (1<<3)
///For mines that limit their effects to a specific direction (like claymores)
#define MINE_DIRECTIONAL (1<<4)
///For mines that can have their range changed
#define MINE_CUSTOM_RANGE (1<<5)
///For mines that can be disarmed or interacted with in any way once triggered
#define MINE_INTERRUPTIBLE (1<<6)
///For mines that do not delete themselves upon detonation
#define MINE_REUSABLE (1<<7)
///Record war crimes when deploying this mine
#define MINE_ILLEGAL (1<<8)

///Common flags for most mines; reduce amount of flags needed to copy paste
#define MINE_STANDARD_FLAGS MINE_DISCERN_LIVING|MINE_ELECTRONIC|MINE_INTERRUPTIBLE

/* Flags for volatility; also go under mine_features */
///For mines that detonate when damaged physically (hit by a bullet, slashed, etc.)
#define MINE_VOLATILE_DAMAGE (1<<9)
///For mines that detonate when damaged by fire
#define MINE_VOLATILE_FIRE (1<<10)
///For mines that detonate when damaged by explosions
#define MINE_VOLATILE_EXPLOSION (1<<11)
///For mines that detonate when hit by EMPs
#define MINE_VOLATILE_EMP (1<<12)

//Flags for craftable IED
#define IED_SECURED (1<<0)
#define IED_WIRED (1<<1)
#define IED_CONNECTED (1<<2)
#define IED_FINISHED IED_SECURED|IED_WIRED|IED_CONNECTED

/obj/item/mine
	name = "not a real mine"
	desc = "Dummy object. Otherwise changing stats on the parent item would cause chaos/tedium every time."
	icon = 'icons/obj/items/mine.dmi'
	icon_state = "proximity"
	resistance_flags = XENO_DAMAGEABLE
	flags_atom = CONDUCT
	w_class = WEIGHT_CLASS_SMALL
	max_integrity = 100
	force = 5
	throwforce = 5
	throw_range = 6
	throw_speed = 3
	flags_atom = CONDUCT
	///IFF signal - used to determine friendly units
	var/iff_signal = NONE
	///If the mine has been triggered
	var/triggered = FALSE
	///State of the mine. Will the mine explode or not
	var/armed = FALSE
	///List of references to each dummy object that serve as triggers for this mine
	var/list/triggers = list()
	///Stored reference to the duration timer that leads to self-deletion; can be modified or stopped once started
	var/deletion_timer

	/* -- Gameplay data -- */
	///Message sent to nearby players when this mine is triggered; "The [name] [message]"
	var/detonation_message = "screams for the sweet release of death."
	///Sound played when the mine is triggered
	var/detonation_sound = 'sound/weapons/mine_tripped.ogg'
	///How many tiles around/in front of itself will trigger detonation
	var/range = 0
	///How many tiles around/in front of itself before it starts detecting; at 0, you can trigger the tile the mine is on
	var/buffer_range = 0
	///Determines how wide the cone for detecting victims is
	var/angle = 0
	///How long this mine is active once detonated; for things like slow or radiation fields; set to -1 if it stays active until prompted
	var/duration = 0
	///Time before the mine explodes
	var/detonation_delay = 0
	///Time it takes to disable this mine
	var/disarm_delay = 0
	///Time it takes to turn off and pack up a mine
	var/undeploy_delay = 0
	///Time it takes to set up a mine
	var/deploy_delay = 0
	///Flags for what this mine can do; see top of mine.dm for defines
	var/mine_features = MINE_STANDARD_FLAGS

	/* -- Explosion data -- */
	///How large the devestation impact is
	var/uber_explosion_range = 0
	///How large the heavy impact is
	var/heavy_explosion_range = 0
	///How large the light impact is
	var/light_explosion_range = 0
	///How large the weak impact is
	var/weak_explosion_range = 0
	///How far away a player can be to be blinded by the explosion
	var/blinding_range = 0
	///How far away objects are thrown
	var/launch_distance = 0
	///Color of the explosion
	var/explosion_color = LIGHT_COLOR_LAVA	//Default used by explosions
	///Radius of how far flames are spawned
	var/fire_range = 0
	///How long the spawned fire will stay alight on a tile
	var/fire_intensity = 0
	///How long a mob keeps burning
	var/fire_duration = 0
	///How much damage is inflicted when a mob enters the fire tile
	var/fire_damage = 0
	///How intense the fire burns on a mob over time; higher number means higher damage initially
	var/fire_stacks = 0
	///Color of the flames; either red, blue, or green
	var/fire_color = "red"
	///The ammo datum used for this mine's shrapnel
	var/shrapnel_type = null
	///How far the shrapnel can go before it is deleted
	var/shrapnel_range = 0
	///Type of smoke to spawn
	var/datum/effect_system/smoke_spread/gas_type = null
	///Radius of the mine's smoke cloud
	var/gas_range = 0
	///How long the gas cloud remains; do not use SECONDS as it is used by the smoke object's process(), which is called roughly every second
	var/gas_duration = 0

/obj/item/mine/Initialize(mapload)
	. = ..()
	if(!buffer_range || CHECK_BITFIELD(mine_features, MINE_PRESSURE_SENSITIVE|MINE_PRESSURE_WEIGHTED))
		var/static/list/connections = list(COMSIG_ATOM_ENTERED = PROC_REF(on_cross))
		AddElement(/datum/element/connect_loc, connections)

/obj/item/mine/Destroy()
	delete_detection_zone()
	return ..()

/obj/item/mine/examine(mob/user)
	. = ..()
	if(CHECK_BITFIELD(mine_features, MINE_CUSTOM_RANGE))
		. += "[span_bold("Alt Click")] to change the detection range."
	if(armed)
		. += span_warning("It is active!")

///Update the icon, adding "_armed" or "_deployed" (or nothing if not planted)
/obj/item/mine/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][anchored ? (armed ? "_armed" : "_deployed") : ""]"

/obj/item/mine/AltClick(mob/user)
	if(armed)
		balloon_alert(user, "Undeploy [src] to adjust range!")
		return FALSE
	if(!can_interact(user))
		return FALSE
	var/new_range = tgui_input_number(user, "Input the detection range of [src] in tiles, up to 7", "Set Range", range, 7, 1)
	//Check if the user is still near this mine or if a value was provided; also make sure the mine isn't already planted
	if(!new_range || armed || !can_interact(user))
		return FALSE
	range = new_range

/obj/item/mine/attack_self(mob/living/user)
	. = ..()
	setup(user)

///Runs the checks for attempting to deploy a mine
/obj/item/mine/proc/setup(mob/living/user)
	if(!user.loc || user.loc.density)
		balloon_alert(user, "No space!")
		return FALSE
	if(locate(/obj/item/mine) in get_turf(src))
		balloon_alert(user, "Already a mine here!")
		return FALSE
	if(armed || triggered)	//Just in case
		return FALSE
	if(!do_after(user, deploy_delay, NONE, src, BUSY_ICON_BUILD))
		return FALSE

	//Probably important to keep this logged, just in case
	visible_message(span_notice("[user] deploys a [src]."))
	var/obj/item/card/id/id = user.get_idcard()
	deploy(user, id?.iff_signal)
	user.record_traps_created()
	if(CHECK_BITFIELD(mine_features, MINE_ILLEGAL) && user)
		user.record_war_crime()
	return TRUE

///Process for arming the mine; anchoring, setting who it belongs to, generating the trigger zones
/obj/item/mine/proc/deploy(mob/living/user, faction)
	iff_signal = faction
	anchored = TRUE
	armed = TRUE
	playsound(src.loc, 'sound/weapons/mine_armed.ogg', 25, 1)

	if(user)
		user.temporarilyRemoveItemFromInventory(src)
		forceMove(drop_location())
		setDir(user.dir)
	else
		setDir(pick(CARDINAL_DIRS))

	generate_detection_zone()
	update_icon()

/obj/item/mine/attack_hand(mob/living/user)
	. = ..()
	if(anchored || armed)
		undeploy(user)
	if(.)
		return

///Required checks before a mine is turned off and packed up
/obj/item/mine/proc/undeploy(mob/living/user)
	if(triggered && !CHECK_BITFIELD(mine_features, MINE_INTERRUPTIBLE))
		balloon_alert(user, "Too late, run!")
		return FALSE

	if(iff_signal)	//Has to actually be registered with a faction, otherwise it's hostile to everyone!
		var/obj/item/card/id/id_card = user.get_idcard()
		if(id_card && id_card.iff_signal == iff_signal)
			if(undeploy_delay && !do_after(user, undeploy_delay, TRUE, src))
				return FALSE
			//The brain damaged and blind are likely to fumble it
			if((user.brainloss > BRAIN_DAMAGE_MILD && prob(user.brainloss)) || (user.eye_blind && prob(50)))
				visible_message(span_alert("[user] accidentally set off [src]!"), \
				span_alert("You pressed the wrong button, dumb ass."))
				trigger_explosion(user)
				return
			disarm()
			return

	balloon_alert(user, "Must be defused!")

/obj/item/mine/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(ismultitool(I))
		bomb_defusal(user)	//Sweaty palms time

///The process for trying to disarm a mine
/obj/item/mine/proc/bomb_defusal(mob/user)
	if(triggered && !CHECK_BITFIELD(mine_features, MINE_INTERRUPTIBLE))
		balloon_alert(user, "Can't disarm this, run!")
		return FALSE

	//Mine defusal time is de/increased by 1 second per skill point
	var/skill_issue = max(disarm_delay - user.skills.getRating(SKILL_ENGINEER) + SKILL_ENGINEER_ENGI, 0)

	//Chance for failure below; only /living/ types can be checked for brain damage
	var/mob/living/living = isliving(user) ? user : null
	var/extra_failure_risk = living ? living.brainloss : 0

	if(skill_issue)	//If you got the time down to 0, you can just skip this whole disarming process you smart egg!
		if(user.skills.getRating(SKILL_ENGINEER) >= SKILL_ENGINEER_ENGI)
			user.visible_message(span_notice("[user] starts disarming [src]."), \
			span_notice("You start disarming [src]."))
		else if(user.skills.getRating(SKILL_ENGINEER) == SKILL_ENGINEER_DEFAULT)
			user.visible_message(span_warning("[user] is about to do something stupid!"), \
			span_warning("You are about to get yourself killed."))
			extra_failure_risk += 50	//Just add a flat 50% chance of failure if you're completely unskilled
		else
			user.visible_message(span_notice("[user] visibly struggles to disarm [src]."), \
			span_notice("You try your best to disarm [src]."))

		if(!do_after(user, skill_issue, TRUE, src, skill_issue > disarm_delay ? BUSY_ICON_UNSKILLED : BUSY_ICON_BUILD))
			user.visible_message(span_notice("[user] stops disarming [src]."), \
			span_notice("You stop disarming [src]."))
			return FALSE

	if(prob(extra_failure_risk))
		user.visible_message(span_alert("[user] accidentally set off [src]!"), \
		span_alert("You failed to disarm [src]!"))
		trigger_explosion(user)
		return

	//Let everyone know a mine was disarmed, but no need to log it to chat
	balloon_alert_to_viewers("[src] disarmed")
	disarm(user)

///Turns off the mine
/obj/item/mine/proc/disarm()
	if(!CHECK_BITFIELD(mine_features, MINE_REUSABLE) && deletion_timer)	//Non-reuseable mine already doing it's thing? Deletion upon disarming then
		qdel(src)
		return

	armed = FALSE
	anchored = FALSE
	triggered = FALSE	//Good job, you managed to disarm it before it blew
	update_icon()
	delete_detection_zone()
	if(deletion_timer)
		deltimer(deletion_timer)

///Generate the trigger zones for the mine
/obj/item/mine/proc/generate_detection_zone()
	if(!range)
		return

	if(length(triggers))
		delete_detection_zone()

	var/list/trigger_turfs = generate_true_cone(get_turf(src), range, buffer_range, angle, dir2angle(dir), bypass_xeno = TRUE, air_pass = TRUE)
	for(var/turf/T in trigger_turfs)
		var/obj/effect/mine_trigger/tripwire = new /obj/effect/mine_trigger(T)
		tripwire.linked_mine = src
		triggers += tripwire

///Delete the trigger zones for the mine
/obj/item/mine/proc/delete_detection_zone()
	if(!length(triggers))
		return

	QDEL_LIST(triggers)

///Checks if a mob entered the tile this mine is on, and if it can cause it to trigger
/obj/item/mine/proc/on_cross(datum/source, atom/movable/AM, oldloc, oldlocs)
	if(AM.status_flags & INCORPOREAL)	//Don't let ghosts trigger them
		return FALSE

	var/mob/living/crosser = isliving(AM) ? AM : null
	if(CHECK_BITFIELD(mine_features, MINE_DISCERN_LIVING))	//If only conscious mobs can trigger this mine, run the appropriate checks
		if(!crosser)
			return FALSE
		if(crosser.stat)
			return FALSE

	if(CHECK_BITFIELD(mine_features, MINE_PRESSURE_SENSITIVE|MINE_PRESSURE_WEIGHTED))
		//Flying mobs can't trip this mine
		if(CHECK_MULTIPLE_BITFIELDS(AM.pass_flags, HOVERING))
			return FALSE

		if(CHECK_BITFIELD(mine_features, MINE_PRESSURE_WEIGHTED))
			//Maybe do some exercise and you won't trip mines so easily
			if(crosser)
				var/mob/living/carbon/possible_fatty = iscarbon(crosser) ? crosser : null
				if(crosser.mob_size < MOB_SIZE_BIG || possible_fatty?.nutrition >= NUTRITION_OVERFED)
					return FALSE

			//Only heavy objects can trip this mine (or a structure)
			else if(isitem(AM))
				var/obj/item/object = AM
				if(object.w_class < WEIGHT_CLASS_HUGE)
					return FALSE

	//All crossing conditions met, run the triggering-related checks
	trip_mine(AM)

///Process for triggering detonation
/obj/item/mine/proc/trip_mine(atom/movable/victim)
	if(!armed || triggered)
		return FALSE

	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		var/obj/item/card/id/id_card = human_victim.get_idcard()
		if(id_card?.iff_signal == iff_signal)
			return FALSE

	else if(isvehicle(victim))
		var/obj/vehicle/vehicle_victim = victim
		if(vehicle_victim.iff_signal == iff_signal)
			return FALSE

	trigger_explosion(victim)

///Trigger the mine; needs to be a separate proc so that we can use a timer
/obj/item/mine/proc/trigger_explosion(atom/movable/victim)
	if(triggered)
		return FALSE

	triggered = TRUE
	if(detonation_message)
		visible_message(span_danger("[icon2html(src, viewers(src))] \The [src] [detonation_message]"))
	playsound(loc, detonation_sound, 50, sound_range = 7)
	if(detonation_delay)
		addtimer(CALLBACK(src, PROC_REF(explode)), detonation_delay)
		return
	explode(victim)

///Proc that actually causes the explosion
/obj/item/mine/proc/explode(atom/movable/victim)
	if(!triggered)
		return FALSE

	if(light_explosion_range || heavy_explosion_range || uber_explosion_range || weak_explosion_range)
		//Directional-based explosives (like claymores) will spawn the explosion in front instead of on themselves
		explosion((CHECK_BITFIELD(mine_features, MINE_DIRECTIONAL)) ? get_step(src, dir) : loc, \
		uber_explosion_range, heavy_explosion_range, light_explosion_range, weak_explosion_range, \
		blinding_range, throw_range = launch_distance, color = explosion_color)

	if(fire_range)
		flame_radius(fire_range, (CHECK_BITFIELD(mine_features, MINE_DIRECTIONAL)) ? get_step(src, dir) : loc, \
		fire_intensity, fire_duration, fire_damage, fire_stacks, colour = fire_color)

	if(shrapnel_range && shrapnel_type)	//Spawn projectiles, their associated data, and then launch it the direction it is facing
		var/obj/projectile/projectile_to_fire = new /obj/projectile(get_turf(src))
		projectile_to_fire.generate_bullet(shrapnel_type)
		projectile_to_fire.fire_at(get_step(src, dir), null, src, shrapnel_range, projectile_to_fire.ammo.shell_speed)

	if(gas_type && gas_duration)
		var/datum/effect_system/smoke_spread/smoke = new gas_type()
		playsound(src, 'sound/effects/smoke.ogg', 25, 1, gas_range + 2)
		smoke.set_up(gas_range, get_turf(src), gas_duration)
		smoke.start()

	//If this is a mine that causes effects over time, call extra_effects() and set timers before deletion/disarming
	if(duration || duration < 0)
		extra_effects(victim)
		if(duration > 0)
			if(CHECK_BITFIELD(mine_features, MINE_REUSABLE))
				return deletion_timer = addtimer(CALLBACK(src, PROC_REF(disarm)), duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
			return deletion_timer = addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(qdel), src), duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
		return TRUE	//Don't stop

	//Reusable mines do not delete themselves upon detonation, just go back to sleep
	if(CHECK_BITFIELD(mine_features, MINE_REUSABLE))
		return disarm()

	delete_detection_zone()
	qdel(src)

///Shove any code for special effects caused by this mine here
/obj/item/mine/proc/extra_effects(atom/movable/victim)
	return

///If this mine is volatile, explode! See top of mine.dm for volatility flags
/obj/item/mine/proc/volatility_check(flag)
	if(CHECK_BITFIELD(mine_features, flag))
		//Let's make sure everyone knows it was not activated by normal circumstances
		visible_message(span_danger("[icon2html(src, viewers(src))] \The [src]'s detonation mechanism is accidentally triggered!"))
		trigger_explosion()

//On explosion, mines trigger their own explosion, assuming they were not deleted straight away (larger explosions or probability)
/obj/item/mine/ex_act(severity)
	. = ..()
	if(QDELETED(src) || !armed)
		return

	//Only heavy and light explosions can cause a detonation, and depending on RNG
	if(severity == EXPLODE_DEVASTATE || (severity == EXPLODE_HEAVY && prob(25)) || (severity == EXPLODE_LIGHT && prob(50)) || severity == EXPLODE_WEAK)
		return

	volatility_check(MINE_VOLATILE_EXPLOSION)

//Fire will cause mines to trigger their explosion
/obj/item/mine/flamer_fire_act(burnlevel)
	volatility_check(MINE_VOLATILE_FIRE)

/obj/item/mine/fire_act()
	volatility_check(MINE_VOLATILE_FIRE)

/obj/item/mine/take_damage(damage_amount, damage_type, damage_flag, effects, attack_dir, armour_penetration, mob/living/blame_mob)
	if(damage_amount)	//Only do this if the mine actually took damage; run it before damage is dealt in case it destroys the mine
		volatility_check(MINE_VOLATILE_DAMAGE)
	return ..()

//Any EMP effects will render electronic mines disabled, or trigger them if they are volatile
/obj/item/mine/emp_act(severity)
	if(CHECK_BITFIELD(mine_features, MINE_VOLATILE_EMP))
		trigger_explosion()
	else if(CHECK_BITFIELD(mine_features, MINE_ELECTRONIC))
		disarm()

///Act as dummy objects that detects if something touched it, causing the linked mine to detonate
/obj/effect/mine_trigger
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon_state = "blocker"	//For debugging; comment out the invisibility var below to see mine sensor zones
	invisibility = INVISIBILITY_MAXIMUM
	///The explosive this dummy object is connected to
	var/obj/item/mine/linked_mine

/obj/effect/mine_trigger/Initialize(mapload)
	. = ..()
	var/static/list/connections = list(COMSIG_ATOM_ENTERED = PROC_REF(on_cross))
	AddElement(/datum/element/connect_loc, connections)
	RegisterSignal(loc, COMSIG_TURF_CHANGE, PROC_REF(on_turf_change))

/obj/effect/mine_trigger/Destroy()
	linked_mine = null
	return ..()

///If the turf this trigger is on changes, update the detection zones to prevent orphaned triggers
/obj/effect/mine_trigger/proc/on_turf_change()
	SIGNAL_HANDLER
	linked_mine.generate_detection_zone()

///When crossed, triggers the linked mine if checks pass
/obj/effect/mine_trigger/proc/on_cross(datum/source, atom/movable/AM, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(!linked_mine)	//If this doesn't belong to a mine, why does this object exist?!
		qdel(src)
		return
	if(linked_mine.triggered) //Mine is already set to go off
		return FALSE
	if(CHECK_BITFIELD(linked_mine.mine_features, MINE_DISCERN_LIVING))	//If only mobs can trigger the mine this belongs to, check if they are conscious
		if(!isliving(AM))
			return FALSE
		var/mob/living/unlucky_person = AM
		if(unlucky_person.stat)
			return FALSE
	linked_mine.trip_mine(AM)

/* Claymores - Directional fragment spray, small explosion */
/obj/item/mine/claymore
	name = "\improper M20 Claymore anti-personnel mine"
	desc = "The M20 Claymore is a directional proximity triggered anti-personnel mine designed by Armat Systems for use by the TerraGov Marine Corps."
	icon_state = "m20"
	detonation_message = "makes a loud click."
	range = 3
	buffer_range = 1
	angle = 110
	disarm_delay = 1 SECONDS
	undeploy_delay = 2 SECONDS
	deploy_delay = 2 SECONDS
	light_explosion_range = 2
	shrapnel_type = /datum/ammo/bullet/claymore_shrapnel
	shrapnel_range = 5
	mine_features = MINE_STANDARD_FLAGS|MINE_DIRECTIONAL

/obj/item/mine/claymore/pmc
	name = "\improper M20P Claymore anti-personnel mine"
	desc = "The M20P Claymore is a directional proximity triggered anti-personnel mine designed by Armat Systems for use by the TerraGov Marine Corps. It has been modified for use by the NT PMC forces."
	icon_state = "m20p"
	range = 6
	angle = 60
	shrapnel_type = /datum/ammo/bullet/claymore_shrapnel/pmc
	shrapnel_range = 8

/* Land mines - explode when something walks on or near it */
/obj/item/mine/proximity
	name = "proximity mine"
	desc = "Detonates when it detects a nearby hostile."
	detonation_message = "beeps rapidly."
	detonation_sound = 'sound/machines/triple_beep.ogg'
	range = 3
	angle = 360
	detonation_delay = 1 SECONDS
	disarm_delay = 3 SECONDS
	undeploy_delay = 1 SECONDS
	deploy_delay = 1 SECONDS
	light_explosion_range = 2
	weak_explosion_range = 3
	blinding_range = 1
	launch_distance = 1
	mine_features = MINE_STANDARD_FLAGS|MINE_VOLATILE_DAMAGE|MINE_VOLATILE_FIRE|MINE_VOLATILE_EXPLOSION

/obj/item/mine/pressure
	name = "land mine"
	desc = "Pressure activated high explosive. Watch your step."
	icon_state = "pressure"
	detonation_message = "whirs and clicks. Run."
	max_integrity = 250
	detonation_delay = 0.5 SECONDS
	disarm_delay = 5 SECONDS
	undeploy_delay = 3 SECONDS
	deploy_delay = 3 SECONDS
	uber_explosion_range = 1
	heavy_explosion_range = 3
	blinding_range = 1
	launch_distance = 5
	mine_features = MINE_PRESSURE_SENSITIVE

/obj/item/mine/pressure/anti_tank
	name = "\improper M92 Valiant anti-tank mine"
	desc = "The M92 Valiant is a anti-tank mine designed by Armat Systems for use by the TerraGov Marine Corps against heavy armour, both tanks and mechs."
	icon_state = "m92"
	uber_explosion_range = 2
	heavy_explosion_range = 3
	weak_explosion_range = 4
	mine_features = MINE_PRESSURE_WEIGHTED|MINE_VOLATILE_EXPLOSION

/obj/item/mine/pressure/anti_tank/update_icon_state()
	. = ..()
	alpha = armed ? 50 : 255

/obj/item/mine/incendiary
	name = "napalm mine"
	desc = "Incendiary mine variant with a napalm-based formula. Very sticky."
	icon_state = "incendiary"
	detonation_message = "hisses, releasing an inferno."
	detonation_sound = 'sound/weapons/guns/fire/tank_flamethrower.ogg'
	range = 3
	disarm_delay = 2 SECONDS
	undeploy_delay = 1 SECONDS
	deploy_delay = 1 SECONDS
	fire_range = 4
	fire_intensity = 10 SECONDS
	fire_duration = 4 SECONDS
	fire_damage = 10
	fire_stacks = 10
	fire_color = "green"
	mine_features = MINE_DISCERN_LIVING|MINE_ELECTRONIC|MINE_VOLATILE_DAMAGE|MINE_VOLATILE_FIRE|MINE_VOLATILE_EXPLOSION

/* Improvised explosives - You craft them */
/obj/item/mine/ied
	name = "pipe mine"
	desc = "Cobbled together from a metal pipe, gunpowder, rods, cables, and a proximity sensor. The people's mine."
	icon_state = "pipe"
	detonation_message = "clicks and rattles."
	detonation_sound = 'sound/machines/triple_beep.ogg'
	range = 2
	angle = 360
	detonation_delay = 0.5 SECONDS
	disarm_delay = 1 SECONDS
	undeploy_delay = 2 SECONDS
	deploy_delay = 2 SECONDS
	shrapnel_type = /datum/ammo/bullet/claymore_shrapnel/nail
	shrapnel_range = 4
	//I know they technically are electronic with the proximity sensor but it's probably more fun if not EMP'able since they're practically junk
	mine_features = MINE_INTERRUPTIBLE|MINE_VOLATILE_DAMAGE|MINE_VOLATILE_FIRE|MINE_VOLATILE_EXPLOSION

	///Stages of assembly; see top of file for the flags
	var/assembly_steps_completed = NONE
	///How much gunpowder is needed for the mine to be operational
	var/gunpowder_amount_required = 20
	///How much gunpowder is in the mine
	var/gunpowder_amount = 0
	///How many rods are needed for the mine to be operational
	var/rods_amount_required = 4
	///How many rods have been added to this mine
	var/rods_amount = 0

/obj/item/mine/ied/examine(mob/user)
	. = ..()
	if(gunpowder_amount < gunpowder_amount_required)
		. += "Currently has [span_bold("[gunpowder_amount]")] out of [span_bold("[gunpowder_amount_required]")] gunpowder."
	if(rods_amount < rods_amount_required)
		. += "Currently has [span_bold("[rods_amount]")] out of [span_bold("[rods_amount_required]")] rods."

/obj/item/mine/ied/update_overlays()
	. = ..()
	cut_overlays()
	//Only add the wires if not deployed, don't need the overlay for that
	if(CHECK_BITFIELD(assembly_steps_completed, IED_WIRED) && !anchored)
		var/image/wires_overlay = image(icon, src, "wires")
		add_overlay(wires_overlay)

/obj/item/mine/ied/setup(mob/living/user)
	if(!CHECK_MULTIPLE_BITFIELDS(assembly_steps_completed, IED_FINISHED) || gunpowder_amount < gunpowder_amount_required || rods_amount < rods_amount_required)
		balloon_alert(user, "Not finished!")
		return FALSE
	return ..()

/obj/item/mine/ied/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(iscablecoil(I))
		if(CHECK_BITFIELD(assembly_steps_completed, IED_WIRED))
			balloon_alert(user, "Already wired!")
			return

		var/obj/item/stack/cable_coil/cables = I
		if(!cables.use(1))
			balloon_alert(user, "Not enough cables!")
			return

		ENABLE_BITFIELD(assembly_steps_completed, IED_WIRED)
		update_icon_state()
		balloon_alert(user, "Wired!")
		return

	if(istype(I, /obj/item/ammo_magazine/handful))
		//Marines can no longer use chem machines to make gunpowder, so we're going to apply a simple mechanic of recycling bullets
		if(gunpowder_amount >= gunpowder_amount_required)
			balloon_alert(user, "Already full!")
			return

		var/obj/item/ammo_magazine/handful/bullets = I
		if(bullets.current_rounds < 1)
			balloon_alert(user, "Not enough gunpowder!")
			return

		//The gunpowder to bullet ratio is 1:1, so using something like bullets from your rifle are straightforward
		//However, shotgun shells are packed with a lot more so they have a multiplier; 4 gunpowder from each shotgun shell
		var/caliber_bonus = 1
		if(bullets.caliber == CALIBER_12G || bullets.caliber == CALIBER_410)
			caliber_bonus = 4

		var/amount_to_transfer = min(bullets.current_rounds * caliber_bonus, gunpowder_amount_required - gunpowder_amount)
		bullets.current_rounds -= ROUND_UP(amount_to_transfer/caliber_bonus)	//Round up instead of down since you're not summoning gunpowder out of thin air
		gunpowder_amount += amount_to_transfer
		if(!bullets.current_rounds)	//Delete the handful stack if we used it all
			qdel(bullets)
		balloon_alert(user, gunpowder_amount == gunpowder_amount_required ? "Full!" : "[gunpowder_amount]/[gunpowder_amount_required] powder!")
		return

	if(istype(I, /obj/item/stack/rods))
		if(rods_amount >= rods_amount_required)
			balloon_alert(user, "Already full!")
			return

		var/obj/item/stack/rods = I
		var/amount_to_transfer = max(1, min(rods.amount, rods_amount_required - rods_amount))
		if(!rods.use(amount_to_transfer))
			balloon_alert(user, "Not enough rods!")
			return

		rods_amount += amount_to_transfer
		balloon_alert(user, rods_amount == rods_amount_required ? "Full!" : "[rods_amount]/[rods_amount_required] rods!")
		return

/obj/item/mine/ied/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(CHECK_BITFIELD(assembly_steps_completed, IED_SECURED))
		balloon_alert(user, "Already secured!")
		return
	ENABLE_BITFIELD(assembly_steps_completed, IED_SECURED)
	balloon_alert(user, "Secured!")
	return

/obj/item/mine/ied/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(!CHECK_BITFIELD(assembly_steps_completed, IED_WIRED))
		balloon_alert(user, "Not wired!")
		return
	if(CHECK_BITFIELD(assembly_steps_completed, IED_CONNECTED))
		balloon_alert(user, "Already connected!")
		return
	ENABLE_BITFIELD(assembly_steps_completed, IED_CONNECTED)
	balloon_alert(user, "Connected!")

/obj/item/mine/ied/assembled
	assembly_steps_completed = IED_FINISHED

/obj/item/mine/ied/assembled/Initialize(mapload)
	. = ..()
	gunpowder_amount = gunpowder_amount_required
	rods_amount = rods_amount_required
	update_icon_state()

/* Exotic mines - Rather than just explode, these have special effects */
/obj/item/mine/radiation
	name = "\improper MOPe radiation mine"
	desc = "The Marine Operation Penalizer irradiates the surrounding area when triggered. Uses sheets of uranium as a source of fuel. More fuel increases the range of the radiation field."
	icon_state = "radiation"
	detonation_message = "clicks, emitting a low hum."
	range = 2
	duration = 30 SECONDS
	disarm_delay = 5 SECONDS
	undeploy_delay = 4 SECONDS	//You turn it off veeeery carefully
	deploy_delay = 2 SECONDS
	mine_features = MINE_STANDARD_FLAGS|MINE_REUSABLE|MINE_ILLEGAL|MINE_VOLATILE_DAMAGE|MINE_VOLATILE_EXPLOSION
	///Base damage of the radiation pulse, and determines severity of effects; see extra_effects()
	var/radiation_damage = 20
	///How many more times the mine pulses out radiation and refreshes the radiation field
	var/number_of_pulses = 3
	///How many units of fuel are inside; each unit is 1 tile of range
	var/current_fuel = 0
	///The maximum capacity of fuel units
	var/max_fuel = 10
	///Stored reference to the timer that determines when extra_effects() is called again
	var/pulse_timer

	//Light-related vars for when the radiation glow is emitted
	light_power = 10
	light_color = COLOR_GREEN
	light_system = HYBRID_LIGHT
	light_mask_type = /atom/movable/lighting_mask/flicker

/obj/item/mine/radiation/examine(mob/user)
	. = ..()
	. += "Currently has [span_bold("[current_fuel]")] out of [span_bold("[max_fuel]")] fuel."

/obj/item/mine/radiation/attackby(obj/item/I, mob/user, params)
	. = ..()
	//While we could use a var/fuel_type instead of hard coded to use uranium, it would be a headache since only /stack/ use amount vars
	//Also no other /stack/ type apart from maybe phoron would be a good fuel candidate so why bother
	if(istype(I, /obj/item/stack/sheet/mineral/uranium))
		if(current_fuel >= max_fuel)
			balloon_alert(user, "Already full!")
			return

		var/obj/item/stack/uranium = I
		var/amount_to_transfer = max(1, min(uranium.amount, max_fuel - current_fuel))
		if(uranium.use(amount_to_transfer))
			balloon_alert(user, "Not enough fuel!")
			return

		current_fuel += amount_to_transfer
		balloon_alert(user, current_fuel == max_fuel ? "Full!" : "[current_fuel]/[max_fuel] fuel!")
		return

/obj/item/mine/radiation/disarm()
	if(triggered)
		current_fuel = 0	//In the event of disarmament when already detonated, have the fuel be already expended
	deltimer(pulse_timer)
	light_range = 0	//Hybrid lights don't actually turn off, just have to change light_range
	return ..()

/obj/item/mine/radiation/trip_mine(atom/movable/victim)
	if(!current_fuel)
		return FALSE
	return ..()

/obj/item/mine/radiation/explode(atom/movable/victim)
	. = ..()
	if(!.)
		return FALSE
	//The deletion_timer lasts a second longer so that the last pulse can go off before qdel()
	deletion_timer = addtimer(CALLBACK(src, PROC_REF(disarm)), duration + 1 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

/obj/item/mine/radiation/extra_effects(atom/movable/victim)
	if(!current_fuel)	//While this should NEVER happen, just in case
		current_fuel = 1	//I would normally have it be disarmed but this mine is not reusable, so just let it continue as normal
	new /obj/effect/temp_visual/shockwave(get_turf(src), current_fuel * 1.5)
	light_range = current_fuel * 1.5
	set_light(light_range, light_power, light_color)
	var/list/exclusion_zone = circle_range(get_turf(src), current_fuel)	//Radiation passes through walls
	for(var/mob/living/carbon/radiation_victim in exclusion_zone)
		//Apply initial damages of the detonation evenly in BURN and TOX, then do a fifth of it in cellular damage
		radiation_victim.apply_damages(0, radiation_damage/2, radiation_damage/2, 0, radiation_damage/5, ishuman(radiation_victim) ? pick(GLOB.human_body_parts) : null, BIO)
		radiation_victim.adjust_stagger(radiation_damage/5 SECONDS)
		radiation_victim.adjust_radiation(radiation_damage SECONDS)
	for(var/turf/irradiated_turf in exclusion_zone)
		//Delete them before the next pulse otherwise the exclusion_zone list will be gigantic
		new /obj/effect/temp_visual/radiation(irradiated_turf, (duration/number_of_pulses) - 1)
	pulse_timer = addtimer(CALLBACK(src, PROC_REF(extra_effects)), duration/number_of_pulses, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

/obj/item/mine/radiation/fueled
	current_fuel = 10

/obj/effect/temp_visual/radiation
	randomdir = FALSE
	///How much damage each tick does
	var/radiation_damage = 10
	///Reference to the radiation particle effect
	var/obj/effect/abstract/particle_holder/particle_holder

/obj/effect/temp_visual/radiation/Initialize(mapload, effect_duration)
	. = ..()
	//Override the timerid value set on the object; the duration is determined by the radiation mine
	deltimer(timerid)
	timerid = QDEL_IN_STOPPABLE(src, effect_duration)
	particle_holder = new(src, /particles/radiation)
	var/static/list/connections = list(COMSIG_ATOM_ENTERED = PROC_REF(on_cross))
	AddElement(/datum/element/connect_loc, connections)

///Called when an atom enters the tile this radiation effect is on
/obj/effect/temp_visual/radiation/proc/on_cross(datum/source, atom/A, oldloc, oldlocs)
	if(!isliving(A))
		return FALSE
	if(irradiate(A))
		START_PROCESSING(SSobj, src)

/obj/effect/temp_visual/radiation/process()
	if(!irradiate())
		STOP_PROCESSING(SSobj, src)

///Proc to run the radiation effects on mobs that are on the same tile as this radiation effect
/obj/effect/temp_visual/radiation/proc/irradiate(mob/living/crosser)
	var/turf/turf_to_check = get_turf(src)
	var/list/radiation_victims = turf_to_check.contents.Copy()
	var/result = FALSE	//For determining if process() should keep going
	if(crosser)
		radiation_victims.Remove(crosser)	//Remove the crosser from the list, they are already going to take damage
		//Not as punishing if you are just running through a radiation field
		crosser.apply_damage(radiation_damage/2, BURN, ishuman(crosser) ? pick(GLOB.human_body_parts) : null, BIO)
		crosser.adjust_radiation(radiation_damage/5 SECONDS)
		result = TRUE
	for(var/mob/living/victim in radiation_victims)
		victim.apply_damage(radiation_damage, BURN, ishuman(victim) ? pick(GLOB.human_body_parts) : null, BIO)
		victim.adjust_radiation(radiation_damage SECONDS)
		if(isxeno(victim))	//Benos are immune to the radiation status effect so let's just give them a bit of stagger
			victim.adjust_stagger(radiation_damage/5 SECONDS)
		result = TRUE
	return result

//Radiation dust effects
/particles/radiation
	icon = 'icons/effects/particles/generic_particles.dmi'
	icon_state = "cross"
	width = 100
	height = 100
	count = 1000
	spawning = 0.5
	lifespan = 30
	fade = 5
	fadein = 5
	position = generator(GEN_CIRCLE, 10, 10, NORMAL_RAND)
	drift = generator(GEN_VECTOR, list(-0.01, -0.03), list(0.01, 0.03))
	scale = list(0.5, 0.5)
	spin = 5
	color = COLOR_GREEN

/obj/item/mine/shock
	name = "tesla mine"
	desc = "Delivers high voltage arcs of lightning at nearby conductive targets. Can be recharged."
	icon_state = "tesla"
	range = 3
	duration = -1
	disarm_delay = 4 SECONDS
	undeploy_delay = 5 SECONDS
	deploy_delay = 5 SECONDS
	mine_features = MINE_STANDARD_FLAGS|MINE_REUSABLE|MINE_VOLATILE_DAMAGE|MINE_VOLATILE_EMP
	///The internal cell powering it
	var/obj/item/cell/battery
	///How much energy is drained from the internal cell
	var/energy_cost = 100	//Average cell holds 1000, so 10 shots
	///How long between each shot
	var/fire_delay = 0.75 SECONDS
	///Damage dealt per shot
	var/damage = 50

/obj/item/mine/shock/Initialize()
	. = ..()
	if(battery)
		battery = new battery(src)

/obj/item/mine/shock/examine(mob/user)
	. = ..()
	. += span_notice("[battery ? "Battery Charge - [PERCENT(battery.charge/battery.maxcharge)]%" : "No battery installed."]")

/obj/item/mine/shock/attackby(obj/item/I, mob/user, params)
	if(!iscell(I))
		return ..()
	if(battery)
		balloon_alert(user, "Already has one!")
		return
	user.transferItemToLoc(I, src)
	battery = I
	update_icon()

/obj/item/mine/shock/screwdriver_act(mob/living/user, obj/item/I)
	if(!battery)
		return balloon_alert(user, "No battery installed!")
	user.put_in_hands(battery)
	battery = null
	update_icon()

/obj/item/mine/shock/trip_mine(atom/movable/victim)
	if(!battery?.charge)
		return FALSE
	return ..()

/obj/item/mine/shock/extra_effects(atom/movable/victim)
	if(!battery?.charge || battery.charge < energy_cost)
		playsound(loc, 'sound/machines/buzz-sigh.ogg', 50, sound_range = 7)
		balloon_alert_to_viewers("Out of charge!")
		return disarm()

	//Grab a list of nearby objects, shuffle it, then see if they are an eligible victim
	var/target
	var/list/nearby_objects = shuffle(circle_range(src, range))
	nearby_objects -= src	//Prevent the mine from committing suicide

	for(var/atom in nearby_objects)
		if(!check_path(src, atom))	//circle_range() goes through walls, so make sure the target is reachable
			continue

		if(isliving(atom))
			if(ishuman(atom))
				var/mob/living/carbon/human/human_victim = atom
				//Will shock a random body part on humans
				human_victim.apply_damage(damage, BURN, pick(GLOB.human_body_parts), ENERGY)
				target = human_victim
			else
				var/mob/living/living_victim = atom
				living_victim.apply_damage(damage, BURN, blocked = ENERGY)
				target = living_victim
			break

		else if(isobj(atom) && !iseffect(atom))
			var/obj/lightning_rod = atom
			//Prevents targeting things like wiring under floor tiles and makes it so only conductive objects will attract lightning
			if(lightning_rod.invisibility > SEE_INVISIBLE_LIVING || !CHECK_BITFIELD(lightning_rod.flags_atom, CONDUCT))
				continue
			lightning_rod.take_damage(damage, BURN, ENERGY)
			target = lightning_rod
			break

	playsound(loc, "sparks", 100, sound_range = 7)
	if(target)
		beam(target, "lightning[rand(1,12)]", time = 0.25 SECONDS)
		battery.charge -= energy_cost
	addtimer(CALLBACK(src, PROC_REF(extra_effects)), fire_delay)

/obj/item/mine/shock/battery_included
	battery = /obj/item/cell

/* Gas mines - Release smoke clouds on detonation, war crime certified */
/obj/item/mine/tanglefoot
	name = "tanglefoot mine"
	desc = "Releases plasma-draining smoke."
	icon_state = "gas"
	detonation_message = "beeps and hisses, releasing purple vapors."
	range = 2
	duration = 10 SECONDS	//Stays around for a bit venting gas
	detonation_delay = 1.5 SECONDS
	disarm_delay = 5 SECONDS
	undeploy_delay = 3 SECONDS
	deploy_delay = 3 SECONDS
	gas_type = /datum/effect_system/smoke_spread/plasmaloss
	gas_range = 3
	gas_duration = 15
	mine_features = MINE_DISCERN_LIVING|MINE_ELECTRONIC|MINE_ILLEGAL|MINE_VOLATILE_DAMAGE|MINE_VOLATILE_FIRE|MINE_VOLATILE_EXPLOSION

/* Tactical mines - Non-lethal, utility-focused gadgets */
/obj/item/mine/alarm
	name = "\improper S20 Proximity Alarm"
	desc = "The S20 proximity mine serve a different purpose other than exploding. Instead it will announce enemy movements, giving early warning when hostiles approach."
	icon_state = "m20"
	detonation_message = "blares \"Intruder detected!\""
	detonation_sound = 'sound/machines/triple_beep.ogg'
	range = 5
	duration = -1
	undeploy_delay = 0.5 SECONDS
	deploy_delay = 1 SECONDS
	mine_features = MINE_STANDARD_FLAGS|MINE_REUSABLE
	///Internal radio that transmits alerts, spawned on Initialize()
	var/obj/item/radio/radio
	///To prevent spam
	COOLDOWN_DECLARE(alarm_cooldown)
	///Time between alarm messages
	var/cooldown = 2 SECONDS
	///Reference to the unique timer that deletes the minimap icon when done
	var/minimap_timer
	///How long a minimap icon remains
	var/minimap_duration = 7 SECONDS

/obj/item/mine/alarm/Initialize()
	. = ..()
	radio = new(src)
	radio.frequency = FREQ_COMMON	//Frequency argument on talk_into is bugged so making it common by default

/obj/item/mine/alarm/trip_mine(atom/movable/victim)
	if(!COOLDOWN_CHECK(src, alarm_cooldown))
		return
	return ..()

/obj/item/mine/alarm/extra_effects(atom/movable/victim)
	triggered = FALSE	//Reset the mine but not disarm it
	if(!victim)
		return FALSE

	var/mini_icon = "defiler"	//Closest thing to a generic warning icon
	if(isxeno(victim))
		var/mob/living/carbon/xenomorph/beno_victim = victim
		mini_icon = beno_victim.xeno_caste.minimap_icon
	else if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(human_victim.job)
			mini_icon = human_victim.job.minimap_icon

	var/marker_flags
	if(CHECK_BITFIELD(iff_signal, TGMC_LOYALIST_IFF))
		marker_flags |= MINIMAP_FLAG_MARINE
	else	//I have been told ERT factions don't have a minimap anyways
		marker_flags |= MINIMAP_FLAG_MARINE_SOM

	radio.talk_into(src, "ALERT! Hostile/Unknown: [victim.name] | [AREACOORD_NO_Z(src)]")
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, z, marker_flags, mini_icon)
	deltimer(minimap_timer)
	minimap_timer = addtimer(CALLBACK(SSminimaps, TYPE_PROC_REF(/datum/controller/subsystem/minimaps, remove_marker), src), minimap_duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
	COOLDOWN_START(src, alarm_cooldown, cooldown)

/obj/item/mine/alarm/disarm()
	. = ..()
	SSminimaps.remove_marker(src)	//Do a minimap icon removal on being disarmed just in case

/obj/item/mine/emp
	name = "\improper EMP mine"
	desc = "Emits a powerful electromagnetic pulse that disables electronics."
	icon_state = "m20"
	detonation_message = "makes a high pitched whine."
	detonation_sound = 'sound/effects/nightvision.ogg'
	range = 3
	duration = 1.5 SECONDS
	undeploy_delay = 2 SECONDS
	deploy_delay = 2 SECONDS
	mine_features = MINE_STANDARD_FLAGS|MINE_REUSABLE|MINE_CUSTOM_RANGE
	///The internal cell powering it
	var/obj/item/cell/battery

/obj/item/mine/emp/Initialize()
	. = ..()
	if(battery)
		battery = new battery(src)

/obj/item/mine/emp/examine(mob/user)
	. = ..()
	. += span_notice("[battery ? "Battery Charge - [PERCENT(battery.charge/battery.maxcharge)]%" : "No battery installed."]")

/obj/item/mine/emp/attackby(obj/item/I, mob/user, params)
	if(!iscell(I))
		return ..()

	if(battery)
		balloon_alert(user, "There is already a battery installed!")
		return

	user.transferItemToLoc(I, src)
	battery = I
	update_icon()

/obj/item/mine/emp/screwdriver_act(mob/living/user, obj/item/I)
	if(!battery)
		balloon_alert(user, "No battery installed!")
		return

	user.put_in_hands(battery)
	battery = null
	update_icon()

/obj/item/mine/emp/trip_mine(atom/movable/victim)
	if(!battery?.charge)
		return FALSE
	return ..()

/obj/item/mine/emp/extra_effects(atom/movable/victim)
	addtimer(CALLBACK(src, PROC_REF(do_empulse)), duration - 1)	//Make the timer slightly less than duration otherwise it gets disarmed

///Separate proc that performs empulse() if it was not disarmed before the timer was done
/obj/item/mine/emp/proc/do_empulse()
	if(!battery?.charge)
		return FALSE
	if(!triggered)
		return FALSE
	//Find the logarithm of current charge, subtract 2, multiply it to the power of 3, then round down
	//Best formula I could come up with that kept scaling smooth and didn't have extreme highs or lows
	//Standard cell (1k charge) will only affect the tile it is on; a hyper cell (30k charge) will reach 15 tiles
	var/light_emp_range = FLOOR((log(10, battery.charge) - 2) ** 3, 1)
	var/heavy_emp_range = FLOOR(light_emp_range/2, 1)	//Heavy range is half of the light range rounded down
	empulse(get_turf(src), heavy_emp_range, light_emp_range)
	battery.charge = 0	//Detonation always drains the battery completely

/obj/item/mine/emp/battery_included
	battery = /obj/item/cell/high

/obj/item/mine/flash
	name = "flash mine"
	desc = "Blinds nearby enemies when activated."
	icon_state = "flash"
	detonation_message = "clicks."
	range = 4
	duration = -1
	undeploy_delay = 1 SECONDS
	deploy_delay = 1 SECONDS
	mine_features = MINE_STANDARD_FLAGS|MINE_REUSABLE
	///How long to blind a victim
	var/flash_duration = 3 SECONDS
	///The internal cell powering it
	var/obj/item/cell/battery
	///How much energy is drained from the internal cell
	var/energy_cost = 500	//Average cell holds 1000, so has 2 charges
	///To prevent spam
	COOLDOWN_DECLARE(flash_cooldown)
	///Time between alarm messages
	var/cooldown = 3 SECONDS

/obj/item/mine/flash/Initialize()
	. = ..()
	if(battery)
		battery = new battery(src)

/obj/item/mine/flash/examine(mob/user)
	. = ..()
	. += span_notice("[battery ? "Battery Charge - [PERCENT(battery.charge/battery.maxcharge)]%" : "No battery installed."]")

/obj/item/mine/flash/attackby(obj/item/I, mob/user, params)
	if(!iscell(I))
		return ..()

	if(battery)
		balloon_alert(user, "There is already a battery installed!")
		return

	user.transferItemToLoc(I, src)
	battery = I
	update_icon()

/obj/item/mine/flash/screwdriver_act(mob/living/user, obj/item/I)
	if(!battery)
		balloon_alert(user, "No battery installed!")
		return

	user.put_in_hands(battery)
	battery = null
	update_icon()

/obj/item/mine/flash/trip_mine(atom/movable/victim)
	if(!COOLDOWN_CHECK(src, flash_cooldown))
		return FALSE

	if(!battery?.charge)
		return FALSE

	return ..()

/obj/item/mine/flash/extra_effects(atom/movable/victim)
	if(!battery?.charge || battery.charge < energy_cost)
		balloon_alert_to_viewers("Out of charge!")
		return disarm()

	triggered = FALSE	//Reset the mine but not disarm it
	var/turf/epicenter = get_turf(src)
	playsound(epicenter, "flashbang", 65, FALSE, range + 2)

	for(var/mob/living/carbon/bystander in oviewers(range, epicenter))
		if(!HAS_TRAIT(bystander, TRAIT_FLASHBANGIMMUNE))
			bystander.flash_act(duration = flash_duration)

	battery.charge -= energy_cost
	COOLDOWN_START(src, flash_cooldown, cooldown)

/obj/item/mine/flash/battery_included
	battery = /obj/item/cell
