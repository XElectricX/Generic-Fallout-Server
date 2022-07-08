//Base floor for terrains, since they will all use the same icon file
/turf/open/ground/fallout
	name = "terrain template"
	desc = "If you see this ingame, someone screwed up."
	icon = 'fallout/fallout icons/fallout turfs/fallout_terrain.dmi'
	icon_state = ""
	shoefootstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND

//Sand, I don't like it
/turf/open/ground/fallout/desert
	name = "desert"
	desc = "It's coarse and rough and irritating and it gets everywhere."
	icon_state = "desert1"

/turf/open/ground/fallout/desert/Initialize()
	. = ..()
	var/random_turf = rand(1,29)
	icon_state = "desert[random_turf]"

//Dirt
/turf/open/ground/fallout/dirt
	name = "dirt"
	desc = "Brown and dry."
	icon_state = "dirt"

/turf/open/ground/fallout/dirt/border
	icon_state = "dirt_desert_border"

/turf/open/ground/fallout/dirt/corner
	icon_state = "dirt_desert_corner"

//Soil, dirt but darker colored
/turf/open/ground/fallout/soil
	name = "soil"
	desc = "Rich in nutrients."
	icon_state = "soil"

/turf/open/ground/fallout/soil/border
	icon_state = "soil_desert_border"

/turf/open/ground/fallout/soil/corner
	icon_state = "soil_desert_corner"

//Savannah
/turf/open/ground/fallout/savannah
	name = "savannah"
	desc = "Hardy grass that still manages to grow in such an inhospitable environment."
	icon_state = "savannah1"

/turf/open/ground/fallout/savannah/dirt
	icon_state = "savannah_dirt"

/turf/open/ground/fallout/savannah/dirt_border
	icon_state = "savannah_dirt_border"

/turf/open/ground/fallout/savannah/dirt_corner
	icon_state = "savannah_dirt_corner"

/turf/open/ground/fallout/savannah/dirt_corner_border
	icon_state = "savannah_dirt_corner_border"

/turf/open/ground/fallout/savannah/soil
	icon_state = "savannah_soil"

/turf/open/ground/fallout/savannah/soil_border
	icon_state = "savannah_soil_border"

/turf/open/ground/fallout/savannah/soil_corner
	icon_state = "savannah_soil_corner"

/turf/open/ground/fallout/savannah/soil_corner_border
	icon_state = "savannah_soil_corner_border"

//Gravel
/turf/open/ground/fallout/gravel
	name = "gravel"
	desc = "Loose pebbles and dirt. Crunchy."
	icon_state = "gravel"

/turf/open/ground/fallout/gravel/desert_path
	icon_state = "gravel_desert_path"

/turf/open/ground/fallout/gravel/desert_intersection
	icon_state = "gravel_desert_intersection"

/turf/open/ground/fallout/gravel/desert_end
	icon_state = "gravel_desert_end"

/turf/open/ground/fallout/gravel/desert_edge
	icon_state = "gravel_desert_edge"

/turf/open/ground/fallout/gravel/dirt
	icon_state = "gravel_dirt"

/turf/open/ground/fallout/gravel/dirt_path
	icon_state = "gravel_dirt_path"

/turf/open/ground/fallout/gravel/dirt_intersection
	icon_state = "gravel_dirt_intersection"

/turf/open/ground/fallout/gravel/dirt_end
	icon_state = "gravel_dirt_end"

/turf/open/ground/fallout/gravel/dirt_edge
	icon_state = "gravel_dirt_edge"

/turf/open/ground/fallout/gravel/dirt_corner_border
	icon_state = "gravel_dirt_corner"

/turf/open/ground/fallout/gravel/soil_path
	icon_state = "gravel_soil_path"

/turf/open/ground/fallout/gravel/soil_intersection
	icon_state = "gravel_soil_intersection"

/turf/open/ground/fallout/gravel/soil_end
	icon_state = "gravel_soil_end"

/turf/open/ground/fallout/gravel/soil_edge
	icon_state = "gravel_soil_edge"

/turf/open/ground/fallout/gravel/soil_corner
	icon_state = "gravel_soil_corner"

//Rubble turfs
/turf/open/ground/fallout/rubble
	name = "rubble"
	desc = "Whatever was here, it's gone."
	icon_state = "rubble"
	shoefootstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_CONCRETE

/turf/open/ground/fallout/rubble/plate
	icon_state = "rubble_plate"

/turf/open/ground/fallout/rubble/pillar
	icon_state = "rubble_pillar"

/turf/open/ground/fallout/rubble/edge
	icon_state = "rubble_edge"

/turf/open/ground/fallout/rubble/corner
	icon_state = "rubble_corner"

//Cobblestone paths
/turf/open/ground/fallout/cobble
	name = "cobblestone"
	desc = "Fancy cobble path."
	icon_state = "cobble"
	shoefootstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_CONCRETE

/turf/open/ground/fallout/cobble/border
	icon_state = "cobble_border"

/turf/open/ground/fallout/cobble/corner
	icon_state = "cobble_corner"

//Road turfs
/turf/open/ground/fallout/road
	name = "\the road"
	desc = "Once ruled by cars, now used by travellers for convenient routes."
	icon = 'fallout/fallout icons/fallout turfs/fallout_pavement.dmi'
	icon_state = "road"
	shoefootstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_CONCRETE

/turf/open/ground/fallout/road/shadow
	icon_state = "road_shadow"

/turf/open/ground/fallout/road/shadow/tiny_left
	icon_state = "road_shadow_tiny_left"

/turf/open/ground/fallout/road/shadow/tiny_right
	icon_state = "road_shadow_tiny_right"

/turf/open/ground/fallout/road/shaded
	icon_state = "road_shaded"

/turf/open/ground/fallout/road/one
	icon_state = "road1"

/turf/open/ground/fallout/road/one/bottom
	icon_state = "road1_bottom"

/turf/open/ground/fallout/road/one/left
	icon_state = "road1_left"

/turf/open/ground/fallout/road/one/right
	icon_state = "road1_right"

/turf/open/ground/fallout/road/top
	icon_state = "road1_top"

/turf/open/ground/fallout/road/one/vertical
	icon_state = "road1_vertical"

/turf/open/ground/fallout/road/one/vertical/right
	icon_state = "road1_vertical_right"

/turf/open/ground/fallout/road/one/vertical/right/top
	icon_state = "road1_vertical_right_top"

/turf/open/ground/fallout/road/one/vertical/right/bottom
	icon_state = "road1_vertical_right_bottom"

/turf/open/ground/fallout/road/one/vertical/left
	icon_state = "road1_vertical_left"

/turf/open/ground/fallout/road/one/vertical/left/top
	icon_state = "road1_vertical_left_top"

/turf/open/ground/fallout/road/one/vertical/left/bottom
	icon_state = "road1_vertical_left_bottom"

/turf/open/ground/fallout/road/two
	icon_state = "road2"

/turf/open/ground/fallout/road/two/bottom
	icon_state = "road2_bottom"

/turf/open/ground/fallout/road/two/top
	icon_state = "road2_top"

/turf/open/ground/fallout/road/two/vertical
	icon_state = "road2_vertical"

/turf/open/ground/fallout/road/two/vertical/left
	icon_state = "road2_vertical_left"

/turf/open/ground/fallout/road/two/vertical/right
	icon_state = "road2_vertical_right"

/turf/open/ground/fallout/road/three
	icon_state = "road3"

/turf/open/ground/fallout/road/three/bottom
	icon_state = "road3_bottom"

/turf/open/ground/fallout/road/three/top
	icon_state = "road3_top"

/turf/open/ground/fallout/road/three/left
	icon_state = "road3_left"

/turf/open/ground/fallout/road/three/left/bottom
	icon_state = "road3_left_bottom"

/turf/open/ground/fallout/road/three/left/top
	icon_state = "road3_left_top"

/turf/open/ground/fallout/road/three/right
	icon_state = "road3_right"

/turf/open/ground/fallout/road/three/right/bottom
	icon_state = "road3_right_bottom"

/turf/open/ground/fallout/road/three/right/top
	icon_state = "road3_right_top"

/turf/open/ground/fallout/road/three/vertical
	icon_state = "road3_vertical"

/turf/open/ground/fallout/road/three/vertical/bottom
	icon_state = "road3_vertical_bottom"

/turf/open/ground/fallout/road/three/vertical/top
	icon_state = "road3_vertical_top"

/turf/open/ground/fallout/road/three/vertical/left
	icon_state = "road3_vertical_left"

/turf/open/ground/fallout/road/three/vertical/left/bottom
	icon_state = "road3_vertical_left_bottom"

/turf/open/ground/fallout/road/three/vertical/left/top
	icon_state = "road3_vertical_left_top"

/turf/open/ground/fallout/road/three/vertical/right
	icon_state = "road3_vertical_right"

/turf/open/ground/fallout/road/three/vertical/right/bottom
	icon_state = "road3_vertical_right_bottom"

/turf/open/ground/fallout/road/three/vertical/right/top
	icon_state = "road3_vertical_right_top"

/turf/open/ground/fallout/road/four
	icon_state = "road4"

/turf/open/ground/fallout/road/four/bottom
	icon_state = "road4_bottom"

/turf/open/ground/fallout/road/four/top
	icon_state = "road4_top"

/turf/open/ground/fallout/road/four/vertical
	icon_state = "road4_vertical"

/turf/open/ground/fallout/road/four/vertical/left
	icon_state = "road4_vertical_left"

/turf/open/ground/fallout/road/four/vertical/right
	icon_state = "road4_vertical_right"

/turf/open/ground/fallout/road/corner
	icon_state = "road_corner"

/turf/open/ground/fallout/road/corner/alt
	icon_state = "road_corner_alt"

/turf/open/ground/fallout/road/desert
	icon_state = "road_desert"

/turf/open/ground/fallout/road/desert/alt
	icon_state = "road_desert_alt"

/turf/open/ground/fallout/road/broken
	icon_state = "road_broken"

/turf/open/ground/fallout/road/broken/left_bottom
	icon_state = "road_broken_left_bottom"

/turf/open/ground/fallout/road/broken/right_bottom
	icon_state = "road_broken_right_bottom"

/turf/open/ground/fallout/road/broken/left_top
	icon_state = "road_broken_left_top"

/turf/open/ground/fallout/road/broken/right_top
	icon_state = "road_broken_right_top"

/turf/open/ground/fallout/road/broken/corner
	icon_state = "road_broken_corner"

/turf/open/ground/fallout/road/broken/left_bottom
	icon_state = "road_broken_left_bottom"

/turf/open/ground/fallout/road/broken/left_top
	icon_state = "road_broken_left_top"

/turf/open/ground/fallout/road/broken/right_bottom
	icon_state = "road_broken_right_bottom"

/turf/open/ground/fallout/road/broken/right_top
	icon_state = "road_broken_right_top"

/turf/open/ground/fallout/road/broken/left1_top
	icon_state = "road_broken_left1_top"

/turf/open/ground/fallout/road/broken/right1_top
	icon_state = "road_broken_right1_top"

/turf/open/ground/fallout/road/broken/left2_bottom
	icon_state = "road_broken_left2_bottom"

/turf/open/ground/fallout/road/broken/right2_bottom
	icon_state = "road_broken_right2_bottom"

/turf/open/ground/fallout/road/hole
	icon_state = "road_hole"

/turf/open/ground/fallout/road/hole/dirt
	icon_state = "road_hole_dirt"

/turf/open/ground/fallout/road/hole/soil
	icon_state = "road_hole_soil"

//Sidewalk turfs
/turf/open/ground/fallout/sidewalk
	name = "\the sidewalk"
	desc = "For pedestrian use only."
	icon = 'fallout/fallout icons/fallout turfs/fallout_pavement.dmi'
	icon_state = "sidewalk"
	shoefootstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_CONCRETE

/turf/open/ground/fallout/sidewalk/shaded
	icon_state = "sidewalk_shaded"

/turf/open/ground/fallout/sidewalk/one
	icon_state = "sidewalk1"

/turf/open/ground/fallout/sidewalk/one/border
	icon_state = "sidewalk1_border"

/turf/open/ground/fallout/sidewalk/one/vertical
	icon_state = "sidewalk1_vertical"

/turf/open/ground/fallout/sidewalk/two
	icon_state = "sidewalk2"

/turf/open/ground/fallout/sidewalk/two/border
	icon_state = "sidewalk2_border"

/turf/open/ground/fallout/sidewalk/two/vertical
	icon_state = "sidewalk2_vertical"

/turf/open/ground/fallout/sidewalk/three
	icon_state = "sidewalk3"

/turf/open/ground/fallout/sidewalk/three/left
	icon_state = "sidewalk3_left"

/turf/open/ground/fallout/sidewalk/three/right
	icon_state = "sidewalk3_right"

/turf/open/ground/fallout/sidewalk/three/border
	icon_state = "sidewalk3_border"

/turf/open/ground/fallout/sidewalk/three/border/left
	icon_state = "sidewalk3_border_left"

/turf/open/ground/fallout/sidewalk/three/border/right
	icon_state = "sidewalk3_border_right"

/turf/open/ground/fallout/sidewalk/three/vertical
	icon_state = "sidewalk3_vertical"

/turf/open/ground/fallout/sidewalk/three/vertical/bottom
	icon_state = "sidewalk3_vertical_bottom"

/turf/open/ground/fallout/sidewalk/three/vertical/top
	icon_state = "sidewalk3_vertical_top"

/turf/open/ground/fallout/sidewalk/four
	icon_state = "sidewalk4"

/turf/open/ground/fallout/sidewalk/four/border
	icon_state = "sidewalk4_border"

/turf/open/ground/fallout/sidewalk/four/vertical
	icon_state = "sidewalk4_vertical"

/turf/open/ground/fallout/sidewalk/border_corner
	icon_state = "sidewalk_border_corner"

/turf/open/ground/fallout/sidewalk/border_corner/alt
	icon_state = "sidewalk_border_corner_alt"

/turf/open/ground/fallout/sidewalk/corner
	icon_state = "sidewalk_corner"

/turf/open/ground/fallout/sidewalk/corner/alt
	icon_state = "sidewalk_corner_alt"

/turf/open/ground/fallout/sidewalk/desert
	icon_state = "sidewalk_desert"

/turf/open/ground/fallout/sidewalk/desert/corner
	icon_state = "sidewalk_desert_corner"

/turf/open/ground/fallout/sidewalk/broken
	icon_state = "sidewalk_broken"

/turf/open/ground/fallout/sidewalk/broken/corner
	icon_state = "sidewalk_broken_corner"

/turf/open/ground/fallout/sidewalk/broken/left1_bottom
	icon_state = "sidewalk_broken_left1_bottom"

/turf/open/ground/fallout/sidewalk/broken/right1_bottom
	icon_state = "sidewalk_broken_right1_bottom"

/turf/open/ground/fallout/sidewalk/broken/left2_top
	icon_state = "sidewalk_broken_left2_top"

/turf/open/ground/fallout/sidewalk/broken/left2_top
	icon_state = "sidewalk_broken_right2_top"

/turf/open/ground/fallout/sidewalk/broken/left_bottom
	icon_state = "sidewalk_broken_left_bottom"

/turf/open/ground/fallout/sidewalk/broken/left_top
	icon_state = "sidewalk_broken_left_top"

/turf/open/ground/fallout/sidewalk/broken/right_bottom
	icon_state = "sidewalk_broken_right_bottom"

/turf/open/ground/fallout/sidewalk/broken/right_top
	icon_state = "sidewalk_broken_right_top"

//Curb turfs
/turf/open/ground/fallout/sidewalk/turn_outer
	icon_state = "turn_outer"

/turf/open/ground/fallout/sidewalk/turn_outer/bottom_left
	name = "\proper road"
	desc = "Once ruled by cars, now used by travellers for convenient routes."
	icon_state = "turn_outer_bottom_left"

/turf/open/ground/fallout/sidewalk/turn_outer/bottom_right
	name = "\proper road"
	desc = "Once ruled by cars, now used by travellers for convenient routes."
	icon_state = "turn_outer_bottom_right"

/turf/open/ground/fallout/sidewalk/turn_inner
	name = "\proper road"
	desc = "Once ruled by cars, now used by travellers for convenient routes."
	icon_state = "turn_inner"

/turf/open/ground/fallout/sidewalk/turn_inner/horizontal
	name = "\the sidewalk"
	desc = "For pedestrian use only."
	icon_state = "turn_inner_horizontal"

/turf/open/ground/fallout/sidewalk/turn_inner/vertical
	name = "\the sidewalk"
	desc = "For pedestrian use only."
	icon_state = "turn_inner_vertical"

//Crosswalk turfs
/turf/open/ground/fallout/sidewalk/crosswalk
	name = "\proper crosswalk"
	desc = "Look both ways!"
	icon_state = "crosswalk1"

/turf/open/ground/fallout/sidewalk/crosswalk/two
	icon_state = "crosswalk2"

/turf/open/ground/fallout/sidewalk/crosswalk/three
	icon_state = "crosswalk3"

/turf/open/ground/fallout/sidewalk/crosswalk/vertical
	icon_state = "crosswalk_vertical1"

/turf/open/ground/fallout/sidewalk/crosswalk/vertical/two
	icon_state = "crosswalk_vertical2"

/turf/open/ground/fallout/sidewalk/crosswalk/vertical/three
	icon_state = "crosswalk_vertical3"

/turf/open/ground/fallout/sidewalk/crosswalk/border
	icon_state = "crosswalk_border"

/turf/open/ground/fallout/sidewalk/crosswalk/border/round
	icon_state = "crosswalk_border_round"

/turf/open/ground/fallout/sidewalk/turn_inner
	icon_state = "turn_inner"

/turf/open/ground/fallout/sidewalk/turn_inner
	icon_state = "turn_inner"

/turf/open/ground/fallout/sidewalk/turn_inner
	icon_state = "turn_inner"

//Base floor for tiling, since they will all use the same icon file
/turf/open/floor/fallout
	name = "floor template"
	desc = "If you see this ingame, someone screwed up."
	icon = 'fallout/fallout icons/fallout turfs/fallout_terrain.dmi'
	icon_state = ""

//Tunnel plating
/turf/open/floor/fallout/tunnel
	name = "tunnel plating"
	desc = "Old flooring laid out for underground tunnels."
	icon_state = "tunnel"
	floor_tile = null
	intact_tile = FALSE
	shoefootstep = FOOTSTEP_PLATING
	barefootstep = FOOTSTEP_HARD

/turf/open/floor/fallout/tunnel/dirty
	icon_state = "tunnel_dirty"

/turf/open/floor/fallout/tunnel/rusty
	icon_state = "tunnel_rusty1"

/turf/open/floor/fallout/tunnel/rusty/Initialize()
	. = ..()
	var/random_turf = rand(1,3)
	icon_state = "tunnel_rusty[random_turf]"

/turf/open/floor/fallout/tunnel/hole
	icon_state = "tunnel_hole"

/turf/open/floor/fallout/tunnel/broken
	icon_state = "tunnel_broken1"

/turf/open/floor/fallout/tunnel/broken/Initialize()
	. = ..()
	var/random_turf = rand(1,2)
	icon_state = "tunnel_broken[random_turf]"

/turf/open/floor/fallout/tunnel/damaged
	icon_state = "tunnel_damaged"

//Orange carpeted floor, base carpet
/turf/open/floor/fallout/carpet
	name = "carpet"
	desc = "Old carpeted flooring."
	icon = 'fallout/fallout icons/fallout turfs/fallout_carpet.dmi'
	icon_state = "carpet"
	shoefootstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_CARPET

/turf/open/floor/fallout/carpet/broken1
	icon_state = "carpet_broken1"

/turf/open/floor/fallout/carpet/broken2
	icon_state = "carpet_broken2"

/turf/open/floor/fallout/carpet/broken3
	icon_state = "carpet_broken3"

/turf/open/floor/fallout/carpet/broken4
	icon_state = "carpet_broken4"

/turf/open/floor/fallout/carpet/broken5
	icon_state = "carpet_broken5"

/turf/open/floor/fallout/carpet/broken6
	icon_state = "carpet_broken6"

/turf/open/floor/fallout/carpet/broken7
	icon_state = "carpet_broken7"

/turf/open/floor/fallout/carpet/broken8
	icon_state = "carpet_broken8"

/turf/open/floor/fallout/carpet/broken9
	icon_state = "carpet_broken9"

/turf/open/floor/fallout/carpet/broken10
	icon_state = "carpet_broken10"

/turf/open/floor/fallout/carpet/broken11
	icon_state = "carpet_broken11"

/turf/open/floor/fallout/carpet/broken12
	icon_state = "carpet_broken12"

/turf/open/floor/fallout/carpet/broken13
	icon_state = "carpet_broken13"

/turf/open/floor/fallout/carpet/broken14
	icon_state = "carpet_broken14"

/turf/open/floor/fallout/carpet/burn
	icon_state = "carpet_burn"

/turf/open/floor/fallout/carpet/torn
	icon_state = "carpet_torn"

//Galactic, "arcade" carpet
/turf/open/floor/fallout/carpet/galactic
	name = "galactic carpet"
	desc = "Hard carpeted floor with graphics of planets, rockets, and other celestial objects."
	icon_state = "galactic"

//Wooden base
/turf/open/floor/fallout/wooden_base
	name = "wooden base"
	desc = "Foundation made from wooden planks."
	icon = 'fallout/fallout icons/fallout turfs/fallout_wood_flooring.dmi'
	icon_state = "base"
	floor_tile = null
	intact_tile = FALSE
	shoefootstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD

/turf/open/floor/fallout/wooden_base/broken
	icon_state = "base_broken1"

/turf/open/floor/fallout/wooden_base/broken/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "base_broken[random_turf]"

//Basic wooden tile
/turf/open/floor/fallout/wood
	name = "oak floor"
	desc = "Hardwood flooring."
	icon = 'fallout/fallout icons/fallout turfs/fallout_wood_flooring.dmi'
	icon_state = "oak1"
	shoefootstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD

/turf/open/floor/fallout/wood/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "oak[random_turf]"

/turf/open/floor/fallout/wood/broken
	icon_state = "oak_broken1"

/turf/open/floor/fallout/wood/broken/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "oak_broken[random_turf]"

/turf/open/floor/fallout/wood/dark
	name = "dark oak floor"
	icon_state = "dark1"

/turf/open/floor/fallout/wood/dark/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "dark[random_turf]"

/turf/open/floor/fallout/wood/dark/broken
	icon_state = "dark_broken1"

/turf/open/floor/fallout/wood/dark/broken/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "dark_broken[random_turf]"

/turf/open/floor/fallout/wood/dark/broken/two
	icon_state = "dark_broken5"

/turf/open/floor/fallout/wood/dark/broken/three
	icon_state = "dark_broken6"

/turf/open/floor/fallout/wood/dark/broken/four
	icon_state = "dark_broken7"

/turf/open/floor/fallout/wood/walnut
	name = "walnut floor"
	icon_state = "walnut1"

/turf/open/floor/fallout/wood/walnut/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "walnut[random_turf]"

/turf/open/floor/fallout/wood/walnut/broken
	icon_state = "walnut_broken1"

/turf/open/floor/fallout/wood/walnut/broken/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "walnut_broken[random_turf]"

/turf/open/floor/fallout/wood/walnut/broken/two
	icon_state = "walnut_broken5"

/turf/open/floor/fallout/wood/walnut/broken/three
	icon_state = "walnut_broken6"

/turf/open/floor/fallout/wood/maple
	name = "maple floor"
	icon_state = "maple1"

/turf/open/floor/fallout/wood/maple/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "maple[random_turf]"

/turf/open/floor/fallout/wood/chestnut
	name = "chestnut floor"
	icon_state = "chestnut1"

/turf/open/floor/fallout/wood/chestnut/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "chestnut[random_turf]"

/turf/open/floor/fallout/wood/chestnut/broken
	icon_state = "chestnut_broken1"

/turf/open/floor/fallout/wood/chestnut/broken/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "chestnut_broken[random_turf]"

/turf/open/floor/fallout/wood/chestnut/broken/two
	icon_state = "chestnut_broken5"

/turf/open/floor/fallout/wood/chestnut/broken/three
	icon_state = "chestnut_broken6"

/turf/open/floor/fallout/wood/tiled
	name = "tiled wooden floor"
	icon_state = "tiled"

/turf/open/floor/fallout/wood/tiled/broken
	icon_state = "tiled_broken1"

/turf/open/floor/fallout/wood/tiled/broken/Initialize()
	. = ..()
	var/random_turf = rand(1,3)
	icon_state = "tiled_broken[random_turf]"

/turf/open/floor/fallout/wood/panel
	name = "paneled wooden floor"
	icon_state = "panel"

/turf/open/floor/fallout/wood/panel/broken
	icon_state = "panel_broken1"

/turf/open/floor/fallout/wood/panel/broken/Initialize()
	. = ..()
	var/random_turf = rand(1,3)
	icon_state = "panel_broken[random_turf]"

/turf/open/floor/fallout/wood/diagonal
	name = "diagonal wooden floor"
	icon_state = "diagonal"

/turf/open/floor/fallout/wood/diagonal/broken
	icon_state = "diagonal_broken1"

/turf/open/floor/fallout/wood/diagonal/broken/Initialize()
	. = ..()
	var/random_turf = rand(1,3)
	icon_state = "diagonal_broken[random_turf]"

/turf/open/floor/fallout/wood/stage
	name = "wooden stage floor"
	icon_state = "stage"

/turf/open/floor/fallout/wood/stage/tile
	icon_state = "stage1"

/turf/open/floor/fallout/wood/stage/tile/Initialize()
	. = ..()
	var/random_turf = rand(1,4)
	icon_state = "stage[random_turf]"

/*
//Wood tiles exposing the base, separated to due to the randomization of the normal ones
/turf/open/floor/fallout/wood_broken
	name = "broken dark oak flooring"
	desc = "Torn away and damaged wood."
	icon = 'fallout/fallout icons/fallout turfs/fallout_wood_flooring.dmi'
	icon_state = "dark_broken5"
	shoefootstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_WOOD

/turf/open/floor/fallout/wood_broken/two
	icon_state = "dark_broken6"

/turf/open/floor/fallout/wood_broken/three
	icon_state = "dark_broken7"

/turf/open/floor/fallout/wood_broken/walnut
	name = "broken walnut flooring"
	icon_state = "walnut_broken5"

/turf/open/floor/fallout/wood_broken/walnut/two
	icon_state = "walnut_broken6"

/turf/open/floor/fallout/wood_broken/chestnut
	name = "broken chestnut flooring"
	icon_state = "chestnut_broken5"

/turf/open/floor/fallout/wood_broken/chestnut/two
	icon_state = "chestnut_broken6"
*/