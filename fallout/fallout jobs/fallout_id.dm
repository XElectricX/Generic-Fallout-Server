//NCR
/obj/item/card/id/ncr
	name = "NCR dog tag"
	desc = "An NCR dog tag."
	icon = 'fallout/fallout icons/fallout clothing/identification.dmi'
	icon_state = "ncr"
	item_state = "dogtag"
	access = list(NCR_ACCESS)
	//iff_signal =

/obj/item/card/id/ncr/medic
	access = list(NCR_MEDIC_ACCESS)

/obj/item/card/id/ncr/engineer
	access = list(NCR_ENGINEER_ACCESS)

/obj/item/card/id/ncr/captain
	icon_state = "ncr_officer"
	access = list(NCR_CAPTAIN_ACCESS)

/obj/item/card/id/ncr/leader
	icon_state = "ncr_leader"
	access = list(NCR_LEADER_ACCESS)

/obj/item/card/id/ncr/support
	icon_state = "ncr_staff"
	access = list(NCR_SUPPORT_ACCESS)

/obj/item/card/id/ncr/examine(mob/user)
	..()
	if(ishuman(user))
		to_chat(user, span_notice("It reads \"[registered_name] - [assignment] - [blood_type]\""))

//Legion
/obj/item/card/id/legion
	name = "Legion badge"
	desc = "A medallion signifying allegiance to Caesar's Legion."
	icon = 'fallout/fallout icons/fallout clothing/identification.dmi'
	icon_state = "legion"
	item_state = "dogtag"
	access = list(LEGION_ACCESS)

/obj/item/card/id/legion/prime
	icon_state = "legion_prime"
	access = list(LEGION_PRIME_ACCESS)

/obj/item/card/id/legion/veteran
	icon_state = "legion_veteran"
	access = list(LEGION_VETERAN_ACCESS)

/obj/item/card/id/legion/decanus
	icon_state = "legion_command"
	access = list(LEGION_DECANUS_ACCESS)

/obj/item/card/id/legion/leader
	icon_state = "legion_command"
	access = list(LEGION_LEADER_ACCESS)

/obj/item/card/id/legion/support
	access = list(LEGION_SUPPORT_ACCESS)

/obj/item/card/id/legion/examine(mob/user)
	..()
	if(ishuman(user))
		to_chat(user, span_notice("It reads \"[registered_name] - [assignment] - [blood_type]\""))
