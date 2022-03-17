/obj/item/weapon/gun/fallout_pistol
	name = "Browning Highpower Pistol"
	desc = "Common 9mm pistol."
	icon = 'fallout/fallout icons/fallout weapons/fallout_pistols.dmi'
	icon_state = "browning_highpower"
	item_icons = list(
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_guns.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_guns.dmi',
		)
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/9mm_pistol_fire.wav'
	unload_sound = 'sound/weapons/guns/interact/pistol_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/pistol_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/pistol_cocked.ogg'
	w_class = WEIGHT_CLASS_SMALL
	gun_skill_category = GUN_SKILL_PISTOLS
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol
	allowed_ammo_types = /obj/item/ammo_magazine/fallout_pistol
	caliber = CALIBER_9X19
	max_shells = 15
	fire_delay = 0.2 SECONDS
	force = 8
	wield_delay = 0.2 SECONDS
	aim_slowdown = 0.2
	scatter = 3
	scatter_unwielded = 8
	recoil_unwielded = 0.6

/obj/item/weapon/gun/fallout_pistol/n99
	name = "N99 Pistol"
	desc = "One of the most popular handguns in the wastes. Relatively powerful for its size and highly customizable."
	icon_state = "n99"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/10mm_pistol_fire.ogg'
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/ten
	allowed_ammo_types = /obj/item/ammo_magazine/fallout_pistol/ten
	caliber = CALIBER_10X25MM
	max_shells = 10
	fire_delay = 0.3 SECONDS
	force = 10
	wield_delay = 0.3 SECONDS
	aim_slowdown = 0.3
	scatter = 5
	scatter_unwielded = 10
	recoil_unwielded = 0.8
