//Anything gun weapon-related that doesn't fit in the other files go here

/obj/item/weapon/gun
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	load_method = MAGAZINE
	type_of_casings = "bullet"
	damage_falloff_mult = 0
	cock_delay = 0
	upper_akimbo_accuracy = 0
	lower_akimbo_accuracy = 0
	//For bolt actions, pump actions have their own under fallout_shotgun
	cocked_message = "You work the bolt."
	cock_locked_message = "The bolt is locked and ready to fire."
	//For lever actions
	chamber_opened_message = "You swing the lever down."
	chamber_closed_message = "You pull back the lever."

//Currently Fallout guns only have a regular and empty sprite set, so this is a band-aid
/obj/item/weapon/gun/update_icon(mob/user)
	. = ..()
	if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_TOGGLES_OPEN) && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED))
		icon_state = base_gun_icon + "_e"
	else if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION) && !in_chamber && length(chamber_items))
		icon_state = base_gun_icon
	else if((!length(chamber_items) && max_chamber_items) || !rounds)
		icon_state = base_gun_icon
