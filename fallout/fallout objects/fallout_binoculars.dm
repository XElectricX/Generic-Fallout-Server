/obj/item/binoculars/fallout
	name = "binoculars"
	desc = "A pair of binoculars. Examine a tile/object while in use to get coordinates."
	item_icons = list(slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_items.dmi', slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_items.dmi')
	item_state = "binoculars"
	throw_range = 7
	throw_speed = 2
	var/turf/targetturf
	var/wielded

//Updates the mob sprite
/obj/item/binoculars/fallout/update_item_state(mob/user)
	item_state = "binoculars[wielded ? "_w" : ""]"	//The check for if the binoculars are wielded or not
	return

/obj/item/binoculars/fallout/onzoom(mob/living/user)
	. = ..()
	user.reset_perspective(src)
	user.update_sight()
	user.client.click_intercept = src
	wielded = TRUE	//Makes the mob icon have binoculars on their face
	update_item_state()

/obj/item/binoculars/fallout/onunzoom(mob/living/user)
	. = ..()
	if(!user?.client)
		return
	user.client.click_intercept = null
	user.reset_perspective(user)
	user.update_sight()
	wielded = FALSE	//Males the mob icon have binoculars in their hand
	update_item_state()

/obj/item/binoculars/fallout/proc/acquire_coordinates(atom/A, mob/living/carbon/human/user)
	var/turf/TU = get_turf(A)
	targetturf = TU
	to_chat(user, span_notice("COORDINATES: LONGITUDE [targetturf.x]. LATITUDE [targetturf.y]."))
	playsound(src, 'sound/effects/binoctarget.ogg', 35)

//Copies code from tactical binoculars, only need the coordinate stuff
/obj/item/binoculars/fallout/InterceptClickOn(mob/user, params, atom/object)
	var/list/pa = params2list(params)
	if(pa.Find("shift"))
		acquire_coordinates(object, user)
		return TRUE
	return FALSE
