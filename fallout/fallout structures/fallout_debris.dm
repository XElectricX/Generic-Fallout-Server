/obj/structure/debris
	name = "debris"
	desc = "Leftovers of buildings and other structures."
	icon = 'fallout/fallout icons/fallout structures/fallout_debris.dmi'
	icon_state = "debris1"
	destroy_sound = 'sound/effects/meteorimpact.ogg'
	obj_flags = CAN_BE_HIT
	density = TRUE
	max_integrity = 1000
	coverage = 80
	bound_width = 64
	bound_height = 64

/obj/structure/debris/two
	icon_state = "debris2"

/obj/structure/debris/three
	icon_state = "debris3"

/obj/structure/debris/four
	icon_state = "debris4"

/obj/structure/debris/random
	icon_state = "debris1"

/obj/structure/debris/random/Initialize()
	. = ..()
	var/random = rand(1,4)
	icon_state = "debris[random]"

/obj/structure/debris/car
	name = "derelict vehicle"
	desc = "Common reminder of the world before the war. Non-functional and battered, only useful for scrap."
	icon_state = "car1"

/obj/structure/debris/car/two
	icon_state = "car2"

/obj/structure/debris/car/three
	icon_state = "car3"

/obj/structure/debris/car/four
	icon_state = "car4"

/obj/structure/debris/car/random
	icon_state = "car1"

/obj/structure/debris/car/random/Initialize()
	. = ..()
	var/random = rand(1,4)
	icon_state = "car[random]"

/obj/structure/debris/car/junker
	name = "junker car"
	desc = "An old vehicle stripped of parts and completely rusted over the years."
	icon_state = "car_junker"
	bound_height = 32
