/obj/item/weapon/gun/fallout/rifle
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
		/obj/item/attachable/foldable/bipod,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung)

/obj/item/weapon/gun/fallout/rifle/bears_roar
	name = "\improper The Bear's Roar"
	desc = "Appears to be an improved service rifle made by a very patriotic fellow."
	icon_state = "bears_roar"
	fire_delay = 0.2 SECONDS

/obj/item/weapon/gun/fallout/rifle/r91
	name = "\improper R-91 assault rifle"
	desc = "Standard issue rifle of the US armed forces."
	icon_state = "r91"
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

/obj/item/weapon/gun/fallout/rifle/ak47
	name = "\improper Kalashnikov automatic rifle"
	desc = "Iconic weapon that made assault rifles accessible to practically anyone. It has been surpassed by modern designs, but it still remains a reliable option. Modified for 5.56mm rounds."
	icon_state = "ak47"
	fire_sound = 'sound/weapons/guns/fire/ak47.ogg'
	unload_sound = 'sound/weapons/guns/interact/ak47_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ak47_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/ak47_cocked.ogg'
	fire_delay = 0.25 SECONDS
	force = 20
	wield_delay = 1.4 SECONDS
	scatter_unwielded = 15
	recoil = 0.9
	recoil_unwielded = 4

/obj/item/weapon/gun/fallout/rifle/ak47/type93
	name = "\improper Type 93 assault rifle"
	desc = "Stadard issue weapon of the People's Liberation Army. Built off of the old Kalashnikov design and mass produced for both soldiers and infiltrators."
	icon_state = "type93"	//Need an actual Chinese AR sprite

/obj/item/weapon/gun/fallout/rifle/ak47/type93/golden_star
	name = "\improper The People's Golden Star"
	desc = "An old Chinese assault rifle that probably belonged to some PLA officer."
	icon_state = "golden_star"
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/machinegun
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle, /obj/item/ammo_magazine/fallout_rifle/extended, /obj/item/ammo_magazine/fallout_rifle/machinegun)
	max_shells = 90
	force = 25
	recoil = 0.2

/obj/item/weapon/gun/fallout/rifle/varmint
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

//Battle rifles
/obj/item/weapon/gun/fallout/rifle/combat
	name = "combat rifle"
	desc = "Standard issue battle rifle of the pre-war US military. "
	icon_state = "combat_rifle"
	fire_sound = 'sound/weapons/guns/fire/t18.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/t18_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/t18_reload.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/winchester
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/winchester, /obj/item/ammo_magazine/fallout_rifle/winchester/short, /obj/item/ammo_magazine/fallout_rifle/winchester/extended)
	caliber = CALIBER_308WIN
	max_shells = 10
	fire_delay = 0.5 SECONDS
	force = 20
	wield_delay = 1.5 SECONDS
	aim_slowdown = 2.5
	scatter = 0
	scatter_unwielded = 10
	recoil = 0.8
	recoil_unwielded = 5

/obj/item/weapon/gun/fallout/rifle/fn_fal
	name = "\improper FN FAL battle rifle"
	desc = "Widely used pre-war, but harder to find these days. This wonderful machine can deliver .308 rounds in automatic and semi-automatic settings."
	icon_state = "fn_fal"
	item_state = "l1a1"
	fire_sound = 'sound/weapons/guns/fire/m16.ogg'
	unload_sound = 'sound/weapons/guns/interact/m16_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m16_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/m16_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/winchester/extended
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/winchester, /obj/item/ammo_magazine/fallout_rifle/winchester/short, /obj/item/ammo_magazine/fallout_rifle/winchester/extended)
	caliber = CALIBER_308WIN
	max_shells = 15
	fire_delay = 0.5 SECONDS
	force = 20
	wield_delay = 1.3 SECONDS
	aim_slowdown = 2.3
	scatter = 0
	scatter_unwielded = 10
	recoil = 1
	recoil_unwielded = 5

/obj/item/weapon/gun/fallout/rifle/fn_fal/israel
	name = "\improper Israeli FAL battle rifle"
	desc = "Israeli-produced paratrooper configuration of the FN FAL."
	icon_state = "fn_fal_israel"
	item_state = "l1a1"

/obj/item/weapon/gun/fallout/rifle/fn_fal/l1a1
	name = "\improper L1A1 Self-Loading Rifle"
	desc = "British-produced FN FAL, now in metric!"
	icon_state = "l1a1"

//Bolt-action rifles, DMRs, snipers
/obj/item/weapon/gun/fallout/rifle/hunting
	name = "hunting rifle"
	desc = "A simple bolt-action long gun. Hunting license not included."
	icon_state = "hunting_rifle"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_fire.wav'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_reload.wav'
	cocked_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_cock.wav'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/winchester/short
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/winchester, /obj/item/ammo_magazine/fallout_rifle/winchester/short)
	caliber = CALIBER_308WIN
	max_shells = 5
	fire_delay = 0.8 SECONDS
	force = 20
	scatter = 0
	scatter_unwielded = 15
	recoil = 0.8
	recoil_unwielded = 5
	attachable_offset = list("muzzle_x" = 49, "muzzle_y" = 19, "rail_x" = 19, "rail_y" = 21, "under_x" = 30, "under_y" = 15)

/obj/item/weapon/gun/fallout/rifle/hunting/short
	name = "short hunting rifle"
	icon_state = "hunting_rifle_short"
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	scatter = 5
	scatter_unwielded = 20
	recoil = 1.2
	recoil_unwielded = 3

/obj/item/weapon/gun/fallout/rifle/delisle
	name = "\improper DeLisle carbine"
	desc = "Suppressed bolt-action rifle. One of the quietest firearms in existence."
	icon_state = "delisle"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/american180.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
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

/obj/item/weapon/gun/fallout/rifle/garand
	name = "\improper M1 Garand"
	desc = "Old, but still popular semi-automatic rifle. Chambered in .308 Winchester. Garand ping included."
	icon_state = "m1_garand"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_fire.wav'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/garand_ping.ogg'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_reload.wav'
	cocked_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_cock.wav'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT|AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/winchester/en_bloc
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/winchester/en_bloc)
	caliber = CALIBER_308WIN
	max_shells = 8
	fire_delay = 0.5 SECONDS
	force = 20
	aim_slowdown = 2.5
	scatter = 3
	scatter_unwielded = 7
	recoil = 0.5
	recoil_unwielded = 3

/obj/item/weapon/gun/fallout/rifle/garand/americas_pride
	name = "\improper America's Pride"
	desc = "Glory, glory, what a hell of a way to die."
	icon_state = "americas_pride"
	fire_delay = 0.4 SECONDS
	wield_delay = 0.5 SECONDS
	recoil = 0.3
	recoil_unwielded = 2.5

/obj/item/weapon/gun/fallout/rifle/enfield
	name = "\improper Lee-Enfield No. 4 bolt-action rifle"
	desc = "Ancient rifle that was commonly used in the battlefield. Can fit up to 10 rounds of .308 Winchester."
	icon_state = "no4"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_fire.wav'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_reload.wav'
	cocked_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_cock.wav'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/winchester/clip
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/winchester/clip)
	caliber = CALIBER_308WIN
	max_shells = 10
	max_chamber_items = 11
	max_rounds = 11
	fire_delay = 0.6 SECONDS
	force = 20
	aim_slowdown = 2.5
	scatter = 0
	scatter_unwielded = 5
	recoil = 0.6
	recoil_unwielded = 3

/obj/item/weapon/gun/fallout/rifle/enfield/smle
	name = "\improper Short Magazine Lee-Enfield bolt-action rifle"
	desc = "A smelly rifle."
	icon_state = "smle"

/obj/item/weapon/gun/fallout/rifle/enfield/pederson
	name = "\improper Pederson rifle"
	desc = "An SMLE that had it's reciever swapped with a semi automatic one chambered in .22 LR."
	icon_state = "smle_pederson"
	item_state = "smle"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/varmint_rifle_fire.ogg'
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/subsonic
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/subsonic)
	caliber = CALIBER_22LR
	max_shells = 15
	fire_delay = 0.3 SECONDS
	scatter = 3
	scatter_unwielded = 15
	recoil = 0
	recoil_unwielded = 0.3

/obj/item/weapon/gun/fallout/rifle/scrap_rifle
	name = "scrap bolt-action rifle"
	desc = "A clip-fed, bolt-action rifle made from spare parts."
	icon_state = "mauser"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_fire.wav'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_reload.wav'
	cocked_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_cock.wav'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/winchester/clip
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/winchester/clip)
	caliber = CALIBER_308WIN
	max_shells = 5
	max_chamber_items = 6
	max_rounds = 6
	fire_delay = 0.5 SECONDS
	force = 15
	aim_slowdown = 1.8
	scatter = 5
	scatter_unwielded = 15
	recoil = 1
	recoil_unwielded = 5

/obj/item/weapon/gun/fallout/rifle/springfield_trapdoor
	name = "\improper Springfield Model 1873 \"Trapdoor\""
	desc = "The first standard-issue breech-loading rifle used by the pre-war US military. Only holds a single .45-70 round. Reload after every shot."
	icon_state = "springfield_trapdoor"
	item_state = "no4"
	fire_sound = 'sound/weapons/guns/fire/martini.ogg'
	unload_sound = 'sound/weapons/guns/interact/martini_open.ogg'
	reload_sound = 'sound/weapons/guns/interact/martini_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/martini_cocked.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_TOGGLES_OPEN_EJECTS
	default_ammo_type = /datum/ammo/bullet/fallout/govt
	allowed_ammo_types = /datum/ammo/bullet/fallout/govt
	caliber = CALIBER_4570
	max_shells = 1
	max_chamber_items = 1
	fire_delay = 0.2 SECONDS
	force = 20
	wield_delay = 1.2 SECONDS
	scatter = 0
	scatter_unwielded = 5
	recoil = 1
	recoil_unwielded = 5

/obj/item/weapon/gun/fallout/rifle/mosin
	name = "\improper Mosin-Nagant bolt-action rifle"
	desc = "A cheap, mass produced firearm. Used over several centuries by many different militaries."
	icon_state = "mosin"
	fire_sound = 'sound/weapons/guns/fire/mosin.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_rifle_unload.wav'
	reload_sound = 'sound/weapons/guns/interact/mosin_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/working_the_bolt.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/russian/clip
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/russian/clip)
	caliber = CALIBER_762X54
	max_shells = 5
	max_chamber_items = 6
	max_rounds = 6
	fire_delay = 0.7 SECONDS
	force = 20
	aim_slowdown = 2.2
	scatter = 3
	scatter_unwielded = 10
	recoil = 1
	recoil_unwielded = 5

/obj/item/weapon/gun/fallout/rifle/svd
	name = "\improper SVD marksman rifle"
	desc = "The natural evolution of the Mosin-Nagant. Packs the same punch but in a semi-automatic package."
	icon_state = "svd"
	fire_sound = 'sound/weapons/guns/fire/svd.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/svd_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/svd_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/svd_cocked.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/russian
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/russian)
	caliber = CALIBER_762X54
	max_shells = 10
	fire_delay = 0.6 SECONDS
	force = 25
	aim_slowdown = 2.8
	scatter = 0
	scatter_unwielded = 7
	recoil = 0.6
	recoil_unwielded = 4
	attachable_offset = list("muzzle_x" = 59, "muzzle_y" = 19,"rail_x" = 21, "rail_y" = 22, "under_x" = 35, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)

/obj/item/weapon/gun/fallout/rifle/anti_materiel
	name = "\improper Hecate II anti-materiel rifle"
	desc = "Heavy bolt-action rifle chambered for .50 BMG. Necessary for when you want to kill someone and the wall they were hiding behind."
	icon_state = "hecate"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/antimateriel_rifle_fire.wav'
	unload_sound = 'fallout/fallout sounds/fallout weapon sounds/antimateriel_rifle_unload.wav'
	reload_sound = 'fallout/fallout sounds/fallout weapon sounds/antimateriel_rifle_reload.wav'
	cocked_sound = 'sound/weapons/guns/interact/tl-127_bolt.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/bmg
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/bmg)
	caliber = CALIBER_50BMG
	max_shells = 5
	fire_delay = 1 SECONDS
	force = 40
	wield_delay = 1.2 SECONDS
	aim_slowdown = 3
	scatter = 0
	scatter_unwielded = 15
	recoil = 1.5
	recoil_unwielded = 10
	recoil_backtime_multiplier = 5
	recoil_deviation = 0
	attachable_offset = list("rail_x" = 22, "rail_y" = 19, "under_x" = 32, "under_y" = 13)
	starting_attachment_types = list(/obj/item/attachable/scope/anti_materiel, /obj/item/attachable/foldable/bipod)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/scope/slavic,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/anti_materiel,
		/obj/item/attachable/foldable/bipod)

/obj/item/weapon/gun/fallout/rifle/cowboy_repeater
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
/obj/item/weapon/gun/fallout/rifle/cowboy_repeater/unique_action(mob/user, dont_operate = FALSE)
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
/obj/item/weapon/gun/fallout/rifle/m60
	name = "\improper M60 machinegun"
	desc = "Heavy and cumbersome, the M60 is a powerful weapon for laying down suppressive fire."
	icon_state = "m60"
	fire_sound =  'sound/weapons/guns/fire/GPMG.ogg'
	fire_rattle =  'sound/weapons/guns/fire/GPMG_low.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/T42_reload.ogg'
	flags_gun_features = GUN_WIELDED_FIRING_ONLY
	gun_skill_category = SKILL_HEAVY_WEAPONS
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
/obj/item/weapon/gun/fallout/rifle/m60/update_icon()
	. = ..()
	for(var/obj/item/ammo_magazine/belt in chamber_items)	//Check if it has a belt mag
		if(istype(belt, /obj/item/ammo_magazine/fallout_ammopack))
			icon_state = base_gun_icon + "_b"
			if(!rounds)
				icon_state = base_gun_icon + "_u"

/obj/item/weapon/gun/fallout/rifle/howard
	name = "\improper Howard MG"
	desc = "A flexible machinegun. The Howard MG is lighter than most LMGs while still being capable of sustained fire. \
			It features the ability to accept both standard rifle magazines and machinegun box magazines."
	icon_state = "howard"
	fire_sound =  'sound/weapons/guns/fire/t27.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/T42_reload.ogg'
	flags_gun_features = GUN_WIELDED_FIRING_ONLY
	gun_skill_category = SKILL_HEAVY_WEAPONS
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

/obj/item/weapon/gun/fallout/rifle/lewis
	name = "\improper Lewis MG"
	desc = "Rejected in America, but adopted by the British. The classic Lewis machinegun continues to prove itself even out in the wasteland. Chambered in .308 for extra power."
	icon_state = "lewis"
	fire_sound =  'sound/weapons/guns/fire/smartgun1.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/p90_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/p90_reload.ogg'
	flags_gun_features = GUN_WIELDED_FIRING_ONLY
	gun_skill_category = SKILL_HEAVY_WEAPONS
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/pan
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/pan)
	max_shells = 90
	fire_delay = 0.25 SECONDS
	force = 35
	wield_delay = 2 SECONDS
	aim_slowdown = 3.2
	scatter = 5
	recoil = 1.2
