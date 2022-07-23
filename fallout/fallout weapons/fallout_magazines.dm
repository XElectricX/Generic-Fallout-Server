//Single bullets
/obj/item/ammo_magazine/handful
	name = "ammo handful template"
	desc = "If you see this, someone did not set a description for this caliber."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	w_class = WEIGHT_CLASS_TINY

//Changes to handfuls-related stuff going here, no other simple way to do it, have to copy paste it all back and then make changes
/obj/item/ammo_magazine/generate_handful(new_ammo, new_caliber, new_rounds, maximum_rounds)
	var/datum/ammo/ammo = ispath(new_ammo) ? GLOB.ammo_list[new_ammo] : new_ammo
	var/ammo_name = ammo.name

	name = "handful of [ammo_name]\s"	//These 2 lines give the handfuls their names
	icon_state = ammo.handful_icon_state

	var/bullet_desc = ammo.desc	//These 2 lines are for giving bullets descriptions
	desc = "[bullet_desc]"

	default_ammo = new_ammo
	caliber = new_caliber
	if(maximum_rounds)
		max_rounds = maximum_rounds
	else
		max_rounds = ammo.handful_amount
	current_rounds = new_rounds
	update_icon()

//Pistol magazines
/obj/item/ammo_magazine/fallout_pistol
	name = "\improper 9x19mm pistol magazine"
	desc = "Holds small caliber rounds, fitted for pistols."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "9mag_pistol"
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/fallout/nine
	caliber = CALIBER_9X19
	max_rounds = 15

/obj/item/ammo_magazine/fallout_pistol/ten
	name = "\improper 10x25mm pistol magazine"
	desc = "Magazine for your trusty sidearm."
	icon_state = "10mag_pistol"
	default_ammo = /datum/ammo/bullet/fallout/ten
	caliber = CALIBER_10X25MM
	max_rounds = 10

/obj/item/ammo_magazine/fallout_pistol/acp
	name = "\improper .45 ACP pistol magazine"
	desc = "Classic magazine for classic rounds."
	icon_state = "45mag_pistol"
	default_ammo = /datum/ammo/bullet/fallout/acp
	caliber = CALIBER_45ACP
	max_rounds = 12

/obj/item/ammo_magazine/fallout_pistol/subsonic
	name = "\improper .22 LR pistol magazine"
	desc = "Magazine fitted for pistols that use .22LR ammunition. Feels very light."
	icon_state = "22mag_pistol"
	default_ammo = /datum/ammo/bullet/fallout/subsonic
	caliber = CALIBER_22LR
	max_rounds = 15

/obj/item/ammo_magazine/fallout_pistol/magnum357
	name = "\improper .357 Magnum speed loader"
	desc = "Cylinder that holds .357 caliber rounds."
	icon_state = "38loader"
	default_ammo = /datum/ammo/bullet/fallout/magnum357
	caliber = CALIBER_357
	max_rounds = 6

/obj/item/ammo_magazine/fallout_pistol/magnum44
	name = "\improper .44 Magnum speed loader"
	desc = "Cylinder that holds .44 caliber rounds."
	icon_state = "44loader"
	default_ammo = /datum/ammo/bullet/fallout/magnum44
	caliber = CALIBER_44
	max_rounds = 6

/obj/item/ammo_magazine/fallout_pistol/govt	//Make a 5-round speedloader sprite and reduce max_rounds to 5 when possible
	name = "\improper .45-70 Govt speed loader"
	desc = "Cylinder that holds .45-70 caliber rounds."
	icon_state = "4570loader"
	default_ammo = /datum/ammo/bullet/fallout/govt
	caliber = CALIBER_4570
	max_rounds = 6	//Not lore accurate but only a 6 round sprite exists

/obj/item/ammo_magazine/fallout_pistol/action_express
	name = "\improper .50 AE pistol magazine"
	desc = "Weighs like a sock of batteries."
	icon_state = "50mag_pistol"
	default_ammo = /datum/ammo/bullet/fallout/action_express
	caliber = CALIBER_50AE
	max_rounds = 7

//SMG magazines
/obj/item/ammo_magazine/fallout_smg
	name = "\improper 9x19mm SMG magazine"
	desc = "Stick magazine for 9mm SMGs."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "9mag_smg"
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/fallout/nine
	caliber = CALIBER_9X19
	max_rounds = 25

/obj/item/ammo_magazine/fallout_smg/ten
	name = "\improper 10x25mm SMG magazine"
	desc = "Stick magazine for 10mm SMGs."
	icon_state = "10mag_smg"
	default_ammo = /datum/ammo/bullet/fallout/ten
	caliber = CALIBER_10X25MM
	max_rounds = 20

/obj/item/ammo_magazine/fallout_smg/acp
	name = "\improper .45 ACP SMG magazine"
	desc = "Stick magazine for .45cal SMGs."
	icon = 'icons/obj/items/ammo.dmi'
	icon_state = "uzi_ext"
	default_ammo = /datum/ammo/bullet/fallout/acp
	caliber = CALIBER_45ACP
	max_rounds = 25

/obj/item/ammo_magazine/fallout_smg/acp/thompson
	name = "\improper .45 ACP Thompson magazine"
	desc = "A drum that can hold .45cal ammunition."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "45mag_stick"
	max_rounds = 20

/obj/item/ammo_magazine/fallout_smg/acp/drum
	name = "\improper .45 ACP drum magazine"
	desc = "A drum that can hold .45cal ammunition."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "45mag_drum"
	max_rounds = 40
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_magazine/fallout_smg/subsonic
	name = "\improper .22 LR pan magazine"
	desc = "Pan magazine that can be packed full of tiny .22LR rounds."
	icon_state = "22mag_pan"
	default_ammo = /datum/ammo/bullet/fallout/subsonic
	caliber = CALIBER_22LR
	max_rounds = 100
	w_class = WEIGHT_CLASS_NORMAL

//Rifle magazines
/obj/item/ammo_magazine/fallout_rifle
	name = "\improper 5.56x45mm magazine"
	desc = "Common holder of 5.56mm ammunition. Fits most assault rifles."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "556mag_rifle"
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/fallout/assault_rifle
	caliber = CALIBER_556X45
	max_rounds = 20

/obj/item/ammo_magazine/fallout_rifle/extended
	name = "\improper 5.56x45mm extended magazine"
	desc = "Quad-stack arrangement for holding more rounds than your standard magazine."
	icon_state = "556mag_quad"
	default_ammo = /datum/ammo/bullet/fallout/assault_rifle
	max_rounds = 30

/obj/item/ammo_magazine/fallout_rifle/winchester
	name = "\improper .308 Winchester magazine"
	desc = "A magazine for holding large .308 rounds used in high power rifles."
	icon_state = "308mag_rifle"
	default_ammo = /datum/ammo/bullet/fallout/winchester
	caliber = CALIBER_308WIN
	max_rounds = 5

/obj/item/ammo_magazine/fallout_rifle/winchester/extended
	name = "\improper extended .308 Winchester magazine"
	desc = "Double the size for double the lead."
	icon_state = "308mag_extended"
	default_ammo = /datum/ammo/bullet/fallout/winchester
	max_rounds = 10

/obj/item/ammo_magazine/fallout_rifle/bmg
	name = "\improper .50 BMG rifle magazine"
	desc = "Probably more expensive than you."
	icon_state = "50mag_rifle"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/fallout/bmg
	caliber = CALIBER_50BMG
	max_rounds = 5

/obj/item/ammo_magazine/fallout_pistol/rifle
	name = "\improper 9x19mm rifle magazine"
	desc = "Longer magazine designed for rifles."
	icon_state = "9mag_rifle"
	default_ammo = /datum/ammo/bullet/fallout/nine
	caliber = CALIBER_9X19
	max_rounds = 20

//Shotgun magazines
/obj/item/ammo_magazine/fallout_shotgun
	name = "\improper 12 gauge drum magazine"
	desc = "Drum magazine for holding all those beautiful shells of death."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "riotdrum"
	default_ammo = /datum/ammo/bullet/fallout/buckshot
	caliber = CALIBER_12G
	max_rounds = 12
	w_class = WEIGHT_CLASS_NORMAL

//Explosive ordnance magazines
/obj/item/ammo_magazine/standard_atgun
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/mortal_shell
	w_class = WEIGHT_CLASS_NORMAL

//Energy cells

//Ammo boxes
/obj/item/ammo_magazine/box
	name = "\improper 9x19mm Box"
	desc = "A box of ammunition. You can alt-click to draw ammo directly from it."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "9box"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/fallout/nine
	caliber = CALIBER_9X19
	max_rounds = 100

//Remove the need to have a box in hand to restock it
/obj/item/ammo_magazine/box/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(!istype(I, /obj/item/ammo_magazine))
		if(!CHECK_BITFIELD(flags_magazine, MAGAZINE_WORN) || !istype(I, /obj/item/weapon/gun) || loc != user)
			return ..()
		var/obj/item/weapon/gun/gun = I
		if(!CHECK_BITFIELD(gun.reciever_flags, AMMO_RECIEVER_MAGAZINES))
			return ..()
		gun.reload(src, user)
		return

	if(!CHECK_BITFIELD(flags_magazine, MAGAZINE_REFILLABLE)) //and a refillable magazine
		return

	var/obj/item/ammo_magazine/mag = I
	if(default_ammo != mag.default_ammo)
		to_chat(user, span_notice("Those aren't the same rounds. Better not mix them up."))
		return

	var/amount_to_transfer = mag.current_rounds
	transfer_ammo(mag, user, amount_to_transfer)

//Withdraw rounds via alt click, no need to hold in hand
/obj/item/ammo_magazine/box/AltClick(mob/living/user)
	if(!can_interact(user))
		return ..()
	if(current_rounds <= 0)
		to_chat(user, span_notice("[src] is empty. There is nothing to grab."))
		return
	create_handful(user)

/obj/item/ammo_magazine/box/ten
	name = "\improper 10x25mm Box"
	icon_state = "10box"
	default_ammo = /datum/ammo/bullet/fallout/ten
	caliber = CALIBER_10X25MM

/obj/item/ammo_magazine/box/acp
	name = "\improper .45 ACP Box"
	icon_state = "45box"
	default_ammo = /datum/ammo/bullet/fallout/acp
	caliber = CALIBER_45ACP

/obj/item/ammo_magazine/box/subsonic
	name = "\improper .22LR Box"
	icon_state = "10box"
	default_ammo = /datum/ammo/bullet/fallout/subsonic
	caliber = CALIBER_22LR

/obj/item/ammo_magazine/box/magnum357
	name = "\improper .357 Magnum Box"
	icon_state = "38box"
	default_ammo = /datum/ammo/bullet/fallout/magnum357
	caliber = CALIBER_357

/obj/item/ammo_magazine/box/magnum44
	name = "\improper .44 Magnum Box"
	icon_state = "44box"
	default_ammo = /datum/ammo/bullet/fallout/magnum44
	caliber = CALIBER_44

/obj/item/ammo_magazine/box/assault_rifle
	name = "\improper 5.56x45mm Box"
	icon_state = "556box"
	default_ammo = /datum/ammo/bullet/fallout/assault_rifle
	caliber = CALIBER_556X45
	max_rounds = 80

/obj/item/ammo_magazine/box/winchester
	name = "\improper .308 Winchester Box"
	icon_state = "308box"
	default_ammo = /datum/ammo/bullet/fallout/winchester
	caliber = CALIBER_308WIN

/obj/item/ammo_magazine/box/govt
	name = "\improper .45-70 Government Box"
	icon_state = "4570box"
	default_ammo = /datum/ammo/bullet/fallout/govt
	caliber = CALIBER_4570

//Shotgun shell boxes
/obj/item/ammo_magazine/box/shotgun
	name = "\improper Buckshot Box"
	desc = "A carton of shotgun shells."
	icon_state = "box_buckshot"
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/fallout/buckshot
	caliber = CALIBER_12G
	max_rounds = 16
