//Belts
/obj/item/storage/belt/fallout
	name = "leather belt"
	desc = "Belt with pockets."
	icon = 'fallout/fallout icons/fallout clothing/fallout_accessories.dmi'
	item_icons = list(
		slot_belt_str = 'fallout/fallout icons/fallout clothing/fallout_accessories_worn.dmi',
		slot_l_hand_str = 'fallout/fallout icons/fallout inhands/left_misc_clothing.dmi',
		slot_r_hand_str = 'fallout/fallout icons/fallout inhands/right_misc_clothing.dmi')
	icon_state = "belt"
	item_state = "belt"
	w_class = WEIGHT_CLASS_NORMAL
	max_w_class = WEIGHT_CLASS_SMALL
	storage_slots = null
	max_storage_space = 8

//Regular belt but better, needs a unique mechanic at a later date
/obj/item/storage/belt/fallout/assault
	name = "assault belt"
	desc = "Tactical belt with planty of pockets and clips."
	icon_state = "belt_assault"
	item_state = "belt_assault"
	max_storage_space = 10

/obj/item/storage/belt/fallout/ncr
	name = "\improper NCR belt"
	desc = "Cotton belt with various pouches and clips."
	icon = 'fallout/fallout icons/fallout clothing/faction_accessories.dmi'
	item_icons = list(slot_belt_str = 'fallout/fallout icons/fallout clothing/faction_accessories_worn.dmi')
	icon_state = "belt_ncr"
	item_state = "belt_ncr"

/obj/item/storage/belt/fallout/legion
	name = "\improper Legion belt"
	desc = "Leather belt with a decorative sash denoting Legion soldiers."
	icon = 'fallout/fallout icons/fallout clothing/faction_accessories.dmi'
	item_icons = list(slot_belt_str = 'fallout/fallout icons/fallout clothing/faction_accessories_worn.dmi')
	icon_state = "belt_legion"
	item_state = "belt_legion"

/obj/item/storage/belt/fallout/tools
	name = "toolbelt"
	desc = "Holds tools around your waist. Handy."
	icon_state = "belt_tools"
	item_state = "belt_tools"
	storage_slots = 7
	max_storage_space = 14
	can_hold = list(
		/obj/item/tool/crowbar,
		/obj/item/tool/screwdriver,
		/obj/item/tool/weldingtool,
		/obj/item/tool/wirecutters,
		/obj/item/tool/wrench,
		/obj/item/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/tool/taperoll/engineering)

/obj/item/storage/belt/fallout/tools/full/Initialize()
	. = ..()
	new /obj/item/tool/screwdriver(src)
	new /obj/item/tool/wrench(src)
	new /obj/item/tool/weldingtool(src)
	new /obj/item/tool/crowbar(src)
	new /obj/item/tool/wirecutters(src)
	new /obj/item/stack/cable_coil(src,30,pick("red","yellow","orange"))
	new /obj/item/multitool(src)

/obj/item/storage/belt/fallout/medical
	name = "medical supplies belt"
	desc = "Storage solution for the medic on the go."
	icon_state = "belt_medical"
	item_state = "belt_medical"
	storage_slots = 7
	max_storage_space = 14
	can_hold = list(/obj/item/weapon/gun/fallout_pistol, /obj/item/ammo_magazine/fallout_pistol)

/obj/item/storage/belt/fallout/medical/full/Initialize()
	. = ..()
	new /obj/item/storage/pill_bottle/bicaridine(src)
	new /obj/item/storage/pill_bottle/kelotane(src)
	new /obj/item/storage/pill_bottle/tramadol(src)
	new /obj/item/storage/pill_bottle/dylovene(src)
	new /obj/item/storage/pill_bottle/inaprovaline(src)
	new /obj/item/storage/pill_bottle/dexalin(src)
	new /obj/item/healthanalyzer(src)

/obj/item/storage/belt/fallout/holster
	name = "pistol holster belt"
	desc = "Waist belt with a holster and 3 magazine pockets attached."
	max_w_class = WEIGHT_CLASS_NORMAL
	storage_slots = 3
	max_storage_space = 7
	can_hold = list(/obj/item/weapon/gun/fallout_pistol, /obj/item/ammo_magazine/fallout_pistol)

	//The gun it holds, used for referencing later so we can update the icon.
	//Will need worn sprites and such later, for now most of this is not doing anything
	var/obj/item/weapon/gun/current_gun
	var/image/gun_underlay
	var/sheatheSound = 'sound/weapons/guns/misc/pistol_sheathe.ogg'
	var/drawSound = 'sound/weapons/guns/misc/pistol_draw.ogg'

/obj/item/storage/belt/fallout/holster/Destroy()
	if(gun_underlay)
		qdel(gun_underlay)
		gun_underlay = null
	if(current_gun)
		qdel(current_gun)
		current_gun = null
	return ..()

/obj/item/storage/belt/fallout/holster/attack_hand(mob/living/user)
	if(current_gun && ishuman(user) && loc == user)
		current_gun.attack_hand(user)
	else
		return ..()

//Will only draw the specific holstered item, not ammo etc.
/obj/item/storage/belt/fallout/holster/do_quick_equip()
	if(!current_gun)
		return FALSE
	var/obj/item/W = current_gun
	remove_from_storage(W, user = src)
	return W

//Bandoliers
/obj/item/storage/belt/fallout/bandolier
	name = "bandolier"
	desc = "Hold individual shells and bullets."
	icon_state = "bandolier"
	item_state = "bandolier"
	storage_slots = 7
	max_storage_space = 7
	can_hold = list(/obj/item/ammo_magazine/handful)	//You only put handfuls into this

/obj/item/storage/belt/fallout/bandolier/alt
	name = "leather bandolier"
	icon_state = "bandolier_alt"
	item_state = "bandolier_alt"
