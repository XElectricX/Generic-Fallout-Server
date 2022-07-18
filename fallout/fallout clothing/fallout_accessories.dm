//Gloves
/obj/item/clothing/gloves/fallout
	name = "leather gloves"
	desc = "Rough and not very fasionable, but good for protecting those meaty graspers."
	icon = 'fallout/fallout icons/fallout clothing/fallout_accessories.dmi'
	item_icons = list(slot_gloves_str = 'fallout/fallout icons/fallout clothing/fallout_accessories_worn.dmi')
	icon_state = "gloves_leather"
	item_state = "gloves_leather"

/obj/item/clothing/gloves/fallout/blacksmith
	name = "blacksmithing gloves"
	desc = "Heavy gloves made out of treated leather, lined with insulated materials."
	icon_state = "gloves_blacksmith"
	item_state = "gloves_blacksmith"
	siemens_coefficient = 0

/obj/item/clothing/gloves/fallout/metal
	name = "metal gauntlets"
	desc = "Armored gloves made out of metal plates."
	icon_state = "gloves_metal"
	item_state = "gloves_metal"

//Shoes
/obj/item/clothing/shoes/fallout
	name = "rags"
	desc = "Cloth rags bundled into something you could wrap around your feet."
	icon = 'fallout/fallout icons/fallout clothing/fallout_accessories.dmi'
	item_icons = list(slot_shoes_str = 'fallout/fallout icons/fallout clothing/fallout_accessories_worn.dmi')
	icon_state = "shoes_rag"
	item_state = "shoes_rag"
	flags_armor_protection = FEET
	flags_cold_protection = FEET
	flags_heat_protection = FEET
	slowdown = 0

/obj/item/clothing/shoes/fallout/cowboy
	name = "cowboy boots"
	desc = "They jingle jangle."
	icon_state = "shoes_cowboy"
	item_state = "shoes_cowboy"

/obj/item/clothing/shoes/fallout/trekker
	name = "trekker boots"
	desc = "Designed for walking long distances over unforgiving terrain."
	icon_state = "shoes_trekker"
	item_state = "shoes_trekker"

/obj/item/clothing/shoes/fallout/combat
	name = "combat boots"
	desc = "Hardy pair of boots for any environment a soldier may find themselves in."
	icon_state = "shoes_combat"
	item_state = "shoes_combat"

/obj/item/clothing/shoes/fallout/metal
	name = "metal boots"
	desc = "Boots covered in metal plating."
	icon_state = "shoes_metal"
	item_state = "shoes_metal"

//Masks
/obj/item/clothing/mask/fallout
	name = "joy mask"
	desc = "A funny mask."
	icon = 'fallout/fallout icons/fallout clothing/fallout_accessories.dmi'
	item_icons = list(slot_wear_mask_str = 'fallout/fallout icons/fallout clothing/fallout_accessories_worn.dmi')
	icon_state = "mask_joy"
	item_state = "mask_joy"
	flags_inventory = COVERMOUTH|COVEREYES
	flags_inv_hide = HIDEFACE|HIDELOWHAIR
	w_class = WEIGHT_CLASS_SMALL
	active = FALSE	//Toggleable masks are not up by default

/obj/item/clothing/mask/fallout/verb/toggle()
	set category = "Object"
	set name = "Adjust mask"
	set src in usr

	if(!toggleable)	//If mask can be toggled or not
		return
	if(usr.incapacitated())
		return

	active = !active
	icon_state = "[initial(icon_state)][active ? "_up" : ""]"
	if(!active)
		DISABLE_BITFIELD(flags_inventory, (COVERMOUTH))
		DISABLE_BITFIELD(flags_inv_hide, (HIDEFACE|HIDELOWHAIR))
		DISABLE_BITFIELD(flags_armor_protection, FACE)
	else
		ENABLE_BITFIELD(flags_inventory, (COVERMOUTH))
		ENABLE_BITFIELD(flags_inv_hide, (HIDEFACE|HIDELOWHAIR))
		ENABLE_BITFIELD(flags_armor_protection, FACE)
	to_chat(usr, "You [active ? "pull [src] up to cover your face" : "pull [src] off your face"].")

	update_clothing_icon()

	update_action_button_icons()

/obj/item/clothing/mask/fallout/gondola
	name = "gondola mask"
	desc = "fugg :DDDDD"
	icon_state = "mask_gondola"
	item_state = "mask_gondola"

/obj/item/clothing/mask/fallout/sack
	name = "sack mask"
	desc = "A dingy, straw sack with a sideways smiley face drawn on it, held together with rope."
	icon_state = "mask_sack"
	item_state = "mask_sack"
	flags_inv_hide = HIDEFACE|HIDEALLHAIR

/obj/item/clothing/mask/fallout/wrap
	name = "brown face wrap"
	desc = "Bundled cloth for covering your face."
	icon_state = "mask_brown"
	item_state = "mask_brown"
	flags_inventory = COVERMOUTH
	flags_inv_hide = HIDEFACE|HIDEALLHAIR

/obj/item/clothing/mask/fallout/wrap/black
	name = "black face wrap"
	icon_state = "mask_black"
	item_state = "mask_black"

/obj/item/clothing/mask/fallout/wrap/red
	name = "red face wrap"
	icon_state = "mask_red"
	item_state = "mask_red"

/obj/item/clothing/mask/fallout/wrap/blue
	name = "blue face wrap"
	icon_state = "mask_blue"
	item_state = "mask_blue"
