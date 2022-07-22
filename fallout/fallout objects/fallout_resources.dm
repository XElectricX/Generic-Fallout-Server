//Need to remove the check for only allowing building on floors
/obj/item/stack/building_checks(mob/user, datum/stack_recipe/R, multiplier)
	if (get_amount() < R.req_amount*multiplier)
		if (R.req_amount*multiplier>1)
			to_chat(user, span_warning("You haven't got enough [src] to build \the [R.req_amount*multiplier] [R.title]\s!"))
		else
			to_chat(user, span_warning("You haven't got enough [src] to build \the [R.title]!"))
		return FALSE
	var/turf/T = get_turf(user)

	switch(R.max_per_turf)
		if(STACK_RECIPE_ONE_PER_TILE)
			if(locate(R.result_type) in T)
				to_chat(user, span_warning("There is another [R.title] here!"))
				return FALSE
		if(STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE)
			for(var/obj/thing in T)
				if(!istype(thing, R.result_type))
					continue
				if(thing.dir != user.dir)
					continue
				to_chat(user, span_warning("You can't build \the [R.title] on top of another!"))
				return FALSE
	if(R.on_floor)
		if(!isopenturf(T) || isspaceturf(T) || islava(T))	//Only prohibit building on actually unsuitable turfs
			to_chat(user, span_warning("\The [R.title] must be constructed on stable ground!"))
			return FALSE
		for(var/obj/AM in T)
			if(istype(AM,/obj/structure/grille))
				continue
			if(istype(AM,/obj/structure/table))
				continue
			if(!AM.density)
				continue
			if(AM.flags_atom & ON_BORDER && AM.dir != user.dir)
				if(istype(AM, /obj/structure/window))
					var/obj/structure/window/W = AM
					if(!W.is_full_window())
						continue
				else
					continue
			to_chat(user, span_warning("There is a [AM.name] right where you want to place \the [R.title], blocking the construction."))
			return FALSE
	return TRUE