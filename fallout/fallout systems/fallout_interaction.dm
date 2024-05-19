/* Everything below is mostly for removing lying_angle checks to facilitate crawling mechanics */

//Allows interaction with stuff while lying down
/mob/living/carbon/human/UnarmedAttack(atom/A, proximity, list/modifiers)
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		return

	var/obj/item/clothing/gloves/G = gloves // not typecast specifically enough in defines

	// Special glove functions:
	// If the gloves do anything, have them return TRUE to stop the touch
	// normal attack_hand() here.
	if(proximity && istype(G) && G.Touch(A, 1))
		return

	var/datum/limb/temp = get_limb(hand ? "l_hand" : "r_hand")
	if(temp && !temp.is_usable())
		to_chat(src, "<span class='notice'>You try to move your [temp.display_name], but cannot!")
		return

	if(LAZYACCESS(modifiers, "right"))
		A.attack_hand_alternate(src)
		return

	SEND_SIGNAL(src, COMSIG_HUMAN_MELEE_UNARMED_ATTACK, A)

	if(species?.spec_unarmedattack(src, A)) //Because species like monkeys dont use attack hand
		return
	A.attack_hand(src)

//Allow use of hands while lying down for the following two procs
/mob/put_in_l_hand(obj/item/W)
	W.do_pickup_animation(src)
	if(status_flags & INCORPOREAL) // INCORPOREAL things don't have hands
		return FALSE
	if(!istype(W))
		return FALSE
	if(!l_hand)
		W.forceMove(src)
		l_hand = W
		W.equipped(src,SLOT_L_HAND)
		W.layer = ABOVE_HUD_LAYER
		W.plane = ABOVE_HUD_PLANE
		update_inv_l_hand()
		W.pixel_x = initial(W.pixel_x)
		W.pixel_y = initial(W.pixel_y)
		return TRUE
	return FALSE

/mob/put_in_r_hand(obj/item/W)
	W.do_pickup_animation(src)
	if(status_flags & INCORPOREAL) // INCORPOREAL things don't have hands
		return FALSE
	if(!istype(W))
		return FALSE
	if(!r_hand)
		W.forceMove(src)
		r_hand = W
		W.equipped(src,SLOT_R_HAND)
		W.layer = ABOVE_HUD_LAYER
		W.plane = ABOVE_HUD_PLANE
		update_inv_r_hand()
		W.pixel_x = initial(W.pixel_x)
		W.pixel_y = initial(W.pixel_y)
		return TRUE
	return FALSE

//Also allow interactions if lying down
/datum/action/item_action/can_use_action()
	if(QDELETED(owner) || owner.incapacitated())
		return FALSE
	return TRUE

//Overriding to remove a lying_angle check
/datum/storage/on_mousedrop_onto(datum/source, obj/over_object as obj, mob/user)
	if(!ishuman(user))
		return COMPONENT_NO_MOUSEDROP

	if(over_object == user && parent.Adjacent(user)) // this must come before the screen objects only block
		open(user)
		return COMPONENT_NO_MOUSEDROP

	if(!istype(over_object, /atom/movable/screen))
		return //Don't cancel mousedrop

	if(HAS_TRAIT(src, TRAIT_NODROP))
		return COMPONENT_NO_MOUSEDROP

	//Makes sure that the storage is equipped, so that we can't drag it into our hand from miles away.
	if(parent.loc != user && parent.loc.loc != user) //loc.loc handles edge case of storage attached to an item attached to another item (modules/boots)
		return COMPONENT_NO_MOUSEDROP

	if(!user.restrained() && !user.stat)
		switch(over_object.name)
			if("r_hand")
				INVOKE_ASYNC(src, PROC_REF(put_item_in_r_hand), source, user)
				return COMPONENT_NO_MOUSEDROP
			if("l_hand")
				INVOKE_ASYNC(src, PROC_REF(put_item_in_l_hand), source, user)
				return COMPONENT_NO_MOUSEDROP

//Another one
/obj/item/clothing/under/MouseDrop(obj/over_object as obj)
	if(!ishuman(usr))
		return
	//makes sure that the clothing is equipped so that we can't drag it into our hand from miles away.
	if(HAS_TRAIT(src, TRAIT_NODROP) || loc != usr)
		return
	if(usr.incapacitated())	//Removed lying_angle check and if user is buckled, why was that a check?
		return
	if(!over_object)
		return
	switch(over_object.name)
		if("r_hand")
			usr.dropItemToGround(src)
			usr.put_in_r_hand(src)
		if("l_hand")
			usr.dropItemToGround(src)
			usr.put_in_l_hand(src)

//Add a check to prevent wielding while lying down
/obj/item/wield(mob/user)
	if(!(item_flags & TWOHANDED) || item_flags & WIELDED)
		return FALSE

	if(user.lying_angle)	//Can't wield if you're lying down
		to_chat(user, span_warning("You have to stand up first!"))
		return FALSE

	var/obj/item/offhand = user.get_inactive_held_item()
	if(offhand)
		if(offhand == user.r_hand)
			user.drop_r_hand()
		else if(offhand == user.l_hand)
			user.drop_l_hand()
		if(user.get_inactive_held_item()) //Failsafe; if there's somehow still something in the off-hand (undroppable), bail.
			to_chat(user, span_warning("You need your other hand to be empty!"))
			return FALSE

	if(ishuman(user))
		var/check_hand = user.r_hand == src ? "l_hand" : "r_hand"
		var/mob/living/carbon/human/wielder = user
		var/datum/limb/hand = wielder.get_limb(check_hand)
		if(!istype(hand) || !hand.is_usable())
			to_chat(user, span_warning("Your other hand can't hold [src]!"))
			return FALSE

	toggle_wielded(user, TRUE)
	SEND_SIGNAL(src, COMSIG_ITEM_WIELD, user)
	name = "[name] (Wielded)"
	update_item_state()
	place_offhand(user, name)
	return TRUE
