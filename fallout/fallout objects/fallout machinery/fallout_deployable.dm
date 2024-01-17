//Adding turret adjacency checks for external magazines
/obj/machinery/deployable/mounted/Initialize(mapload, _internal_item, deployer)
	. = ..()
	var/obj/item/weapon/gun/gun = get_internal_item()
	if(gun)
		for(var/obj/item/ammo_magazine/ammo_magazine in gun.chamber_items)	//Checks if we even have a magazine loaded
			if(CHECK_BITFIELD(gun.get_flags_magazine_features(ammo_magazine), MAGAZINE_WORN))	//Start process() if it was deployed already connected
				START_PROCESSING(SSobj, src)

/obj/machinery/deployable/mounted/reload(mob/user, ammo_magazine)
	if(HAS_TRAIT(src, TRAIT_GUN_RELOADING))
		to_chat(user, span_warning("The weapon is already being reloaded!"))
		return

	if(user.do_actions)
		to_chat(user, span_warning("You are busy doing something else!"))
		return

	ADD_TRAIT(src, TRAIT_GUN_RELOADING, GUN_TRAIT)

	var/obj/item/weapon/gun/gun = get_internal_item()
	if(length(gun?.chamber_items))
		gun.unload(user)
		update_icon_state()

	gun?.reload(ammo_magazine, user)
	update_icon_state()

	if(CHECK_BITFIELD(gun.get_flags_magazine_features(ammo_magazine), MAGAZINE_WORN))	//Start process() if a backpack magazine has been connected
		START_PROCESSING(SSobj, src)

	REMOVE_TRAIT(src, TRAIT_GUN_RELOADING, GUN_TRAIT)

	if(!CHECK_BITFIELD(gun?.reciever_flags, AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION))
		return
	gun?.do_unique_action(gun, user)

/obj/machinery/deployable/mounted/process()
	var/obj/item/weapon/gun/gun = get_internal_item()
	if(gun)
		for(var/obj/item/ammo_magazine/ammo_magazine in gun.chamber_items)
			if(CHECK_BITFIELD(gun.get_flags_magazine_features(ammo_magazine), MAGAZINE_WORN))	//Check if an external mag is connected
				if(!(get_dist(src, ammo_magazine) <= 1))	//Check if the magazine is more than one tile away from itself
					gun.drop_connected_mag(src)
					visible_message("[src]'s ammo has been disconnected.")
					update_icon()
					STOP_PROCESSING(SSobj, src)
			else
				STOP_PROCESSING(SSobj, src)	//If the gun no longer has a backpack, no need to do it anymore

//Need to redo the same from mounted/process() down here because . = ..() is just not working
/obj/machinery/deployable/mounted/sentry/process()
	var/obj/item/weapon/gun/gun = get_internal_item()
	if(gun)
		for(var/obj/item/ammo_magazine/ammo_magazine in gun.chamber_items)
			if(CHECK_BITFIELD(gun.get_flags_magazine_features(ammo_magazine), MAGAZINE_WORN))
				if(!(get_dist(src, ammo_magazine) <= 1))
					gun.drop_connected_mag(src)
					visible_message("[src]'s ammo has been disconnected.")
					update_icon()
					if(!CHECK_BITFIELD(gun.turret_flags, TURRET_ON))
						STOP_PROCESSING(SSobj, src)
			else if(!CHECK_BITFIELD(gun.turret_flags, TURRET_ON))
				STOP_PROCESSING(SSobj, src)	//If the gun no longer has a backpack magazine and is not turned on, no need to do it anymore
	if(CHECK_BITFIELD(gun.turret_flags, TURRET_ON))	//In case the process is running for the purposes of the worn magazine but turret is off
		update_icon()
		if(!scan())
			gun?.stop_fire()
			firing = FALSE
			update_minimap_icon()
			return
		playsound(loc, 'sound/items/detector.ogg', 25, FALSE)

		sentry_start_fire()
