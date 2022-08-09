/obj/item/weapon/gun/fallout_rifle
	name = "service rifle"
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
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle, /obj/item/ammo_magazine/fallout_rifle/extended)
	caliber = CALIBER_556X45
	max_shells = 20
	fire_delay = 0.4 SECONDS
	force = 15
	wield_delay = 1 SECONDS
	aim_slowdown = 2
	scatter = 5
	scatter_unwielded = 20
	recoil = 0.5
	recoil_unwielded = 3
	attachable_offset = list("muzzle_x" = 46, "muzzle_y" = 20, "rail_x" = 18, "rail_y" = 23, "under_x" = 33, "under_y" = 16)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/quickfire,
		/obj/item/attachable/scope/slavic,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/bipod,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung)

/obj/item/weapon/gun/fallout_rifle/r91
	name = "\improper R-91 assault rifle"
	desc = "Standard issue rifle of the US armed forces."
	icon_state = "r91"
	item_state = "R84"	//Needs an appropriate worn icon, this will do for now though
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/r91_rifle_fire.wav'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/r91_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/r91_rifle_reload.wav'
	cocked_sound = 'fallout/fallout sounds/fallout weapon sounds/r91_rifle_cock.wav'
	fire_delay = 0.3 SECONDS
	force = 18
	wield_delay = 1.2 SECONDS
	aim_slowdown = 2.1
	scatter = 3
	scatter_unwielded = 15
	recoil = 0.7
	recoil_unwielded = 4

/obj/item/weapon/gun/fallout_rifle/varmint
	name = "varmint rifle"
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
	scatter = 3
	scatter_unwielded = 15
	recoil = 0
	recoil_unwielded = 0.3
	attachable_offset = list("muzzle_x" = 44, "muzzle_y" = 19, "rail_x" = 13, "rail_y" = 21, "under_x" = 27, "under_y" = 15)

/obj/item/weapon/gun/fallout_rifle/hunting
	name = "hunting rifle"
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
	attachable_offset = list("muzzle_x" = 49, "muzzle_y" = 19, "rail_x" = 19, "rail_y" = 21, "under_x" = 30, "under_y" = 15)

/obj/item/weapon/gun/fallout_rifle/hunting/short
	name = "short hunting rifle"
	icon_state = "hunting_rifle_short"
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	scatter = 5
	scatter_unwielded = 20
	recoil = 1.2
	recoil_unwielded = 3

/obj/item/weapon/gun/fallout_rifle/delisle
	name = "\improper DeLisle carbine"
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
	recoil_unwielded = 0.4
	attachable_offset = list("muzzle_x" = 43, "muzzle_y" = 20, "rail_x" = 23, "rail_y" = 22, "under_x" = 28, "under_y" = 16)

/obj/item/weapon/gun/fallout_rifle/anti_materiel
	name = "\improper Hecate II anti-materiel rifle"
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
	scatter = 3
	scatter_unwielded = 15
	recoil = 0.2
	recoil_unwielded = 1
	attachable_offset = list("muzzle_x" = 47, "muzzle_y" = 21, "rail_x" = 16, "rail_y" = 22, "under_x" = 30, "under_y" = 17)

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

//Heavy weapons
/obj/item/weapon/gun/fallout_rifle/m60
	name = "\improper M60 machinegun"
	desc = "Heavy and cumbersome, the M60 is a powerful weapon for laying down suppressive fire."
	icon_state = "m60"
	fire_sound =  'sound/weapons/guns/fire/GPMG.ogg'
	fire_rattle =  'sound/weapons/guns/fire/GPMG_low.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/T42_reload.ogg'
	flags_gun_features = GUN_WIELDED_FIRING_ONLY
	gun_skill_category = GUN_SKILL_HEAVY_WEAPONS
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/machinegun
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/machinegun, /obj/item/ammo_magazine/fallout_ammopack)
	max_shells = 500
	fire_delay = 0.18 SECONDS
	force = 35
	wield_delay = 2 SECONDS
	aim_slowdown = 3
	scatter = 3
	recoil = 1
	attachable_offset = list("muzzle_x" = 41, "muzzle_y" = 17, "rail_x" = 17, "rail_y" = 19, "under_x" = 28, "under_y" = 13)

//For switching the sprite to the one with a belt
/obj/item/weapon/gun/fallout_rifle/m60/update_icon()
	. = ..()
	for(var/obj/item/ammo_magazine/belt in chamber_items)	//Check if it has a belt mag
		if(istype(belt, /obj/item/ammo_magazine/fallout_ammopack))
			icon_state = base_gun_icon + "_b"
			if(!rounds)
				icon_state = base_gun_icon + "_u"

/obj/item/weapon/gun/fallout_rifle/howard
	name = "\improper Howard MG"
	desc = "A flexible machinegun. The Howard MG is lighter than most LMGs while still being capable of sustained fire. \
			It features the ability to accept both standard rifle magazines and machinegun box magazines."
	icon_state = "howard"
	fire_sound =  'sound/weapons/guns/fire/t42.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/T42_reload.ogg'
	flags_gun_features = GUN_WIELDED_FIRING_ONLY
	gun_skill_category = GUN_SKILL_HEAVY_WEAPONS
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/extended
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/fallout_rifle,
		/obj/item/ammo_magazine/fallout_rifle/extended,
		/obj/item/ammo_magazine/fallout_rifle/machinegun)
	max_shells = 90
	fire_delay = 0.25 SECONDS
	force = 25
	wield_delay = 1.5 SECONDS
	aim_slowdown = 2.5
	scatter = 7
	recoil = 0.8
	attachable_offset = list("muzzle_x" = 35, "muzzle_y" = 17, "rail_x" = 20, "rail_y" = 20, "under_x" = 24, "under_y" = 12)

//Keep the minigun here I guess
/obj/item/weapon/gun/fallout_minigun
	name = "\improper CZ53 Rockwell minigun"
	desc = "Absolute peak dakka. Can use either machinegun magazines or be attached to an ammo backpack. Has a deployable tripod."
	icon = 'fallout/fallout icons/fallout weapons/fallout_heavy.dmi'
	icon_state = "minigun"
	fire_animation = "minigun_fire"
	item_icons = list(
		slot_back_str = 'fallout/fallout icons/fallout weapons/fallout_rifles_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_guns.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_guns.dmi')
	muzzleflash_iconstate = "muzzle_flash"
	fire_sound = 'sound/weapons/guns/fire/minigun.ogg'
	unload_sound = 'sound/weapons/guns/interact/minigun_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/minigun_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/minigun_cocked.ogg'
	windup_sound = 'sound/weapons/guns/fire/tank_minigun_start.ogg'
	w_class = WEIGHT_CLASS_HUGE
	gun_skill_category = GUN_SKILL_HEAVY_WEAPONS
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	flags_item = IS_DEPLOYABLE|TWOHANDED
	flags_gun_features = GUN_WIELDED_FIRING_ONLY
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/machinegun
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/machinegun, /obj/item/ammo_magazine/fallout_ammopack)
	caliber = CALIBER_556X45
	max_shells = 500
	fire_delay = 0.1 SECONDS
	windup_delay = 0.5 SECONDS
	force = 40
	wield_delay = 1.5 SECONDS
	aim_slowdown = 3.5
	scatter = 10
	scatter_unwielded = 40
	deployed_scatter_change = -8
	recoil = 1
	recoil_unwielded = 20
	deploy_time = 5 SECONDS
	undeploy_time = 3 SECONDS
	deployable_item = /obj/machinery/deployable/mounted
	attachable_offset = list("rail_x" = 26, "rail_y" = 20, "under_x" = 30, "under_y" = 8)
	attachable_allowed = list(/obj/item/attachable/flashlight, /obj/item/attachable/lasersight)

//For switching the sprite to the one with a belt
/obj/item/weapon/gun/fallout_minigun/update_icon()
	..()
	if(!length(chamber_items))
		icon_state = base_gun_icon + "_u"
		fire_animation = initial(fire_animation)
	else
		icon_state = base_gun_icon
	if(length(chamber_items) && !rounds)
		icon_state = base_gun_icon + "_e"
	for(var/obj/item/ammo_magazine/belt in chamber_items)	//Check if it has a belt mag
		if(istype(belt, /obj/item/ammo_magazine/fallout_ammopack))
			icon_state = base_gun_icon + "_b"
			fire_animation = initial(fire_animation) + "_b"
			if(!rounds)
				icon_state = base_gun_icon + "_u"
