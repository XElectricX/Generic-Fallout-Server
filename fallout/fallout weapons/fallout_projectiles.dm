/obj/projectile
	friendly_fire_multiplier = 1	//By default this halves all damage taken via bullets, so setting it to normal here

/datum/ammo
	var/desc	//Var needs to be defined here instead of the template below otherwise errors

//Basic "bullet"
/datum/ammo/bullet/fallout
	name = "bullet template"
	desc = "This should not exist."
	handful_icon_state = "small_casing"
	accuracy = 20	//Accuracy boost to reduce RNG but allow other factors to impact it

//Pistol rounds
/datum/ammo/bullet/fallout/nine
	name = "9x19mm Parabellum bullet"
	desc = "Ubiquitous round used by all kinds of weapons. Small but plentiful."
	damage = 9
	damage_falloff = 1.5
	penetration = 5
	shrapnel_chance = 3
	point_blank_range = 1
	shell_speed = 2.5

/datum/ammo/bullet/fallout/ten
	name = "10x25mm Auto bullet"
	desc = "Common round used by semi-auto pistols and SMGs."
	damage = 13
	damage_falloff = 1.5
	penetration = 7
	shrapnel_chance = 3
	point_blank_range = 1
	shell_speed = 2.3

/datum/ammo/bullet/fallout/acp
	name = ".45 ACP bullet"
	desc = "Ol'e reliable. Subsonic round that still packs a punch."
	damage = 11
	damage_falloff = 1.5
	penetration = 5
	shrapnel_chance = 3
	shell_speed = 1.8

/datum/ammo/bullet/fallout/subsonic
	name = ".22 Long Rifle bullet"
	desc = "Tiny subsonic round used in a variety of weapons from pistols to rifles. Practically littered across the wastes."
	damage = 7
	damage_falloff = 1.5
	penetration = 2
	shrapnel_chance = 5
	point_blank_range = 1

/datum/ammo/bullet/fallout/magnum357
	name = ".357 Magnum bullet"
	desc = "Yee-fucking-haw."
	damage = 20
	penetration = 10
	shrapnel_chance = 10
	shell_speed = 2.2

/datum/ammo/bullet/fallout/magnum44
	name = ".44 Magnum bullet"
	desc = "The ammo of choice for revolvers and carbines do more than look cool."
	damage = 25
	penetration = 15
	shrapnel_chance = 15
	shell_speed = 2.5

/datum/ammo/bullet/fallout/action_express
	name = ".50 Action Express bullet"
	desc = "Absolute unit of a pistol bullet."
	damage = 35
	damage_falloff = 1.5
	penetration = 20
	shrapnel_chance = 20
	point_blank_range = 1
	shell_speed = 2.8

//Rifle rounds
/datum/ammo/bullet/fallout/assault_rifle
	name = "5.56x45mm rifle bullet"
	desc = "Popular cartridge for assault rifles, carbines, marksman rifles, and machine guns."
	handful_icon_state = "medium_casing"
	handful_amount = 4
	damage = 15
	penetration = 40
	shrapnel_chance = 15
	accurate_range = 6

/datum/ammo/bullet/fallout/winchester
	name = ".308 Winchester bullet"
	desc = "Good for hunting wild animals. Or humans."
	handful_icon_state = "medium_casing"
	handful_amount = 4
	damage = 40
	damage_falloff = 0.8
	penetration = 60
	shrapnel_chance = 20
	accurate_range = 8
	accurate_range_min = 1
	shell_speed = 2.8

/datum/ammo/bullet/fallout/govt
	name = ".45-70 Government bullet"
	desc = "Inaccurate but powerful round. Put the fear of American munitions into your enemy."
	handful_icon_state = "medium_casing"
	handful_amount = 4
	damage = 40
	damage_falloff = 2
	penetration = 40
	shrapnel_chance = 15
	accurate_range = 4
	point_blank_range = 1
	shell_speed = 2.5

/datum/ammo/bullet/fallout/bmg
	name = ".50 BMG bullet"
	desc = "You could kill a house with this. Usually used by HMGs and anti-materiel rifles."
	handful_icon_state = "large_casing"
	handful_amount = 1
	flags_ammo_behavior = AMMO_PASS_THROUGH_MOB|AMMO_PASS_THROUGH_MOVABLE|AMMO_PASS_THROUGH_TURF
	damage = 70
	damage_falloff = 0.6
	penetration = 70
	shrapnel_chance = 0	//Doubtful a giant bullet would break up inside you instead of penetrating
	accurate_range = 12
	accurate_range_min = 1
	max_range = 40
	shell_speed = 4	//It go fast
	on_pierce_multiplier = 0.5 //Damage and penetration values are halved every time it pierces through something

/datum/ammo/bullet/fallout/bmg/on_hit_mob(mob/M, obj/projectile/P)
	P.proj_max_range -= 15

/datum/ammo/bullet/fallout/bmg/on_hit_obj(obj/O, obj/projectile/P)
	P.proj_max_range -= 15

/datum/ammo/bullet/fallout/bmg/on_hit_turf(turf/T, obj/projectile/P)
	P.proj_max_range -= 30

//Shotgun rounds
/datum/ammo/bullet/fallout/buckshot
	name = "buckshot shell"
	desc = "For when you can't be bothered to aim."
	icon_state = "buckshot"
	handful_icon_state = "shell_buckshot"
	handful_amount = 4
	damage = 6
	damage_falloff = 1.5
	penetration = 0
	shrapnel_chance = 5
	point_blank_range = 1
	shell_speed = 2
	bonus_projectiles_type = /datum/ammo/bullet/fallout/buckshot/extra
	bonus_projectiles_amount = 5
	bonus_projectiles_scatter = 4

//The additional buckshot projectiles that spread out from one shell
/datum/ammo/bullet/fallout/buckshot/extra
	name = "additional buckshot"
	icon_state = "buckshot"
	bonus_projectiles_amount = 0

//Missile
/datum/ammo/rocket/fallout_missile
	name = "missile"
	flags_ammo_behavior = AMMO_EXPLOSIVE
	max_range = 50
	damage = 20	//The actual explosion does the damage
	penetration = 60
	bullet_color = LIGHT_COLOR_FIRE

/datum/ammo/rocket/fallout_missile/drop_nade(turf/T)
	explosion(T, 1, 3, 4, 4)