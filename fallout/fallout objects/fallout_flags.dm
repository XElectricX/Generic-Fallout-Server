//The item variants
/obj/item/flag
	name = "flag"
	desc = "A cloth banner on a metal rod."
	icon = 'fallout/fallout icons/fallout items/fallout_trinkets.dmi'
	icon_state = ""
	item_icons = list(slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_items.dmi', slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_items.dmi')
	resistance_flags = RESIST_ALL

/obj/item/flag/ncr
	name = "\improper NCR flag"
	desc = "Proudly displaying the two-headed bear of the Republic."
	icon_state = "flag_ncr"

/obj/item/flag/legion
	name = "\improper Legion flag"
	desc = "The red of the Legion army trimmed in gold, featuring the mighty bull."
	icon_state = "flag_legion"

//The structure variants
/obj/structure/flag
	name = "flag pole"
	desc = "Metal pole for hanging a flag."
	icon = 'fallout/fallout icons/fallout structures/fallout_flags.dmi'
	icon_state = "empty"
	layer = ABOVE_ALL_MOB_LAYER
	resistance_flags = RESIST_ALL
	var/flag_faction
	var/flag_type
	var/has_flag = TRUE

/obj/structure/flag/Initialize()
	. = ..()
	AddComponent(/datum/component/largetransparency, 0, 0, 0, 1)

/obj/structure/flag/update_icon()
	. = ..()
	icon_state = has_flag ? initial(icon_state) : "empty"

/obj/structure/flag/attack_hand(mob/living/user)
	. = ..()
	flag_remove(user)

/obj/structure/flag/proc/flag_remove(mob/living/user)
	if(!has_flag)
		return
	if(user.faction == flag_faction)	//To prevent people from taking the flag roundstart to hide or grief
		to_chat(user, span_warning("You can't take your own faction's flag!"))
		return
	has_flag = FALSE
	user.put_in_any_hand_if_possible(new flag_type)
	update_icon()

/obj/structure/flag/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(I == flag_type)	//Returning your flag
		flag_add(I)
		return
	if(user.faction == flag_faction)	//To prevent grief
		to_chat(user, span_warning("What are you, French?"))
		return
	if(istype(I, /obj/item/flag))	//Ends the game if it's a foreign flag
		flag_captured(I, user)

//Readds your flag back to the pole
/obj/structure/flag/proc/flag_add(obj/item/I)
	if(has_flag)
		return
	has_flag = TRUE
	qdel(I)
	update_icon()

//Determines who wins
/obj/structure/flag/proc/flag_captured()
	var/datum/game_mode/ncr_vs_legion/mode = SSticker.mode
	switch(flag_type)
		if(NCR_FLAG)
			message_admins("Round finished: NCR victory") //NCR took objective
			mode.round_finished = NCR_VICTORY
		if(LEGION_FLAG)
			message_admins("Round finished: Legion victory") //Legion took objective
			mode.round_finished = LEGION_VICTORY

/obj/structure/flag/ncr
	name = "\improper NCR flag"
	desc = "Proudly displaying the two-headed bear of the Republic."
	icon_state = "ncr"
	flag_faction = NCR
	flag_type = NCR_FLAG

/obj/structure/flag/legion
	name = "\improper Legion flag"
	desc = "The red of the Legion army trimmed in gold, featuring the mighty bull."
	icon_state = "legion"
	flag_faction = LEGION
	flag_type = LEGION_FLAG
