//Pump action shotguns
/obj/item/weapon/gun/fallout/shotgun
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
	gun_skill_category = SKILL_SHOTGUNS
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	default_ammo_type = /datum/ammo/bullet/fallout/buckshot
	allowed_ammo_types = list()
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
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
	recoil_unwielded = 5	//What you get for firing a long shotgun one-handed
	cocked_message = "You rack the pump."
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

/obj/item/weapon/gun/fallout/shotgun/short
	name = "\improper Short Pump Shotgun"
	desc = "Reliable and common shotgun. Operated by racking the pump before each shot. Fits in your bag."
	icon_state = "pump_short"
	w_class = WEIGHT_CLASS_NORMAL
	damage_falloff_mult = 2 //Worse range
	force = 10
	wield_delay = 0.4 SECONDS
	aim_slowdown = 1.5
	scatter = 5
	scatter_unwielded = 15
	recoil = 1.3
	recoil_unwielded = 3

/obj/item/weapon/gun/fallout/shotgun/double
	name = "\improper Double Barrel Shotgun"
	desc = "The reliable and easy to manufacture boomstick. Quite compact as well."
	icon_state = "double_barrel"
	w_class = WEIGHT_CLASS_NORMAL
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_TOGGLES_OPEN_EJECTS
	max_chamber_items = 2
	max_shells = 2
	fire_delay = 0.2 SECONDS
	damage_falloff_mult = 2
	force = 10
	wield_delay = 0.3 SECONDS
	aim_slowdown = 1
	scatter = 5
	scatter_unwielded = 15
	recoil = 1.5
	recoil_unwielded = 4
	chamber_opened_message = "You hinge the barrels down."
	chamber_closed_message = "You snap the barrels back up."

/obj/item/weapon/gun/fallout/shotgun/trench
	name = "\improper Winchester Model 1897"
	desc = "Classic pump action designed for close quarters combat. Illegal in Germany."
	icon_state = "trench"
	max_chamber_items = 6
	fire_delay = 0.3 SECONDS
	force = 25
	wield_delay = 1 SECONDS
	scatter = 5

/obj/item/weapon/gun/fallout/shotgun/lever
	name = "\improper Winchester Model 1887"
	desc = "Every cowboy's trusty lever-action shotgun."
	icon_state = "lever_action"
	item_state = "cowboy_repeater"	//They look close enough and I am tired
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION
	max_chamber_items = 7
	max_shells = 7
	fire_delay = 0.1 SECONDS
	scatter = 3
	scatter_unwielded = 15
	attachable_offset = list("muzzle_x" = 47, "muzzle_y" = 21, "rail_x" = 16, "rail_y" = 22, "under_x" = 30, "under_y" = 17)

//Same as the code for lever action rifle
/obj/item/weapon/gun/fallout/shotgun/lever/unique_action(mob/user, dont_operate = FALSE)
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

//Magazine-fed semi-automatic and automatic shotguns
/obj/item/weapon/gun/fallout/shotgun/combat
	name = "\improper Combat Shotgun"
	desc = "Magazine fed shotgun with select fire capabilities. Aim in the general direction of your enemy to fill them with holes."
	icon_state = "combat_shotgun"
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
	force = 30
	wield_delay = 1 SECONDS
	aim_slowdown = 2.2
	scatter = 15

/obj/item/weapon/gun/fallout/shotgun/combat/short
	name = "\improper Short Combat Shotgun"
	desc = "Magazine fed shotgun with select fire capabilities. Aim in the general direction of your enemy to fill them with holes. Fits in your bag."
	icon_state = "combat_shotgun_short"
	w_class = WEIGHT_CLASS_NORMAL
	damage_falloff_mult = 2 //Worse range
	force = 10
	wield_delay = 0.4 SECONDS
	aim_slowdown = 1.8
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
