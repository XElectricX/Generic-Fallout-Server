//Anything gun weapon-related that doesn't fit in the other files go here

/obj/item/weapon/gun/fallout
	item_state = ""
	item_icons = list(
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_guns.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_guns.dmi')
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	load_method = MAGAZINE
	type_of_casings = "bullet"
	damage_falloff_mult = 0
	cock_delay = 0
	movement_acc_penalty_mult = 2	//Only doubles the accuracy and scatter penalties, 5 was wayyy too much
	akimbo_scatter_mod = 0
	akimbo_additional_delay = 0
	//For bolt actions, pump actions have their own under fallout_shotgun
	cocked_message = "You work the bolt."
	cock_locked_message = "The bolt is locked and ready to fire."
	//For lever actions
	chamber_opened_message = "You swing the lever down."
	chamber_closed_message = "You pull back the lever."
	attack_speed = ATTACK_SPEED_MEDIUM

/*
Changes to what gun sprites are selected
"_c" for chambered (round chambered, no magazine)
"_e" for empty (magazine but no ammo/has ammo but not chambered)
"_u" for unloaded (no ammo and no magazine)
*/
/obj/item/weapon/gun/fallout/update_icon_state(mob/user)
	. = ..()
	if(!CHECK_BITFIELD(gun_features_flags, GUN_DEPLOYED_FIRE_ONLY))	//Stationary guns have only one sprite state
		if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_TOGGLES_OPEN) && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED))	//For lever actions and revolvers
			icon_state = base_gun_icon + "_e"
		else if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED))	//For lever actions and revolvers
			icon_state = base_gun_icon
		else if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_MAGAZINES) && (!length(chamber_items) && max_chamber_items) && rounds)	//Only guns with magazines
			icon_state = base_gun_icon + "_c"
		//Let's use this for pump and bolt actions with internal magazines that are not cocked for now
		else if(!CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_MAGAZINES) && CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION) && rounds && !in_chamber)
			icon_state = base_gun_icon + "_e"
		else if((length(chamber_items) && max_chamber_items) && !rounds)
			icon_state = base_gun_icon + "_e"
		else if((!length(chamber_items) && max_chamber_items) && !rounds)
			icon_state = base_gun_icon + "_u"
		else
			icon_state = base_gun_icon
	else
		icon_state =  base_gun_icon

/obj/item/weapon/gun/fallout/update_item_state()
	var/current_state = item_state
	if(gun_features_flags & GUN_SHOWS_AMMO_REMAINING) //shows different ammo levels
		var/remaining_rounds = (rounds <= 0) ? 0 : CEILING((rounds / max((length(chamber_items) ? max_rounds : max_shells), 1)) * 100, 25)
		item_state = "[initial(icon_state)]_[remaining_rounds][item_flags & WIELDED ? "_w" : ""]"
	else if(gun_features_flags & GUN_SHOWS_LOADED) //shows loaded or unloaded
		item_state = "[initial(icon_state)]_[rounds ? 100 : 0][item_flags & WIELDED ? "_w" : ""]"
	else
		//For some reason guns just don't use item_states so... I fix that
		if(!initial(item_state))
			item_state = "[base_gun_icon][item_flags & WIELDED ? "_w" : ""]"
		else
			item_state = "[initial(item_state)][item_flags & WIELDED ? "_w" : ""]"
		return

	if(current_state != item_state && ishuman(gun_user))
		var/mob/living/carbon/human/human_user = gun_user
		if(src == human_user.l_hand)
			human_user.update_inv_l_hand()
		else if (src == human_user.r_hand)
			human_user.update_inv_r_hand()

/obj/item/weapon/gun/fallout/able_to_fire(mob/user)
	if(!user || user.stat != CONSCIOUS || !isturf(user.loc))	/* FALLOUT EDIT: Remove lying_angle check! */
		return
	if(rounds - rounds_per_shot < 0 && rounds)
		to_chat(user, span_warning("There's not enough rounds left to fire."))
		return FALSE
	if(!CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED) && CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_TOGGLES_OPEN))
		to_chat(user, span_warning("The chamber is open! Close it first."))
		return FALSE
	if(!user.dextrous)
		to_chat(user, span_warning("You don't have the dexterity to do this!"))
		return FALSE
	if(!(gun_features_flags & GUN_ALLOW_SYNTHETIC) && !CONFIG_GET(flag/allow_synthetic_gun_use) && issynth(user))
		to_chat(user, span_warning("Your program does not allow you to use this firearm."))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_GUN_SAFETY))
		to_chat(user, span_warning("The safety is on!"))
		return FALSE
	if(CHECK_BITFIELD(gun_features_flags, GUN_WIELDED_FIRING_ONLY)) //If we're not holding the weapon with both hands when we should.
		if(!master_gun && !CHECK_BITFIELD(item_flags, WIELDED))
			to_chat(user, "<span class='warning'>You need a more secure grip to fire this weapon!")
			return FALSE
		if(master_gun && !CHECK_BITFIELD(master_gun.item_flags, WIELDED))
			to_chat(user, span_warning("You need a more secure grip to fire [src]!"))
			return FALSE
	if(LAZYACCESS(user.do_actions, src))
		to_chat(user, "<span class='warning'>You are doing something else currently.")
		return FALSE
	if(CHECK_BITFIELD(gun_features_flags, GUN_WIELDED_STABLE_FIRING_ONLY))//If we must wait to finish wielding before shooting.
		if(!master_gun && !(item_flags & FULLY_WIELDED))
			to_chat(user, "<span class='warning'>You need a more secure grip to fire this weapon!")
			return FALSE
		if(master_gun && !(master_gun.item_flags & FULLY_WIELDED))
			to_chat(user, "<span class='warning'>You need a more secure grip to fire [src]!")
			return FALSE
	if(CHECK_BITFIELD(gun_features_flags, GUN_DEPLOYED_FIRE_ONLY) && !CHECK_BITFIELD(item_flags, IS_DEPLOYED))
		to_chat(user, span_notice("You cannot fire [src] while it is not deployed."))
		return FALSE
	if(CHECK_BITFIELD(gun_features_flags, GUN_IS_ATTACHMENT) && !master_gun && CHECK_BITFIELD(gun_features_flags, GUN_ATTACHMENT_FIRE_ONLY))
		to_chat(user, span_notice("You cannot fire [src] without it attached to a gun!"))
		return FALSE
	return TRUE

//For some reason, the code has a connected mag always be disconnected if the gun is removed from the inventory; this breaks the deployable minigun
/obj/item/weapon/gun/fallout/removed_from_inventory(mob/user)
	SHOULD_CALL_PARENT(FALSE)
	SEND_SIGNAL(src, COMSIG_ITEM_REMOVED_INVENTORY, user)
	set_gun_user(null)
	active_attachable?.removed_from_inventory(user)

	//Fallout edit; just checks if the mag this weapon uses is connected to it before deciding to drop the mag
	if(length(chamber_items))
		var/obj/item/ammo_magazine/magazine = chamber_items[current_chamber_position]
		if(CHECK_BITFIELD(get_magazine_features_flags(magazine), MAGAZINE_WORN) && (get_dist(src, magazine) <= 1))
			addtimer(CALLBACK(src, PROC_REF(check_if_deployed)), 0.1 SECONDS, TIMER_STOPPABLE)
			return

	drop_connected_mag(null, user)

//Currently the deployable component removes the weapon from the user's inventory before actually deploying, so this check's if the weapon was deployed after a timer call
/obj/item/weapon/gun/fallout/proc/check_if_deployed()
	if(CHECK_BITFIELD(item_flags, IS_DEPLOYED))
		return

	//Remove the connected magazine since it wasn't actually deployed; prevents a minigun having a backpack with teleporting ammo
	unload()

//Deleting the check that prevents empty mags from being loaded into guns and adding RNG hand reload sounds
/obj/item/weapon/gun/fallout/reload(obj/item/new_mag, mob/living/user, force = FALSE)
	if(HAS_TRAIT(src, TRAIT_GUN_BURST_FIRING) || user?.do_actions)
		return
	if(!(new_mag.type in allowed_ammo_types))
		if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_HANDFULS))
			var/obj/item/ammo_magazine/mag = new_mag
			if(!CHECK_BITFIELD(mag.magazine_flags, MAGAZINE_HANDFUL)) //If the gun uses handfuls, it accepts all handfuls since it uses caliber to check if its allowed.
				to_chat(user, span_warning("[new_mag] cannot fit into [src]!"))
				return FALSE
			if(mag.caliber != caliber)
				to_chat(user, span_warning("Those handfuls cannot fit into [src]!"))
				return FALSE
		else
			to_chat(user, span_warning("[new_mag] cannot fit into [src]!"))
			return FALSE

	if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED) && !force)
		if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_TOGGLES_OPEN)) //AMMO_RECIEVER_CLOSED without AMMO_RECIEVER_TOGGLES_OPEN means the gun is not allowed to reload. Period.
			to_chat(user, span_warning("[src] is closed!"))
		else
			to_chat(user, span_warning("You cannot reload [src]!"))
		return FALSE

	if((length(chamber_items) >= max_chamber_items) && max_chamber_items)
		if(!CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_ROTATES_CHAMBER))
			to_chat(user, span_warning("There is no room for [new_mag]!"))
			return FALSE
		if(rounds >= max_chamber_items)
			to_chat(user, span_warning("There is no room for [new_mag]!"))
			return FALSE

	if(!max_chamber_items && in_chamber)
		to_chat(user, span_warning("[src]'s chamber is closed"))
		return FALSE

	if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_MAGAZINES))
		var/magazine_features_flags = get_magazine_features_flags(new_mag)
		if(magazine_features_flags && CHECK_BITFIELD(magazine_features_flags, MAGAZINE_WORN) && user && user.get_active_held_item() == new_mag)
			return FALSE
		if(get_magazine_reload_delay(new_mag) > 0 && user && !force)
			to_chat(user, span_notice("You begin reloading [src] with [new_mag]."))
			if(!do_after(user, get_magazine_reload_delay(new_mag), TRUE, user))
				to_chat(user, span_warning("Your reload was interupted!"))
				return FALSE
		if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_ROTATES_CHAMBER))
			for(var/i = 1, i <= length(chamber_items), i++)
				if(chamber_items[i])
					continue
				chamber_items[i] = new_mag
				break
		else
			chamber_items += new_mag
		get_ammo()
		if(user)
			playsound(src, reload_sound, 25, 1)
		if(!magazine_features_flags || (magazine_features_flags && !CHECK_BITFIELD(magazine_features_flags, MAGAZINE_WORN)))
			new_mag.forceMove(src)
			user?.temporarilyRemoveItemFromInventory(new_mag)
		if(istype(new_mag, /obj/item/ammo_magazine))
			var/obj/item/ammo_magazine/magazine = new_mag
			magazine.on_inserted(src)
		if(!in_chamber && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION) && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE))
			cycle(user, FALSE)
		update_ammo_count()
		update_icon()
		to_chat(user, span_notice("You reload [src] with [new_mag]."))
		RegisterSignal(new_mag, COMSIG_ITEM_REMOVED_INVENTORY, TYPE_PROC_REF(/obj/item/weapon/gun, drop_connected_mag))
		return TRUE


	var/list/obj/items_to_insert = list()
	if(max_chamber_items)
		if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_HANDFULS))
			var/obj/item/ammo_magazine/mag = new_mag
			if(CHECK_BITFIELD(mag.magazine_flags, MAGAZINE_HANDFUL))
				if(mag.current_rounds > 1)
					items_to_insert += mag.create_handful(null, 1)
				else
					items_to_insert += mag
				//RNG reload sounds
				playsound(src, pick(
					'fallout/fallout sounds/fallout weapon sounds/insert_shell_1.wav',
					'fallout/fallout sounds/fallout weapon sounds/insert_shell_2.wav',
					'fallout/fallout sounds/fallout weapon sounds/insert_shell_3.wav',
					'fallout/fallout sounds/fallout weapon sounds/insert_shell_4.wav',
					'fallout/fallout sounds/fallout weapon sounds/insert_shell_5.wav',
					'fallout/fallout sounds/fallout weapon sounds/insert_shell_6.wav'), 75, 1)
			else
				if((CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_ROTATES_CHAMBER) && rounds))	//FALLOUT EDIT: Remove bit that prevents loading a partially filled non-revolver
					to_chat(user, span_warning("[src] must be completely empty to use the [mag]!"))
					return FALSE
				var/rounds_to_fill = mag.current_rounds < max_chamber_items ? mag.current_rounds : max_chamber_items
				for(var/i = 0, i < rounds_to_fill, i++)
					items_to_insert += mag.create_handful(null, 1)
				playsound(src, reload_sound, 25, 1)
		else
			items_to_insert += new_mag

		if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_ROTATES_CHAMBER))
			for(var/obj/object_to_insert in items_to_insert)
				for(var/i = 1, i <= length(chamber_items), i++)
					if(chamber_items[i])
						continue
					chamber_items[i] = object_to_insert
					break
		else
			chamber_items += items_to_insert
	else
		items_to_insert += new_mag
		in_chamber = new_mag
	for(var/obj/obj_to_insert in items_to_insert)
		obj_to_insert.forceMove(src)
		user?.temporarilyRemoveItemFromInventory(obj_to_insert)
	if(!CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_HANDFULS))
		playsound(src, reload_sound, 25, 1)
	if(!CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION) && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_TOGGLES_OPEN) && !in_chamber && max_chamber_items && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE))
		cycle(user, FALSE)
	get_ammo()
	update_ammo_count()
	update_icon()
	return TRUE

//We make it a multiplier instead!
/obj/item/weapon/gun/fallout/modify_fire_delay(value, mob/user)
	fire_delay *= (1 + value)	//For example, if attachment has a value of -0.1, the fire delay is multiplied by 0.9, so a 10% increase
	SEND_SIGNAL(src, COMSIG_GUN_AUTOFIREDELAY_MODIFIED, fire_delay)
