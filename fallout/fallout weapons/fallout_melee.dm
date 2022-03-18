//Basic melee weapon
/obj/item/weapon/fallout_melee
	name = "\improper To be determined"
	desc = "Agony"
	icon = 'fallout/fallout icons/fallout weapons/fallout_melee.dmi'
	var/force_wielded
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
	. = ..()
	if(!weapon_can_activate)
		return

//Hammers
/obj/item/weapon/fallout_melee/hammer
	name = "\improper Sledgehammer"
	desc = "Cement on a stick. A crude and simple tool... or weapon."
	icon_state = "hammer_sledge"
	flags_atom = CONDUCT
	flags_item = TWOHANDED
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	force = 25
	force_wielded = 50
	throwforce = 20
	throw_speed = 1
	throw_range = 2
	attack_verb = list("smashed", "hammered")
	attack_speed = 20

/obj/item/weapon/fallout_melee/hammer/rocket
	name = "\improper Rocket Sledge"
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
	..()
	to_chat(user, "The fuel gage reads [reagents.get_reagent_amount(/datum/reagent/fuel)]/[max_fuel] units.")
	if(weapon_active)
		to_chat(user, span_notice("The booster is active."))
	else
		to_chat(user, span_notice("The booster is inactive."))

/obj/item/weapon/fallout_melee/hammer/rocket/unique_action(mob/user)
	. = ..()
	to_chat(user, span_italics("You press the ignition button."))
	if(weapon_active)
		weapon_active = FALSE
		force_wielded = initial(force_wielded)
		if(CHECK_BITFIELD(flags_item, WIELDED))
			force = force_wielded
		user.visible_message(span_notice("[user] deactivates the [src]'s booster."))
		playsound(loc, 'sound/machines/switch.ogg', 25)
		return
	weapon_active = TRUE
	force_wielded = force_wielded * 2
	if(CHECK_BITFIELD(flags_item, WIELDED))
		force = force_wielded
	user.visible_message(span_warning("[user] ignites the [src]'s booster."))
	playsound(loc, 'sound/machines/switch.ogg', 25)

/obj/item/weapon/fallout_melee/hammer/rocket/attack(mob/living/carbon/M, mob/living/carbon/user as mob)
	if(weapon_active)
		if(!CHECK_BITFIELD(flags_item, WIELDED))
			to_chat(user, span_warning("You need both hands on the [src] to use the booster safely!"))
			return ..()
		if(reagents.get_reagent_amount(/datum/reagent/fuel) < fuel_consumption_rate)
			to_chat(user, span_warning("The [src]'s booster fizzles! It lacks sufficient fuel."))
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
	return ..()

//Refuel code, only works on full sized fuel tanks currently
/obj/item/weapon/fallout_melee/hammer/rocket/afterattack(obj/target, mob/user, flag)
	if(istype(target, /obj/structure/reagent_dispensers/fueltank) && get_dist(user,target) <= 1)
		var/obj/structure/reagent_dispensers/fueltank/RS = target
		if(RS.reagents.total_volume == 0)
			to_chat(user, span_warning("The [target] is out of fuel!"))
			return ..()
		var/fuel_transfer_amount = min(RS.reagents.total_volume, (max_fuel - reagents.get_reagent_amount(/datum/reagent/fuel)))
		RS.reagents.remove_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		reagents.add_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
		to_chat(user, span_notice("You refuel the [src]."))
		update_icon()
	return ..()

//Shields
/obj/item/weapon/shield/fallout_shield
	name = "\improper Riot Shield"
	icon = 'fallout/fallout icons/fallout weapons/fallout_melee.dmi'
	icon_state = "shield_riot"
	item_icons = list(
		slot_back_str = 'fallout/fallout icons/fallout weapons/fallout_melee_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_melee.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_melee.dmi'
		)
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	slowdown = 1
	max_integrity = 200
	force = 30
	throwforce = 15
	throw_speed = 1
	throw_range = 2
	var/repair_material = /obj/item/stack/sheet/metal
	materials = list(/datum/material/metal = 1000)
	soft_armor = list("melee" = 40, "bullet" = 20, "laser" = 0, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hard_armor = list("melee" = 15, "bullet" = 5, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hit_sound = 'sound/effects/grillehit.ogg'
	destroy_sound = 'sound/effects/glassbr3.ogg'
	attack_verb = "bashed"

/obj/item/weapon/shield/fallout_shield/reinforced
	name = "\improper Reinforced Riot Shield"
	icon_state = "shield_reinforced"
	slowdown = 1.5
	max_integrity = 300
	force = 40
	throwforce = 20
	soft_armor = list("melee" = 50, "bullet" = 30, "laser" = 15, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	hard_armor = list("melee" = 25, "bullet" = 15, "laser" = 5, "energy" = 5, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 10)

/obj/item/weapon/shield/fallout_shield/reinforced/legion
	name = "\improper Legionnaire Shield"
	desc = "A plated metal shield used by the Legion. Dense and heavy but affords good protection."
	icon_state = "shield_legion"

/obj/item/weapon/shield/fallout_shield/buckler
	name = "\improper Wooden Buckler"
	desc = "A wooden shield for protection in combat."
	icon_state = "shield_buckler"
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 0.5
	max_integrity = 100
	force = 15
	throwforce = 20	//Captain America this bad boy
	throw_speed = 2
	throw_range = 7
	repair_material = /obj/item/stack/sheet/wood
	soft_armor = list("melee" = 20, "bullet" = 20, "laser" = 5, "energy" = 5, "bomb" = 10, "bio" = 5, "rad" = 0, "fire" = 0, "acid" = 0)
	hard_armor = list("melee" = 5, "bullet" = 5, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	destroy_sound = 'sound/effects/woodhit.ogg'

/obj/item/weapon/shield/fallout_shield/buckler/makeshift
	name = "\improper Makeshift Shield"
	desc = "A buckler fashioned from a stop sign."
	icon_state = "shield_stop"
	repair_material = /obj/item/stack/sheet/metal
	destroy_sound = 'sound/effects/glassbr3.ogg'

/obj/item/weapon/shield/fallout_shield/roman
	name = "\improper Roman Shield"
	desc = "For strategic shield walls."
	icon_state = "shield_roman"

/obj/item/weapon/shield/fallout_shield/examine(mob/user, distance, infix, suffix)
	. = ..()
	var/health_status = (obj_integrity * 100)/max_integrity
	switch(health_status)
		if(0)
			to_chat(user, span_warning("It's fallen apart. This needs repairs before it can offer protection again."))
		if(0 to 30)
			to_chat(user, span_warning("It's falling apart and will not be able to withstand further damage."))
		if(30 to 80)
			to_chat(user, span_notice("It has cracked edges and dents."))
		if(80 to 100)
			to_chat(user, span_notice("It appears in perfect condition."))
	to_chat(user, span_notice("Alt click to tighten or loosen the anti-drop strap."))

/obj/item/weapon/shield/fallout_shield/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, repair_material))
		var/obj/item/stack/repair_material = I
		if(obj_integrity == max_integrity)
			to_chat(user, span_warning("[src] doesn't need repairs."))
			return
		if(repair_material.get_amount() < 1)
			to_chat(user, span_warning("You need one [repair_material.name] to mend the [src]."))
			return
		user.visible_message(span_notice("[user] begins to mend the [src]."))
		if(!do_after(user, 2 SECONDS, TRUE, src, BUSY_ICON_FRIENDLY) || obj_integrity >= max_integrity)
			return
		if(!repair_material.use(1))
			return
		repair_damage(max_integrity * 0.5)
		user.visible_message(span_notice("[user] mended the [src] with [repair_material.name]."))

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
