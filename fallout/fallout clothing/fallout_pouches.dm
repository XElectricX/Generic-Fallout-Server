/obj/item/storage/pouch/fallout
	name = "\improper Leather Pouch"
	desc = "Deepen your pockets."
	icon = 'fallout/fallout icons/fallout items/fallout_storage.dmi'
	icon_state = "pouch"
	w_class = WEIGHT_CLASS_NORMAL
	storage_slots = null
	max_storage_space = 3

/obj/item/storage/pouch/fallout/magazine
	name = "\improper Magazine Pouch"
	desc = "Fits up to 3 magazines."
	icon = 'icons/Marine/marine-pouches.dmi'
	icon_state = "large_ammo_mag"
	storage_slots = 3
	max_storage_space = 6
	can_hold = list(/obj/item/ammo_magazine)

/obj/item/storage/pouch/fallout/medical
	name = "\improper First Aid Pouch"
	desc = "Raggedy leather pouch storing your most valuable items."
	icon_state = "pouch_firstaid"
	storage_slots = 2
	max_storage_space = 4
	can_hold = list(/obj/item/reagent_containers/hypospray/fallout, /obj/item/stack/medical, /obj/item/storage/pill_bottle)

/obj/item/storage/pouch/fallout/medical/doctor
	name = "\improper Medical Pouch"
	desc = "Sterilized (as much as something can be in the wasteland) pouch with 3 pockets for chems and other medical supplies."
	icon = 'icons/Marine/marine-pouches.dmi'
	icon_state = "medical"
	storage_slots = 3
	max_storage_space = 6

/obj/item/storage/pouch/fallout/medical/full
	fill_type = /obj/item/reagent_containers/hypospray/fallout/stimpak
	fill_number = 2
