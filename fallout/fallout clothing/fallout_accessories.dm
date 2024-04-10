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
/obj/item/clothing/shoes
	slowdown = 0

/obj/item/clothing/shoes/fallout
	name = "rags"
	desc = "Cloth rags bundled into something you could wrap around your feet."
	icon = 'fallout/fallout icons/fallout clothing/fallout_accessories.dmi'
	item_icons = list(slot_shoes_str = 'fallout/fallout icons/fallout clothing/fallout_accessories_worn.dmi')
	icon_state = "shoes_rag"
	item_state = "shoes_rag"
	armor_protection_flags = FEET
	cold_protection_flags = FEET
	heat_protection_flags = FEET

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
	inventory_flags = COVERMOUTH|COVEREYES
	inv_hide_flags = HIDEFACE|HIDELOWHAIR
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
		DISABLE_BITFIELD(inventory_flags, (COVERMOUTH))
		DISABLE_BITFIELD(inv_hide_flags, (HIDEFACE|HIDELOWHAIR))
		DISABLE_BITFIELD(armor_protection_flags, FACE)
	else
		ENABLE_BITFIELD(inventory_flags, (COVERMOUTH))
		ENABLE_BITFIELD(inv_hide_flags, (HIDEFACE|HIDELOWHAIR))
		ENABLE_BITFIELD(armor_protection_flags, FACE)
	to_chat(usr, "You [active ? "pull [src] up to cover your face" : "pull [src] off your face"].")

	update_clothing_icon()

	//Set user's name to Unknown if mask is over their face and they have no ID, opposite if they are pulling it down
	if(isliving(usr))
		var/mob/living/user = usr
		user.name = user.get_visible_name()

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
	inv_hide_flags = HIDEFACE|HIDEALLHAIR

/obj/item/clothing/mask/fallout/wrap
	name = "brown face wrap"
	desc = "Bundled cloth for covering your face."
	icon_state = "mask_brown"
	item_state = "mask_brown"
	inventory_flags = COVERMOUTH
	inv_hide_flags = HIDEFACE|HIDEALLHAIR

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

//Attachables below
/obj/item/armor_module/fallout
	name = "accessory template"
	desc = "Oh no, this shouldn't happen."
	icon = 'fallout/fallout icons/fallout items/armor_modules.dmi'
	icon_state = ""
	w_class = WEIGHT_CLASS_HUGE
	attach_features_flags = ATTACH_NO_HANDS|ATTACH_REMOVABLE
	///To prevent runtimes, but no reason it cannot be used as normal
	var/armor_features_flags
	///Primarily used for process() as I cannot pass arguments onto it
	var/mob/living/carbon/human/human_owner
	attach_delay = 0 SECONDS
	detach_delay = 0 SECONDS
	///Sound played on activate()
	var/activation_sound
	///Constant battery usage whenever this armor piece is equipped
	var/passive_energy_cost = 0
	///How much energy this module needs when activated
	var/active_energy_cost = 0
	///Which slot this attachment needs to be in to use enable_mod or disable_mod; var/equip_slot_flags would be used but then the user can equip it directly
	var/equip_slot

/obj/item/armor_module/fallout/Initialize()
	. = ..()
	attachments_allowed = string_list(attachments_allowed)
	starting_attachments = string_list(starting_attachments)
	if(!length(attachments_allowed) || !length(attachments_by_slot))
		return
	AddComponent(/datum/component/attachment_handler, attachments_by_slot, attachments_allowed, starting_attachments = starting_attachments)

/obj/item/armor_module/fallout/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(armor_protection_flags && !equip_slot_flags)	//Check equip_slot_flags or else items like helmets apply armor twice
		user.add_limb_armor(src)
	if(slowdown)
		user.add_movespeed_modifier(type, TRUE, 0, (item_flags & IMPEDE_JETPACK) ? SLOWDOWN_IMPEDE_JETPACK : NONE, TRUE, slowdown)
	if(user.pa_cell)
		user.pa_cell.action_energy_drain += passive_energy_cost
	if(!length(attachments_allowed) || !length(attachments_by_slot))	//Check if anything can be attached to this object
		return
	for(var/module_slot in attachments_by_slot)
		var/obj/item/armor_module/fallout/attachment = attachments_by_slot[module_slot]
		if(!attachment)
			continue
		attachment.enable_mod(src, user, slot)

/obj/item/armor_module/fallout/unequipped(mob/living/carbon/human/unequipper, slot)
	. = ..()
	if(armor_protection_flags && !equip_slot_flags)	//Check equip_slot_flags or else items like helmets remove armor twice
		unequipper.remove_limb_armor(src)
	if(slowdown)
		unequipper.remove_movespeed_modifier(type)
	if(unequipper.pa_cell)
		unequipper.pa_cell.action_energy_drain -= passive_energy_cost
	if(!length(attachments_allowed) || !length(attachments_by_slot))	//Check if anything can be attached to this object
		return
	for(var/module_slot in attachments_by_slot)
		var/obj/item/armor_module/fallout/attachment = attachments_by_slot[module_slot]
		if(!attachment)
			continue
		attachment.disable_mod(src, unequipper, slot)

///What this module does when the object it is attached to is equipped
/obj/item/armor_module/fallout/proc/enable_mod(obj/item/armor_module/fallout/attached_to, mob/living/carbon/human/user, which_slot)
	if(attached_to.equip_slot != which_slot)
		return
	human_owner = user

///What this module does when the object it is attached to is unequipped
/obj/item/armor_module/fallout/proc/disable_mod(obj/item/armor_module/fallout/attached_to, mob/living/carbon/human/user, which_slot)
	if(attached_to.equip_slot != which_slot)
		return
	human_owner = null

//Modifying to include an ATTACH_NO_OVERLAY check
/datum/component/attachment_handler/update_parent_overlay(datum/source)
	var/obj/item/parent_item = parent
	for(var/slot in slots) //Cycles through all the slots.
		var/obj/item/attachment = slots[slot]
		var/image/overlay = attachable_overlays[slot]
		parent_item.overlays -= overlay //First removes the existing overlay that occupies the slots overlay.
		if(!attachment) //No attachment, no overlay.
			attachable_overlays[slot] = null
			continue
		var/list/attachment_data = attachment_data_by_slot[slot]
		var/icon = attachment_data[OVERLAY_ICON]
		var/icon_state = attachment.icon_state
		if(!CHECK_BITFIELD(attachment_data[FLAGS_ATTACH_FEATURES], ATTACH_NO_OVERLAY))
			if(attachment_data[OVERLAY_ICON] == attachment.icon)
				icon_state = attachment.icon_state + "_a"
			if(CHECK_BITFIELD(attachment_data[FLAGS_ATTACH_FEATURES], ATTACH_SAME_ICON))
				icon_state = attachment.icon_state
				icon = attachment.icon
				overlay = image(icon, parent_item, icon_state)
				overlay.overlays += attachment.overlays
			else
				overlay = image(icon, parent_item, icon_state)
			var/slot_x = 0 //This and slot_y are for the event that the parent did not have an overlay_offsets. In that case the offsets default to 0
			var/slot_y = 0
			for(var/attachment_slot in attachment_offsets)
				if("[slot]_x" == attachment_slot)
					slot_x = attachment_offsets["[slot]_x"]
					continue
				if("[slot]_y" == attachment_slot)
					slot_y = attachment_offsets["[slot]_y"]
					continue
			var/pixel_shift_x = attachment_data[PIXEL_SHIFT_X] ? attachment_data[PIXEL_SHIFT_X] : 0 //This also is incase the attachments pixel_shift_x and y are null. If so it defaults to 0.
			var/pixel_shift_y = attachment_data[PIXEL_SHIFT_Y] ? attachment_data[PIXEL_SHIFT_Y] : 0
			overlay.pixel_x = slot_x - pixel_shift_x
			overlay.pixel_y = slot_y - pixel_shift_y
			attachable_overlays[slot] = overlay
			parent_item.overlays += overlay

//Capes
/obj/item/armor_module/fallout/cape
	name = "cape"
	desc = "Stylish."
	icon = 'fallout/fallout icons/fallout clothing/fallout_accessories.dmi'
	icon_state = ""	//Add a basic cape sprite some time in the future
	attach_icon = 'fallout/fallout icons/fallout clothing/fallout_accessories_worn.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	attach_features_flags = ATTACH_NO_HANDS|ATTACH_APPLY_ON_MOB|ATTACH_REMOVABLE
	attachment_layer = CAPE_LAYER
	slot = ATTACHMENT_SLOT_CAPE
