/obj/item/storage/belt/fallout
	name = "\improper Leather Belt"
	desc = "Belt with pockets."
	icon_state = "som_belt"
	item_state = "som_belt"
	max_w_class = WEIGHT_CLASS_SMALL
	storage_slots = null
	max_storage_space = 8

/obj/item/storage/belt/fallout/tools
	name = "\improper Toolbelt"
	desc = "Holds tools around your waist. Handy."
	icon_state = "utilitybelt"
	item_state = "utility"
	storage_slots = 7
	max_storage_space = 14
	can_hold = list(
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/tool/taperoll/engineering,
		)

/obj/item/storage/belt/fallout/tools/full/Initialize()
	. = ..()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/stack/cable_coil(src,30,pick("red","yellow","orange"))
	new /obj/item/multitool(src)

/obj/item/storage/belt/fallout/medical
	name = "\improper Medical Supplies Belt"
	desc = "Storage solution for the medic on the go."
	icon_state = "medicalbelt"
	item_state = "medical"
	storage_slots = 7
	max_storage_space = 14
	can_hold = list(/obj/item/weapon/gun/fallout_pistol, /obj/item/ammo_magazine/fallout_pistol)

/obj/item/storage/belt/fallout/medical/full/Initialize()
	. = ..()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/gun/fallout
	name = "\improper Pistol Holster Belt"
	desc = "Waist belt with a holster and 3 magazine pockets attached."
	max_w_class = WEIGHT_CLASS_SMALL
	storage_slots = 3
	max_storage_space = 6
	can_hold = list(/obj/item/weapon/gun/fallout_pistol, /obj/item/ammo_magazine/fallout_pistol)