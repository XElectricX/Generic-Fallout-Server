/obj/item/weapon/gun/fallout_smg
	name = "\improper M3 \"Grease Gun\""
	desc = "A barebones submachine gun. Easy to use and maintain."
	icon = 'fallout/fallout icons/fallout weapons/fallout_smgs.dmi'
	icon_state = "m3"
	item_icons = list(
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_guns.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_guns.dmi')
	muzzleflash_iconstate = "muzzle_flash_medium"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/9mm_smg_fire.wav'
	unload_sound = 'sound/weapons/guns/interact/smg_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/smg_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/smg_cocked.ogg'
	w_class = WEIGHT_CLASS_BULKY
	gun_skill_category = GUN_SKILL_SMGS
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
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

/obj/item/weapon/gun/fallout_smg/ten
	name = "\improper 10mm Submachinegun"
	desc = "Mass-produced, high quality submachinegun. Favorite among pre-war civilians and private security personnel. Still a favorite post-war."
	icon_state = "smg10"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/10mm_smg_fire.wav'
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

/obj/item/weapon/gun/fallout_smg/uzi
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

/obj/item/weapon/gun/fallout_smg/thompson
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
/obj/item/weapon/gun/fallout_smg/thompson/update_icon_state()
	. = ..()
	for(var/obj/drum in contents)	//Check if it has a drum mag
		if(istype(drum,/obj/item/ammo_magazine/fallout_smg/acp/drum))
			icon_state = base_gun_icon + "_drum"
		else if(length(chamber_items) && !rounds)
			icon_state = base_gun_icon + "_drum_e"


/obj/item/weapon/gun/fallout_smg/american180
	name = "\improper American 180"
	desc = "Shoots angry bees."
	icon_state = "american180"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/american180.ogg'
	w_class = WEIGHT_CLASS_BULKY
	default_ammo_type = /obj/item/ammo_magazine/fallout_smg/subsonic
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_smg/subsonic)
	caliber = CALIBER_22LR
	max_shells = 100
	fire_delay = 0.2 SECONDS
	force = 20
	wield_delay = 0.7 SECONDS
	aim_slowdown = 0.7
	scatter = 5
	scatter_unwielded = 25
	recoil = 0.1
	recoil_unwielded = 0.4
