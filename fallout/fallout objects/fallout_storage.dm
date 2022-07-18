//Base storage item
/obj/item/storage/fallout
	name = "generic storage"
	desc = "Someone did an oopsie."
	icon = 'fallout/fallout icons/fallout items/fallout_storage.dmi'
	item_icons = list(slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_items.dmi', slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_items.dmi')

//Toolboxes
/obj/item/storage/fallout/toolbox
	name = "toolbox"
	desc = "Stores tools. Very robust."
	icon_state = "toolbox"
	flags_atom = CONDUCT
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	throwforce = 15
	throw_range = 5
	throw_speed = 1
	attack_verb = list("robusted", "made a tool out of")

/obj/item/storage/fallout/toolbox/full/Initialize(mapload, ...)
	. = ..()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/analyzer(src)
	new /obj/item/tool/wirecutters(src)

//Doctor's bag, stores anything medical related
/obj/item/storage/fallout/medical
	name = "doctor's bag"
	desc = "The ultimate storage solution for medical practitioners. Space for a variety of items ranging from medicines to surgical instruments."
	icon_state = "bag_medical"
	w_class = WEIGHT_CLASS_NORMAL
	storage_slots = 12
	max_storage_space = 24
	can_hold = list(
		/obj/item/tool/surgery,
		/obj/item/stack/nanopaste,
		/obj/item/reagent_containers,
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/syringe_case,
		/obj/item/healthanalyzer)

/obj/item/storage/fallout/medical/surgery/Initialize(mapload, ...)
	. = ..()
	new /obj/item/stack/nanopaste(src)
	new /obj/item/tool/surgery/FixOVein(src)
	new /obj/item/tool/surgery/bonegel(src)
	new /obj/item/tool/surgery/surgical_membrane(src)
	new /obj/item/tool/surgery/bonesetter(src)
	new /obj/item/tool/surgery/cautery(src)
	new /obj/item/tool/surgery/retractor(src)
	new /obj/item/tool/surgery/hemostat(src)
	new /obj/item/tool/surgery/circular_saw(src)
	new /obj/item/tool/surgery/scalpel(src)
	new /obj/item/tool/surgery/suture(src)
	new /obj/item/healthanalyzer(src)
