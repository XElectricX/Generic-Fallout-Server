//Pistol magazines
/obj/item/ammo_magazine/fallout_pistol
	name = "9x19mm pistol magazine"
	desc = "Holds small caliber rounds, fitted for pistols."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "9mag_pistol"
	default_ammo = /datum/ammo/bullet/nine
	max_rounds = 15

/obj/item/ammo_magazine/fallout_pistol/ten
	name = "10x25mm pistol magazine"
	desc = "Magazine for your trusty sidearm."
	icon_state = "10mag_pistol"
	max_rounds = 10

/obj/item/ammo_magazine/fallout_pistol/acp
	name = ".45 ACP pistol magazine"
	desc = "Classic magazine for classic rounds."
	icon_state = "45mag_pistol"
	default_ammo = /datum/ammo/bullet/acp
	max_rounds = 12

/obj/item/ammo_magazine/fallout_pistol/subsonic
	name = ".22 LR pistol magazine"
	desc = "Magazine fitted for pistols that use .22LR ammunition. Feels very light."
	icon_state = "22mag_pistol"
	default_ammo = /datum/ammo/bullet/subsonic
	max_rounds = 15

/obj/item/ammo_magazine/fallout_pistol/magnum357
	name = ".357 Magnum speed loader"
	desc = "Cylinder that holds .357 caliber rounds."
	icon_state = "45mag_pistol"
	default_ammo = /datum/ammo/bullet/magnum357
	max_rounds = 6

/obj/item/ammo_magazine/fallout_pistol/magnum44
	name = ".44 Magnum speed loader"
	desc = "Cylinder that holds .44 caliber rounds."
	icon_state = "44loader"
	default_ammo = /datum/ammo/bullet/magnum44
	max_rounds = 6

/obj/item/ammo_magazine/fallout_pistol/govt
	name = ".45-70 Govt speed loader"
	desc = "Cylinder that holds .45-70 caliber rounds."
	icon_state = "4570loader"
	default_ammo = /datum/ammo/bullet/govt
	max_rounds = 6

/obj/item/ammo_magazine/fallout_pistol/action_express
	name = ".50 AE pistol magazine"
	desc = "Weighs like a sock of batteries."
	icon_state = "50mag_pistol"
	default_ammo = /datum/ammo/bullet/action_express
	max_rounds = 7

//SMG magazines
/obj/item/ammo_magazine/fallout_smg
	name = "9x19mm SMG magazine"
	desc = "Stick magazine for 9mm SMGs."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "9mag_smg"
	default_ammo = /datum/ammo/bullet/nine
	max_rounds = 25

/obj/item/ammo_magazine/fallout_smg/ten
	name = "10x25mm SMG magazine"
	desc = "Stick magazine for 10mm SMGs."
	icon_state = "10mag_smg"
	default_ammo = /datum/ammo/bullet/ten
	max_rounds = 20

/obj/item/ammo_magazine/fallout_smg/acp
	name = ".45 ACP SMG magazine"
	desc = "Stick magazine for .45cal SMGs."
	icon = 'icons/obj/items/ammo.dmi'
	icon_state = "mp7"
	default_ammo = /datum/ammo/bullet/acp
	max_rounds = 22

/obj/item/ammo_magazine/fallout_smg/acp/extended
	name = "extended .45 ACP SMG magazine"
	desc = "Extended stick magazine for .45cal SMGs."
	icon = 'icons/obj/items/ammo.dmi'
	icon_state = "uzi_ext"
	default_ammo = /datum/ammo/bullet/acp
	max_rounds = 27

/obj/item/ammo_magazine/fallout_smg/acp/drum
	name = ".45 ACP drum magazine"
	desc = "A drum that can hold .45cal ammunition."
	icon_state = "45mag_drum"
	default_ammo = /datum/ammo/bullet/acp
	max_rounds = 40
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_magazine/fallout_smg/subsonic
	name = ".22 LR pan magazine"
	desc = "Pan magazine that can be packed full of tiny .22LR rounds."
	icon_state = "22mag_pan"
	default_ammo = /datum/ammo/bullet/subsonic
	max_rounds = 100
	w_class = WEIGHT_CLASS_SMALL

//Rifle magazines
/obj/item/ammo_magazine/fallout_rifle
	name = "5.56x45mm magazine"
	desc = "Common holder of 5.56mm ammunition. Fits most assault rifles."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "556mag"
	default_ammo = /datum/ammo/bullet/assault_rifle
	max_rounds = 20

/obj/item/ammo_magazine/fallout_rifle/extended
	name = "5.56x45mm extended magazine"
	desc = "Quad-stack arrangement for holding more rounds than your standard magazine."
	icon_state = "556mag_quad"
	default_ammo = /datum/ammo/bullet/assault_rifle
	max_rounds = 30

/obj/item/ammo_magazine/fallout_rifle/winchester
	name = ".308 Winchester magazine"
	desc = "A magazine for holding large .308 rounds used in high power rifles."
	icon_state = "308mag"
	default_ammo = /datum/ammo/bullet/winchester
	max_rounds = 5

/obj/item/ammo_magazine/fallout_rifle/winchester/extended
	name = "extended .308 Winchester magazine"
	desc = "Double the size for double the lead."
	icon_state = "308mag_extended"
	default_ammo = /datum/ammo/bullet/winchester
	max_rounds = 10

/obj/item/ammo_magazine/fallout_rifle/bmg
	name = ".50 BMG rifle magazine"
	desc = "Probably more expensive than you."
	icon_state = "50mag"
	default_ammo = /datum/ammo/bullet/bmg
	max_rounds = 5

/obj/item/ammo_magazine/fallout_pistol/rifle
	name = "9x19mm rifle magazine"
	desc = "Longer magazine designed for rifles."
	icon_state = "9mag_rifle"
	default_ammo = /datum/ammo/bullet/nine
	max_rounds = 20

//Shotgun magazines
/obj/item/ammo_magazine/fallout_shotgun
	name = "12 gauge drum magazine"
	desc = "Drum magazine for holding all those beautiful shells of death."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "riotdrum"
	default_ammo = /datum/ammo/bullet/shotgun/buckshot
	max_rounds = 12
	w_class = WEIGHT_CLASS_SMALL

//Explosive ordnance magazines


//Energy cells