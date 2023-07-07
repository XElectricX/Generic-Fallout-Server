/obj/item/weapon/gun/fallout/smg
	name = "\improper M3 \"Grease Gun\""
	desc = "A barebones submachine gun. Easy to use and maintain."
	icon = 'fallout/fallout icons/fallout weapons/fallout_smgs.dmi'
	icon_state = "m3"
	muzzleflash_iconstate = "muzzle_flash_medium"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/9mm_smg_fire.wav'
	unload_sound = 'sound/weapons/guns/interact/smg_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/smg_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/smg_cocked.ogg'
	w_class = WEIGHT_CLASS_BULKY
	gun_skill_category = SKILL_SMGS
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	//I discovered what open bolt guns mean well after I did the chambered sprites for guns so they will retain their bullet in chamber
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	default_ammo_type = /obj/item/ammo_magazine/fallout_smg
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_smg)
	caliber = CALIBER_9X19
	max_shells = 25
	fire_delay = 0.12 SECONDS
	force = 12
	wield_delay = 0.4 SECONDS
	aim_slowdown = 0.5
	scatter = 10
	scatter_unwielded = 20
	recoil = 0.5
	recoil_unwielded = 1.5
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
		/obj/item/attachable/foldable/bipod)
	attack_speed = ATTACK_SPEED_FAST

/obj/item/weapon/gun/fallout/smg/ten
	name = "\improper 10mm Submachinegun"
	desc = "Mass-produced, high quality submachinegun. Favorite among pre-war civilians and private security personnel. Still a favorite post-war."
	icon_state = "smg10"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/10mm_smg_fire.wav'
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	default_ammo_type = /obj/item/ammo_magazine/fallout_smg/ten
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_smg/ten)
	caliber = CALIBER_10X25MM
	max_shells = 20
	fire_delay = 0.2 SECONDS
	force = 15
	wield_delay = 0.6 SECONDS
	aim_slowdown = 0.6
	scatter = 8
	scatter_unwielded = 17
	recoil = 0.3
	recoil_unwielded = 1.2

/obj/item/weapon/gun/fallout/smg/uzi
	name = "\improper Uzi Submachinegun"
	desc = "Some raiders try to shoot these sideways. Try."
	icon_state = "uzi"
	fire_sound = 'sound/weapons/guns/fire/uzi.ogg'
	default_ammo_type = /obj/item/ammo_magazine/fallout_smg/acp
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_smg/acp)
	caliber = CALIBER_45ACP
	max_shells = 22
	fire_delay = 0.1 SECONDS
	force = 12
	wield_delay = 0.4 SECONDS
	aim_slowdown = 0.4
	recoil = 0.5
	recoil_unwielded = 1.5

/obj/item/weapon/gun/fallout/smg/thompson
	name = "\improper Thompson Submachinegun"
	desc = "Classic lead sprayer, still in working order."
	icon_state = "thompson"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/10mm_pistol_fire_heavy.wav'
	w_class = WEIGHT_CLASS_BULKY
	default_ammo_type = /obj/item/ammo_magazine/fallout_smg/acp/thompson
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_smg/acp/thompson, /obj/item/ammo_magazine/fallout_smg/acp/drum)
	caliber = CALIBER_45ACP
	max_shells = 20
	fire_delay = 0.15 SECONDS
	force = 20
	wield_delay = 0.7 SECONDS
	aim_slowdown = 0.7
	scatter = 8
	scatter_unwielded = 25
	recoil = 0.6
	recoil_unwielded = 2

//For switching the sprite to the one with a drum
/obj/item/weapon/gun/fallout/smg/thompson/update_icon()
	. = ..()
	for(var/obj/item/ammo_magazine/fallout_smg/acp/drum/drum in contents)	//Check if it has a drum mag
		icon_state = base_gun_icon + "_drum"
		if(length(chamber_items) && !rounds)
			icon_state = base_gun_icon + "_drum_e"


/obj/item/weapon/gun/fallout/smg/american180
	name = "\improper American 180"
	desc = "Shoots angry bees."
	icon_state = "american180"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/american180.ogg'
	w_class = WEIGHT_CLASS_BULKY
	default_ammo_type = /obj/item/ammo_magazine/fallout_smg/subsonic
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_smg/subsonic)
	caliber = CALIBER_22LR
	max_shells = 180
	fire_delay = 0.2 SECONDS
	force = 20
	wield_delay = 0.7 SECONDS
	aim_slowdown = 0.7
	scatter = 5
	scatter_unwielded = 25
	recoil = 0.1
	recoil_unwielded = 0.4

/obj/item/weapon/gun/fallout/smg/carl_gustaf
	name = "\improper Carl Gustaf m/45"
	desc = "A Swedish invention, it is the culmination of WWII-era submachinegun designs. Has a folding stock."
	icon_state = "cg45"
	fire_sound = 'sound/weapons/guns/fire/smg_light.ogg'
	fire_delay = 0.15 SECONDS
	force = 14
	wield_delay = 0.5 SECONDS
	aim_slowdown = 0.6
	scatter = 8
	recoil = 0.4

/obj/item/weapon/gun/fallout/smg/sten
	name = "\improper Sten Mark V"
	desc = "One of the simplest and cheapest to produce firearms, the Sten continues to find use in a resource-scarce world."
	icon_state = "sten"
	fire_sound = 'sound/weapons/guns/fire/smg_light.ogg'
	fire_delay = 0.2 SECONDS
	aim_slowdown = 0.6
	scatter = 12
	scatter_unwielded = 22
	recoil = 0.6
	recoil_unwielded = 1.6
