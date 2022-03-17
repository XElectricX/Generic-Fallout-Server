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
	w_class = WEIGHT_CLASS_HUGE
	flags_equip_slot = ITEM_SLOT_BACK
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
		visible_message(span_notice("[user] begins to mend the [src]."))
		if(!do_after(user, 2 SECONDS, TRUE, src, BUSY_ICON_FRIENDLY) || obj_integrity >= max_integrity)
			return
		if(!repair_material.use(1))
			return
		repair_damage(max_integrity * 0.5)
		visible_message(span_notice("[user] mended the [src] with [repair_material.name]."))

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
		visible_message(span_notice("[user] fumbles around figuring out how to weld [src]."))
		var/fumbling_time = 3 SECONDS * (SKILL_ENGINEER_METAL - user.skills.getRating("engineer"))
		if(!do_after(user, fumbling_time, TRUE, src, BUSY_ICON_BUILD))
			return TRUE
	visible_message(span_notice("[user] begins welding the damage on [src]."))
	playsound(loc, 'sound/items/welder2.ogg', 25, TRUE)
	if(!do_after(user, 3 SECONDS, TRUE, src, BUSY_ICON_FRIENDLY))
		return TRUE
	if(!WT.remove_fuel(2, user))
		to_chat(user, span_warning("Not enough fuel to finish the task."))
		return TRUE
	visible_message(span_notice("[user] welds some of the damage on [src]."))
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
