/obj/item/tool/fallout
	name = "tool"
	desc = "Some sort of tool."
	atom_flags = CONDUCT
	equip_slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	sharp = IS_SHARP_ITEM_SIMPLE
	force = 5
	throwforce = 5

/obj/item/tool/fallout/pickaxe
	name = "pickaxe"
	desc = "Rock and stone."
	icon = 'fallout/fallout icons/fallout items/fallout_tools.dmi'
	item_icons = list(slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_items.dmi', slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_items.dmi')
	icon_state = "pickaxe"
	item_state = "pickaxe"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	throwforce = 10
	attack_verb = list("swung at", "stabbed")
	var/dig_speed = 1 SECONDS
	var/dig_sound = 'sound/weapons/genhit.ogg'

/obj/item/tool/fallout/pickaxe/attack_turf(turf/T, mob/living/user)
	. = ..()
	if(!istype(T, /turf/closed/fallout))
		return

	if(!do_after(user, dig_speed, NONE, src, BUSY_ICON_BAR))
		return

	if(!istype(T, /turf/closed/fallout))
		return

	var/turf/closed/fallout/wall = T
	playsound(loc, dig_sound, 25, TRUE)

	wall.mine()
