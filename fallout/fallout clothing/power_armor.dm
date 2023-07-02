//This is all stuff for allowing deletion of the power armor when someone enters without deleting the armor pieces and putting them back without a fuss
/datum/component/attachment_handler/Initialize(list/slots, list/attachables_allowed, list/attachment_offsets, list/starting_attachments, datum/callback/can_attach, datum/callback/on_attach, datum/callback/on_detach, list/overlays = list())
	. = ..()
	RegisterSignal(parent, COMSIG_DELETE_ATTACHMENTS, .proc/delete_attachment_list)
	RegisterSignal(parent, COMSIG_ATTACH_WITHOUT_CHECKS, .proc/attach_without_checks)
	RegisterSignal(parent, COMSIG_DETACH_WITHOUT_CHECKS, .proc/detach_without_checks)

///Very dirty and inelegant but does not matter since this proc is only used before an item is set to be deleted
/datum/component/attachment_handler/proc/delete_attachment_list()
	SIGNAL_HANDLER
	slots = null

///Almost the same as attach_without_user except that attacher is set because if not, attachments are not moved
/datum/component/attachment_handler/proc/attach_without_checks(datum/source, obj/item/attachment, mob/attacher)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/handle_attachment, attachment, attacher, TRUE)

///Pretty much the same as proc/finish_detach except that it comes with the var/list/attachment_data bit included, which saves headaches
/datum/component/attachment_handler/proc/detach_without_checks(datum/source, obj/item/attachment, mob/living/user)
	SIGNAL_HANDLER
	var/list/attachment_data
	for(var/key in slots)
		if(slots[key] != attachment)
			continue
		attachment_data = attachment_data_by_slot[key]
		break
	slots[attachment_data[SLOT]] = null //Sets the slot the attachment is being removed from to null.
	attachment_data_by_slot[attachment_data[SLOT]] = null
	on_detach?.Invoke(attachment, user)
	UnregisterSignal(attachment, COMSIG_ATOM_UPDATE_ICON)
	update_parent_overlay()
	if(!user)
		QDEL_NULL(attachment)
		return
	if(attachment_data[ON_DETACH])
		var/datum/callback/attachment_on_detach = CALLBACK(attachment, attachment_data[ON_DETACH])
		attachment_on_detach.Invoke(parent, user)
	user.put_in_hands(attachment)
	SEND_SIGNAL(attachment, COMSIG_ATTACHMENT_DETACHED, parent, user)
	SEND_SIGNAL(parent, COMSIG_ATTACHMENT_DETACHED_FROM_ITEM, attachment, user)

//Base power armor frame; everything is attached to this, children of this are just presets
/obj/item/clothing/power_armor
	name = "power armor frame"
	desc = "Mechanical skeleton on which armor pieces and modules are attached."
	icon = 'fallout/fallout icons/fallout clothing/power_armor.dmi'
	icon_state = "frame"
	item_icons = null
	w_class = WEIGHT_CLASS_GIGANTIC
	density = TRUE
	attachments_by_slot = list(
		ATTACHMENT_SLOT_SHOULDER,
		ATTACHMENT_SLOT_KNEE,
		ATTACHMENT_SLOT_HELMET,
		ATTACHMENT_SLOT_CHESTPLATE)
	attachments_allowed = list(
		/obj/item/armor_module/fallout,
		/obj/item/armor_module/fallout/helmet,
		/obj/item/armor_module/fallout/torso,
		/obj/item/armor_module/fallout/arms,
		/obj/item/armor_module/fallout/legs,
		/obj/item/armor_module/fallout/helmet/t45,
		/obj/item/armor_module/fallout/torso/t45,
		/obj/item/armor_module/fallout/arms/t45,
		/obj/item/armor_module/fallout/legs/t45,
		/obj/item/armor_module/fallout/torso/t45/bos,
		/obj/item/armor_module/fallout/arms/t45/bos,
		/obj/item/armor_module/fallout/helmet/t51,
		/obj/item/armor_module/fallout/torso/t51,
		/obj/item/armor_module/fallout/arms/t51,
		/obj/item/armor_module/fallout/legs/t51,
		/obj/item/armor_module/fallout/torso/t51/bos,
		/obj/item/armor_module/fallout/arms/t51/bos,
		/obj/item/armor_module/fallout/helmet/t60,
		/obj/item/armor_module/fallout/torso/t60,
		/obj/item/armor_module/fallout/arms/t60,
		/obj/item/armor_module/fallout/legs/t60,
		/obj/item/armor_module/fallout/helmet/scrap,
		/obj/item/armor_module/fallout/torso/scrap,
		/obj/item/armor_module/fallout/arms/scrap,
		/obj/item/armor_module/fallout/legs/scrap,
		/obj/item/armor_module/fallout/helmet/scrap/ncr,
		/obj/item/armor_module/fallout/torso/scrap/ncr,
		/obj/item/armor_module/fallout/arms/scrap/ncr,
		/obj/item/armor_module/fallout/helmet/scrap/sierra,
		/obj/item/armor_module/fallout/torso/scrap/sierra,
		/obj/item/armor_module/fallout/arms/scrap/sierra,
		/obj/item/armor_module/fallout/legs/scrap/sierra,
		/obj/item/armor_module/fallout/helmet/raider,
		/obj/item/armor_module/fallout/torso/raider,
		/obj/item/armor_module/fallout/arms/raider,
		/obj/item/armor_module/fallout/legs/raider,
		/obj/item/armor_module/fallout/helmet/excavator,
		/obj/item/armor_module/fallout/torso/excavator,
		/obj/item/armor_module/fallout/arms/excavator,
		/obj/item/armor_module/fallout/legs/excavator)
	///Percentage chance an armor piece is spawned on a frame
	var/spawn_chance = 80
	///Holder for power armor battery
	var/obj/item/cell/fallout/battery

/obj/item/clothing/power_armor/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/cell))
		return ..()
	if(battery)
		unload(user)
	user.transferItemToLoc(I, src)
	battery = I
	playsound(user, 'sound/machines/hydraulics_1.ogg', 25, TRUE)
	to_chat(user, span_notice("You insert [I] into [src]."))

///Proc for removing energy cells from weapons that have them
/obj/item/clothing/power_armor/proc/unload(mob/user)
	user.put_in_hands(battery)
	battery = null
	playsound(user, 'sound/machines/hydraulics_2.ogg', 25, TRUE)

/obj/item/clothing/power_armor/attack_hand(mob/living/user)
	modify_armor_pieces(user)
	return

///Handles modification/removal of armor pieces
/obj/item/clothing/power_armor/proc/modify_armor_pieces(mob/living/user)
	var/list/choice_list = list()	//List to be populated with the armor pieces for the radial menu
	var/list/armor_pieces = list()	//List for holding references to which slot an armor piece belongs to by var/name
	var/obj/item/armor_module/fallout/choice	//Holder for armor pieces
	for(var/attachments in attachments_by_slot)	//Check the power armor slots
		if(!attachments_by_slot[attachments])	//If empty, skip to next one
			continue
		choice = attachments_by_slot[attachments]
		armor_pieces += list("[choice.name]" = attachments)
		choice_list += list("[choice.name]" = image(icon = choice.icon, icon_state = choice.icon_state))	//Add the info of this armor piece to the radial menu
	if(battery)
		choice_list += list("[battery.name]" = image(icon = battery.icon, icon_state = battery.icon_state))
	choice = show_radial_menu(user, src, choice_list, require_near = TRUE, tooltips = TRUE)
	if(choice)
		var/obj/item/attachment_to_detach = attachments_by_slot[armor_pieces[choice]]	//Take the choice the player made and search for that slot in the attachment list
		if(!attachment_to_detach)	//If null, must be a cell, so unload it
			unload(user)
		else
			SEND_SIGNAL(src, COMSIG_DETACH_WITHOUT_CHECKS, attachment_to_detach, user)

/obj/item/clothing/power_armor/MouseDrop_T(atom/dropping, mob/user)
	if(!ishuman(user) || user.status_flags & INCORPOREAL)	//Mob check
		return
	enter_armor(user)

///Suiting up procedures
/obj/item/clothing/power_armor/proc/enter_armor(mob/living/carbon/human/user)
	if(user.is_wearing_power_armor || user.mob_size > MOB_SIZE_HUMAN)	//To prevent power armor inception
		user.notification("You are too big to enter.")
		return
	playsound(src, "sound/mecha/mechmove01.ogg", 100, TRUE, 7, 0.5)
	if(!do_after(user, 3 SECONDS, TRUE, src, BUSY_ICON_BAR))
		return
	if(user.loc != loc)
		user.forceMove(loc)
	if(battery)
		user.pa_cell = battery
		battery.forceMove(user)
		battery = null
		if(user.pa_cell.charge <= 0)
			to_chat(user, span_warning("The internal battery is out of power!"))
			ADD_TRAIT(user, TRAIT_IMMOBILE, "power_armor_no_energy")
			user.playsound_local(user, 'sound/mecha/lowpowernano.ogg', 100)
			user.playsound_local(user, 'sound/mecha/lowpower.ogg', 50)
		else
			user.playsound_local(user, "sound/mecha/nominal.ogg", 100)
	else
		to_chat(user, span_warning("There is no battery installed!"))
		ADD_TRAIT(user, TRAIT_IMMOBILE, "power_armor_no_energy")
		user.playsound_local(user, 'sound/mecha/lowpowernano.ogg', 100)
		user.playsound_local(user, 'sound/mecha/lowpower.ogg', 100)
	for(var/attachments in attachments_by_slot)	//Check what slots we got in this suit
		switch(attachments)	//If there is an attached armor piece, attach it to the user; remove whatever the user is wearing first
			if(ATTACHMENT_SLOT_HELMET)
				if(!attachments_by_slot[attachments])
					continue
				user.dropItemToGround(user.head)
				user.equip_to_slot(attachments_by_slot[attachments], SLOT_HEAD)
			if(ATTACHMENT_SLOT_CHESTPLATE)
				user.dropItemToGround(user.wear_suit)
				if(!attachments_by_slot[attachments])
					user.equip_to_slot(new /obj/item/armor_module/fallout/torso(src), SLOT_WEAR_SUIT)
				else
					user.equip_to_slot(attachments_by_slot[attachments], SLOT_WEAR_SUIT)
				user.wear_suit.flags_item |= NODROP
			if(ATTACHMENT_SLOT_SHOULDER)
				user.dropItemToGround(user.gloves)
				if(!attachments_by_slot[attachments])
					user.equip_to_slot(new /obj/item/armor_module/fallout/arms(src), SLOT_GLOVES)
				else
					user.equip_to_slot(attachments_by_slot[attachments], SLOT_GLOVES)
				user.gloves.flags_item |= NODROP
			if(ATTACHMENT_SLOT_KNEE)
				user.dropItemToGround(user.shoes)
				if(!attachments_by_slot[attachments])
					user.equip_to_slot(new /obj/item/armor_module/fallout/legs(src), SLOT_SHOES)
				else
					user.equip_to_slot(attachments_by_slot[attachments], SLOT_SHOES)
				user.shoes.flags_item |= NODROP
	user.mob_size = MOB_SIZE_BIG	//PA makes you a big boi
	user.is_wearing_power_armor = TRUE
	var/datum/action/exit_pa/action = new(user)
	action.give_action(user)	//For letting you exit your power armor through clicking an action button
	SEND_SIGNAL(src, COMSIG_DELETE_ATTACHMENTS)	//Delete attachments from this power armor frame
	qdel(src)

//From suit/modular
/obj/item/clothing/power_armor/get_mechanics_info()
	. = ..()
	. += "<br><br />This is a power armor frame. It can equip different armor pieces and modules.<br />"
	. += "</ul>"
	if(attachments_by_slot[ATTACHMENT_SLOT_HELMET])
		. += "<br> It has [attachments_by_slot[ATTACHMENT_SLOT_HELMET]] attached."
	if(attachments_by_slot[ATTACHMENT_SLOT_CHESTPLATE])
		. += "<br> It has [attachments_by_slot[ATTACHMENT_SLOT_CHESTPLATE]] attached."
	if(attachments_by_slot[ATTACHMENT_SLOT_SHOULDER])
		. += "<br> It has [attachments_by_slot[ATTACHMENT_SLOT_SHOULDER]] attached."
	if(attachments_by_slot[ATTACHMENT_SLOT_KNEE])
		. += "<br> It has [attachments_by_slot[ATTACHMENT_SLOT_KNEE]] attached."
	if(battery)
		. += "<br> \a [battery] is installed."

//Code below facilitates the exiting of power armor
/datum/action/exit_pa
	name = "Exit Power Armor"
	action_icon_state = "71"

/datum/action/exit_pa/action_activate()
	var/mob/living/carbon/human/user = owner
	if(user.lying_angle)
		user.notification("You must be upright to initiate exit procedures.")
		return
	playsound(user, "sound/mecha/mechmove01.ogg", 100, TRUE, 7, 0.5)
	if(!do_after(user, 3 SECONDS, TRUE, user, BUSY_ICON_BAR))
		return
	/* This portion of code is spawning in a frame, then checking if you have any armor pieces in each limb to attach back to it */
	var/obj/item/clothing/power_armor/armor = new /obj/item/clothing/power_armor(user.loc)
	if(istype(user.head, /obj/item/armor_module/fallout/helmet))
		SEND_SIGNAL(armor, COMSIG_ATTACH_WITHOUT_CHECKS, user.head, user)
	if(istype(user.wear_suit, /obj/item/armor_module/fallout/torso))
		user.wear_suit.flags_item &= ~NODROP
		if(user.wear_suit.type == /obj/item/armor_module/fallout/torso)
			qdel(user.wear_suit)
		else
			SEND_SIGNAL(armor, COMSIG_ATTACH_WITHOUT_CHECKS, user.wear_suit, user)
	if(istype(user.gloves, /obj/item/armor_module/fallout/arms))
		user.gloves.flags_item &= ~NODROP
		if(user.gloves.type == /obj/item/armor_module/fallout/arms)
			qdel(user.gloves)
		else
			SEND_SIGNAL(armor, COMSIG_ATTACH_WITHOUT_CHECKS, user.gloves, user)
	if(istype(user.shoes, /obj/item/armor_module/fallout/legs))
		user.shoes.flags_item &= ~NODROP
		if(user.shoes.type == /obj/item/armor_module/fallout/legs)
			qdel(user.shoes)
		else
			SEND_SIGNAL(armor, COMSIG_ATTACH_WITHOUT_CHECKS, user.shoes, user)
	if(user.pa_cell)
		armor.battery = user.pa_cell
		user.pa_cell.forceMove(armor)
		user.pa_cell = null
		armor.battery.action_energy_drain = initial(armor.battery.action_energy_drain)	//Resetting the var just to make sure
	if(HAS_TRAIT(user, TRAIT_IMMOBILE))
		REMOVE_TRAIT(user, TRAIT_IMMOBILE, "power_armor_no_energy")
	user.mob_size = initial(user.mob_size)	//No longer a big boi
	user.is_wearing_power_armor = FALSE
	qdel(src)

/obj/item/clothing/power_armor/random/Initialize()
	/*	RNG code for randomized PA going here because it does need to be it's own proc as it only runs when first spawned
		Why this instead of just pick()? Because while pick(null, etc) does work, the null will cause a runtime			*/
	var/list/rng_attachments = list()
	if(prob(spawn_chance))
		rng_attachments.Add(pick(
			/obj/item/armor_module/fallout/helmet/t45,
			/obj/item/armor_module/fallout/helmet/t51,
			/obj/item/armor_module/fallout/helmet/t60,
			/obj/item/armor_module/fallout/helmet/scrap,
			/obj/item/armor_module/fallout/helmet/raider,
			/obj/item/armor_module/fallout/helmet/excavator))
	if(prob(spawn_chance))
		rng_attachments.Add(pick(
			/obj/item/armor_module/fallout/torso/t45,
			/obj/item/armor_module/fallout/torso/t51,
			/obj/item/armor_module/fallout/torso/t60,
			/obj/item/armor_module/fallout/torso/scrap,
			/obj/item/armor_module/fallout/torso/raider,
			/obj/item/armor_module/fallout/torso/excavator))
	if(prob(spawn_chance))
		rng_attachments.Add(pick(
			/obj/item/armor_module/fallout/arms/t45,
			/obj/item/armor_module/fallout/arms/t51,
			/obj/item/armor_module/fallout/arms/t60,
			/obj/item/armor_module/fallout/arms/scrap,
			/obj/item/armor_module/fallout/arms/raider,
			/obj/item/armor_module/fallout/arms/excavator))
	if(prob(spawn_chance))
		rng_attachments.Add(pick(
			/obj/item/armor_module/fallout/legs/t45,
			/obj/item/armor_module/fallout/legs/t51,
			/obj/item/armor_module/fallout/legs/t60,
			/obj/item/armor_module/fallout/legs/scrap,
			/obj/item/armor_module/fallout/legs/raider,
			/obj/item/armor_module/fallout/legs/excavator))
	if(prob(spawn_chance) && !battery)
		battery = new /obj/item/cell/fallout
	starting_attachments = rng_attachments
	. = ..()

/obj/item/clothing/power_armor/t45
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/t45,
		/obj/item/armor_module/fallout/torso/t45,
		/obj/item/armor_module/fallout/arms/t45,
		/obj/item/armor_module/fallout/legs/t45)
	battery = new /obj/item/cell/fallout

/obj/item/clothing/power_armor/t45_bos
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/t45,
		/obj/item/armor_module/fallout/torso/t45/bos,
		/obj/item/armor_module/fallout/arms/t45/bos,
		/obj/item/armor_module/fallout/legs/t45)
	battery = new /obj/item/cell/fallout

/obj/item/clothing/power_armor/t51
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/t51,
		/obj/item/armor_module/fallout/torso/t51,
		/obj/item/armor_module/fallout/arms/t51,
		/obj/item/armor_module/fallout/legs/t51)
	battery = new /obj/item/cell/fallout

/obj/item/clothing/power_armor/t51_bos
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/t51,
		/obj/item/armor_module/fallout/torso/t51/bos,
		/obj/item/armor_module/fallout/arms/t51/bos,
		/obj/item/armor_module/fallout/legs/t51)
	battery = new /obj/item/cell/fallout

/obj/item/clothing/power_armor/t60
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/t60,
		/obj/item/armor_module/fallout/torso/t60,
		/obj/item/armor_module/fallout/arms/t60,
		/obj/item/armor_module/fallout/legs/t60)
	battery = new /obj/item/cell/fallout

/obj/item/clothing/power_armor/scrap
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/scrap,
		/obj/item/armor_module/fallout/torso/scrap,
		/obj/item/armor_module/fallout/arms/scrap,
		/obj/item/armor_module/fallout/legs/scrap)
	battery = new /obj/item/cell/fallout

/obj/item/clothing/power_armor/raider
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/raider,
		/obj/item/armor_module/fallout/torso/raider,
		/obj/item/armor_module/fallout/arms/raider,
		/obj/item/armor_module/fallout/legs/raider)
	battery = new /obj/item/cell/fallout

/obj/item/clothing/power_armor/excavator
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/excavator,
		/obj/item/armor_module/fallout/torso/excavator,
		/obj/item/armor_module/fallout/arms/excavator,
		/obj/item/armor_module/fallout/legs/excavator)
	battery = new /obj/item/cell/fallout

/obj/item/clothing/power_armor/ncr
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/scrap/ncr,
		/obj/item/armor_module/fallout/torso/scrap/ncr,
		/obj/item/armor_module/fallout/arms/scrap/ncr,
		/obj/item/armor_module/fallout/legs/scrap)
	battery = new /obj/item/cell/fallout

/obj/item/clothing/power_armor/sierra
	starting_attachments = list(
		/obj/item/armor_module/fallout/helmet/scrap/sierra,
		/obj/item/armor_module/fallout/torso/scrap/sierra,
		/obj/item/armor_module/fallout/arms/scrap/sierra,
		/obj/item/armor_module/fallout/legs/scrap/sierra)
	battery = new /obj/item/cell/fallout

//List of armor pieces and mods below
/obj/item/armor_module/fallout/helmet
	name = "non-existent helmet"
	desc = "Frames don't come with a helmet."
	icon_state = ""
	item_icons = list(slot_head_str = 'fallout/fallout icons/fallout clothing/power_armor.dmi')
	attach_icon = 'fallout/fallout icons/fallout clothing/power_armor.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	flags_atom = CONDUCT
	flags_inv_hide = HIDEFACE|HIDEALLHAIR|HIDEMASK|HIDEEYES|HIDEEARS
	flags_armor_protection = HEAD|FACE|EYES
	flags_equip_slot = ITEM_SLOT_HEAD
	equip_slot = SLOT_HEAD
	slot = ATTACHMENT_SLOT_HELMET
	light_power = 5
	light_range = 5
	light_color = LIGHT_COLOR_YELLOW
	passive_energy_cost = 4
	///Severity of how much of the screen is covered when equipped; 0 is none, 5 is max
	var/tint_level = 1
	actions_types = list(/datum/action/item_action/toggle)
	activation_sound = 'sound/items/flashlight.ogg'
	attachments_by_slot = list(ATTACHMENT_SLOT_MODULE)
	attachments_allowed = list(/obj/item/armor_module/fallout/night_vision)
	soft_armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)
	hard_armor = list("melee" = 1, "bullet" = 1, "laser" = 1, "energy" = 1, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)

/obj/item/armor_module/fallout/helmet/Initialize()
	. = ..()
	GLOB.nightfall_toggleable_lights += src
	AddComponent(/datum/component/clothing_tint, tint_level, TRUE)

/obj/item/armor_module/fallout/helmet/Destroy()
	GLOB.nightfall_toggleable_lights -= src
	return ..()

/obj/item/armor_module/fallout/helmet/update_icon()
	. = ..()
	if(light_on)
		icon_state = "[initial(icon_state)]_on"
	else
		icon_state = initial(icon_state)
	update_item_state()

/obj/item/armor_module/fallout/helmet/update_item_state(mob/user)
	item_state = "[initial(item_state)][light_on ? "_on" : ""]"

/obj/item/armor_module/fallout/helmet/activate(mob/living/carbon/human/user)
	if(activation_sound)
		playsound(get_turf(src), activation_sound, 15, 1)
	turn_light(user, !light_on)
	user.update_inv_head()	//This refreshes the onmob icon
	return TRUE

/obj/item/armor_module/fallout/helmet/turn_light(mob/user, toggle_on, forced = TRUE)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	set_light_on(toggle_on)
	update_action_button_icons()
	update_icon()

/obj/item/armor_module/fallout/helmet/unequipped(mob/unequipper, slot)
	. = ..()
	turn_light(unequipper, FALSE, TRUE)

/obj/item/armor_module/fallout/torso
	name = "power armor frame torso"
	desc = "Bare metal and circuitry waiting to be plated."
	icon_state = "frame_torso"
	item_icons = list(slot_wear_suit_str = 'fallout/fallout icons/fallout clothing/power_armor.dmi')
	attach_icon = 'fallout/fallout icons/fallout clothing/power_armor.dmi'
	flags_atom = CONDUCT
	flags_armor_protection = CHEST|GROIN
	equip_slot = SLOT_WEAR_SUIT
	slot = ATTACHMENT_SLOT_CHESTPLATE
	worn_layer = BELT_LAYER + 0.2	//Render below most things
	attachment_layer = BELT_LAYER + 0.2
	passive_energy_cost = 4
	slowdown = 0.2
	attachments_by_slot = list(ATTACHMENT_SLOT_MODULE)
	attachments_allowed = list(/obj/item/armor_module/fallout/stealth_boy)
	allowed = list(
		/obj/item/weapon/gun/fallout/pistol,
		/obj/item/weapon/gun/fallout/smg,
		/obj/item/weapon/gun/fallout/rifle,
		/obj/item/weapon/gun/fallout/shotgun,
		/obj/item/weapon/twohanded,
		/obj/item/weapon/fallout_melee,
		/obj/item/storage/holster/blade,
		/obj/item/storage/pouch/fallout,
		/obj/item/storage/backpack/fallout/satchel,
		/obj/item/flashlight/fallout,
		/obj/item/tank/emergency_oxygen)
	soft_armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)
	hard_armor = list("melee" = 1, "bullet" = 1, "laser" = 1, "energy" = 1, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)

/obj/item/armor_module/fallout/arms
	name = "power armor frame arms"
	desc = "Mechanical arms for lifting heavy items."
	icon_state = "frame_arms"
	item_icons = list(slot_gloves_str = 'fallout/fallout icons/fallout clothing/power_armor.dmi')
	attach_icon = 'fallout/fallout icons/fallout clothing/power_armor.dmi'
	flags_atom = CONDUCT
	flags_armor_protection = ARMS|HANDS
	equip_slot = SLOT_GLOVES
	slot = ATTACHMENT_SLOT_SHOULDER
	worn_layer = HEAD_LAYER - 0.1	//Render above the helmet or else the helmet clips over the arms in side views
	attachment_layer = HEAD_LAYER - 0.1
	passive_energy_cost = 4
	slowdown = 0.2
	attachments_by_slot = list(ATTACHMENT_SLOT_MODULE)
	attachments_allowed = list(/obj/item/armor_module/fallout/hydraulic_bracers)
	soft_armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)
	hard_armor = list("melee" = 1, "bullet" = 1, "laser" = 1, "energy" = 1, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)

/obj/item/armor_module/fallout/legs
	name = "power armor frame legs"
	desc = "An assembly of servos and light metal for keeping the weight of the frame from crushing you."
	icon_state = "frame_legs"
	item_icons = list(slot_shoes_str = 'fallout/fallout icons/fallout clothing/power_armor.dmi')
	attach_icon = 'fallout/fallout icons/fallout clothing/power_armor.dmi'
	flags_atom = CONDUCT
	flags_armor_protection = LEGS|FEET
	equip_slot = SLOT_SHOES
	slot = ATTACHMENT_SLOT_KNEE
	worn_layer = BELT_LAYER + 0.1	//Render above the torso
	attachment_layer = BELT_LAYER + 0.1
	passive_energy_cost = 4
	slowdown = 0.2
	attachments_by_slot = list(ATTACHMENT_SLOT_MODULE)
	attachments_allowed = list()
	soft_armor = list("melee" = 5, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)
	hard_armor = list("melee" = 1, "bullet" = 1, "laser" = 1, "energy" = 1, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)
	var/track_blood = 0

///Stops runtimes
/obj/item/armor_module/fallout/legs/proc/step_action()
	return

/obj/item/armor_module/fallout/helmet/t45
	name = "\improper T-45 helmet"
	desc = "Helmet from the T-45 series."
	icon_state = "t45_helmet"
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/torso/t45
	name = "\improper T-45 torso"
	desc = "Chest piece of the T-45 series."
	icon_state = "t45_torso"
	slowdown = 0.3
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/arms/t45
	name = "\improper T-45 arms"
	desc = "Arm pieces of the T-45 series."
	icon_state = "t45_arms"
	slowdown = 0.3
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/legs/t45
	name = "\improper T-45 legs"
	desc = "Leg pieces of the T-45 series."
	icon_state = "t45_legs"
	slowdown = 0.3
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/torso/t45/bos
	name = "\improper T-45 Brotherhood of Steel torso"
	desc = "Chest piece of the T-45 series. Has Brotherhood of Steel markings."
	icon_state = "t45_bos_torso"

/obj/item/armor_module/fallout/arms/t45/bos
	name = "\improper T-45 Brotherhood of Steel arms"
	desc = "Arm pieces of the T-45 series. Has Brotherhood of Steel markings."
	icon_state = "t45_bos_arms"

/obj/item/armor_module/fallout/helmet/t51
	name = "\improper T-51 helmet"
	desc = "Helmet from the T-51 series."
	icon_state = "t51_helmet"
	passive_energy_cost = 5
	tint_level = 4
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 40, "bomb" = 50, "bio" = 100, "fire" = 40, "acid" = 40)
	hard_armor = list("melee" = 15, "bullet" = 15, "laser" = 8, "energy" = 5, "bomb" = 5, "bio" = 0, "fire" = 5, "acid" = 5)

/obj/item/armor_module/fallout/torso/t51
	name = "\improper T-51 torso"
	desc = "Chest piece of the T-51 series."
	icon_state = "t51_torso"
	passive_energy_cost = 5
	slowdown = 0.6
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 40, "bomb" = 50, "bio" = 100, "fire" = 40, "acid" = 40)
	hard_armor = list("melee" = 15, "bullet" = 15, "laser" = 8, "energy" = 5, "bomb" = 5, "bio" = 0, "fire" = 5, "acid" = 5)

/obj/item/armor_module/fallout/arms/t51
	name = "\improper T-51 arms"
	desc = "Arm pieces of the T-51 series."
	icon_state = "t51_arms"
	passive_energy_cost = 5
	slowdown = 0.6
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 40, "bomb" = 50, "bio" = 100, "fire" = 40, "acid" = 40)
	hard_armor = list("melee" = 15, "bullet" = 15, "laser" = 8, "energy" = 5, "bomb" = 5, "bio" = 0, "fire" = 5, "acid" = 5)

/obj/item/armor_module/fallout/legs/t51
	name = "\improper T-51 legs"
	desc = "Leg pieces of the T-51 series."
	icon_state = "t51_legs"
	passive_energy_cost = 5
	slowdown = 0.6
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 40, "bomb" = 50, "bio" = 100, "fire" = 40, "acid" = 40)
	hard_armor = list("melee" = 15, "bullet" = 15, "laser" = 8, "energy" = 5, "bomb" = 5, "bio" = 0, "fire" = 5, "acid" = 5)

/obj/item/armor_module/fallout/torso/t51/bos
	name = "\improper T-51 Brotherhood of Steel torso"
	desc = "Chest piece of the T-51 series. Has Brotherhood of Steel markings."
	icon_state = "t51_bos_torso"

/obj/item/armor_module/fallout/arms/t51/bos
	name = "\improper T-51 Brotherhood of Steel arms"
	desc = "Arm pieces of the T-51 series. Has Brotherhood of Steel markings."
	icon_state = "t51_bos_arms"

/obj/item/armor_module/fallout/helmet/t60
	name = "\improper T-60 helmet"
	desc = "Helmet from the T-60 series."
	icon_state = "t60_helmet"
	light_color = LIGHT_COLOR_CYAN
	passive_energy_cost = 6
	tint_level = 3
	soft_armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 50, "bio" = 100, "fire" = 30, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/torso/t60
	name = "\improper T-60 torso"
	desc = "Chest piece of the T-60 series."
	icon_state = "t60_torso"
	passive_energy_cost = 6
	slowdown = 0.5
	soft_armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 50, "bio" = 100, "fire" = 30, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/arms/t60
	name = "\improper T-60 arms"
	desc = "Arm pieces of the T-60 series."
	icon_state = "t60_arms"
	passive_energy_cost = 6
	slowdown = 0.5
	soft_armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 50, "bio" = 100, "fire" = 30, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/legs/t60
	name = "\improper T-60 legs"
	desc = "Leg pieces of the T-60 series."
	icon_state = "t60_legs"
	passive_energy_cost = 6
	slowdown = 0.5
	soft_armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 50, "bio" = 100, "fire" = 30, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/helmet/scrap
	name = "scrap power armor helmet"
	desc = "Rough metal helmet with some rudimentary wiring."
	icon_state = "scrap_helmet"
	passive_energy_cost = 6
	tint_level = 2
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/torso/scrap
	name = "scrap power armor torso"
	desc = "Probably made from scratch or junk power armor parts."
	icon_state = "scrap_torso"
	passive_energy_cost = 6
	slowdown = 0.4
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/arms/scrap
	name = "scrap power armor arms"
	desc = "Probably made from scratch or junk power armor parts."
	icon_state = "scrap_arms"
	passive_energy_cost = 6
	slowdown = 0.4
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/legs/scrap
	name = "scrap power armor legs"
	desc = "Probably made from scratch or junk power armor parts."
	icon_state = "scrap_legs"
	passive_energy_cost = 6
	slowdown = 0.4
	soft_armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/helmet/raider
	name = "raider power armor helmet"
	desc = "Reinforced helmet with very likely faulty wiring. Smells like piss."
	icon_state = "raider_helmet"
	light_color = LIGHT_COLOR_TUNGSTEN
	passive_energy_cost = 6
	tint_level = 3
	soft_armor = list("melee" = 60, "bullet" = 60, "laser" = 30, "energy" = 30, "bomb" = 50, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/torso/raider
	name = "raider power armor torso"
	desc = "Probably made from scratch or junk power armor parts with additional reinforcements."
	icon_state = "raider_torso"
	passive_energy_cost = 6
	slowdown = 0.5
	soft_armor = list("melee" = 60, "bullet" = 60, "laser" = 30, "energy" = 30, "bomb" = 50, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/arms/raider
	name = "raider power armor arms"
	desc = "Probably made from scratch or junk power armor parts with additional reinforcements."
	icon_state = "raider_arms"
	passive_energy_cost = 6
	slowdown = 0.5
	soft_armor = list("melee" = 60, "bullet" = 60, "laser" = 30, "energy" = 30, "bomb" = 50, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/legs/raider
	name = "raider power armor legs"
	desc = "Probably made from scratch or junk power armor parts with additional reinforcements."
	icon_state = "raider_legs"
	passive_energy_cost = 6
	slowdown = 0.5
	soft_armor = list("melee" = 60, "bullet" = 60, "laser" = 30, "energy" = 30, "bomb" = 50, "bio" = 100, "fire" = 20, "acid" = 30)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 3, "acid" = 3)

/obj/item/armor_module/fallout/helmet/excavator
	name = "excavator power armor helmet"
	desc = "Featuring air scrubbers, a powerful lamp, and heavy radiation shielding."
	icon_state = "excavator_helmet"
	light_range = 6
	passive_energy_cost = 5
	tint_level = 3
	soft_armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 100, "fire" = 80, "acid" = 80)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 10, "acid" = 10)

/obj/item/armor_module/fallout/torso/excavator
	name = "excavator power armor torso"
	desc = "More of a mobile habitat than combat armor. It is designed with an internal air tank and filtration system, emergency power reserve, and heavily shielded against radiation and fires."
	icon_state = "excavator_torso"
	passive_energy_cost = 5
	slowdown = 0.4
	soft_armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 100, "fire" = 80, "acid" = 80)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 10, "acid" = 10)

/obj/item/armor_module/fallout/arms/excavator
	name = "excavator power armor arms"
	desc = "Inside these arms are reinforced hydraulics and motors, intended for letting miners wield heavy equipment while retaining agile limbs."
	icon_state = "excavator_arms"
	passive_energy_cost = 5
	slowdown = 0.4
	soft_armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 100, "fire" = 80, "acid" = 80)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 10, "acid" = 10)

/obj/item/armor_module/fallout/legs/excavator
	name = "excavator power armor legs"
	desc = "Reinforced hydraulics and advanced shock absorber technology enables the user to support large loads."
	icon_state = "excavator_legs"
	passive_energy_cost = 5
	slowdown = 0.4
	soft_armor = list("melee" = 30, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 100, "fire" = 80, "acid" = 80)
	hard_armor = list("melee" = 3, "bullet" = 3, "laser" = 3, "energy" = 3, "bomb" = 3, "bio" = 0, "fire" = 10, "acid" = 10)

/obj/item/armor_module/fallout/helmet/scrap/ncr
	name = "\improper NCR power armor helmet"
	desc = "Metal helmet with a red stripe, indicative of the NCR."
	icon_state = "scrap_ncr_helmet"

/obj/item/armor_module/fallout/torso/scrap/ncr
	name = "\improper NCR power armor torso"
	desc = "Chest piece with the majestic two-headed bear of the Republic."
	icon_state = "scrap_ncr_torso"

/obj/item/armor_module/fallout/arms/scrap/ncr
	name = "\improper NCR power armor arms"
	desc = "Arm pieces with red NCR stripes."
	icon_state = "scrap_ncr_arms"

/obj/item/armor_module/fallout/helmet/scrap/sierra
	name = "\improper NCR Sierra power armor helmet"
	desc = "The best of the NCR's engineering condensed into a helmet."
	icon_state = "scrap_sierra_helmet"
	light_color = LIGHT_COLOR_WHITE
	passive_energy_cost = 4

/obj/item/armor_module/fallout/torso/scrap/sierra
	name = "\improper NCR Sierra power armor torso"
	desc = "Scrap power armor chest piece that was improved upon. Much more resistant to damage than your average waster power armor."
	icon_state = "scrap_sierra_torso"
	passive_energy_cost = 4
	slowdown = 0.3

/obj/item/armor_module/fallout/arms/scrap/sierra
	name = "\improper NCR Sierra power armor arms"
	desc = "Republic engineers added undamaged servos to these so they aren't a pain to lift with. Comes with a stylish pelt."
	icon_state = "scrap_sierra_arms"
	passive_energy_cost = 4
	slowdown = 0.3

/obj/item/armor_module/fallout/legs/scrap/sierra
	name = "\improper NCR Sierra power armor legs"
	desc = "Featuring more gold than most will ever see in their lives."
	icon_state = "scrap_sierra_legs"
	passive_energy_cost = 4
	slowdown = 0.3

//Power armor modules
/obj/item/armor_module/fallout/hydraulic_bracers
	name = "hydraulic bracers"
	desc = "Increases the user's arm strength."
	icon_state = "module_armor"
	flags_attach_features = ATTACH_NO_OVERLAY|ATTACH_REMOVABLE|ATTACH_NO_HANDS
	slot = ATTACHMENT_SLOT_MODULE

/obj/item/armor_module/fallout/hydraulic_bracers/enable_mod(obj/item/armor_module/fallout/attached_to, mob/living/carbon/human/user, which_slot)
	. = ..()
	user.melee_damage += 20

/obj/item/armor_module/fallout/hydraulic_bracers/disable_mod(obj/item/armor_module/fallout/attached_to, mob/living/carbon/human/user, which_slot)
	. = ..()
	user.melee_damage -= 20

/obj/item/armor_module/fallout/stealth_boy
	name = "integrated stealth boy modkit"
	desc = "Grants a low-level stealth field when activated."
	icon_state = "module_armor"
	flags_attach_features = ATTACH_NO_OVERLAY|ATTACH_REMOVABLE|ATTACH_NO_HANDS
	slot = ATTACHMENT_SLOT_MODULE
	activation_sound = 'sound/effects/seedling_chargeup.ogg'
	active_energy_cost = 200

/obj/item/armor_module/fallout/stealth_boy/enable_mod(obj/item/armor_module/fallout/attached_to, mob/living/carbon/human/user, which_slot)
	. = ..()
	var/datum/action/item_action/toggle/action = new(src)
	action.give_action(user)

/obj/item/armor_module/fallout/stealth_boy/disable_mod(obj/item/armor_module/fallout/attached_to, mob/living/carbon/human/user, which_slot)
	. = ..()
	if(active)
		activate(user)
	for(var/datum/action/A AS in actions)
		A.remove_action(user)

/obj/item/armor_module/fallout/stealth_boy/activate(mob/living/carbon/human/user)
	if(active)
		active = FALSE
		user.alpha = 255
		user.color = null
		playsound(src, 'sound/effects/sparks1.ogg', 100, FALSE, 3, 0.25)
		user.pa_cell.passive_energy_drain -= active_energy_cost
		STOP_PROCESSING(SSobj, src)
		return TRUE
	else
		if(!user.pa_cell || user.pa_cell.charge < active_energy_cost)
			user.notification("[src] lacks power.")
			return FALSE
		active = TRUE
		animate(user, time = 5 SECONDS, easing = LINEAR_EASING, alpha = 5, color = "#000000")
		playsound(src, activation_sound, 100, FALSE, 3, 0.25)
		user.pa_cell.passive_energy_drain += active_energy_cost
		START_PROCESSING(SSobj, src)
		return TRUE

/obj/item/armor_module/fallout/stealth_boy/process()
	if(!human_owner?.pa_cell.drain_power(active_energy_cost))
		activate(human_owner)
		return PROCESS_KILL

/obj/item/armor_module/fallout/night_vision
	name = "night vision modkit"
	desc = "Helmet attachment for seeing clearer in low light conditions."
	icon_state = "module_armor"
	flags_attach_features = ATTACH_NO_OVERLAY|ATTACH_REMOVABLE|ATTACH_NO_HANDS
	slot = ATTACHMENT_SLOT_MODULE
	actions_types = list(/datum/action/item_action/toggle)
	activation_sound = 'sound/effects/nightvision.ogg'
	active_energy_cost = 50

/obj/item/armor_module/fallout/night_vision/enable_mod(obj/item/armor_module/fallout/attached_to, mob/living/carbon/human/user, which_slot)
	. = ..()
	var/datum/action/item_action/toggle/action = new(src)
	action.give_action(user)

/obj/item/armor_module/fallout/night_vision/disable_mod(obj/item/armor_module/fallout/attached_to, mob/living/carbon/human/user, which_slot)
	. = ..()
	if(active)
		activate(user)
	for(var/datum/action/A AS in actions)
		A.remove_action(user)

/obj/item/armor_module/fallout/night_vision/activate(mob/living/carbon/human/user)
	if(active)
		active = FALSE
		/*	Change how human/update_sight() works first
		user.see_in_dark = initial(user.see_in_dark)
		user.lighting_alpha = initial(user.lighting_alpha)*/
		REMOVE_TRAIT(user, TRAIT_SEE_IN_DARK, "night vision")
		user.update_sight()
		playsound(src, 'sound/machines/click.ogg', 100, FALSE, 3, 0.25)
		user.pa_cell.passive_energy_drain -= active_energy_cost
		STOP_PROCESSING(SSobj, src)
		return TRUE
	else
		if(!user.pa_cell || user.pa_cell.charge < active_energy_cost)
			user.notification("[src] lacks power.")
			return FALSE
		active = TRUE
		/*	Change how human/update_sight() works first
		user.see_in_dark = 5
		user.lighting_alpha = 230*/
		ADD_TRAIT(user, TRAIT_SEE_IN_DARK, "night vision")
		user.update_sight()
		playsound(src, activation_sound, 100, FALSE, 3, 0.25)
		user.pa_cell.passive_energy_drain += active_energy_cost
		START_PROCESSING(SSobj, src)
		return TRUE

/obj/item/armor_module/fallout/night_vision/process()
	if(!human_owner?.pa_cell.drain_power(active_energy_cost))
		activate(human_owner)
		return PROCESS_KILL
