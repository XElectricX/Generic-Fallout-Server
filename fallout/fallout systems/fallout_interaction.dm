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

/obj/item/storage/internal/handle_mousedrop(mob/user, obj/over_object)
	if(!ishuman(user))
		return FALSE

	if(user.incapacitated()) /* FALLOUT EDIT: Removing the lying_angle check here! */
		return FALSE

	if(istype(user.loc, /obj/vehicle/multitile/root/cm_armored)) //Stops inventory actions in a mech/tank
		return FALSE

	if(over_object == user && Adjacent(user)) //This must come before the screen objects only block
		open(user)
		return FALSE

	if(!isitem(master_item))
		return FALSE

	var/obj/item/owner = master_item

	if(owner.flags_item & NODROP)
		return FALSE

	if(!istype(over_object, /obj/screen))
		return TRUE

	//Makes sure owner is equipped before putting it in hand, so that we can't drag it into our hand from miles away.
	//There's got to be a better way of doing this...
	if(owner.loc != user || (owner.loc?.loc == user))
		return FALSE

	if(over_object.name == "r_hand" || over_object.name == "l_hand")
		if(owner.time_to_unequip)
			INVOKE_ASYNC(src, .proc/unequip_item, user, over_object.name)
		else if(over_object.name == "r_hand")
			user.dropItemToGround(owner)
			user.put_in_r_hand(owner)
		else if(over_object.name == "l_hand")
			user.dropItemToGround(owner)
			user.put_in_l_hand(owner)
	return FALSE

//Removed the lying_angle check here
/obj/item/storage/internal/handle_attack_hand(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.l_store == master_item && !H.get_active_held_item())	//Prevents opening if it's in a pocket.
			H.put_in_hands(master_item)
			H.l_store = null
			return FALSE
		if(H.r_store == master_item && !H.get_active_held_item())
			H.put_in_hands(master_item)
			H.r_store = null
			return FALSE

	if(master_item.loc == user)
		if(draw_mode && ishuman(user) && contents.len)
			var/obj/item/I = contents[contents.len]
			I.attack_hand(user)
		else
			open(user)
		return FALSE

	for(var/mob/M in range(1, master_item.loc))
		if(M.s_active == src)
			close(M)
	return TRUE

//Another lying_angle removal here
/obj/item/storage/MouseDrop(obj/over_object as obj)
	if(!ishuman(usr))
		return

	if(istype(usr.loc, /obj/vehicle/multitile/root/cm_armored)) // stops inventory actions in a mech/tank
		return

	if(over_object == usr && Adjacent(usr)) // this must come before the screen objects only block
		open(usr)
		return

	if(!istype(over_object, /obj/screen))
		return ..()

	//Makes sure that the storage is equipped, so that we can't drag it into our hand from miles away.
	//There's got to be a better way of doing this.
	if(loc != usr || (loc && loc.loc == usr))
		return

	if(!usr.restrained() && !usr.stat)
		switch(over_object.name)
			if("r_hand")
				usr.dropItemToGround(src)
				usr.put_in_r_hand(src)
			if("l_hand")
				usr.dropItemToGround(src)
				usr.put_in_l_hand(src)

//Another one
/obj/item/clothing/under/MouseDrop(obj/over_object as obj)
	if(!ishuman(usr))
		return
	//makes sure that the clothing is equipped so that we can't drag it into our hand from miles away.
	if ((flags_item & NODROP) || loc != usr)
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
	if(!(flags_item & TWOHANDED) || flags_item & WIELDED)
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
