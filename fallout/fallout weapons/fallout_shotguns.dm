//Pump action shotguns
/obj/item/weapon/gun/fallout_shotgun
	name = "\improper Pump Shotgun"
	desc = "Reliable and common shotgun. Operated by racking the pump before each shot."
	icon = 'fallout/fallout icons/fallout weapons/fallout_shotguns.dmi'
	icon_state = "pump"
	item_icons = list(
		slot_back_str = 'fallout/fallout icons/fallout weapons/fallout_shotguns_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_guns.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_guns.dmi')
	fire_sound = 'sound/weapons/guns/fire/shotgun.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/shotgun_empty.ogg'
	reload_sound = 'sound/weapons/guns/interact/shotgun_shell_insert.ogg'
	hand_reload_sound = 'sound/weapons/guns/interact/shotgun_shell_insert.ogg'
	cocked_sound = 'sound/weapons/guns/interact/shotgun_reload.ogg'
	opened_sound = 'sound/weapons/guns/interact/shotgun_open.ogg'
	flags_equip_slot = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	gun_skill_category = GUN_SKILL_SHOTGUNS
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	default_ammo_type = /datum/ammo/bullet/fallout/buckshot
	allowed_ammo_types = list()
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION|AMMO_RECIEVER_UNIQUE_ACTION_LOCKS
	load_method = SINGLE_CASING
	caliber = CALIBER_12G
	type_of_casings = "shell"
	max_chamber_items = 5
	fire_delay = 0.5 SECONDS
	force = 20
	wield_delay = 0.8 SECONDS
	aim_slowdown = 2
	scatter = 0
	scatter_unwielded = 10
	recoil = 1
	recoil_unwielded = 5    //What you get for firing a long shotgun one-handed
	cocked_message = "You rack the pump."
	cock_locked_message = "The pump is locked and ready to fire."
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

/obj/item/weapon/gun/fallout_shotgun/short
	name = "\improper Short Pump Shotgun"
	desc = "Reliable and common shotgun. Operated by racking the pump before each shot. Fits in your bag."
	icon_state = "pump_short"
	w_class = WEIGHT_CLASS_NORMAL
	damage_falloff_mult = 2 //Worse range
	force = 10
	wield_delay = 0.4 SECONDS
	scatter = 5
	scatter_unwielded = 15
	recoil = 1.3
	recoil_unwielded = 3

//Magazine-fed semi-automatic and automatic shotguns
/obj/item/weapon/gun/fallout_shotgun/combat
	name = "\improper Combat Shotgun"
	desc = "Magazine fed shotgun with select fire capabilities. Aim in the general direction of your enemy to fill them with holes."
	icon_state = "combat"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/combat_shotgun_fire.wav'
	unload_sound = 'sound/weapons/guns/interact/m16_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/rifle_reload.ogg'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO, GUN_FIREMODE_AUTOMATIC)
	default_ammo_type = /obj/item/ammo_magazine/fallout_shotgun
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_shotgun)
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	load_method = MAGAZINE
	max_chamber_items = 1
	max_shells = 12
	fire_delay = 0.3 SECONDS
	wield_delay = 1 SECONDS
	scatter = 15
	scatter_unwielded = 40
	recoil = 1.2
	recoil_unwielded = 5

/obj/item/weapon/gun/fallout_shotgun/combat/short
	name = "\improper Short Combat Shotgun"
	desc = "Magazine fed shotgun with select fire capabilities. Aim in the general direction of your enemy to fill them with holes. Fits in your bag."
	icon_state = "combat_short"
	w_class = WEIGHT_CLASS_NORMAL
	damage_falloff_mult = 2 //Worse range
	force = 10
	wield_delay = 0.4 SECONDS
	scatter = 25
	scatter_unwielded = 30
	recoil = 1.5
	recoil_unwielded = 3

//Tweaks to the underbarrel shotgun
/obj/item/weapon/gun/shotgun/combat/masterkey
	flags_gun_features = GUN_IS_ATTACHMENT|GUN_ATTACHMENT_FIRE_ONLY|GUN_CAN_POINTBLANK
	default_ammo_type = /datum/ammo/bullet/fallout/buckshot
	damage_mult = 1
	damage_falloff_mult = 2
