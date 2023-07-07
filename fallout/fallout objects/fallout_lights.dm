//Battery powered lights
/obj/item/flashlight/fallout
	name = "flashlight"
	desc = "Handheld lighting. Convenient."
	icon = 'fallout/fallout icons/fallout items/fallout_lights.dmi'
	item_icons = list(slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_items.dmi', slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_items.dmi')
	light_power = 5
	//light_system = HYBRID_LIGHT
	//light_mask_type = /atom/movable/lighting_mask/conical

//Use "_on" sprites instead of "-on", call "update_item_state()"
/obj/item/flashlight/fallout/update_icon()
	. = ..()
	if(light_on)
		icon_state = "[initial(icon_state)]_on"
	else
		icon_state = initial(icon_state)
	update_item_state()

//Updates the mob sprite	//Fix later, update_item_state() refuses to be called no matter what I try
/obj/item/fashlight/fallout/update_item_state(mob/user)
	item_state = "[initial(item_state)][light_on ? "_on" : ""]"

/obj/item/flashlight/fallout/junk
	name = "junk light"
	desc = "A source of light made out of scrap."
	icon_state = "flashlight_junk"
	item_state = "flashlight_junk"
	light_range = 4
	light_power = 4
	raillight_compatible = FALSE

/obj/item/flashlight/fallout/lantern
	name = "lantern"
	desc = "Small metal casing with glass housing containing a light."
	icon_state = "lantern"
	item_state = "lantern"
	light_power = 4
	light_color = LIGHT_COLOR_YELLOW
	//light_system = MOVABLE_LIGHT
	//light_mask_type = null
	raillight_compatible = FALSE

//Flares
/obj/item/flashlight/fallout/flare
	name = "flare"
	desc = "There are instructions on the side, it reads 'pull cord, make light'."
	icon_state = "flare"
	item_state = "flare"
	actions = list()	//just pull it manually, neckbeard.
	light_range = 6	//More light than a flash light
	light_power = 6 //As bright as a flashlight, but more disposable. Doesn't burn forever though
	light_color = LIGHT_COLOR_FLARE
	//light_system = MOVABLE_LIGHT
	//light_mask_type = null
	raillight_compatible = FALSE
	activation_sound = 'sound/items/flare.ogg'
	var/fuel = 1000	//No random fuel amounts
	var/on_damage = 7
	var/lighting_message = "pulled the cord on the flare"

/obj/item/flashlight/fallout/flare/turn_light(mob/user = null, toggle_on , cooldown = 1 SECONDS, sparks = FALSE, forced = FALSE, atom/originated_turf = null, distance_max = 0)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	if(toggle_on)
		return
	fuel = 0 //Flares are one way; if you turn them off, you're snuffing them out.
	heat = 0
	force = initial(force)
	damtype = initial(damtype)
	icon_state = "[initial(icon_state)]_spent"

/obj/item/flashlight/fallout/flare/proc/turn_off()
	turn_light(null, FALSE, 0, FALSE, TRUE)

/obj/item/flashlight/fallout/flare/attack_self(mob/user)
	// Usual checks
	if(!fuel)
		to_chat(user, span_notice("It's out of fuel."))
		return
	if(light_on)
		return
	. = ..()
	// All good, turn it on.
	if(.)
		user.visible_message(span_notice("[user] [lighting_message]."))
		force = on_damage
		heat = 1500
		damtype = BURN
		addtimer(CALLBACK(src, PROC_REF(turn_off)), fuel)
		if(iscarbon(user))
			var/mob/living/carbon/C = usr
			C.toggle_throw_mode()

/obj/item/flashlight/fallout/flare/torch
	name = "torch"
	desc = "A wooden stick with a flammable subtance on the tip."
	icon_state = "torch"
	item_state = "torch"
	light_range = 5	//Weaker than a flare
	light_power = 4
	light_color = LIGHT_COLOR_FIRE
	activation_sound = 'sound/items/flare.ogg'	//Needs torch sound file
	fuel = 1500	//Lasts longer than a flare
	lighting_message = "lit the torch"

//Street lamps
/obj/machinery/street_light
	name = "street light"
	desc = "Still providing the people with light hundreds of years later."
	icon = 'fallout/fallout icons/fallout structures/street_lights.dmi'
	icon_state = "single_on"
	obj_flags = CAN_BE_HIT
	layer = ABOVE_ALL_MOB_LAYER
	use_power = NO_POWER_USE
	power_channel = LIGHT
	max_integrity = 800
	integrity_failure = 200
	light_range = 12
	light_power = 1
	pixel_x = -32

/obj/machinery/street_light/Initialize()
	. = ..()
	set_light(light_range, light_power, light_color)
	AddComponent(/datum/component/largetransparency, 0, 0, 0, 2)

/obj/machinery/street_light/obj_break(damage_flag)
	set_light(0)
	icon_state = replacetext(icon_state, "_on", "")
	return

/obj/machinery/street_light/corner
	icon_state = "corner_on"

/obj/machinery/street_light/double
	icon_state = "double_on"

/obj/machinery/street_light/triple
	icon_state = "triple_on"

/obj/machinery/street_light/quadra
	icon_state = "quadra_on"

//Flood light used for faction camp lighting, increased range so it is not pathetic
/obj/machinery/floodlight/landing
	brightness_on = 12
