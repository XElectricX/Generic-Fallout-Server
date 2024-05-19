//Belts
/obj/item/storage/belt
	worn_icon_state = null	//Making it null because it's annoying to have to set it for every belt

/obj/item/storage/belt/fallout
	name = "leather belt"
	desc = "Belt with pockets."
	icon = 'fallout/fallout icons/fallout clothing/fallout_accessories.dmi'
	worn_icon_list = list(
		slot_belt_str = 'fallout/fallout icons/fallout clothing/fallout_accessories_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_misc_clothing.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_misc_clothing.dmi')
	icon_state = "belt"
	w_class = WEIGHT_CLASS_NORMAL
	storage_type = /datum/storage/belt/fallout

/datum/storage/belt/fallout
	storage_slots = null
	max_storage_space = 8

//Regular belt but better, needs a unique mechanic at a later date
/obj/item/storage/belt/fallout/assault
	name = "assault belt"
	desc = "Tactical belt with planty of pockets and clips."
	icon_state = "belt_assault"
	storage_type = /datum/storage/belt/fallout/assault

/datum/storage/belt/fallout/assault
	storage_slots = 10

/obj/item/storage/belt/fallout/ncr
	name = "\improper NCR belt"
	desc = "Cotton belt with various pouches and clips."
	icon = 'fallout/fallout icons/fallout clothing/faction_accessories.dmi'
	worn_icon_list = list(slot_belt_str = 'fallout/fallout icons/fallout clothing/faction_accessories_worn.dmi')
	icon_state = "belt_ncr"

/obj/item/storage/belt/fallout/legion
	name = "\improper Legion belt"
	desc = "Leather belt with a decorative sash denoting Legion soldiers."
	icon = 'fallout/fallout icons/fallout clothing/faction_accessories.dmi'
	worn_icon_list = list(slot_belt_str = 'fallout/fallout icons/fallout clothing/faction_accessories_worn.dmi')
	icon_state = "belt_legion"

/obj/item/storage/belt/fallout/tools
	name = "toolbelt"
	desc = "Holds tools around your waist. Handy."
	icon_state = "belt_tools"
	storage_type = /datum/storage/belt/fallout/tools

/datum/storage/belt/fallout/tools
	storage_slots = 7
	max_storage_space = 14

/datum/storage/belt/fallout/tools/New(atom/parent)
	. = ..()
	set_holdable(list(
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/tool/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/t_scanner,
		/obj/item/tool/analyzer,
		/obj/item/tool/taperoll/engineering))

/obj/item/storage/belt/fallout/tools/full/PopulateContents()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/stack/cable_coil(src,30,pick("red","yellow","orange"))
	new /obj/item/tool/multitool(src)

/obj/item/storage/belt/fallout/medical
	name = "medical supplies belt"
	desc = "Storage solution for the medic on the go."
	icon_state = "belt_medical"
	storage_type = /datum/storage/belt/fallout/medical

/datum/storage/belt/fallout/medical
	storage_slots = 7
	max_storage_space = 14

/datum/storage/belt/fallout/medical/New(atom/parent)
	. = ..()
	set_holdable(list(
		/obj/item/healthanalyzer,
		/obj/item/tool/surgery,
		/obj/item/stack/nanopaste,
		/obj/item/reagent_containers,
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/syringe_case,
		/obj/item/tweezers))

/obj/item/storage/belt/fallout/medical/full/PopulateContents()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/holster/fallout
	name = "pistol holster belt"
	desc = "Waist belt with a holster and 3 magazine pockets attached."
	icon = 'fallout/fallout icons/fallout clothing/fallout_accessories.dmi'
	icon_state = "belt_holster"
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE
	storage_type = /datum/storage/holster/fallout

/datum/storage/holster/fallout
	max_w_class = WEIGHT_CLASS_NORMAL
	storage_slots = 4
	max_storage_space = 9
	sheathe_sound = 'sound/weapons/guns/misc/pistol_sheathe.ogg'
	draw_sound = 'sound/weapons/guns/misc/pistol_draw.ogg'

/datum/storage/holster/fallout/New(atom/parent)
	. = ..()
	set_holdable(list(/obj/item/weapon/gun/fallout/pistol, /obj/item/ammo_magazine/fallout_pistol))

//Bandoliers
/obj/item/storage/belt/fallout/bandolier
	name = "bandolier"
	desc = "Hold individual shells, bullets, and explosives."
	icon_state = "bandolier"
	equip_slot_flags = ITEM_SLOT_BELT|ITEM_SLOT_SUITSTORE
	storage_type = /datum/storage/belt/fallout/bandolier

/datum/storage/belt/fallout/bandolier
	storage_slots = 14
	max_storage_space = 14

/datum/storage/belt/fallout/bandolier/New(atom/parent)
	. = ..()
	set_holdable(list(/obj/item/ammo_magazine/handful, /obj/item/explosive/grenade))	//Can fit handfuls and explosives

/obj/item/storage/belt/fallout/bandolier/alt
	name = "leather bandolier"
	icon_state = "bandolier_alt"
