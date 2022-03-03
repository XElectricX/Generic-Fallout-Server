/datum/ammo
	var/desc

//Doing ..() doesn't work here so just pasting it all in
/obj/item/ammo_magazine/generate_handful(new_ammo, new_caliber, new_rounds, maximum_rounds)
	var/datum/ammo/ammo = ispath(new_ammo) ? GLOB.ammo_list[new_ammo] : new_ammo
	var/ammo_name = ammo.name

	name = "handful of [ammo_name + " ([new_caliber])"]"
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

//Pistol rounds
/datum/ammo/bullet/nine
	name = "9x19mm Parabellum bullet"
	desc = "Ubiquitous round used by all kinds of weapons. Small but plentiful."
	damage = 12
	damage_falloff = 1.5
	penetration = 5
	shrapnel_chance = 8
	point_blank_range = 1
	shell_speed = 2.5

/datum/ammo/bullet/ten
	name = "10x25mm Auto bullet"
	desc = "Common round used by semi-auto pistols and SMGs."
	damage = 15
	damage_falloff = 1.5
	penetration = 7
	shrapnel_chance = 12
	point_blank_range = 1
	shell_speed = 2.3

/datum/ammo/bullet/acp
	name = ".45 ACP bullet"
	desc = "Ol'e reliable. Subsonic round that still packs a punch."
	damage = 13
	damage_falloff = 1.5
	penetration = 5
	shrapnel_chance = 10
	shell_speed = 1.8

/datum/ammo/bullet/subsonic
	name = ".22 Long Rifle bullet"
	desc = "Tiny subsonic round used in a variety of weapons from pistols to rifles. Practically littered across the wastes."
	damage = 12
	damage_falloff = 1.5
	penetration = 2
	shrapnel_chance = 8
	point_blank_range = 1

/datum/ammo/bullet/magnum357
	name = ".357 Magnum bullet"
	desc = "Yee-fucking-haw."
	damage = 20

/datum/ammo/bullet/magnum44
	name = ".44 Magnum bullet"
	desc = "The ammo of choice for revolvers and carbines do more than look cool."
	damage = 30
	penetration = 15
	shrapnel_chance = 15
	shell_speed = 2.5

/datum/ammo/bullet/action_express
	name = ".50 Action Express bullet"
	desc = "Absolute unit of a pistol bullet."
	damage = 40
	damage_falloff = 1.5
	penetration = 20
	shrapnel_chance = 20
	point_blank_range = 1
	shell_speed = 2.8

//Rifle rounds
/datum/ammo/bullet/assault_rifle
	name = "5.56x45mm rifle bullet"
	desc = "Popular cartridge for assault rifles, carbines, marksman rifles, and machine guns."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "medium_casing"
	damage = 20
	penetration = 20
	shrapnel_chance = 20
	accurate_range = 6

/datum/ammo/bullet/winchester
	name = ".308 Winchester bullet"
	desc = "Good for hunting wild animals. Or humans."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "medium_casing"
	damage = 35
	damage_falloff = 0.8
	penetration = 30
	shrapnel_chance = 25
	accurate_range = 8
	accurate_range_min = 1
	shell_speed = 2.8

/datum/ammo/bullet/govt
	name = ".45-70 Government bullet"
	desc = "Inaccurate but powerful round. Put the fear of American munitions into your enemy."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "medium_casing"
	damage = 30
	damage_falloff = 2
	penetration = 25
	shrapnel_chance = 15
	accurate_range = 4
	point_blank_range = 1
	shell_speed = 2.5

/datum/ammo/bullet/bmg
	name = ".50 BMG bullet"
	desc = "You could kill a house with this. Usually used by HMGs and anti-materiel rifles."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "large_casing"
	damage = 50
	damage_falloff = 0.6
	penetration = 60
	accurate_range = 12
	accurate_range_min = 1
	shrapnel_chance = 5	//Doubtful a giant bullet would break up inside you instead of penetrating

//Shotgun rounds
/datum/ammo/bullet/shotgun/buckshot
	name = "buckshot shell"
	desc = "For when you can't be bothered to aim."
	damage = 12
	damage_falloff = 1.5
	penetration = 5
	shrapnel_chance = 8
	point_blank_range = 1
	shell_speed = 2.5
