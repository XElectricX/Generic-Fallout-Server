//Anything gun weapon-related that doesn't fit in the other files go here

/obj/item/weapon/gun
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	load_method = MAGAZINE
	type_of_casings = "bullet"
	damage_falloff_mult = 0
	cock_delay = 0
	movement_acc_penalty_mult = 2	//Only doubles the accuracy and scatter penalties, 5 was wayyy too much
	upper_akimbo_accuracy = 0
	lower_akimbo_accuracy = 0
	//For bolt actions, pump actions have their own under fallout_shotgun
	cocked_message = "You work the bolt."
	cock_locked_message = "The bolt is locked and ready to fire."
	//For lever actions
	chamber_opened_message = "You swing the lever down."
	chamber_closed_message = "You pull back the lever."

/*Changes to what gun sprites are selected
"_c" for chambered (round chambered, no magazine)
"_e" for empty (magazine but no ammo/has ammo but not chambered)
"_u" for unloaded (no ammo and no magazine)*/
/obj/item/weapon/gun/update_icon(mob/user)
	. = ..()
	if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_TOGGLES_OPEN) && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED))	//For lever actions and revolvers
		icon_state = base_gun_icon + "_e"
	else if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED))	//For lever actions and revolvers
		icon_state = base_gun_icon
	else if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_MAGAZINES) && (!length(chamber_items) && max_chamber_items) && rounds)	//Only guns with magazines
		icon_state = base_gun_icon + "_c"
	else if((length(chamber_items) && max_chamber_items) && !rounds)
		icon_state = base_gun_icon + "_e"
	else if((!length(chamber_items) && max_chamber_items) && !rounds)
		icon_state = base_gun_icon + "_u"
	else
		icon_state = base_gun_icon

//Deleting the check that prevents empty mags from being loaded into guns and adding RNG hand reload sounds
/obj/item/weapon/gun/reload(obj/item/new_mag, mob/living/user, force = FALSE)
	if(HAS_TRAIT(src, TRAIT_GUN_BURST_FIRING) || user?.do_actions)
		return
	if(!(new_mag.type in allowed_ammo_types))
		if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_HANDFULS))
			var/obj/item/ammo_magazine/mag = new_mag
			if(!CHECK_BITFIELD(mag.flags_magazine, MAGAZINE_HANDFUL)) //If the gun uses handfuls, it accepts all handfuls since it uses caliber to check if its allowed.
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
		var/flags_magazine_features = get_flags_magazine_features(new_mag)
		if(flags_magazine_features && CHECK_BITFIELD(flags_magazine_features, MAGAZINE_WORN) && user && user.get_active_held_item() == new_mag)
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
		if(!flags_magazine_features || (flags_magazine_features && !CHECK_BITFIELD(flags_magazine_features, MAGAZINE_WORN)))
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
		RegisterSignal(new_mag, COMSIG_ITEM_REMOVED_INVENTORY, /obj/item/weapon/gun.proc/drop_connected_mag)
		return TRUE


	var/list/obj/items_to_insert = list()
	if(max_chamber_items)
		if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_HANDFULS))
			var/obj/item/ammo_magazine/mag = new_mag
			if(CHECK_BITFIELD(mag.flags_magazine, MAGAZINE_HANDFUL))
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
				if((length(chamber_items) && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_ROTATES_CHAMBER)) || (CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_ROTATES_CHAMBER) && rounds))
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
/obj/item/weapon/gun/modify_fire_delay(value, mob/user)
	fire_delay *= (1 + value)	//For example, if attachment has a value of -0.1, the fire delay is multiplied by 0.9, so a 10% increase
	SEND_SIGNAL(src, COMSIG_GUN_AUTOFIREDELAY_MODIFIED, fire_delay)
