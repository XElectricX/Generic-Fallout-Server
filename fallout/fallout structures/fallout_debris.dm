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

/obj/structure/debris/welder_act(mob/living/user, obj/item/I)
	var/obj/item/tool/weldingtool/welder = I
	if(!welder.isOn())
		return FALSE
	var/action_time = 10 SECONDS
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS * 1.5)
	to_chat(user, span_notice("You begin to weld through parts of [src]..."))
	add_overlay(GLOB.welding_sparks)
	playsound(loc, 'sound/items/welder.ogg', 50)	//Replace this and all other welding actions with a looping_sound later
	if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
		cut_overlay(GLOB.welding_sparks)
		return
	cut_overlay(GLOB.welding_sparks)
	if(!welder.remove_fuel(5, user))
		return
	playsound(loc, 'sound/effects/clang.ogg', 50)
	to_chat(user, span_notice("You salvaged [src] into pieces!"))
	var/obj/item/stack/S = new /obj/item/stack/sheet/metal(loc)
	S.amount = 20
	qdel(src)
	return

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
