//Weighted list which is used by pickweight(), which adds up the values of the list elements; iron will have about 50% chance of being picked, ultracite 1%
GLOBAL_LIST_INIT(ore_drops, list(
			/obj/item/fallout_ore = 100,
			/obj/item/fallout_ore/silver = 19,
			/obj/item/fallout_ore/gold = 19,
			/obj/item/fallout_ore/platinum = 19,
			/obj/item/fallout_ore/uranium = 19,
			/obj/item/fallout_ore/diamond = 5,
			/obj/item/fallout_ore/ultracite = 1,
			/obj/item/fallout_ore/coal = 19))

/obj/item/fallout_ore
	name = "\a iron ore"
	desc = "Can be refined."
	icon = 'fallout/fallout icons/fallout items/fallout_resources.dmi'
	icon_state = "iron"

/obj/item/fallout_ore/Initialize(mapload)
	. = ..()
	pixel_x = rand(-8, 8)
	pixel_y = rand(-4, 4)

/obj/item/fallout_ore/silver
	name = "\a silver ore"
	icon_state = "silver"

/obj/item/fallout_ore/gold
	name = "\a gold ore"
	icon_state = "gold"

/obj/item/fallout_ore/platinum
	name = "\a platinum ore"
	icon_state = "platinum"

/obj/item/fallout_ore/uranium
	name = "\a uranium ore"
	icon_state = "uranium"

/obj/item/fallout_ore/diamond
	name = "\a raw diamonds"
	icon_state = "diamond"

/obj/item/fallout_ore/ultracite
	name = "\a ultracite ore"
	icon_state = "ultracite"

/obj/item/fallout_ore/coal
	name = "\a coal"
	desc = "People went to war over this."
	icon_state = "coal"

/obj/item/fallout_resource
	name = "resource"
	desc = "Valuable, ain't it?"
	icon = 'fallout/fallout icons/fallout items/fallout_resources.dmi'

/obj/item/fallout_resource/sand
	name = "\a sand"
	desc = "Coarse and rough and irritating... and it gets everywhere."
	icon_state = "sand"

#define CRAFT_STANDARD_FLAGS CRAFT_CHECK_DENSITY|CRAFT_ONE_PER_TURF|CRAFT_ON_SOLID_GROUND
//New recipe lists
//IMPORTANT NOTE: do not put anything that has multipliers (like floor tiles) in lists because it is bugged and will not work
GLOBAL_LIST_INIT(fallout_metal_recipes, list ( \
	new/datum/stack_recipe("metal barricade", /obj/structure/barricade/metal, 4, time = 6 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("barbed wire", /obj/item/stack/barbed_wire, 2, 1, 20, time = 1 SECONDS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("razor wire", /obj/item/stack/razorwire, 3, 1, 20, time = 5 SECONDS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("metal rod", /obj/item/stack/rods, 1, 4, 60), \
	new/datum/stack_recipe("floor tile", /obj/item/stack/tile/plasteel, 1, 4, 20), \
	null, \
	new/datum/stack_recipe_list("construction", list( \
	new/datum/stack_recipe("metal girder", /obj/structure/fallout_girder, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_ADVANCED), \
	null, \
	new/datum/stack_recipe("apc frame", /obj/item/frame/apc, 2), \
	new/datum/stack_recipe("light fixture frame", /obj/item/frame/light_fixture, 2), \
	new/datum/stack_recipe("small light fixture frame", /obj/item/frame/light_fixture/small, 1), \
	null, \
	new/datum/stack_recipe("lock", /obj/item/lock_construct, 1), \
	new/datum/stack_recipe("key", /obj/item/key, 1))), \
	new/datum/stack_recipe_list("furniture", list( \
	new/datum/stack_recipe("crude metal door", /obj/structure/simple_door/metal, 4, time = 4 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("heavy iron door", /obj/structure/simple_door/metal/iron, 10, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("store doors", /obj/structure/simple_door/metal/store, 4, time = 4 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("ventilation panel", /obj/structure/simple_door/metal/ventilation, 4, time = 3 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe("table parts", /obj/item/frame/table, 2), \
	new/datum/stack_recipe("bed", /obj/structure/bed, 2, crafting_flags = CRAFT_STANDARD_FLAGS), \
	new/datum/stack_recipe("bunk bed", /obj/structure/bed/bunkbed, 4, crafting_flags = CRAFT_STANDARD_FLAGS), \
	new/datum/stack_recipe("chair", /obj/structure/bed/chair, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("comfy chair", /obj/structure/bed/chair/comfy/beige, 2, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("office chair",/obj/structure/bed/chair/office/dark, 2, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_ON_SOLID_GROUND), \
	null, \
	new/datum/stack_recipe("yellow hand rail", /obj/structure/fallout_fence/railing/handrail/yellow, 3, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("yellow hand rail end", /obj/structure/fallout_fence/railing/handrail/yellow_end, 2, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("blue hand rail", /obj/structure/fallout_fence/railing/handrail/blue, 3, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("blue hand rail end", /obj/structure/fallout_fence/railing/handrail/blue_end, 2, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL))), \
	new/datum/stack_recipe_list("storage", list( \
	new/datum/stack_recipe("metal crate", /obj/structure/closet/fallout/crate/metal, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("medical crate", /obj/structure/closet/fallout/crate/medical, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("medical chest", /obj/structure/closet/fallout/crate/medical/chest, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("footlocker", /obj/structure/closet/fallout/crate/footlocker, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("trash can", /obj/structure/closet/fallout/crate/trash, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("trash bin", /obj/structure/closet/fallout/crate/bin, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe("metal cart", /obj/structure/closet/fallout/crate/metal, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe("locker", /obj/structure/closet/fallout, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL))), \
	new/datum/stack_recipe_list("airlock assemblies", list( \
	new/datum/stack_recipe("standard airlock assembly", /obj/structure/door_assembly, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("command airlock assembly", /obj/structure/door_assembly/door_assembly_com, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("security airlock assembly", /obj/structure/door_assembly/door_assembly_sec, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("engineering airlock assembly", /obj/structure/door_assembly/door_assembly_eng, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("mining airlock assembly", /obj/structure/door_assembly/door_assembly_min, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("atmospherics airlock assembly", /obj/structure/door_assembly/door_assembly_atmo, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("research airlock assembly", /obj/structure/door_assembly/door_assembly_research, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("medical airlock assembly", /obj/structure/door_assembly/door_assembly_med, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("maintenance airlock assembly", /obj/structure/door_assembly/door_assembly_mai, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("external airlock assembly", /obj/structure/door_assembly/door_assembly_ext, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("freezer airlock assembly", /obj/structure/door_assembly/door_assembly_fre, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("airtight hatch assembly", /obj/structure/door_assembly/door_assembly_hatch, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("maintenance hatch assembly", /obj/structure/door_assembly/door_assembly_mhatch, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("high security airlock assembly", /obj/structure/door_assembly/door_assembly_highsecurity, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER), \
	new/datum/stack_recipe("multi-tile airlock assembly", /obj/structure/door_assembly/multi_tile, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_MASTER)))))

GLOBAL_LIST_INIT(fallout_wood_recipes, list ( \
	new/datum/stack_recipe("wooden barricade", /obj/structure/barricade/wooden, 5, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("wooden girder", /obj/structure/fallout_girder/wood, 4, time = 5 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe("laminated floor", /obj/item/stack/tile/wood, 1, 4, 20), \
	new/datum/stack_recipe("oak floor", /turf/open/floor/fallout/wood, 1, 4, 20), \
	new/datum/stack_recipe("dark oak floor", /turf/open/floor/fallout/wood/dark, 1, 4, 20), \
	new/datum/stack_recipe("walnut floor", /turf/open/floor/fallout/wood/walnut, 1, 4, 20), \
	new/datum/stack_recipe("maple floor", /turf/open/floor/fallout/wood/maple, 1, 4, 20), \
	new/datum/stack_recipe("chestnut floor", /turf/open/floor/fallout/wood/chestnut, 1, 4, 20), \
	new/datum/stack_recipe("tiled floor", /turf/open/floor/fallout/wood/tiled, 1, 4, 20), \
	new/datum/stack_recipe("paneled floor", /turf/open/floor/fallout/wood/panel, 1, 4, 20), \
	new/datum/stack_recipe("diagonal floor", /turf/open/floor/fallout/wood/diagonal, 1, 4, 20), \
	null, \
	new/datum/stack_recipe_list("furniture", list( \
	new/datum/stack_recipe("wooden door", /obj/structure/simple_door/room, 4, time = 4 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("wooden panel door", /obj/structure/simple_door/interior, 4, time = 4 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("house door", /obj/structure/simple_door/house, 4, time = 4 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("cabin door", /obj/structure/simple_door/wood, 4, time = 4 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe("wooden table parts", /obj/item/frame/table/wood, 2), \
	new/datum/stack_recipe("fancy bed", /obj/structure/bed/fancy, 2, crafting_flags = CRAFT_STANDARD_FLAGS), \
	new/datum/stack_recipe("wooden chair", /obj/structure/bed/chair/wood/normal, 1, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("fancy wooden chair",/obj/structure/bed/chair/office/dark, 1, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("pew", /obj/structure/bed/chair/pew, 1, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_ON_SOLID_GROUND), \
	null, \
	new/datum/stack_recipe("wooden fence", /obj/structure/fallout_fence/wood, 4, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("wooden fence left", /obj/structure/fallout_fence/wood/left, 4, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("wooden fence right", /obj/structure/fallout_fence/wood/right, 4, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND), \
	new/datum/stack_recipe("wooden fence gate", /obj/structure/simple_door/gate/wood, 4, time = 3 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS))), \
	new/datum/stack_recipe_list("storage", list( \
	new/datum/stack_recipe("crate", /obj/structure/closet/fallout/crate, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("wooden crate", /obj/structure/closet/fallout/crate/wood, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("wooden chest", /obj/structure/closet/fallout/crate/chest, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("wicker basket", /obj/structure/closet/fallout/crate/basket, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("coffin", /obj/structure/closet/fallout/crate/coffin, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe("cabinet", /obj/structure/closet/fallout/cabinet, 3, time = 2 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL))), \
	null, \
	new/datum/stack_recipe("baseball bat", /obj/item/weapon/fallout_melee/bat, 3, time = 2 SECONDS)))

GLOBAL_LIST_INIT(fallout_rod_recipes, list ( \
	new/datum/stack_recipe("iron gate", /obj/structure/simple_door/gate, 12, time = 4 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("iron bars", /obj/structure/iron_bars, 16, time = 6 SECONDS, crafting_flags = CRAFT_STANDARD_FLAGS, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe("wire fence", /obj/structure/fallout_fence, 4, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("wire fence post", /obj/structure/fallout_fence/post, 4, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("wire fence left", /obj/structure/fallout_fence/left, 4, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("wire fence right", /obj/structure/fallout_fence/right, 4, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("wire fence gate", /obj/structure/simple_door/gate/wire, 8, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	null, \
	new/datum/stack_recipe("railing", /obj/structure/fallout_fence/railing, 3, time = 2 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL), \
	new/datum/stack_recipe("railing corner", /obj/structure/fallout_fence/railing/corner, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY|CRAFT_CHECK_DIRECTION|CRAFT_ON_SOLID_GROUND, skill_req = SKILL_CONSTRUCTION_METAL)))

//Load our own version of recipe lists
/obj/item/stack/sheet/metal/Initialize(mapload, amount)
	. = ..()
	recipes = GLOB.fallout_metal_recipes

/obj/item/stack/sheet/wood/Initialize(mapload, amount)
	. = ..()
	recipes = GLOB.fallout_wood_recipes

/obj/item/stack/rods/Initialize(mapload, amount)
	. = ..()
	recipes = GLOB.fallout_rod_recipes

//Overwrite rod's attack_self() because it makes you build a grille instead of opening a recipe menu
/obj/item/stack/rods/attack_self(mob/user)
	if(!can_interact(user))
		return
	interact(user)
