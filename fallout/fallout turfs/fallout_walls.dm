//For displaying lobby screen images
/turf/closed/wall/indestructible/splashscreen
	name = "Lobby"
	icon = 'fallout/fallout icons/fallout_lobby.dmi'

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

//Concrete wall, very strong
/turf/closed/wall/fallout/concrete
	name = "concrete wall"
	desc = "Robust slab of cement."
	icon_state = "concrete0"
	walltype = "concrete"
	max_integrity = 3000
	explosion_block = 4
	soft_armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 100, "bomb" = 60, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 20)


//Metal tunnel wall, as strong as concrete
/turf/closed/wall/fallout/tunnel
	name = "metallic tunnel wall"
	desc = "Used in pre-war times for supporting subway lines and underground utility tunnels."
	icon_state = "tunnel0"
	walltype = "tunnel"
	max_integrity = 3000
	explosion_block = 4
	soft_armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 100, "bomb" = 60, "bio" = 100, "rad" = 60, "fire" = 100, "acid" = 20)


//Log wall, very weak
/turf/closed/wall/fallout/log
	name = "log cabin wall"
	desc = "Robust slab of cement."
	icon = 'fallout/fallout icons/fallout turfs/fallout_wood_walls.dmi'
	icon_state = "log0"
	walltype = "log"
	max_integrity = 500
	explosion_block = 0
	soft_armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 50, "bomb" = 0, "bio" = 20, "rad" = 5, "fire" = 0, "acid" = 0)


//House wall, slightly weak
/turf/closed/wall/fallout/house
	name = "wooden house wall"
	desc = "Could use a new coat of paint."
	icon = 'fallout/fallout icons/fallout turfs/fallout_wood_walls.dmi'
	icon_state = "house0"
	walltype = "house"
	max_integrity = 800
	explosion_block = 1
	soft_armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 50, "bomb" = 0, "bio" = 20, "rad" = 10, "fire" = 10, "acid" = 10)

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
