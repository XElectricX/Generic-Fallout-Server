/obj/structure/fallout_fence
	name = "wire fence"
	desc = "A large metal mesh strewn between two poles. Intended as a cheap way to separate areas, while allowing one to see through it."
	icon = 'fallout/fallout icons/fallout structures/fallout_fences.dmi'
	icon_state = "wire_fence"
	flags_atom = ON_BORDER
	layer = ABOVE_ALL_MOB_LAYER	//So that the railings and wooden fences appear above stuff
	density = TRUE
	anchored = TRUE
	max_integrity = 150
	coverage = 20
	var/can_be_cut = TRUE	//If FALSE, can only be dismantled with a wrench (or violence)
	var/dismantle_steps = 3	//How many times you need to cut through to destroy it
	var/current_step = 0
	var/icon_prefix = "wire_"	//Used for cut sprite states
	var/is_repaired_with_welder = TRUE	//Only metal fences can be welded back to full condition
	var/building_material = /obj/item/stack/rods	//What this object was made out of
	var/building_cost = 4	//Used to refund however many resources when dismantling; for if a child object uses a different amount

//Following stuff allows railing and fences to act like windows and barricades
/obj/structure/fallout_fence/Initialize()
	. = ..()
	var/static/list/connections = list(COMSIG_ATOM_EXIT = PROC_REF(on_try_exit))
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/fallout_fence/on_try_exit(datum/source, atom/movable/mover, direction, list/knownblockers)
	if(CHECK_BITFIELD(mover.allow_pass_flags, PASS_DEFENSIVE_STRUCTURE))
		return NONE
	if(!density || !(flags_atom & ON_BORDER) || !(direction & dir) || (mover.status_flags & INCORPOREAL))
		return NONE
	knownblockers += src
	return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/fallout_fence/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(CHECK_BITFIELD(mover.allow_pass_flags, PASS_DEFENSIVE_STRUCTURE))
		return TRUE
	if(mover?.throwing && climbable)	//If you can climb over it, surely you can throw items over it!
		return TRUE
	if(istype(mover, /obj/vehicle/multitile))
		visible_message(span_danger("[mover] drives over and destroys [src]!"))
		deconstruct(FALSE)
		return FALSE
	if(density)
		if((mover.flags_atom & ON_BORDER) && get_dir(loc, target) & dir)
			return FALSE
		var/obj/structure/S = locate(/obj/structure) in get_turf(mover)
		if(S?.climbable && !(S.flags_atom & ON_BORDER) && climbable && isliving(mover)) //Climbable objects allow you to universally climb over others
			return TRUE
		if(get_dir(loc, target) & dir)
			return FALSE
		if(CHECK_BITFIELD(flags_atom, ON_BORDER))	//If it doesn't have the flag, don't let through
			return TRUE
	else
		return TRUE

//Dismantling process if can_be_cut is TRUE
/obj/structure/fallout_fence/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	var/action_time = 2.5 SECONDS
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS/2)
	if(can_be_cut)
		to_chat(user, span_notice("You begin to cut [src]..."))
		playsound(loc, 'sound/items/wirecutter.ogg', 25, 1)
		if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
			return
		new building_material(loc)	//Return one rod per step since it totals to 4, which is what it cost
		if(current_step == dismantle_steps)
			to_chat(user, span_notice("You have cut apart [src]!"))
			qdel(src)
		else
			to_chat(user, span_notice("You have cut away some parts of [src]."))
			current_step++
			switch(current_step)	//Fence can be climbed through or walked through depending on how cut up it is
				if(2)
					climbable = TRUE
				if(3)
					density = FALSE
			update_icon()
			return

//Dismantling process if can_be_cut is FALSE
/obj/structure/fallout_fence/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	var/action_time = 2.5 SECONDS
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS/2)
	if(!can_be_cut)	//Check if you need to dismantle with wirecutters
		to_chat(user, span_notice("You begin to dismantle [src]..."))
		playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
		if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
			return
		to_chat(user, span_notice("You have dismantled [src]!"))
		var/obj/item/stack/S = new building_material(loc)
		S.amount = building_cost //Refund however many sheets it took to make this
		qdel(src)

//Repairing process if is_repaired_with_welder is TRUE
/obj/structure/fallout_fence/welder_act(mob/living/user, obj/item/I)
	. = ..()
	var/obj/item/tool/weldingtool/welder = I
	if(!welder.isOn())
		return FALSE
	var/action_time = 2.5 SECONDS
	if(user.skills.getRating("construction"))
		action_time = action_time - (user.skills.getRating("construction")SECONDS/2)
	if(is_repaired_with_welder)
		to_chat(user, span_notice("You begin to repair [src]..."))
		playsound(loc, 'sound/items/welder2.ogg', 25, 1)
		if(!do_after(user, action_time, TRUE, src, BUSY_ICON_BUILD))
			return
		if(!welder.remove_fuel(1, user))
			return
		obj_integrity += (obj_integrity + 50 > max_integrity ? max_integrity - obj_integrity : 50)	//Check to prevent the integrity from going over maximum
		to_chat(user, span_notice("You [obj_integrity == max_integrity ? "fully repaired [src]." : "repaired some parts of [src]."]"))
		return

//Initialize() does NOT set direction before it finishes so update_icon() has to be called from here
/obj/structure/fallout_fence/setDir(newdir)
	. = ..()
	update_icon()

//Change sprite to damaged variants
/obj/structure/fallout_fence/update_icon()
	. = ..()
	switch(dir)	//So that if the fence/railing faces north, mobs and objects appear above it
		if(SOUTH, SOUTHWEST, SOUTHEAST)
			layer = initial(layer)
		if(NORTH, NORTHWEST, NORTHEAST)
			layer = BELOW_OBJ_LAYER
		else
			layer = initial(layer) - 0.01
	if(can_be_cut)	//Switch sprite to damaged states if cut through
		switch(current_step)
			if(0)
				icon_state = initial(icon_state)
				return
			else
				icon_state = icon_prefix + "cut[current_step]"
				return

/obj/structure/fallout_fence/post
	icon_state = "wire_post"

/obj/structure/fallout_fence/left
	icon_state = "wire_left"

/obj/structure/fallout_fence/right
	icon_state = "wire_right"

/obj/structure/fallout_fence/wood
	name = "wooden fence"
	desc = "For keeping your ranch critters in or keeping raiders out."
	icon_state = "wood_fence"
	climbable = TRUE
	max_integrity = 120
	coverage = 10
	can_be_cut = FALSE
	dismantle_steps = null
	current_step = null
	is_repaired_with_welder = FALSE
	building_material = /obj/item/stack/sheet/wood

/obj/structure/fallout_fence/wood/left
	icon_state = "wood_left"

/obj/structure/fallout_fence/wood/right
	icon_state = "wood_right"

/obj/structure/fallout_fence/railing
	name = "metal railing"
	desc = "Do not jump it. NO."
	icon_state = "railing"
	climbable = TRUE
	max_integrity = 100
	coverage = 10
	can_be_cut = FALSE
	dismantle_steps = null
	current_step = null
	building_cost = 3

/obj/structure/fallout_fence/railing/corner
	flags_atom = NONE	//To prevent annoyances
	density = FALSE
	icon_state = "railing_corner"
	building_cost = 2

/obj/structure/fallout_fence/railing/corner/update_icon()
	. = ..()
	switch(dir)
		if(SOUTH, EAST)
			layer = initial(layer)
		else
			layer = BELOW_OBJ_LAYER

/obj/structure/fallout_fence/railing/handrail
	name = "hand rail"
	desc = "Keep yourself from falling over."
	icon_state = "handrail_g"
	climbable = TRUE
	max_integrity = 200	//Pretty robust
	can_be_cut = FALSE
	dismantle_steps = null
	current_step = null
	building_material = /obj/item/stack/sheet/metal
	building_cost = 3

/obj/structure/fallout_fence/railing/handrail/end
	icon_state = "handrail_g_end"

/obj/structure/fallout_fence/railing/handrail/yellow
	icon_state = "handrail_y"

/obj/structure/fallout_fence/railing/handrail/yellow_end
	icon_state = "handrail_y_end"

/obj/structure/fallout_fence/railing/handrail/blue
	icon_state = "handrail_b"

/obj/structure/fallout_fence/railing/handrail/blue_end
	icon_state = "handrail_b_end"
