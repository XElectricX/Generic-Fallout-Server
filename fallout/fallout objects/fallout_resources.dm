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

//New recipe lists
GLOBAL_LIST_INIT(fallout_metal_recipes, list ( \
	new/datum/stack_recipe("metal barricade", /obj/structure/barricade/metal, 4, time = 8 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("barbed wire", /obj/item/stack/barbed_wire, 2, 1, 20, time = 1 SECONDS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("razor wire", /obj/item/stack/razorwire, 3, 1, 20, time = 5 SECONDS, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe_list("construction", list( \
	new/datum/stack_recipe("wall girder", /obj/structure/girder, 8, time = 10 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_ADVANCED), \
	new/datum/stack_recipe("metal rod", /obj/item/stack/rods, 1, 4, 60), \
	new/datum/stack_recipe("floor tile", /obj/item/stack/tile/plasteel, 1, 4, 20), \
	new/datum/stack_recipe("apc frame", /obj/item/frame/apc, 2), \
	new/datum/stack_recipe("light fixture frame", /obj/item/frame/light_fixture, 2), \
	new/datum/stack_recipe("small light fixture frame", /obj/item/frame/light_fixture/small, 1), \
	new/datum/stack_recipe("lock", /obj/item/lock_construct, 1), \
	new/datum/stack_recipe("key", /obj/item/key, 1))), \
	null, \
	new/datum/stack_recipe_list("furniture", list( \
	new/datum/stack_recipe("crude metal door", /obj/structure/simple_door/metal, 4, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("heavy iron door", /obj/structure/simple_door/metal/iron, 15, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("store doors", /obj/structure/simple_door/metal/store, 4, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("ventilation panel", /obj/structure/simple_door/metal/ventilation, 4, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("bed", /obj/structure/bed, 2, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("bunk bed", /obj/structure/bed/bunkbed, 4, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("chair", /obj/structure/bed/chair, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("comfy chair", /obj/structure/bed/chair/comfy/beige, 2, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("office chair",/obj/structure/bed/chair/office/dark, 2, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE))), \
	new/datum/stack_recipe_list("airlock assemblies", list( \
	new/datum/stack_recipe("standard airlock assembly", /obj/structure/door_assembly, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("command airlock assembly", /obj/structure/door_assembly/door_assembly_com, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("security airlock assembly", /obj/structure/door_assembly/door_assembly_sec, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("engineering airlock assembly", /obj/structure/door_assembly/door_assembly_eng, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("mining airlock assembly", /obj/structure/door_assembly/door_assembly_min, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("atmospherics airlock assembly", /obj/structure/door_assembly/door_assembly_atmo, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("research airlock assembly", /obj/structure/door_assembly/door_assembly_research, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("medical airlock assembly", /obj/structure/door_assembly/door_assembly_med, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("maintenance airlock assembly", /obj/structure/door_assembly/door_assembly_mai, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("external airlock assembly", /obj/structure/door_assembly/door_assembly_ext, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("freezer airlock assembly", /obj/structure/door_assembly/door_assembly_fre, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("airtight hatch assembly", /obj/structure/door_assembly/door_assembly_hatch, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("maintenance hatch assembly", /obj/structure/door_assembly/door_assembly_mhatch, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("high security airlock assembly", /obj/structure/door_assembly/door_assembly_highsecurity, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("multi-tile airlock assembly", /obj/structure/door_assembly/multi_tile, 4, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_MASTER)))))

GLOBAL_LIST_INIT(fallout_wood_recipes, list ( \
	new/datum/stack_recipe("wooden barricade", /obj/structure/barricade/wooden, 5, time = 5 SECONDS, max_per_turf = STACK_RECIPE_ONE_DIRECTIONAL_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("baseball bat", /obj/item/weapon/fallout_melee/bat, 3, time = 2 SECONDS), \
	null, \
	new/datum/stack_recipe_list("construction", list( \
	new/datum/stack_recipe("laminated floor", /obj/item/stack/tile/wood, 1, 4, 20), \
	new/datum/stack_recipe("oak floor", /turf/open/floor/fallout/wood, 1, 4, 20), \
	new/datum/stack_recipe("dark oak floor", /turf/open/floor/fallout/wood/dark, 1, 4, 20), \
	new/datum/stack_recipe("walnut floor", /turf/open/floor/fallout/wood/walnut, 1, 4, 20), \
	new/datum/stack_recipe("maple floor", /turf/open/floor/fallout/wood/maple, 1, 4, 20), \
	new/datum/stack_recipe("chestnut floor", /turf/open/floor/fallout/wood/chestnut, 1, 4, 20), \
	new/datum/stack_recipe("tiled floor", /turf/open/floor/fallout/wood/tiled, 1, 4, 20), \
	new/datum/stack_recipe("paneled floor", /turf/open/floor/fallout/wood/panel, 1, 4, 20), \
	new/datum/stack_recipe("diagonal floor", /turf/open/floor/fallout/wood/diagonal, 1, 4, 20))), \
	new/datum/stack_recipe_list("furniture", list( \
	new/datum/stack_recipe("wooden door", /obj/structure/simple_door/room, 4, time = 2 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("wooden panel door", /obj/structure/simple_door/interior, 4, time = 2 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("house door", /obj/structure/simple_door/house, 4, time = 2 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("cabin door", /obj/structure/simple_door/wood, 4, time = 2 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("table parts", /obj/item/frame/table/wood, 2), \
	new/datum/stack_recipe("fancy bed", /obj/structure/bed/fancy, 2, time = 2 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("wooden chair", /obj/structure/bed/chair/wood/normal, 1, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("fancy wooden chair",/obj/structure/bed/chair/office/dark, 1, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("pew", /obj/structure/bed/chair/pew, 1, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE), \
	new/datum/stack_recipe("coffin", /obj/structure/closet/coffin, 4, time = 2 SECONDS, max_per_turf = STACK_RECIPE_ONE_PER_TILE, on_floor = TRUE, skill_req = SKILL_CONSTRUCTION_METAL)))))
