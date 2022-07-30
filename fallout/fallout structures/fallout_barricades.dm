/obj/structure/barricade/metal
	max_integrity = 300

/obj/structure/barricade/plasteel
	max_integrity = 400

/obj/structure/barricade/wooden
	max_integrity = 150

/obj/structure/barricade/sandbags
	max_integrity = 500

/obj/structure/iron_bars
	name = "iron bars"
	desc = "A wall made of metal rods designed to separate areas but allow visibility into the other side."
	icon = 'fallout/fallout icons/fallout structures/fallout_obstacles.dmi'
	icon_state = "iron_bars"
	max_integrity = 400
	throwpass = TRUE	//Bars spaced out enough to let objects be thrown

#define GIRDER_DAMAGED 0
#define GIRDER_BUILT 1
#define GIRDER_SECURED 2
#define GIRDER_REINFORCED 3

//Girders for building walls
/obj/structure/fallout_girder
	name = "metal girder"
	icon = 'fallout/fallout icons/fallout structures/fallout_obstacles.dmi'
	icon_state = "girder"
	desc = "A large structural assembly made out of metal. It requires some layers of metal before it can be considered a wall."
	anchored = TRUE
	density = TRUE
	layer = OBJ_LAYER
	hit_sound = 'sound/effects/metalhit.ogg'
	max_integrity = 200
	integrity_failure = 50
	coverage = 100
	var/girder_state = GIRDER_BUILT
	var/building_material = GIRDER_REINF_METAL	//What item to use to finish the wall
	var/building_cost = 4	//Ideally the cost to make this girder should also match this
	var/building_health_increase = 200	//When adding reinforcement, how much to increase max_integrity by
	var/upgrade_material = GIRDER_REINF_PLASTEEL	//What item to use to reinforce
	var/upgrade_cost = 4
	var/upgrade_health_increase = 400	//When upgrading, how much to increase max_integrity by
	var/upgraded = FALSE
	var/wall_to_build = /turf/closed/wall
	var/upgraded_wall_to_build = /turf/closed/wall/r_wall
	var/repairable_with_materials = FALSE	//If the only way to fix it is by slapping more building_material

/obj/structure/fallout_girder/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, building_material) || istype(I, upgrade_material))
		apply_building_material(I, user)

///When all is done, this is called to spawn in the wall
/obj/structure/fallout_girder/proc/build_wall()
	var/turf/source_turf = get_turf(src)
	if(upgraded)
		source_turf.ChangeTurf(upgraded_wall_to_build)
	else
		source_turf.ChangeTurf(wall_to_build)
	qdel(src)

///Called for slapping metal or plasteel or whatever on your girder; repairs if the girder
/obj/structure/fallout_girder/proc/apply_building_material(obj/item/I, mob/living/user)
	var/action_time = 2.5 SECONDS	//Base time to do stuff
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS/2)	//Each point in construction shaves off a half second
	var/obj/item/stack/sheet/stack = I	//Currently only accepts sheets but it should not be hard to make it accept any item and delete it on use!
	if(girder_state == GIRDER_BROKEN || (repairable_with_materials && obj_integrity != max_integrity))	//Only way to repair a broken girder
		if(stack.amount < 2)
			to_chat(user, span_warning("You need two [stack.name] to fix [src]!"))
			return
		to_chat(user, span_notice("Repairing [src] with [stack.name]..."))
		if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
			return
		if(QDELETED(stack) || stack.amount < 2 || obj_integrity == max_integrity)
			return
		stack.use(2)
		obj_integrity = max_integrity
		to_chat(user, span_notice("You have finished repairing [src]."))
		name = initial(name)
		density = TRUE
		girder_state++
		update_icon()
	if(girder_state == GIRDER_SECURED)
		if(stack.amount < building_cost)
			to_chat(user, span_warning("You need more [stack.name]!"))
			return
		var/is_upgrading = istype(I, upgrade_material)
		if(stack.amount < (is_upgrading ? upgrade_cost : building_cost))
			return
		to_chat(user, span_notice("Now reinforcing [src] with [stack.name]..."))
		if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
			return
		if(QDELETED(stack) || stack.amount < (is_upgrading ? upgrade_cost : building_cost) || girder_state != GIRDER_NORMAL)
			return
		stack.use(is_upgrading ? upgrade_cost : building_cost)
		to_chat(user, span_notice("You reinforced [src] with [stack.name]!"))
		if(is_upgrading)
			upgraded = TRUE
			modify_max_integrity(initial(max_integrity) + upgrade_health_increase)	//600 total HRP if you reinforce with plasteel
			name = "[stack.name] reinforced [initial(name)]"
		else
			modify_max_integrity(initial(max_integrity) + building_health_increase)	//400 total HP if you reinforce with metal
		girder_state++
		update_icon()
		return
	return

//Just an extra step in building
/obj/structure/fallout_girder/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	var/action_time = 2.5 SECONDS
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS/2)
	switch(girder_state)
		if(GIRDER_BUILT)
			to_chat(user, span_notice("You begin to tighten the support struts on [src]..."))
			playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
			if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
				return
			to_chat(user, span_notice("You have tightened the support struts on [src]!"))
			girder_state++
			return
		if(GIRDER_SECURED)
			to_chat(user, span_notice("You begin to loosen the support struts on [src]..."))
			playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
			if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
				return
			to_chat(user, span_notice("You have loosened the support struts on [src]!"))
			girder_state--
			return

//Weld a wall into existence or deconstruct a girder
/obj/structure/fallout_girder/welder_act(mob/living/user, obj/item/I)
	. = ..()
	var/obj/item/tool/weldingtool/welder = I
	if(!welder.isOn())
		return FALSE
	var/action_time = 2.5 SECONDS
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS/2)
	if((girder_state != GIRDER_BROKEN) && obj_integrity < max_integrity)	//If the girder is broken, refer to apply_building_material() above
		to_chat(user, span_notice("You begin to repair [src]..."))
		playsound(loc, 'sound/items/welder2.ogg', 25, 1)
		if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
			return
		obj_integrity += (obj_integrity + 100 > max_integrity ? max_integrity - obj_integrity : 100)	//Check to prevent the integrity from going over maximum
		to_chat(user, span_notice("You [obj_integrity == max_integrity ? "fully repaired [src]." : "repaired some parts of [src]."]"))
		return
	switch(girder_state)
		if(GIRDER_REINFORCED)
			to_chat(user, span_notice("You begin to weld the plating on [src]..."))
			playsound(loc, 'sound/items/welder2.ogg', 25, 1)
			if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
				return
			if(!welder.remove_fuel(1, user))
				return
			to_chat(user, span_notice("You welded the plating on [src] into place!"))
			build_wall()	//Handles the deletion and spawning of the wall itself
		if(GIRDER_BUILT)
			to_chat(user, span_notice("You begin to weld [src] into pieces..."))
			if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
				return
			if(!welder.remove_fuel(1, user))
				return
			to_chat(user, span_notice("You welded the [src] apart!"))
			var/obj/item/stack/S = new building_material(loc)
			S.amount = building_cost
			qdel(src)
			return

//This is only for deconstructing, takes the plating off a girder
/obj/structure/fallout_girder/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	var/action_time = 2.5 SECONDS
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS/2)
	if(girder_state ==  GIRDER_REINFORCED)
		to_chat(user, span_notice("You begin to separate the plating off of [src]..."))
		playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
		if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
			return
		to_chat(user, span_notice("You have separated the plating from [src]!"))
		if(upgraded)
			name = "[initial(name)]"
			var/obj/item/stack/S = new upgrade_material(loc)
			S.amount = upgrade_cost
		else
			var/obj/item/stack/S = new building_material(loc)
			S.amount = building_cost
		modify_max_integrity(initial(max_integrity))
		girder_state--
		update_icon()
		return

//When a girder reaches a threshold, it will break open and stop functioning as cover; also resets the building steps
/obj/structure/fallout_girder/obj_break()
	girder_state = GIRDER_BROKEN
	upgraded = FALSE
	name = "damaged [initial(name)]"
	density = FALSE
	modify_max_integrity(initial(max_integrity))
	visible_message(span_warning("[src] falls apart!"))
	update_icon()

/obj/structure/fallout_girder/update_icon_state()
	switch(girder_state)
		if(GIRDER_BROKEN)
			icon_state = "[initial(icon_state)]_damaged"
		if(GIRDER_BUILT,GIRDER_SECURED)
			icon_state = initial(icon_state)
		if(GIRDER_REINFORCED)
			if(upgraded)
				icon_state = "[initial(icon_state)]_upgraded"
			else
				icon_state = "[initial(icon_state)]_reinforced"

//I'm tired of this and gonna shortcut by just using binary of if the girder is metal or wood /shrug
/obj/structure/fallout_girder/examine(mob/user)
	. = ..()
	var/G = /obj/structure/fallout_girder/wood
	switch(girder_state)
		if(GIRDER_DAMAGED)
			. += "The girder is damaged and no longer provides cover. It can be repaired by adding material. It can be dismantled with [istype(src, G) ? "a crowbar" : "a welder"]."
		if(GIRDER_BUILT)
			. += "To make a wall, first [istype(src, G) ? "use a screwdriver to secure the planks" : "wrench the support struts"]. To dismantle, use [istype(src, G) ? "a crowbar" : "a welder"]."
		if(GIRDER_SECURED)
			. += "The girder requires reinforcement. Add some building materials to plate it."
		if(GIRDER_REINFORCED)
			. += "The girder is reinforced. Finish securing the plating by [istype(src, G) ? "fastening the wooden cover to the structure with a screwdriver" : "welding the metal into place"]."
	if(obj_integrity != max_integrity && girder_state != GIRDER_DAMAGED)
		. += "The girder is damaged and can be repaired with [istype(src, G) ? "wood" : "a welder"]."

/obj/structure/fallout_girder/wood
	name = "wooden girder"
	desc = "A large structural assembly made out of wood. Needs more wood to make a full wall."
	icon_state = "girder_wood"
	hit_sound = 'sound/effects/woodhit.ogg'
	max_integrity = 100
	integrity_failure = 25
	building_material = /obj/item/stack/sheet/wood
	building_health_increase = 100
	upgrade_material = null
	upgrade_cost = 0
	upgrade_health_increase = 0
	wall_to_build = /turf/closed/wall/fallout/log
	upgraded_wall_to_build = null
	repairable_with_materials = TRUE

/obj/structure/fallout_girder/wood/crowbar_act(mob/living/user, obj/item/I)
	var/action_time = 2.5 SECONDS
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS/2)
	switch(girder_state)
		if(GIRDER_REINFORCED)
			to_chat(user, span_notice("You begin to pry loose the reinforcements on [src]..."))
			playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
			if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
				return
			to_chat(user, span_notice("You pried apart some load-bearing planks from [src]!"))
			var/obj/item/stack/S = new building_material(loc)
			S.amount = building_cost
			modify_max_integrity(initial(max_integrity))
			girder_state--
			update_icon()
		if(GIRDER_BUILT)
			to_chat(user, span_notice("You begin to dismantle [src]..."))
			playsound(loc, 'sound/items/crowbar.ogg', 25, 1)
			if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
				return
			to_chat(user, span_notice("You dismantled [src]!"))
			var/obj/item/stack/S = new building_material(loc)
			S.amount = building_cost
			qdel(src)

/obj/structure/fallout_girder/wood/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	var/action_time = 2.5 SECONDS
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS/2)
	if(girder_state == GIRDER_BUILT || girder_state == GIRDER_REINFORCED)	//We're gonna cheat and use screwdriver for both steps
		to_chat(user, span_notice("You begin to screw some planks together on [src]..."))
		playsound(loc, 'sound/items/screwdriver.ogg', 25, 1)
		if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
			return
		to_chat(user, span_notice("You have screwed the planks on [src] to each other securely!"))
		if(girder_state == GIRDER_REINFORCED)
			build_wall()
		else
			girder_state++

/obj/structure/fallout_girder/wood/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/fallout_girder/wood/wirecutter_act(mob/living/user, obj/item/I)
	return