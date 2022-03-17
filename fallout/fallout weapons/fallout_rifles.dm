/obj/item/weapon/gun/fallout_rifle
	name = "Service Rifle"
	desc = "Primary weapon of most NCRA soldiers. Fitted for the reliable 5.56mm cartridge, in addition to being cheap and easy to maintain."
	icon = 'fallout/fallout icons/fallout weapons/fallout_rifles.dmi'
	icon_state = "service"
	item_icons = list(
		slot_back_str = 'fallout/fallout icons/fallout weapons/fallout_rifles_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_guns.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_guns.dmi'
		)
	muzzleflash_iconstate = "muzzle_flash_medium"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/service_rifle_fire.ogg'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/assault_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/assault_rifle_reload.wav'
	cocked_sound = 'fallout/fallout sounds/fallout weapon sounds/assault_rifle_cock.wav'
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO, GUN_FIREMODE_AUTOMATIC)
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle, /obj/item/ammo_magazine/fallout_rifle/extended)
	caliber = CALIBER_556X45
	max_shells = 20
	fire_delay = 0.5 SECONDS
	force = 15
	wield_delay = 1 SECONDS
	aim_slowdown = 2
	scatter = 10
	scatter_unwielded = 50
	recoil = 0.5
	recoil_unwielded = 3

/obj/item/weapon/gun/fallout_rifle/varmint
	name = "Varmint Rifle"
	desc = "Basic and barebones long gun. Ubiquitous as one of the cheapest rifles out there."
	icon_state = "varmint"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/varmint_rifle_fire.ogg'
	w_class = WEIGHT_CLASS_BULKY
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/subsonic
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/subsonic)
	caliber = CALIBER_22LR
	max_shells = 15
	fire_delay = 0.3 SECONDS
	force = 12
	wield_delay = 0.75 SECONDS
	aim_slowdown = 1.2
	scatter = 20
	recoil = 0
	recoil_unwielded = 1

/obj/item/weapon/gun/fallout_rifle/hunting
	name = "\improper Hunting Rifle"
	desc = "A simple bolt-action long gun. Hunting license not included."
	icon_state = "hunting_rifle"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_fire.wav'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_reload.wav'
	cocked_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_cock.wav'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/winchester
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/winchester, /obj/item/ammo_magazine/fallout_rifle/winchester/extended)
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION|AMMO_RECIEVER_UNIQUE_ACTION_LOCKS
	caliber = CALIBER_308WIN
	max_shells = 5
	fire_delay = 0.8 SECONDS
	force = 20
	scatter = 0
	scatter_unwielded = 15
	recoil = 0.8
	recoil_unwielded = 5

/obj/item/weapon/gun/fallout_rifle/hunting/short
	name = "\improper Short Hunting Rifle"
	icon_state = "hunting_rifle_short"
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	scatter = 5
	scatter_unwielded = 25
	recoil = 1.2
	recoil_unwielded = 3

/obj/item/weapon/gun/fallout_rifle/delisle
	name = "\improper DeLisle Carbine"
	desc = "Suppressed bolt-action rifle. One of the quietest firearms in existence."
	icon_state = "delisle"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/american180.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/acp
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/acp)
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION|AMMO_RECIEVER_UNIQUE_ACTION_LOCKS
	caliber = CALIBER_45ACP
	max_shells = 12
	fire_delay = 0.3 SECONDS
	force = 17
	scatter = 5
	scatter_unwielded = 15
	recoil = 0.2
	recoil_unwielded = 2

/obj/item/weapon/gun/fallout_rifle/anti_materiel
	name = "\improper Hecate II Anti-Materiel Rifle"
	desc = "Heavy bolt-action rifle chambered for .50 BMG. Necessary for when you want to kill someone and the wall they were hiding behind."
	icon_state = "hecate"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/antimateriel_rifle_fire.wav'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/antimateriel_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/antimateriel_rifle_reload.wav'
	cocked_sound = 'sound/weapons/guns/interact/tl-127_bolt.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/bmg
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/bmg)
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION|AMMO_RECIEVER_UNIQUE_ACTION_LOCKS
	caliber = CALIBER_50BMG
	max_shells = 5
	fire_delay = 1 SECONDS
	force = 20
	scatter = 0
	scatter_unwielded = 15
	recoil = 1.5
	recoil_unwielded = 10

/obj/item/weapon/gun/fallout_rifle/cowboy_repeater
	name = "\improper Winchester Model 1892"
	desc = "A lever-action rifle that uses .357 Magnum ammunition. Yee-haw."
	icon_state = "cowboy_repeater"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/cowboy_repeater_fire.wav'
	reload_sound = null
	cocked_sound = 'sound/weapons/guns/interact/martini_cocked.ogg'
	opened_sound = 'sound/weapons/guns/interact/martini_open.ogg'
	w_class = WEIGHT_CLASS_BULKY
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	default_ammo_type = /datum/ammo/bullet/magnum357
	allowed_ammo_types = /datum/ammo/bullet/magnum357
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
	caliber = CALIBER_357
	type_of_casings = "cartridge"
	max_chamber_items = 7
	max_shells = 0
	fire_delay = 0.1 SECONDS
	force = 15
	wield_delay = 0.75 SECONDS
	aim_slowdown = 1.1
	scatter = 5
	scatter_unwielded = 15
	recoil = 0.2
	recoil_unwielded = 1

//Trim a bunch of this section down at a later date, necessary to keep it for RNG bullet loading sounds
/obj/item/weapon/gun/fallout_rifle/cowboy_repeater/reload(obj/item/new_mag, mob/living/user, force = FALSE)
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
					'fallout/fallout sounds/fallout weapon sounds/insert_shell_6.wav'), 25, 1)
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
	if(!CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION) && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_TOGGLES_OPEN) && !in_chamber && max_chamber_items && !CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE))
		cycle(user, FALSE)
	get_ammo()
	update_ammo_count()
	update_icon()
	return TRUE

//Trimmed down unique_action to work like a lever action instead of pump action when the gun is operated
/obj/item/weapon/gun/fallout_rifle/cowboy_repeater/unique_action(mob/user, dont_operate = FALSE)
	if(CHECK_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED))
		DISABLE_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED)
		playsound(src, opened_sound, 25, 1)
		cycle(user, FALSE)
		if(casings_to_eject)
			make_casing()
			casings_to_eject = 0
		to_chat(user, span_notice(chamber_opened_message))
		if(in_chamber)
			chamber_items.Insert(current_chamber_position, in_chamber)
			in_chamber = null
	else
		ENABLE_BITFIELD(reciever_flags, AMMO_RECIEVER_CLOSED)
		playsound(src, cocked_sound, 25, 1)
		to_chat(user, span_notice(chamber_closed_message))
		cycle(user, FALSE)
	update_ammo_count()
	update_icon()
