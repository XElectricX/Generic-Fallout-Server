/obj/item/storage/pouch/fallout
	name = "leather pouch"
	desc = "Deepen your pockets."
	icon = 'fallout/fallout icons/fallout items/fallout_storage.dmi'
	icon_state = "pouch"
	w_class = WEIGHT_CLASS_NORMAL
	flags_equip_slot = ITEM_SLOT_POCKET|ITEM_SLOT_BELT
	storage_slots = null
	max_storage_space = 3

/obj/item/storage/pouch/fallout/magazine
	name = "magazine pouch"
	desc = "Fits up to 3 magazines."
	icon_state = "pouch_magazine"
	storage_slots = 3
	max_storage_space = 6
	can_hold = list(/obj/item/ammo_magazine)

/obj/item/storage/pouch/fallout/medical
	name = "first aid pouch"
	desc = "Raggedy leather pouch storing your most valuable items."
	icon_state = "pouch_firstaid"
	storage_slots = 2
	max_storage_space = 4
	can_hold = list(
		/obj/item/tool/surgery,
		/obj/item/stack/nanopaste,
		/obj/item/reagent_containers,
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/storage/syringe_case,
		/obj/item/tweezers,
		/obj/item/healthanalyzer)

/obj/item/storage/pouch/fallout/medical/stimpak
	fill_type = /obj/item/reagent_containers/hypospray/fallout/stimpak
	fill_number = 2

/obj/item/storage/pouch/fallout/medical/healing_powder
	fill_type = /obj/item/stack/medical/heal_pack/healing_powder
	fill_number = 2

/obj/item/storage/pouch/fallout/medical/doctor
	name = "medical pouch"
	desc = "Sterilized (as much as something can be in the wasteland) pouch with 3 pockets for chems and other medical supplies."
	icon_state = "pouch_medical"
	storage_slots = 3
	max_storage_space = 6

/obj/item/storage/pouch/fallout/medical/doctor/full/Initialize()
	. = ..()
	new /obj/item/stack/medical/heal_pack/advanced/burn_pack(src)
	new /obj/item/stack/medical/heal_pack/advanced/bruise_pack(src)
	new /obj/item/healthanalyzer(src)
