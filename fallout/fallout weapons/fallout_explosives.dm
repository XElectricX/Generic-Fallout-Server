//Allow UBGL to use any grenade
/obj/item/weapon/gun/grenade_launcher/underslung
	allowed_ammo_types = list(/obj/item/explosive/grenade)

//Launchers
/obj/item/weapon/gun/launcher/rocket/fallout
	name = "missile launcher"
	desc = "Mobile platform for firing guided missiles. The targeting system appears to have degraded."
	icon = 'fallout/fallout icons/fallout weapons/fallout_heavy.dmi'
	icon_state = "missile_launcher"
	item_icons = list(
		slot_back_str = 'fallout/fallout icons/fallout weapons/fallout_rifles_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_guns.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_guns.dmi')
	item_state = "missile_launcher"
	dry_fire_sound = 'sound/weapons/guns/fire/launcher_empty.ogg'
	reload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	unload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	flags_equip_slot = ITEM_SLOT_BACK
	gun_skill_category = GUN_SKILL_HEAVY_WEAPONS
	flags_gun_features = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY
	default_ammo_type = /obj/item/ammo_magazine/fallout_missile
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_missile)
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT
	caliber = CALIBER_MISSILE
	fire_delay = 2 SECONDS
	force = 40
	wield_delay = 2 SECONDS
	wield_penalty = 0
	aim_slowdown = 2.8
	scatter = 0
	windup_delay = 0
	starting_attachment_types = list(/obj/item/attachable/scope/missile_launcher)
	attachable_allowed = list(/obj/item/attachable/scope/missile_launcher)

/obj/item/weapon/gun/launcher/rocket/fallout/update_icon()
	. = ..()
	if(!rounds)
		icon_state = base_gun_icon + "_e"
	else
		icon_state = base_gun_icon

//Grenades
/obj/item/explosive/grenade/fallout
	name = "fragmentation grenade"
	desc = "Pinapple-style throwable explosive of pre-war design. Detonation time is 3 seconds."
	icon = 'fallout/fallout icons/fallout weapons/fallout_explosives.dmi'
	icon_state = "frag"
	arm_sound = 'sound/weapons/armbombpin.ogg'
	det_time = 3 SECONDS
	var/heavy_impact_range = 0
	light_impact_range = 5
	var/flash_range = 1	//Will create a blinding flash to any mobs in range
	var/has_explosion_effect = TRUE	//If the grenade does a little mushroom cloud animation

/obj/item/explosive/grenade/fallout/prime()
	explosion(loc, heavy_impact_range = src.heavy_impact_range, light_impact_range = src.light_impact_range, small_animation = src.has_explosion_effect, flash_range = src.flash_range)
	qdel(src)

/obj/item/explosive/grenade/fallout/stick
	name = "stick grenade"
	desc = "Ancient style of grenade that focuses on explosive power rather than fragmentation. Detonation time is 4 seconds."
	icon_state = "stick"
	item_state = "grenade_stick"
	throw_speed = 4
	throw_range = 9	//It's made for throwing after all
	det_time = 4 SECONDS
	heavy_impact_range = 2
	light_impact_range = 3
	flash_range = 2

/obj/item/explosive/grenade/fallout/dynamite
	name = "dynamite"
	desc = "Classic and simple design of putting as much explosive powder into one object as one can. Fuse length gives it about 5 seconds to detonate."
	icon_state = "dynamite"
	item_state = "grenade_stick"
	arm_sound = 'fallout/fallout sounds/fallout weapon sounds/dynamite_ignition.wav'
	det_time = 5 SECONDS
	heavy_impact_range = 3
	flash_range = 3
	var/grenade_timer

//Eventually expand this system to most grenades, like putting the pin back in a frag
/obj/item/explosive/grenade/fallout/dynamite/attack_self(mob/user)
	if(active)
		deltimer(grenade_timer)
		active = FALSE
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.throw_mode_off()
		icon_state = initial(icon_state)
		update_icon()
		return
	..()

/obj/item/explosive/grenade/fallout/dynamite/activate(mob/user)
	if(active)
		deltimer(grenade_timer)
		active = FALSE
		icon_state = initial(icon_state)
		update_icon()
		return
	active = TRUE
	if(user)
		log_explosion("[key_name(user)] primed [src] at [AREACOORD(user.loc)].")
		log_combat(user, src, "primed")
	icon_state = initial(icon_state) + "_active"
	playsound(loc, arm_sound, 50, 1, 6)
	grenade_timer = addtimer(CALLBACK(src, .proc/prime), det_time, TIMER_STOPPABLE)
	if(dangerous)
		GLOB.round_statistics.grenades_thrown++
		SSblackbox.record_feedback("tally", "round_statistics", 1, "grenades_thrown")
		update_icon()

/obj/item/explosive/grenade/fallout/molotov
	name = "molotov cocktail"
	desc = "Old bottle filled with alcohol or other flammable substances. Light the cloth on fire and throw the bottle to ignite."
	icon_state = "molotov"
	item_state = "grenade_stick"
	arm_sound = 'fallout/fallout sounds/flame_on.ogg'
	flash_range = 0
	has_explosion_effect = FALSE

//Like dynamite, it can be turned off
/obj/item/explosive/grenade/fallout/molotov/attack_self(mob/user)
	if(active)
		active = FALSE
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.throw_mode_off()
		icon_state = initial(icon_state)
		update_icon()
		return
	..()

/obj/item/explosive/grenade/fallout/molotov/activate(mob/user)
	if(active)
		active = FALSE
		icon_state = initial(icon_state)
		update_icon()
		return
	active = TRUE
	if(user)
		log_explosion("[key_name(user)] primed [src] at [AREACOORD(user.loc)].")
		log_combat(user, src, "primed")
	icon_state = initial(icon_state) + "_active"
	playsound(loc, arm_sound, 50, 1, 6)

//It explodes on impact if ignited
/obj/item/explosive/grenade/fallout/molotov/throw_impact(atom/hit_atom, speed)
	. = ..()
	if(active)
		GLOB.round_statistics.grenades_thrown++
		SSblackbox.record_feedback("tally", "round_statistics", 1, "grenades_thrown")
		prime()

/obj/item/explosive/grenade/fallout/molotov/prime()
	playsound(loc, 'sound/effects/hit_on_shattered_glass.ogg', 35, TRUE, 4)
	flame_radius(2, get_turf(src), 15, 30, 10, 10)
	playsound(loc, 'sound/effects/incendiary_explode.ogg', 30, TRUE, 4)
	qdel(src)

/obj/item/explosive/grenade/fallout/incendiary
	name = "incendiary bomb"
	desc = "Makeshift assembly loaded with napalm and connected to a timer set to 3 seconds."
	icon_state = "incendiary"
	item_state = "grenade_stick"
	arm_sound = 'sound/weapons/armbomb.ogg'
	det_time = 3 SECONDS
	flash_range = 0
	has_explosion_effect = FALSE

/obj/item/explosive/grenade/fallout/incendiary/prime()
	flame_radius(3, get_turf(src), 40, 60, 20, 20)
	playsound(loc, 'sound/effects/incendiary_explode.ogg', 60, FALSE, 6)
	qdel(src)
