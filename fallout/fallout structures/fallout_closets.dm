/obj/structure/closet/fallout
	name = "locker"
	desc = "Stores stuff."
	icon = 'fallout/fallout icons/fallout structures/fallout_closets.dmi'
	icon_state = "locker"
	icon_opened = "_open"
	mob_storage_capacity = 2
	closet_flags = CLOSET_ALLOW_OBJS

/obj/structure/closet/fallout/old
	name = "dingy locker"
	icon_state = "locker_old"

/obj/structure/closet/fallout/rust
	name = "rusted locker"
	icon_state = "locker_rust"

/obj/structure/closet/fallout/cabinet
	name = "cabinet"
	desc = "Keep your clothes tidy and organized."
	icon_state = "cabinet"

/obj/structure/closet/fallout/gun
	name = "gun cabinet"
	desc = "For secure storage of weapons."
	icon_state = "gun"

/obj/structure/closet/fallout/fridge
	name = "fridge"
	desc = "Keeps food cold, preventing spoilage and bacteria growth."
	icon_state = "fridge"

/obj/structure/closet/fallout/fridge/white
	icon_state = "fridge_white"

/obj/structure/closet/fallout/update_icon()
	overlays.Cut()
	if(!opened)
		icon_state = initial(icon_state)
		if(welded)
			overlays += image(icon, overlay_welded)
	else
		icon_state += icon_opened

/obj/structure/closet/fallout/wall
	name = "wall locker"
	desc = "Small storage cabinet."
	icon_state = ""	//Needs one
	density = FALSE
	mob_storage_capacity = 0
	wall_mounted = TRUE
	storage_capacity = 20

/obj/structure/closet/fallout/wall/medical
	name = "medical cabinet"
	desc = "Emergency case containing a fire extinguisher."
	icon_state = "extinguisher"

/obj/structure/closet/fallout/wall/medical/PopulateContents()
	new /obj/item/reagent_containers/hypospray/fallout/stimpak(src)
	new /obj/item/reagent_containers/hypospray/fallout/stimpak(src)
	new /obj/item/reagent_containers/hypospray/fallout/medx(src)
	new /obj/item/stack/medical/heal_pack/bandage(src)
	new /obj/item/stack/medical/heal_pack/bandage(src)

/obj/structure/closet/fallout/wall/Initialize(mapload, ndir)
	. = ..()
	if(ndir)
		dir = ndir
	switch(dir)
		if(NORTH)
			pixel_y -= 32
		if(SOUTH)
			pixel_y += 32
		if(EAST)
			pixel_x -= 32
		if(WEST)
			pixel_x += 32

/obj/structure/closet/fallout/wall/wrench_act(mob/living/user, obj/item/tool/wrench/wrenchy_tool)
	if(opened)
		return FALSE
	to_chat(user, span_notice("You can't detach [src]!"))
	return FALSE

/obj/structure/closet/fallout/wall/extinguisher
	name = "extinguisher cabinet"
	desc = "Emergency case containing a fire extinguisher."
	icon_state = "extinguisher"
	storage_capacity = 3

/obj/structure/closet/fallout/wall/extinguisher/PopulateContents()
	new /obj/item/tool/extinguisher(src)
