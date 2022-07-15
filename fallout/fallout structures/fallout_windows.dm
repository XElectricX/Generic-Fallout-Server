//House windows, parnet of all other windows
/obj/structure/window/fallout
	name = "house window"
	desc = "Back when people liked to look towards the outside from their homes. Not so useful during these dangerous times."
	icon = 'fallout/fallout icons/fallout structures/fallout_windows.dmi'
	icon_state = "house"
	static_frame = TRUE
	flags_atom = NONE
	max_integrity = 75

//Leave it empty or else the game tries to smooth it, breaking the sprite
/obj/structure/window/fallout/update_icon()
	return

/obj/structure/window/fallout/broken
	name = "broken house window"
	icon_state = "house_broken"

/obj/structure/window/fallout/vertical
	icon_state = "house_vertical"

/obj/structure/window/fallout/vertical/broken
	name = "broken house window"
	icon_state = "house_vertical_broken"

//Ancient windows
/obj/structure/window/fallout/ruin
	name = "dilapidated window"
	icon_state = "ruin"

/obj/structure/window/fallout/ruin/damaged
	name = "damaged dilapidated window"
	icon_state = "ruin_damaged"

/obj/structure/window/fallout/ruin/broken
	name = "dilapidated window frame"
	icon_state = "ruin_broken"

/obj/structure/window/fallout/ruin/vertical
	icon_state = "ruin_vertical"

/obj/structure/window/fallout/ruin/vertical/damaged
	name = "damaged dilapidated window"
	icon_state = "ruin_vertical_damaged"

//Wooden windows
/obj/structure/window/fallout/wood
	name = "wood-framed window"
	icon_state = "wood"

/obj/structure/window/fallout/wood/broken
	name = "broken wood-framed window"
	icon_state = "wood_broken"

//Store windows
/obj/structure/window/fallout/metal
	name = "metal-framed window"
	desc = "Commercial window walls, usually found in businesses. Slightly stronger than your average home's windows."
	icon_state = "metal"
	reinf = TRUE
	max_integrity = 150

/obj/structure/window/fallout/metal/left
	icon_state = "metal_left"

/obj/structure/window/fallout/metal/right
	icon_state = "metal_right"

/obj/structure/window/fallout/metal/vertical
	icon_state = "metal_vertical"

/obj/structure/window/fallout/metal/vertical/bottom
	icon_state = "metal_vertical_bottom"

/obj/structure/window/fallout/metal/vertical/top
	icon_state = "metal_vertical_top"
