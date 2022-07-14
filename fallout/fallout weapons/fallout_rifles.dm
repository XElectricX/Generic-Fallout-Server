/obj/item/weapon/gun/fallout_rifle
	name = "\improper Service Rifle"
	desc = "Primary weapon of most NCRA soldiers. Fitted for the reliable 5.56mm cartridge, in addition to being cheap and easy to maintain."
	icon = 'fallout/fallout icons/fallout weapons/fallout_rifles.dmi'
	icon_state = "service"
	item_icons = list(
		slot_back_str = 'fallout/fallout icons/fallout weapons/fallout_rifles_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_guns.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_guns.dmi')
	muzzleflash_iconstate = "muzzle_flash_medium"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/service_rifle_fire.ogg'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/assault_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/assault_rifle_reload.wav'
	cocked_sound = 'fallout/fallout sounds/fallout weapon sounds/assault_rifle_cock.wav'
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO, GUN_FIREMODE_AUTOMATIC)
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle, /obj/item/ammo_magazine/fallout_rifle/extended)
	caliber = CALIBER_556X45
	max_shells = 20
	fire_delay = 0.4 SECONDS
	force = 15
	wield_delay = 1 SECONDS
	aim_slowdown = 2
	scatter = 10
	scatter_unwielded = 50
	recoil = 0.5
	recoil_unwielded = 3

/obj/item/weapon/gun/fallout_rifle/varmint
	name = "\improper Varmint Rifle"
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
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION|AMMO_RECIEVER_UNIQUE_ACTION_LOCKS
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/winchester
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/winchester, /obj/item/ammo_magazine/fallout_rifle/winchester/extended)
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
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION|AMMO_RECIEVER_UNIQUE_ACTION_LOCKS
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/acp
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/acp)
	caliber = CALIBER_45ACP
	max_shells = 12
	fire_delay = 0.3 SECONDS
	force = 17
	scatter = 0
	scatter_unwielded = 10
	recoil = 0
	recoil_unwielded = 1

/obj/item/weapon/gun/fallout_rifle/anti_materiel
	name = "\improper Hecate II Anti-Materiel Rifle"
	desc = "Heavy bolt-action rifle chambered for .50 BMG. Necessary for when you want to kill someone and the wall they were hiding behind."
	icon_state = "hecate"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/antimateriel_rifle_fire.wav'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/antimateriel_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/antimateriel_rifle_reload.wav'
	cocked_sound = 'sound/weapons/guns/interact/tl-127_bolt.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION|AMMO_RECIEVER_UNIQUE_ACTION_LOCKS
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/bmg
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/bmg)
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
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
	default_ammo_type = /datum/ammo/bullet/fallout/magnum357
	allowed_ammo_types = /datum/ammo/bullet/fallout/magnum357
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
