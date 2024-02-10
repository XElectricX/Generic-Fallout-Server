//For displaying lobby screen images
/turf/closed/wall/indestructible/splashscreen
	name = "Lobby"
	icon = 'fallout/fallout icons/fallout_lobby.dmi'
	pixel_x = 0	//De-widescreen the lobby image

/turf/closed/wall/indestructible/splashscreen/New()
	..()
	icon_state = "title[rand(1,13)]"

//Matrix, used for leaving the round
/turf/closed/wall/indestructible/matrix_wall
	name = "matrix"
	desc = "To leave the round, click-drag your character's sprite into this."
	icon = 'fallout/fallout icons/fallout turfs/fallout_walls.dmi'
	icon_state = "matrix"

//Basic wall, currently just a template
/turf/closed/wall/fallout
	name = "metal wall"
	desc = "Oops, no sprite!"
	icon = 'fallout/fallout icons/fallout turfs/fallout_walls.dmi'
	icon_state = ""
	walltype = ""
	///Variants for this type of wall
	var/list/icon_path_variants

/turf/closed/wall/fallout/Initialize(mapload, ...)
	. = ..()
	if(icon_path_variants)
		icon = pick(icon_path_variants)

/* TGMC changed smoothing to /tg/ system and now walls don't work because of it; too much work to convert old walls to 3/4th perspective, so just using TGMC wall sprites */
/turf/closed/wall/fallout/metal
	name = "metal wall"
	desc = "Sturdy wall made of metal."
	icon = 'icons/turf/walls/gwall.dmi'
	icon_state = "gwall-0"
	base_icon_state = "gwall"
	walltype = "gwall"
	max_integrity = 3000
	explosion_block = 4
	soft_armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 100, BOMB = 60, BIO = 100, FIRE = 100, ACID = 10)

/turf/closed/wall/fallout/metal/dark
	icon = 'icons/turf/walls/testwall.dmi'
	icon_state = "testwall-0"
	base_icon_state = "testwall"
	walltype = "testwall"

//Concrete wall, very strong
/turf/closed/wall/fallout/concrete
	name = "concrete wall"
	desc = "Robust slab of cement."
	//icon_state = "concrete0"
	//walltype = "concrete"
	icon = 'icons/turf/walls/siding.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	walltype = "wall"
	icon_path_variants = list(
		'icons/turf/walls/siding.dmi',
		'icons/turf/walls/siding_1.dmi',
		'icons/turf/walls/siding_2.dmi',
		'icons/turf/walls/siding_3.dmi')
	max_integrity = 3000
	explosion_block = 4
	soft_armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 100, BOMB = 60, BIO = 100, FIRE = 100, ACID = 20)

/turf/closed/wall/fallout/concrete/red
	icon = 'icons/turf/walls/siding_red.dmi'
	icon_path_variants = list(
		'icons/turf/walls/siding_red.dmi',
		'icons/turf/walls/siding_red_1.dmi',
		'icons/turf/walls/siding_red_2.dmi',
		'icons/turf/walls/siding_red_3.dmi')

//Adobe walls, primitive
/turf/closed/wall/variable/adobe
	name = "adobe wall"
	desc = "A wall made out of adobe brick."
	icon_state = "wall-0"
	icon = 'icons/turf/walls/adobe.dmi'
	base_icon_state = "wall"
	walltype = "wall"
	icon_path_variants = list(
		'icons/turf/walls/adobe.dmi',
		'icons/turf/walls/adobe_1.dmi',
		'icons/turf/walls/adobe_2.dmi',
		'icons/turf/walls/adobe_3.dmi')
	max_integrity = 2000
	explosion_block = 2
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 50, ENERGY = 100, BOMB = 30, BIO = 100, FIRE = 100, ACID = 80)

//Brick wall, slightly weaker than concrete
/turf/closed/wall/fallout/brick
	name = "brick wall"
	desc = "A wall made out of weathered brick."
	icon = 'icons/turf/walls/brick.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	walltype = "wall"
	max_integrity = 2500
	explosion_block = 3
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 100, BOMB = 40, BIO = 100, FIRE = 100, ACID = 40)

//Metal tunnel wall, as strong as concrete
/turf/closed/wall/fallout/tunnel
	name = "metallic tunnel wall"
	desc = "Used in pre-war times for supporting subway lines and underground utility tunnels."
	icon_state = "tunnel0"
	walltype = "tunnel"
	max_integrity = 3000
	explosion_block = 4
	soft_armor = list(MELEE = 60, BULLET = 60, LASER = 60, ENERGY = 100, BOMB = 60, BIO = 100, FIRE = 100, ACID = 20)


//Log wall, very weak
/turf/closed/wall/fallout/log
	name = "log cabin wall"
	desc = "Hand-crafted from raw wood. Not very durable."
	icon = 'fallout/fallout icons/fallout turfs/fallout_wood_walls.dmi'
	icon_state = "log0"
	walltype = "log"
	max_integrity = 500
	explosion_block = 0
	soft_armor = list(MELEE = 10, BULLET = 10, LASER = 10, ENERGY = 50, BOMB = 0, BIO = 20, FIRE = 0, ACID = 0)


//House wall, slightly weak
/turf/closed/wall/fallout/house
	name = "wooden house wall"
	desc = "Could use a new coat of paint."
	icon = 'fallout/fallout icons/fallout turfs/fallout_wood_walls.dmi'
	icon_state = "house0"
	walltype = "house"
	max_integrity = 800
	explosion_block = 1
	soft_armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 50, BOMB = 0, BIO = 20, FIRE = 10, ACID = 10)

//Broken house wall
/turf/closed/wall/fallout/house/broken
	name = "dilapidated house wall"
	desc = "In dire need of home repairs."
	icon_state = "house_broken0"
	walltype = "house_broken"

//Full-tile tent walls
/turf/closed/wall/fallout/tent
	name = "tent wall"
	desc = "Extra durable, padded cloth for long-term encampments. Still weak compared to traditional walls."
	icon = 'fallout/fallout icons/fallout turfs/fallout_tents.dmi'
	icon_state = "tent0"
	walltype = "tent"
	max_integrity = 400
	explosion_block = 0

//Rock walls, can be mined
/turf/closed/fallout
	name = "rock"
	desc = "A solid rock wall."
	icon = 'icons/turf/walls/lvwall.dmi'
	base_icon_state = "lvwall"
	icon_state = "lvwall-0"
	walltype = "lvwall"
	open_turf_type = /turf/open/ground/fallout/dirt
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_MINERAL_STRUCTURES)
	canSmoothWith = list(SMOOTH_GROUP_MINERAL_STRUCTURES)
	//What ore type will drop from mining this turf
	var/ore_type = TRUE

/turf/closed/fallout/Initialize(mapload)
	. = ..()
	//Randomly choose an ore type
	if(ore_type)
		if(prob(50))
			ore_type = FALSE
		else
			ore_type = pickweight(GLOB.ore_drops)

/turf/closed/fallout/proc/mine()
	if(ore_type)
		new ore_type(src)
	ChangeTurf(open_turf_type)

/turf/closed/fallout/indestructible
	name = "unbreakable rock"
	desc = "Nothing could break through this."
	icon_state = "wall-invincible"
	resistance_flags = RESIST_ALL
	ore_type = FALSE
