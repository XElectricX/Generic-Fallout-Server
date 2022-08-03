//Backpacks, spacious but bulky
/obj/item/storage/backpack/fallout
	name = "survivalist backpack"
	desc = "Multiple bags tied together for your post-apocalyptic storage needs."
	icon = 'fallout/fallout icons/fallout clothing/fallout_backpacks.dmi'
	item_icons = list(
		slot_back_str = 'fallout/fallout icons/fallout clothing/fallout_backpacks_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_misc_clothing.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_misc_clothing.dmi')
	icon_state = "survivalist_pack"
	item_state = "backpack"
	w_class = WEIGHT_CLASS_HUGE
	max_w_class = 4
	max_storage_space = 16
	slowdown = 0.5

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
	max_w_class = 3
	max_storage_space = 9
	access_delay = 0
	slowdown = 0

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
	max_w_class = 4
	storage_slots = 10
	max_storage_space = 40
	access_delay = 0
	slowdown = 0
	can_hold = list(/obj/item/weapon/fallout_melee/spear/throwing)

/obj/item/storage/backpack/fallout/quiver/full/Initialize()
	. = ..()
	for(var/i in 1 to 10)
		new /obj/item/weapon/fallout_melee/spear/throwing(src)
