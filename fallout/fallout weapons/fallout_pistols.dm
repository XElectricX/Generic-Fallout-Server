//Mag-fed handguns
/obj/item/weapon/gun/fallout/pistol
	name = "\improper Browning Hi-Power Pistol"
	desc = "Common 9mm pistol."
	icon = 'fallout/fallout icons/fallout weapons/fallout_pistols.dmi'
	icon_state = "hipower"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/9mm_pistol_fire.ogg'
	unload_sound = 'sound/weapons/guns/interact/pistol_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/pistol_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/pistol_cocked.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	gun_skill_category = SKILL_PISTOLS
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	reciever_flags = AMMO_RECIEVER_MAGAZINES
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol)
	caliber = CALIBER_9X19
	max_shells = 15
	fire_delay = 0.2 SECONDS
	force = 8
	wield_delay = 0.2 SECONDS
	aim_slowdown = 0.2
	scatter = 3
	scatter_unwielded = 8
	recoil_unwielded = 0.6
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
		/obj/item/attachable/gyro,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/foldable/bipod)
	attack_speed = ATTACK_SPEED_VERY_FAST

/obj/item/weapon/gun/fallout/pistol/hipower
	name = "\improper L9A1 FN Hi-Power Pistol"
	desc = "Modernization of a classic hand gun."
	icon_state = "hipower_british"

/obj/item/weapon/gun/fallout/pistol/p220
	name = "\improper SIG Sauer P220 Pistol"
	desc = "Of Swiss origin, the P220 is very lightweight and compact."
	icon_state = "p220"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/9mm_pistol_fire_alt.wav'
	fire_delay = 0.3 SECONDS
	force = 6
	scatter = 5
	scatter_unwielded = 12
	recoil_unwielded = 0

/obj/item/weapon/gun/fallout/pistol/m9fs	//Has burst to differentiate it from other pistols
	name = "\improper Beretta M9FS Pistol"
	desc = "Italian-made handgun with a burst setting."
	icon_state = "beretta_m9fs"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/9mm_pistol_fire_alt.wav'
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO, GUN_FIREMODE_BURSTFIRE)
	fire_delay = 0.3 SECONDS
	burst_amount = 3
	scatter_unwielded = 10
	burst_scatter_mult = 1.1
	recoil_unwielded = 0.7

/obj/item/weapon/gun/fallout/pistol/n99
	name = "\improper N99 Pistol"
	desc = "One of the most popular handguns in the wastes. Relatively powerful for its size and highly customizable."
	icon_state = "n99"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/10mm_pistol_fire.ogg'
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/ten
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/ten)
	caliber = CALIBER_10X25MM
	max_shells = 10
	fire_delay = 0.3 SECONDS
	force = 10
	wield_delay = 0.3 SECONDS
	aim_slowdown = 0.3
	scatter = 5
	scatter_unwielded = 10
	recoil_unwielded = 0.8

/obj/item/weapon/gun/fallout/pistol/type17
	name = "\improper Shanxi Type 17 Pistol"
	desc = "The standard issue sidearm of People's Liberation Army soldiers, re-chambered in the modern 10mm caliber and magazine-fed."
	icon_state = "type17"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/type17_pistol_fire.ogg'
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/ten
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/ten)
	caliber = CALIBER_10X25MM
	max_shells = 10
	fire_delay = 0.4 SECONDS
	wield_delay = 0.3 SECONDS
	scatter = 7
	scatter_unwielded = 13
	recoil_unwielded = 0.8

/obj/item/weapon/gun/fallout/pistol/m1911
	name = "\improper Colt M1911 Pistol"
	desc = "An ancient sidearm that continues to prove itself as one of the most reliable even today."
	icon_state = "m1911"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/9mm_pistol_fire_alt.wav'	//Uses 9mm firing sound in NV, so using it here
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/acp
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/acp)
	caliber = CALIBER_45ACP
	max_shells = 12
	fire_delay = 0.3 SECONDS
	wield_delay = 0.3 SECONDS
	aim_slowdown = 0.3
	scatter = 10
	scatter_unwielded = 15
	recoil_unwielded = 0.5

/obj/item/weapon/gun/fallout/pistol/ruger
	name = "\improper Ruger MK3 Pistol"
	desc = "Integrally suppressed and chambered in the subsonic .22 LR caliber."
	icon_state = "rugermk3"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/22_pistol_fire.ogg'
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/subsonic
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/subsonic)
	caliber = CALIBER_10X25MM
	max_shells = 15
	scatter = 5
	scatter_unwielded = 10
	recoil_unwielded = 0

/obj/item/weapon/gun/fallout/pistol/deagle
	name = "\improper Desert Eagle"
	desc = "The classic hand cannon, chambered in the rare .50 Action Express round."
	icon_state = "deagle"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/deagle_pistol_fire.ogg'
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/action_express
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/action_express)
	caliber = CALIBER_50AE
	max_shells = 7
	fire_delay = 0.3 SECONDS
	force = 10
	wield_delay = 0.3 SECONDS
	aim_slowdown = 0.3
	scatter = 3
	scatter_unwielded = 12
	recoil = 0.5
	recoil_unwielded = 1.5

//Revolvers
/obj/item/weapon/gun/fallout/pistol/colt357
	name = "\improper .357 Colt Revolver"
	desc = "God created man, Sam Colt made them equal."
	icon_state = "357_colt"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/357_colt_fire.ogg'
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_ROTATES_CHAMBER|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_TOGGLES_OPEN_EJECTS
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/magnum357
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/magnum357)
	caliber = CALIBER_357
	max_chamber_items = 6
	max_shells = 6
	fire_delay = 0.1 SECONDS
	wield_delay = 0.4 SECONDS
	aim_slowdown = 0.3
	scatter = 10
	scatter_unwielded = 15
	recoil = 0.3
	recoil_unwielded = 1

/obj/item/weapon/gun/fallout/pistol/colt357/webley
	name = "\improper Webley Mk2 Revolver"
	desc = "An old, top-break revolver that has been modified for use with .357 Magnum."
	icon_state = "webley"

/obj/item/weapon/gun/fallout/pistol/police_revolver
	name = "\improper Colt Official Police Revolver"
	desc = "Widespread and very popular among police officers and armies around the pre-war world."
	icon_state = "357_revolver"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/police_revolver_fire.wav'
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_ROTATES_CHAMBER|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_TOGGLES_OPEN_EJECTS
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/magnum357
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/magnum357)
	caliber = CALIBER_357
	max_chamber_items = 6
	max_shells = 6
	fire_delay = 0.3 SECONDS
	wield_delay = 0.2 SECONDS
	scatter = 10
	scatter_unwielded = 15
	recoil = 0.3
	recoil_unwielded = 1

/obj/item/weapon/gun/fallout/pistol/magnum44
	name = "\improper S&W M29 .44 Magnum Revolver"
	desc = "Big iron."
	icon_state = "44_revolver"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/44_revolver_fire.wav'
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_ROTATES_CHAMBER|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_TOGGLES_OPEN_EJECTS
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/magnum44
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/magnum44)
	caliber = CALIBER_44
	max_chamber_items = 6
	max_shells = 6
	fire_delay = 0.2 SECONDS
	force = 10
	wield_delay = 0.5 SECONDS
	aim_slowdown = 0.3
	scatter = 7
	scatter_unwielded = 10
	recoil = 0.3
	recoil_unwielded = 1.1

/obj/item/weapon/gun/fallout/pistol/hunting_revolver
	name = "\improper Hunting Revolver"
	desc = "Sold as the Magnum Research BFR before the Great War, this powerful handgun is the most accurate revolvers available these days."
	icon_state = "hunting_revolver"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_revolver_fire.wav'
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_ROTATES_CHAMBER|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_TOGGLES_OPEN_EJECTS
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/govt
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/govt)
	caliber = CALIBER_4570
	max_chamber_items = 6
	max_shells = 6
	fire_delay = 0.4 SECONDS
	force = 12
	wield_delay = 0.5 SECONDS
	aim_slowdown = 0.4
	scatter = 2
	scatter_unwielded = 10
	recoil = 0.1
	recoil_unwielded = 1.2

/obj/item/weapon/gun/fallout/pistol/sequoia
	name = "\improper Ranger Sequoia"
	desc = "This revolver features a dark finish with intricate engravings etched all around the weapon. Engraved along the barrel are the words \"For Honorable Service\" and \"Against All Tyrants\". The handgrip bears the symbol of the NCR Rangers, a bear, and a brass plate attached to the bottom that reads \"20 Years\"."
	icon_state = "sequoia"
	fire_sound = 'fallout/fallout sounds/fallout weapon sounds/hunting_revolver_fire.wav'	//Does not have its own sound file, so using this one since they have the same caliber
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_NO_PITCH_SHIFT_NEAR_EMPTY
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_ROTATES_CHAMBER|AMMO_RECIEVER_TOGGLES_OPEN|AMMO_RECIEVER_TOGGLES_OPEN_EJECTS
	default_ammo_type = /obj/item/ammo_magazine/fallout_pistol/govt
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_pistol/govt)
	caliber = CALIBER_4570
	max_chamber_items = 6
	max_shells = 6
	fire_delay = 0.1 SECONDS
	force = 12
	wield_delay = 0.3 SECONDS
	aim_slowdown = 0.3
	scatter = 5
	scatter_unwielded = 10
	recoil = 0.4
	recoil_unwielded = 1.2
