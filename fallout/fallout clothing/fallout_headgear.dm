/obj/item/clothing/head/fallout
	name = "generic hat"
	desc = "Just a hat."
	icon = 'fallout/fallout icons/fallout clothing/fallout_headgear.dmi'
	item_icons = list(slot_head_str = 'fallout/fallout icons/fallout clothing/fallout_headgear_worn.dmi')
	cold_protection_flags = HEAD
	heat_protection_flags = HEAD

/obj/item/clothing/head/fallout/helmet
	inv_hide_flags = HIDEEARS|HIDEEYES
	soft_armor = list(MELEE = 25, BULLET = 25, LASER = 25, ENERGY = 25, BOMB = 25, BIO = 25, FIRE = 25, ACID = 25)

/obj/item/clothing/head/fallout/helmet/police
	name = "police officer hat"
	desc = "A hat with a badge on it."
	icon_state = "police_officer"
	item_state = "police_officer"
