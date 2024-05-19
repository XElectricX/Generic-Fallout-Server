//Backpacks, spacious but bulky
/obj/item/storage/backpack/fallout
	name = "survivalist backpack"
	desc = "Multiple bags tied together for your post-apocalyptic storage needs."
	icon = 'fallout/fallout icons/fallout clothing/fallout_backpacks.dmi'
	worn_icon_list = list(
		slot_back_str = 'fallout/fallout icons/fallout clothing/fallout_backpacks_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_misc_clothing.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_misc_clothing.dmi')
	icon_state = "survivalist_pack"
	worn_icon_state = "backpack"
	w_class = WEIGHT_CLASS_HUGE
	slowdown = 0.5
	storage_type = /datum/storage/backpack/fallout

/datum/storage/backpack/fallout
	max_w_class = WEIGHT_CLASS_BULKY
	max_storage_space = 16
	access_delay = 1 SECONDS

/obj/item/storage/backpack/fallout/wanderer
	name = "wanderer backpack"
	desc = "Leather bag with many pockets."
	icon_state = "wanderer_pack"

/obj/item/storage/backpack/fallout/explorer
	name = "explorer backpack"
	desc = "Leather bag with many pockets."
	icon_state = "explorer_pack"

/obj/item/storage/backpack/fallout/trekker
	name = "trekker backpack"
	desc = "Leather bag with many pockets."
	icon_state = "trekker_pack"

//Satchels, small and light
/obj/item/storage/backpack/fallout/satchel
	name = "Placeholder"
	desc = "Should be a survivalist satchel, but that doesn't exist yet!"
	icon_state = "survivalist_satchel"
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 0
	storage_type = /datum/storage/backpack/fallout/satchel

/datum/storage/backpack/fallout/satchel
	max_w_class = WEIGHT_CLASS_NORMAL
	max_storage_space = 9
	access_delay = 0

/obj/item/storage/backpack/fallout/satchel/wanderer
	name = "wanderer satchel"
	desc = "Leather bag with many pockets."
	icon_state = "wanderer_satchel"

/obj/item/storage/backpack/fallout/satchel/explorer
	name = "explorer satchel"
	desc = "Leather bag with many pockets."
	icon_state = "explorer_satchel"

/obj/item/storage/backpack/fallout/satchel/trekker
	name = "trekker satchel"
	desc = "Leather bag with many pockets."
	icon_state = "trekker_satchel"

//Spear quiver, only holds throwing spears
/obj/item/storage/backpack/fallout/quiver
	name = "spear quiver"
	desc = "Store your pointed sticks for throwing later."
	icon_state = "quiver"
	slowdown = 0
	storage_type = /datum/storage/backpack/fallout/quiver

/datum/storage/backpack/fallout/quiver
	max_w_class = WEIGHT_CLASS_NORMAL
	max_storage_space = 40
	storage_slots = 10
	access_delay = 0

/datum/storage/backpack/fallout/quiver/New(atom/parent)
	. = ..()
	set_holdable(list(/obj/item/weapon/fallout_melee/spear/throwing))

/obj/item/storage/backpack/fallout/quiver/full/PopulateContents()
	if(!storage_datum)	//Sanity check
		return

	for(var/i in 1 to storage_datum.storage_slots)
		new /obj/item/weapon/fallout_melee/spear/throwing(src)
