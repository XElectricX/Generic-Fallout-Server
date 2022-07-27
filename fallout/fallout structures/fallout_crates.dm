//Crates that can be toggled open, store things inside
/obj/structure/closet/fallout/crate
	name = "crate"
	desc = "A rectangular wooden crate."
	icon = 'fallout/fallout icons/fallout structures/fallout_crates.dmi'
	icon_state = "crate"
	anchored = FALSE
	mob_storage_capacity = 2
	storage_capacity = 60
	closet_flags = CLOSET_ALLOW_OBJS

/obj/structure/closet/fallout/crate/open(mob/living/user)
	. = ..()
	density = TRUE	//Crates cannot be walked over

/obj/structure/closet/fallout/crate/wood
	name = "wooden crate"
	desc = "A large crate made from planks."
	icon_state = "crate_wood"

/obj/structure/closet/fallout/crate/medical
	name = "medical crate"
	desc = "Insulated and semi-sterile crate that can keep medical supplies safe."
	icon_state = "crate_medical"

/obj/structure/closet/fallout/crate/metal
	name = "metal crate"
	desc = "A simple crate."
	icon_state = "crate_metal"

/obj/structure/closet/fallout/crate/plasteel
	name = "plasteel crate"
	desc = "Sturdy crate made out of plasteel."
	icon_state = "crate_plasteel"

/obj/structure/closet/fallout/crate/ammo
	name = "ammo crate"
	desc = "For safe transportation of munitions and explosives."
	icon_state = "crate_ammo"

/obj/structure/closet/fallout/crate/equipment
	name = "equipment crate"
	desc = "Usually contains important gear."
	icon_state = "crate_equipment"

/obj/structure/closet/fallout/crate/radioactive
	name = "radioactive materials crate"
	desc = "Probably shouldn't touch this."
	icon_state = "crate_radioactive"

/obj/structure/closet/fallout/crate/freezer
	name = "freezer crate"
	desc = "Insulated crate to keep perishables good for a while."
	icon_state = "crate_freezer"

/obj/structure/closet/fallout/crate/vault
	name = "\improper Vault-Tec crate"
	desc = "Official storage of Vault-Tec."
	icon_state = "crate_vault"

/obj/structure/closet/fallout/crate/vault/yellow
	icon_state = "crate_vault_yellow"

/obj/structure/closet/fallout/crate/footlocker
	name = "foot locker"
	desc = "Good for keeping your stuff in one place."
	icon_state = "crate_footlocker"

/obj/structure/closet/fallout/crate/chest
	name = "wooden chest"
	desc = "Ya found me booty."
	icon_state = "crate_chest"

/obj/structure/closet/fallout/crate/trash
	name = "trash can"
	desc = "Metal can that keeps trash out of sight. Stinks."
	icon_state = "crate_trash"
	anchored = TRUE

/obj/structure/closet/fallout/crate/bin
	name = "trash bin"
	desc = "Pre-war container that people used for keeping trash in."
	icon_state = "crate_bin"
	anchored = TRUE

/obj/structure/closet/fallout/crate/basket
	name = "basket"
	desc = "Traditional storage container made from wicker."
	icon_state = "crate_basket"

/obj/structure/closet/fallout/crate/floorsafe
	name = "floor safe"
	desc = "Secure storage of valuables while also being hidden."
	icon_state = "crate_floorsafe"
	anchored = TRUE

/obj/structure/closet/fallout/crate/coffin
	name = "coffin"
	desc = "Burying the dead in comfort."
	icon_state = "crate_coffin"

//Carts, crates with wheels
/obj/structure/closet/fallout/crate/cart
	name = "cart"
	desc = "A storage container on wheels."
	icon_state = "cart"
	mob_storage_capacity = 1
	storage_capacity = 30

/obj/structure/closet/fallout/crate/cart/medical
	name = "medical cart"
	icon_state = "cart_medical"

/obj/structure/closet/fallout/crate/cart/engineering
	name = "engineering cart"
	icon_state = "cart_engineering"

/obj/structure/closet/fallout/crate/cart/trash
	name = "trash cart"
	desc = "Speedy transportation of junk."
	icon_state = "cart_trash"

/obj/structure/closet/fallout/crate/cart/military
	name = "military cart"
	icon_state = "cart_military"

/obj/structure/closet/fallout/crate/cart/freezer
	name = "freezer cart"
	icon_state = "cart_freezer"

//Crates that you can only pry open, come with goodies
/obj/structure/fallout_crate
	name = "old wooden crate"
	desc = "Sealed crate, likely pre-war. Could be pried open with a crowbar."
	icon = 'fallout/fallout icons/fallout structures/fallout_crates.dmi'
	icon_state = "wooden_crate"
	var/list/supplies = list()

//Taken from largecrate.dm, want this to be its own thing
/obj/structure/fallout_crate/Initialize()
	. = ..()
	if(supplies.len)
		for(var/s in supplies)
			var/amount = supplies[s]
			for(var/i = 1, i <= amount, i++)
				new s (src)

/obj/structure/fallout_crate/supply
	name = "supply crate"
	desc = "Could have ammo, could have medicines, could have plushies. Who knows?"
	icon_state = "supply_crate"
	supplies = list()

/obj/structure/fallout_crate/supply/strapped
	icon_state = "supply_crate_strapped"

/obj/structure/fallout_crate/supply/weapons
	icon_state = "weapons_crate"

/obj/structure/fallout_crate/case
	name = "supply case"
	desc = "Looks like it is locked tight. Pry it open to collect what's inside!"
	icon_state = "supply_case"
	supplies = list()

/obj/structure/fallout_crate/case/double
	name = "supply cases"
	icon_state = "supply_case_double"

/obj/structure/fallout_crate/case/small
	name = "small supply cases"
	icon_state = "supply_case_small"

/obj/structure/fallout_crate/barrel
	name = "metallic barrel"
	desc = "An old metal drum, could have anything inside. Pop it open with a crowbar!"
	icon_state = "barrel_blue"
	supplies = list()

/obj/structure/fallout_crate/barrel/green
	icon_state = "barrel_green"

/obj/structure/fallout_crate/barrel/red
	icon_state = "barrel_red"

/obj/structure/fallout_crate/barrel/yellow
	icon_state = "barrel_yellow"

/obj/structure/fallout_crate/barrel/white
	icon_state = "barrel_white"
