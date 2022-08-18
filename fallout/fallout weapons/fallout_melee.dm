//Basic melee weapon
/obj/item/weapon/fallout_melee
	name = "machete"
	desc = "A length of metal attached to a stick. Reliable cutting tool."
	icon = 'fallout/fallout icons/fallout weapons/fallout_melee.dmi'
	icon_state = "sword_machete"
	item_icons = list(
		slot_back_str = 'fallout/fallout icons/fallout weapons/fallout_melee_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_melee.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_melee.dmi')
	flags_atom = CONDUCT
	flags_item = TWOHANDED
	flags_equip_slot = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	edge = TRUE
	sharp = IS_SHARP_ITEM_BIG
	force = 15
	var/force_wielded = 25
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("slashed", "cut")
	attack_speed = ATTACK_SPEED_FAST
	var/haswieldedstate = FALSE	//If the weapon changes its on-mob sprite when wielded
	var/obj/item/cell/battery	//For weapons that use batteries
	var/energy_cost	//Energy usage per swing
	//var/weapon_can_cleave = TRUE	Future var for cleaving mechanic
	var/weapon_can_activate
	var/weapon_active
	var/wieldsound
	var/unwieldsound

/obj/item/weapon/fallout_melee/attack_self(mob/user)
	. = ..()
	/* Future strength skill check
	if(user.skills.getRating("strength") < INSERT VALUE HERE)
		to_chat(user, span_warning("[src] is too heavy for you to wield properly!"))
		return
	*/
	if(flags_item & WIELDED)
		unwield(user)
	else
		wield(user)

/obj/item/weapon/fallout_melee/wield(mob/user)
	. = ..()
	if(!.)
		return
	if(wieldsound)
		playsound(user, wieldsound, 15, 1)
	force = force_wielded

/obj/item/weapon/fallout_melee/unwield(mob/user)
	. = ..()
	if(!.)
		return
	if(unwieldsound)
		playsound(user, unwieldsound, 15, 1)
	force = initial(force)

//Properly unwields the weapon if it is dropped, stored, etc.
/obj/item/weapon/fallout_melee/mob_can_equip(mob/user)
	unwield(user)
	return ..()

/obj/item/weapon/fallout_melee/dropped(mob/user)
	. = ..()
	unwield(user)

/obj/item/weapon/fallout_melee/pickup(mob/user)
	unwield(user)

//Basis for melee weapon activations like rippers and rocket sledges
/obj/item/weapon/fallout_melee/unique_action(mob/user)
	if(!weapon_can_activate)
		return FALSE

//Handles icon states, takes into account wielded and weapon_active status
/obj/item/weapon/fallout_melee/update_icon_state()
	icon_state = "[initial(icon_state)][weapon_active ? "_on" : ""]"
	update_item_state()

/obj/item/weapon/fallout_melee/update_item_state(mob/user)
	if(haswieldedstate)
		. = ..()
		//item_state += "[weapon_active ? "_on" : ""]"
		//item_state = initial(icon_state) + (flags_item & WIELDED ? "_w" : "") + (weapon_active ? "_on" : "")


//Proc for removing energy cells from weapons that have them
/obj/item/weapon/fallout_melee/proc/unload(mob/user)
	user.dropItemToGround(battery)
	battery = null
	playsound(user, 'sound/weapons/guns/interact/rifle_reload.ogg', 25, TRUE)
	weapon_active = FALSE
	force = initial(force)	//For weapons that have their force modified from activation

//Swords
/obj/item/weapon/fallout_melee/chinese	//Move to /chinese/electrified when normal sword sprite is made
	name = "electrified Chinese sword"
	desc = "A blade commonly used by Chinese military personnel. This one is modified with an energy cell housing and wiring, designed for electrocuting enemies."
	icon_state = "sword_chinese_electrified"
	flags_equip_slot = ITEM_SLOT_BACK
	weapon_can_activate = TRUE
	force = 25
	force_wielded = 35
	energy_cost = 200
	var/electrocution_damage = 30

/obj/item/weapon/fallout_melee/chinese/examine(mob/user, distance, infix, suffix)
	. = ..()
	if(battery)
		. += "It has [battery.charge] power remaining."
	else
		. += "There is no cell installed!"
	if(weapon_active)
		. += "The sword is crackling with electricity!"
	else
		. += "The battery pack is turned off."

/obj/item/weapon/fallout_melee/chinese/unique_action(mob/user)
	..()
	if(!weapon_active && energy_cost > battery.charge)
		to_chat(user, span_warning("[src] lacks sufficient energy!"))
		return
	if(weapon_active)
		weapon_active = FALSE
		to_chat(user, span_italics("You power down [src]."))
		playsound(loc, 'sound/machines/switch.ogg', 25)
		/* Uncomment when sprites added
		update_icon()*/
		return
	weapon_active = TRUE
	to_chat(user, span_italics("You turn on [src]."))
	playsound(loc, 'sound/machines/switch.ogg', 25)
	/* Uncomment when sprites added
	update_icon()*/

/obj/item/weapon/fallout_melee/chinese/attack(mob/living/carbon/M, mob/living/carbon/user as mob)
	if(weapon_active)
		M.apply_damage(electrocution_damage, BURN, user.zone_selected, M.get_soft_armor("energy", user.zone_selected))	//Checks energy armor
		M.visible_message(span_warning("[M]'s [user.zone_selected] was shocked by [src]!"), span_warning("Your [user.zone_selected] was shocked by [src]!"))
		playsound(loc, 'sound/effects/sparks1.ogg', 50, TRUE)
		battery.charge -= energy_cost
		if(battery.charge < energy_cost)
			playsound(loc, 'sound/effects/sparks3.ogg', 50, TRUE)
			to_chat(user, span_warning("[src] fizzles out, it lacks power!"))
			weapon_active = FALSE
			update_icon()
	return ..()

/obj/item/weapon/fallout_melee/chinese/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/cell))
		return ..()
	if(battery)
		unload(user)
	user.transferItemToLoc(I,src)
	battery = I
	to_chat(user, span_notice("You insert [I] into [src]."))

/obj/item/weapon/fallout_melee/chinese/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(!battery)
		to_chat(user, span_notice("There is no battery installed!"))
		return TRUE
	to_chat(user, span_notice("You pop open the cover and remove [battery]."))
	unload(user)
	return TRUE

/obj/item/weapon/fallout_melee/assaultron
	name = "\improper Assaultron blade"
	desc = "An improvised weapon made out of the severed arm blade of an Assaultron."
	icon_state = "sword_assaultron"
	force = 30
	force_wielded = 45
	throwforce = 20

/obj/item/weapon/fallout_melee/assaultron/gold
	name = "\improper Republic Assaultron blade"
	desc = "The NCR's response to a need for weapons that can match the Legion. Manufactured from salvaged Assaultrons and adorned with a golden handle."
	icon_state = "sword_assaultron_gold"

/obj/item/weapon/fallout_melee/gladius
	name = "machete gladius"
	desc = "A formidable blade crafted by Legion Blacksmiths. The symbol of achievement for combat-proven Legionnaires."
	icon_state = "sword_gladius"
	force = 40
	force_wielded = 40	//No benefit to wielding a one-handed blade
	throwforce = 25

/obj/item/weapon/fallout_melee/scrap
	name = "scrap blade"
	desc = "A shoddy amalgation of metal."
	icon_state = "sword_scrap"

/obj/item/weapon/fallout_melee/bumper
	name = "bumper sword"
	desc = "A long, heavy sword made from scrap metal. Best used with both hands."
	icon_state = "sword_bumper"
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	force_wielded = 35
	throwforce = 15
	throw_speed = 0.5
	throw_range = 2
	attack_speed = ATTACK_SPEED_MEDIUM
	haswieldedstate = TRUE

/obj/item/weapon/fallout_melee/knife
	name = "survival knife"
	desc = "Common knife found all across the wasteland. Still a reliable cutting tool hundreds of years later."
	icon_state = "knife_survival"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items_lefthand_0.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_0.dmi')
	item_state = "knife"	//Needs a worn sprite
	flags_item = null
	w_class = WEIGHT_CLASS_SMALL
	sharp = IS_SHARP_ITEM_ACCURATE
	force = 10
	throw_speed = 2
	throw_range = 7
	attack_verb = list("slashed", "cut", "stabbed", "knifed")
	attack_speed = ATTACK_SPEED_VERY_FAST
	//weapon_can_cleave = FALSE

/obj/item/weapon/fallout_melee/knife/hunting
	name = "hunting knife"
	icon_state = "knife_hunting"	//Also needs a worn sprite

/obj/item/weapon/fallout_melee/knife/bowie
	name = "bowie knife"
	icon_state = "knife_bowie"
	item_icons = list(
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_melee.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_melee.dmi')
	item_state = "knife_bowie"

/obj/item/weapon/fallout_melee/knife/trench
	name = "trench knife"
	icon_state = "knife_trench"
	item_icons = list(
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_melee.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_melee.dmi')
	item_state = "knife_trench"

/obj/item/weapon/fallout_melee/knife/switchblade
	name = "switchblade"
	desc = "Compact blade that can be flipped open."
	icon_state = "knife_switch"
	item_icons = list(
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_melee.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_melee.dmi')
	item_state = "knife_switch"
	w_class = WEIGHT_CLASS_TINY

//Uses attack_self instead of unique_action for now because the game won't update worn icons for some reason
/obj/item/weapon/fallout_melee/knife/switchblade/attack_self(mob/user)
	. = ..()
	if(weapon_active)
		weapon_active = FALSE
		force = 5
		throwforce = 5
		edge = FALSE
		sharp = IS_NOT_SHARP_ITEM
		hitsound = "swing_hit"
		w_class = WEIGHT_CLASS_TINY
		attack_verb = "hit"
		playsound(loc, 'sound/weapons/flipblade.ogg', 25)
		update_icon()
		return
	weapon_active = TRUE
	force = initial(force)
	throwforce = initial(throwforce)
	edge = TRUE
	sharp = IS_SHARP_ITEM_ACCURATE
	hitsound = 'sound/weapons/bladeslice.ogg'
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("slashed", "cut", "stabbed", "knifed")
	playsound(loc, 'sound/weapons/flipblade.ogg', 25)
	update_icon()
	return

/obj/item/weapon/fallout_melee/knife/switchblade/update_icon_state()
	. = ..()
	icon_state = initial(icon_state) + (weapon_active ? "_on" : "")
	update_item_state()

/obj/item/weapon/fallout_melee/knife/switchblade/update_item_state(mob/user)
	item_state = "[initial(item_state)][weapon_active ? "_on" : ""]"

/obj/item/weapon/fallout_melee/knife/bone
	name = "bone knife"
	desc = "Makeshift blade crafted from bone with a wooden handle."
	icon_state = "knife_bone"
	item_icons = list(
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_melee.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_melee.dmi')
	item_state = "knife_bone"

//Spears
/obj/item/weapon/fallout_melee/spear
	name = "metal spear"
	desc = "Then there is the absolute Chad of a weapon, the spear. \
			Seen in basically every pre-gunpowder battle, the backbone of most major armies. Cheap, useful, easy to produce, no non-sense stabbing greatness. \
			The friend of peasants, with reach and accuracy. Cheers to the spear and all of its cousins; the pike, halberd, and others."
	icon_state = "spear"
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	force_wielded = 40	//More effective wielded than one-handed
	throwforce = 30	//An effective throwing weapon
	throw_speed = 2
	throw_range = 7
	attack_verb = list("stabbed", "violently poked", "skewered")
	attack_speed = ATTACK_SPEED_SLOW
	haswieldedstate = TRUE
	reach = 2
	//weapon_can_cleave = FALSE

/obj/item/weapon/fallout_melee/spear/throwing
	name = "javelin"
	desc = "A stick made sharp, light, and aerodynamic. Impale your enemies from a distance!"
	icon_state = "spear_throwing"
	w_class = WEIGHT_CLASS_BULKY
	force_wielded = 25
	throwforce = 62.5	//The formula for throwforce takes throw_speed into account, so this makes it do 50 damage
	throw_speed = 4
	embedding = list("embed_chance" = 100, "embedded_fall_chance" = 3, "embedded_unsafe_removal_time" = 4 SECONDS)

/obj/item/weapon/fallout_melee/spear/scrap
	name = "scrap spear"
	desc = "Long, pointy metal stick."
	icon_state = "spear_scrap"
	force = 10
	force_wielded = 30
	throwforce = 20

/obj/item/weapon/fallout_melee/spear/bone
	name = "bone spear"
	desc = "Sharpened bone fashioned into a spear."
	icon_state = "spear_bone"
	force = 10
	force_wielded = 30
	throwforce = 20

/obj/item/weapon/fallout_melee/spear/claw
	name = "deathclaw spear"
	desc = "A spear made from the bones and claw of a Deathclaw."
	icon_state = "spear_claw"
	force = 25
	force_wielded = 50
	throwforce = 40

//Axes
/obj/item/weapon/fallout_melee/axe
	name = "metal axe"
	desc = "Lumberjacking really fell off when most of the trees did."
	icon_state = "axe_metal"	//Doesn't exist yet, but needs to
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	force = 25
	force_wielded = 50
	throwforce = 20
	throw_speed = 0.5
	throw_range = 2
	attack_verb = list("cleaved", "cut", "axed", "sliced")
	attack_speed = ATTACK_SPEED_SLOW

/obj/item/weapon/fallout_melee/axe/fire
	name = "fire axe"
	desc = "Natural enemy of fire."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "fireaxe"
	item_icons = list(
		slot_back_str = 'icons/mob/back.dmi',
		slot_l_hand_str = 'icons/mob/items_lefthand_0.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_0.dmi')

/obj/item/weapon/fallout_melee/axe/bone
	name = "bone axe"
	desc = "Crude axe made from wood and bone."
	icon_state = "axe_bone"
	force = 20
	force_wielded = 30	//Not that sharp
	throwforce = 15

//Hammers
/obj/item/weapon/fallout_melee/hammer
	name = "sledgehammer"
	desc = "Cement on a stick. A crude and simple tool... or weapon."
	icon_state = "hammer_sledge"
	hitsound = 'sound/weapons/genhit3.ogg'
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	edge = FALSE
	sharp = IS_NOT_SHARP_ITEM
	force = 25
	force_wielded = 50
	throwforce = 20
	throw_speed = 0.5
	throw_range = 2
	attack_verb = list("smashed", "hammered", "bludgeoned")
	attack_speed = ATTACK_SPEED_SLOW
	haswieldedstate = TRUE

/obj/item/weapon/fallout_melee/hammer/rocket
	name = "rocket sledge"
	desc = "A particularly savage weapon, this can replicate the effects of standing in front of a moving train."
	icon_state = "hammer_rocket"
	weapon_can_activate = TRUE
	///Fuel capacity
	var/max_fuel = 50
	///Fuel used per hit
	var/fuel_consumption_rate = 10
	///Value for knockback
	var/knockback_bonus = 0.5

/obj/item/weapon/fallout_melee/hammer/rocket/Initialize()
	. = ..()
	create_reagents(max_fuel, null, list(/datum/reagent/fuel = max_fuel))

/obj/item/weapon/fallout_melee/hammer/rocket/examine(mob/user)
	. = ..()
	to_chat(user, "The fuel gage reads [reagents.get_reagent_amount(/datum/reagent/fuel)]/[max_fuel] units.")
	if(weapon_active)
		. += "The booster is active."
	else
		. += "The booster is inactive."

/obj/item/weapon/fallout_melee/hammer/rocket/unique_action(mob/user)
	. = ..()
	to_chat(user, span_italics("You press the ignition button."))
	if(weapon_active)
		weapon_active = FALSE
		force_wielded = initial(force_wielded)
		if(CHECK_BITFIELD(flags_item, WIELDED))
			force = force_wielded
		user.visible_message(span_notice("[user] deactivates [src]'s booster."))
		playsound(loc, 'sound/machines/switch.ogg', 25)
		/* Uncomment when sprites added
		update_icon()*/
		return
	weapon_active = TRUE
	force_wielded = force_wielded * 2
	if(CHECK_BITFIELD(flags_item, WIELDED))
		force = force_wielded
	user.visible_message(span_warning("[user] ignites [src]'s booster."))
	playsound(loc, 'sound/machines/switch.ogg', 25)
	/* Uncomment when sprites added
	update_icon()*/

/obj/item/weapon/fallout_melee/hammer/rocket/attack(mob/living/carbon/M, mob/living/carbon/user as mob)
	if(weapon_active)
		if(!CHECK_BITFIELD(flags_item, WIELDED))
			to_chat(user, span_warning("You need both hands on [src] to use the booster safely!"))
			attack_verb = list("smashed", "hammered", "bludgeoned")
			return ..()
		if(reagents.get_reagent_amount(/datum/reagent/fuel) < fuel_consumption_rate)
			to_chat(user, span_warning("[src]'s booster fizzles! It lacks sufficient fuel."))
			return ..()
		attack_verb = "slammed"
		playsound(loc, 'sound/weapons/rocket_sledge.ogg', 50, TRUE)
		reagents.remove_reagent(/datum/reagent/fuel, fuel_consumption_rate)
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		var/throw_distance = knockback_bonus * LERP(5 , 2, M.mob_size / MOB_SIZE_BIG)
		M.throw_at(throw_target, throw_distance, 0.5 + (knockback_bonus * 0.5))
		if(reagents.get_reagent_amount(/datum/reagent/fuel) < fuel_consumption_rate)
			playsound(loc, 'sound/items/weldingtool_off.ogg', 50)
			to_chat(user, span_warning("[src]'s fuel gage blinks, indicating fuel levels are too low!"))
			weapon_active = FALSE
			force_wielded = initial(force_wielded)
			force = force_wielded
			update_icon()
	else
		attack_verb = list("smashed", "hammered", "bludgeoned")
	return ..()

//Refuel code, only works on full sized fuel tanks currently
/obj/item/weapon/fallout_melee/hammer/rocket/afterattack(obj/target, mob/user, flag)
	if(istype(target, /obj/structure/reagent_dispensers/fueltank) && get_dist(user,target) <= 1)
		var/obj/structure/reagent_dispensers/fueltank/RS = target
		if(RS.reagents.total_volume == 0)
			to_chat(user, span_warning("[target] is out of fuel!"))
			return ..()
		var/fuel_transfer_amount = min(RS.reagents.total_volume, (max_fuel - reagents.get_reagent_amount(/datum/reagent/fuel)))
		RS.reagents.remove_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		reagents.add_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
		to_chat(user, span_notice("You refuel [src]."))
	return ..()

//Move to hammer/super and make it work off battery instead of fuel
/obj/item/weapon/fallout_melee/hammer/rocket/super
	name = "super sledge"
	desc = "High tech hammer made of dense, advanced materials."
	icon_state = "hammer_super"
	force = 30
	force_wielded = 60

//Bats
/obj/item/weapon/fallout_melee/bat
	name = "baseball bat"
	desc = "A swatter never runs out of bullets."
	icon_state = "bat"
	hitsound = 'sound/weapons/genhit3.ogg'
	flags_atom = null
	flags_equip_slot = ITEM_SLOT_BACK
	edge = FALSE
	sharp = IS_NOT_SHARP_ITEM
	throw_speed = 0.5	//Slightly heavier than a sword, so slower to throw
	attack_verb = list("smashed", "hit a home run on", "bludgeoned", "smacked")
	haswieldedstate = TRUE

/obj/item/weapon/fallout_melee/bat/spiked
	name = "spiked baseball bat"
	icon_state = "bat_spiked"
	edge = TRUE
	sharp = IS_SHARP_ITEM_SIMPLE
	force = 20
	force_wielded = 30

/obj/item/weapon/fallout_melee/bat/metal
	name = "metal baseball bat"
	icon_state = "bat_metal"
	flags_atom = CONDUCT

//Gauntlets
/obj/item/weapon/fallout_melee/gauntlet
	name = "lacerator gauntlet"
	desc = "A leather glove with rows of metallic blades attached."
	icon_state = "gauntlet_lacerator"
	hitsound = 'sound/weapons/genhit3.ogg'
	flags_atom = null
	flags_item = null
	w_class = WEIGHT_CLASS_NORMAL
	edge = FALSE
	sharp = IS_NOT_SHARP_ITEM
	force = 20
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	attack_verb = list("lacerated", "punched")

/obj/item/weapon/fallout_melee/gauntlet/punch
	name = "punch dagger"
	desc = "Wood assembled into the form of a handle with a knife attached. Creatively simple weapon."
	icon_state = "gauntlet_dagger"
	edge = TRUE
	sharp = IS_SHARP_ITEM_SIMPLE
	force = 20
	attack_verb = list("punched", "stabbed")

/obj/item/weapon/fallout_melee/gauntlet/mole
	name = "mole miner gauntlet"
	desc = "Digging tool repurposed into a weapon by the Mole Miner population."
	icon_state = "gauntlet_mole"
	flags_atom = CONDUCT
	w_class = WEIGHT_CLASS_BULKY
	edge = TRUE
	sharp = IS_SHARP_ITEM_SIMPLE
	force = 30
	throwforce = 10
	attack_verb = list("lacerated", "slashed", "stabbed", "ripped apart")

/obj/item/weapon/fallout_melee/gauntlet/power
	name = "power fist"
	desc = "Mechanical gauntlet fitted with hydraulics and a battery. You could punch through concrete with it."
	icon = 'icons/obj/items/weapons.dmi'
	icon_state = "powerfist"
	item_icons = list(
		slot_l_hand_str = 'icons/mob/items_lefthand_0.dmi',
		slot_r_hand_str = 'icons/mob/items_righthand_0.dmi')
	item_state = "powerfist"
	flags_atom = CONDUCT
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("bonked", "punched", "fisted")
	var/knockback_bonus = 0.5
	energy_cost = 200

/obj/item/weapon/fallout_melee/gauntlet/power/Destroy()
	if(battery)
		QDEL_NULL(battery)
	return ..()

/obj/item/weapon/fallout_melee/gauntlet/power/examine(user)
	. = ..()
	if(battery)
		. += "It has [battery.charge] power remaining."
	else
		. += "There is no cell installed!"
	if(weapon_active)
		. += "The hydraulics are active."
	else
		. += "The hydraulics are inactive."

/obj/item/weapon/fallout_melee/gauntlet/power/unique_action(mob/user)
	. = ..()
	if(!weapon_active && energy_cost > battery.charge)
		to_chat(user, span_warning("[src] lacks sufficient energy!"))
		return
	if(weapon_active)
		weapon_active = FALSE
		force = initial(force)
		to_chat(user, span_italics("You power down [src]."))
		playsound(loc, 'sound/machines/switch.ogg', 25)
		/* Uncomment when sprites added
		update_icon()*/
		return
	weapon_active = TRUE
	force = force * 3
	to_chat(user, span_italics("You activate [src]'s hydraulics."))
	playsound(loc, 'sound/machines/switch.ogg', 25)
	/* Uncomment when sprites added
	update_icon()*/

/obj/item/weapon/fallout_melee/gauntlet/power/attack_self(mob/user)
	. = ..()
	if(!(user.l_hand == src || user.r_hand == src))
		return ..()
	TOGGLE_BITFIELD(flags_item, NODROP)
	if(CHECK_BITFIELD(flags_item, NODROP))
		to_chat(user, span_warning("You feel [src] clamp shut around your hand!"))
		playsound(user, 'sound/weapons/fistclamp.ogg', 25, 1, 7)
	else
		to_chat(user, span_notice("You feel [src] loosen around your hand!"))
		playsound(user, 'sound/weapons/fistunclamp.ogg', 25, 1, 7)

/obj/item/weapon/fallout_melee/gauntlet/power/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(weapon_active)
		attack_verb = "slammed"
		playsound(loc, 'sound/weapons/energy_blast.ogg', 50, TRUE)
		playsound(loc, 'sound/weapons/genhit2.ogg', 50, TRUE)
		battery.charge -= energy_cost
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		var/throw_distance = knockback_bonus * LERP(5 , 2, M.mob_size / MOB_SIZE_BIG)
		M.throw_at(throw_target, throw_distance, 0.5 + (knockback_bonus / 2))
		if(battery.charge < energy_cost)
			playsound(loc, 'sound/effects/sparks3.ogg', 50, TRUE)
			to_chat(user, span_warning("[src]'s battery meter flashes, indicating energy levels are too low!"))
			weapon_active = FALSE
			force = initial(force)
			update_icon()
	else
		attack_verb = list("bonked", "punched", "fisted")
	return ..()

/obj/item/weapon/fallout_melee/gauntlet/power/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/cell))
		return ..()
	if(battery)
		unload(user)
	user.transferItemToLoc(I,src)
	battery = I
	to_chat(user, span_notice("You insert [I] into [src]."))

/obj/item/weapon/fallout_melee/gauntlet/power/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(!battery)
		to_chat(user, span_notice("There is no cell installed!"))
		return TRUE
	unload(user)
	to_chat(user, span_notice("You pop open the cover and remove the cell."))
	return TRUE

//Knuckle weapons
/obj/item/weapon/fallout_melee/knuckles
	name = "brass knuckles"
	desc = "Brass metal shaped into the form of a fist with holes for the wearer's fingers."
	icon_state = "knuckles_brass"
	hitsound = 'sound/weapons/genhit3.ogg'
	flags_item = null
	w_class = WEIGHT_CLASS_SMALL
	edge = FALSE
	sharp = IS_NOT_SHARP_ITEM
	force = 15
	throwforce = 5
	throw_speed = 2
	throw_range = 7
	attack_verb = list("swung at", "punched", "pummeled")
	attack_speed = ATTACK_SPEED_VERY_FAST
	//weapon_can_cleave = FALSE

/obj/item/weapon/fallout_melee/knuckles/spiked
	name = "spiked knuckles"
	desc = "Metal shaped into the form of a fist with holes for the wearer's fingers and raised points along the edge."
	icon_state = "knuckles_spiked"
	edge = TRUE
	sharp = IS_SHARP_ITEM_SIMPLE
	force = 20

//Misc melee weapons
/obj/item/weapon/fallout_melee/pipe
	name = "lead pipe"
	desc = "Rusty pipe that's been given a new life as a skull cracker."
	icon_state = "pipe"
	hitsound = 'sound/weapons/genhit3.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	edge = FALSE
	sharp = IS_NOT_SHARP_ITEM
	force = 12
	force_wielded = 15
	throw_range = 7
	attack_verb = list("bludgeoned", "smacked", "clubbed")

/obj/item/weapon/fallout_melee/tire_iron
	name = "tire iron"
	desc = "Not very useful these days. Except for beating people with it."
	icon_state = "tire_iron"
	hitsound = 'sound/weapons/genhit3.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	edge = FALSE
	sharp = IS_NOT_SHARP_ITEM
	force = 12
	force_wielded = 15
	throw_range = 7
	attack_verb = list("swung at", "clubbed")

/obj/item/weapon/fallout_melee/golf_club
	name = "golf club"
	desc = "Fore!"
	icon_state = "golf_club"
	hitsound = 'sound/weapons/genhit3.ogg'
	edge = FALSE
	sharp = IS_NOT_SHARP_ITEM
	force = 12
	force_wielded = 15
	throw_range = 7
	attack_verb = list("swung at", "practiced their backswing on", "clubbed")
	haswieldedstate = TRUE

/obj/item/weapon/fallout_melee/whip
	name = "leather whip"
	desc = "Inspires fear in some, horniness in others."
	icon_state = "whip"
	hitsound = 'sound/weapons/genhit3.ogg'
	flags_atom = null
	flags_item = null
	w_class = WEIGHT_CLASS_NORMAL
	edge = FALSE
	sharp = IS_NOT_SHARP_ITEM
	hitsound = "swing_hit"
	attack_verb = list("whipped", "lashed", "flogged")
	attack_speed = ATTACK_SPEED_MEDIUM
	reach = 3
	//weapon_can_cleave = FALSE

//Shields
/obj/item/weapon/shield/fallout_shield
	name = "riot shield"
	icon = 'fallout/fallout icons/fallout weapons/fallout_melee.dmi'
	icon_state = "shield_riot"
	item_icons = list(
		slot_back_str = 'fallout/fallout icons/fallout weapons/fallout_melee_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_melee.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_melee.dmi')
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	slowdown = 0.2
	max_integrity = 700
	force = 30
	throwforce = 15
	throw_speed = 0.5
	throw_range = 2
	var/repair_material = /obj/item/stack/sheet/metal
	materials = list(/datum/material/metal = 1000)
	hard_armor = list("melee" = 10, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 10)
	hit_sound = 'sound/effects/grillehit.ogg'
	destroy_sound = 'sound/effects/glassbr3.ogg'
	attack_verb = "bashed"

/obj/item/weapon/shield/fallout_shield/reinforced
	name = "reinforced riot shield"
	icon_state = "shield_reinforced"
	slowdown = 0.4
	max_integrity = 1500
	force = 40
	throwforce = 20
	hard_armor = list("melee" = 20, "bullet" = 10, "laser" = 15, "energy" = 15, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 10)

/obj/item/weapon/shield/fallout_shield/reinforced/legion
	name = "\improper Legionnaire shield"
	desc = "A plated metal shield used by the Legion. Dense and heavy but affords good protection."
	icon_state = "shield_legion"

/obj/item/weapon/shield/fallout_shield/buckler
	name = "wooden buckler"
	desc = "A wooden shield for protection in combat."
	icon_state = "shield_buckler"
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 0
	max_integrity = 300
	force = 15
	throwforce = 30	//Captain America this bad boy
	throw_speed = 3
	throw_range = 7
	repair_material = /obj/item/stack/sheet/wood
	hard_armor = list("melee" = 5, "bullet" = 3, "laser" = 0, "energy" = 0, "bomb" = 5, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	destroy_sound = 'sound/effects/woodhit.ogg'

/obj/item/weapon/shield/fallout_shield/buckler/makeshift
	name = "makeshift shield"
	desc = "A buckler fashioned from a stop sign."
	icon_state = "shield_stop"
	repair_material = /obj/item/stack/sheet/metal
	destroy_sound = 'sound/effects/glassbr3.ogg'

/obj/item/weapon/shield/fallout_shield/roman
	name = "\improper Roman shield"
	desc = "For strategic shield walls."
	icon_state = "shield_roman"

//Shield associated code below
/datum/component/shield/Initialize(shield_flags, shield_soft_armor, shield_hard_armor, shield_cover = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 80, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 80))
	. = ..()

//Rework how shields calculate damage taken to be based on flat damage reduction instead of percentages
/datum/component/shield/item_intercept_attack(attack_type, incoming_damage, damage_type, silent)
	var/obj/item/parent_item = parent
	var/status_cover_modifier = 1
	if(parent_item.obj_integrity <= parent_item.integrity_failure)
		return incoming_damage
	if(affected.IsSleeping() || affected.IsUnconscious() || affected.IsAdminSleeping()) //We don't do jack if we're literally KOed/sleeping/paralyzed.
		return incoming_damage
	if(affected.IsStun() || affected.IsKnockdown() || affected.IsParalyzed()) //Halve shield cover if we're paralyzed or stunned
		status_cover_modifier *= 0.5
	if(iscarbon(affected))
		var/mob/living/carbon/C = affected
		if(C.stagger) //Lesser penalty to shield cover for being staggered.
			status_cover_modifier *= 0.75
	switch(attack_type)
		if(COMBAT_TOUCH_ATTACK)
			if(!prob(cover.getRating(damage_type) * status_cover_modifier))
				return FALSE //Bypassed the shield.
			incoming_damage = max(0, incoming_damage - hard_armor.getRating(damage_type))
			incoming_damage *= (100 - soft_armor.getRating(damage_type)) * 0.01
			return prob(50 - round(incoming_damage / 3))
		if(COMBAT_MELEE_ATTACK, COMBAT_PROJ_ATTACK)
			var/absorbing_damage = incoming_damage * cover.getRating(damage_type) * 0.01 * status_cover_modifier  //Determine cover ratio; this is the % of damage we actually intercept.
			if(!absorbing_damage)	//This should be checked before we get to damage calculations!
				return incoming_damage //We are transparent to this kind of damage.
			var/calculated_damage = max(0, absorbing_damage - hard_armor.getRating(damage_type)) //We apply hard armor *first* _not_ *after* soft armor
			if(incoming_damage != absorbing_damage)	//If only part of the damage is being reduced, use the formula below
				. = incoming_damage - absorbing_damage + calculated_damage	//The math for calculating the resulting damage taken
			else
				. = calculated_damage
			absorbing_damage *= (100 - soft_armor.getRating(damage_type)) * 0.01 //Now apply soft armor
			if(attack_type == COMBAT_MELEE_ATTACK && !silent && !calculated_damage)	//If you block all or what was absorbed of a melee attack
				affected.visible_message(span_avoidharm("[affected] [. ? "negated most of the attack" : "performed a flawless block"]!"), span_avoidharm("You [. ? "blocked most of the damage" : "blocked the attack"]!"))
			if(!.)	//If damage is nullified to the user, user gets told so
				if(!silent && attack_type != COMBAT_PROJ_ATTACK)	//No need to spam another message if you already got from being melee'ed
					to_chat(affected, span_avoidharm("\The [parent_item.name] absorbs the damage!"))
			if(transfer_damage_cb)
				return transfer_damage_cb.Invoke(absorbing_damage, ., silent)

/obj/item/weapon/shield/fallout_shield/examine(mob/user, distance, infix, suffix)
	. = ..()
	var/health_status = (obj_integrity * 100)/max_integrity
	switch(health_status)
		if(0)
			. += span_warning("It's fallen apart. This needs repairs before it can offer protection again.")
		if(0 to 30)
			. += span_warning("It's falling apart and will not be able to withstand further damage.")
		if(30 to 80)
			. += span_notice("It has cracked edges and dents.")
		if(80 to 100)
			. += span_notice("It appears in perfect condition.")
	. += "Alt click to tighten or loosen the anti-drop strap."

/obj/item/weapon/shield/fallout_shield/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, repair_material))
		var/obj/item/stack/repair_material = I
		if(obj_integrity == max_integrity)
			to_chat(user, span_warning("[src] doesn't need repairs."))
			return
		if(repair_material.get_amount() < 1)
			to_chat(user, span_warning("You need one [repair_material.name] to mend [src]."))
			return
		user.visible_message(span_notice("[user] begins to mend [src]."))
		if(!do_after(user, 2 SECONDS, TRUE, src, BUSY_ICON_FRIENDLY) || obj_integrity >= max_integrity)
			return
		if(!repair_material.use(1))
			return
		repair_damage(max_integrity * 0.5)
		user.visible_message(span_notice("[user] mended [src] with [repair_material.name]."))

/obj/item/weapon/shield/fallout_shield/welder_act(mob/living/user, obj/item/I)
	if(user.do_actions)
		return FALSE
	var/obj/item/tool/weldingtool/WT = I
	if(!WT.isOn())
		return FALSE
	if(current_acid)
		to_chat(user, "<span class='warning'>You can't get near that, it's melting!<span>")
		return TRUE
	if(obj_integrity < max_integrity * 0.5)
		to_chat(user, span_warning("[src] has sustained too much structural damage. It needs to be reinforced."))
		return TRUE
	if(obj_integrity == max_integrity)
		to_chat(user, span_warning("[src] doesn't need repairs."))
		return TRUE
	if(user.skills.getRating("engineer") < SKILL_ENGINEER_METAL)
		user.visible_message(span_notice("[user] fumbles around figuring out how to weld [src]."))
		var/fumbling_time = 3 SECONDS * (SKILL_ENGINEER_METAL - user.skills.getRating("engineer"))
		if(!do_after(user, fumbling_time, TRUE, src, BUSY_ICON_BUILD))
			return TRUE
	user.visible_message(span_notice("[user] begins welding the damage on [src]."))
	playsound(loc, 'sound/items/welder2.ogg', 25, TRUE)
	if(!do_after(user, 3 SECONDS, TRUE, src, BUSY_ICON_FRIENDLY))
		return TRUE
	if(!WT.remove_fuel(2, user))
		to_chat(user, span_warning("Not enough fuel to finish the task."))
		return TRUE
	user.visible_message(span_notice("[user] welds some of the damage on [src]."))
	repair_damage(20)
	update_icon()
	playsound(loc, 'sound/items/welder2.ogg', 25, TRUE)
	return TRUE

/obj/item/weapon/shield/fallout_shield/update_icon_state()
	/* Code for when damaged and broken sprites are added
	if(obj_integrity < max_integrity * 0.5)
		icon_state = initial(icon_state) + "_damaged"
	if(obj_integrity == integrity_failure)
		icon_state = initial(icon_state) + "_broken"
	else
		icon_state = initial(icon_state)
	*/

	if(!isliving(loc))
		return
	var/mob/living/holder = loc
	if(holder.l_hand == src)
		holder.update_inv_l_hand()
		return
	if(holder.r_hand == src)
		holder.update_inv_r_hand()
		return
	holder.update_inv_back()

/obj/item/weapon/shield/fallout_shield/AltClick(mob/user)
	if(!can_interact(user))
		return ..()
	if(!ishuman(user))
		return ..()
	if(!(user.l_hand == src || user.r_hand == src))
		return ..()
	TOGGLE_BITFIELD(flags_item, NODROP)
	if(CHECK_BITFIELD(flags_item, NODROP))
		to_chat(user, span_warning("You tighten the strap of [src] around your hand!"))
	else
		to_chat(user, span_notice("You loosen the strap of [src] around your hand!"))
