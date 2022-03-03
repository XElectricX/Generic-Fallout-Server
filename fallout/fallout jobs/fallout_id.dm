//NCR
/obj/item/card/id/ncr
	name = "NCR dog tag"
	desc = "An NCR dog tag."
	access = list(NCR_ACCESS)
	icon_state = "dogtag"
	item_state = "dogtag"
	//iff_signal =

/obj/item/card/id/ncr/medic
	access = list(NCR_MEDIC_ACCESS)

/obj/item/card/id/ncr/engineer
	access = list(NCR_ENGINEER_ACCESS)

/obj/item/card/id/ncr/captain
	access = list(NCR_CAPTAIN_ACCESS)

/obj/item/card/id/ncr/leader
	access = list(NCR_LEADER_ACCESS)

/obj/item/card/id/ncr/support
	access = list(NCR_SUPPORT_ACCESS)

/obj/item/card/id/ncr/examine(mob/user)
	..()
	if(ishuman(user))
		to_chat(user, span_notice("It reads \"[registered_name] - [assignment] - [blood_type]\""))

//Legion
/obj/item/card/id/legion
	name = "Legion badge"
	desc = "A roughly-made Legion badge with writing on paper over a leather frame."
	access = list(LEGION_ACCESS)
	icon_state = "dogtag"
	item_state = "dogtag"
	//iff_signal =

/obj/item/card/id/legion/prime
	access = list(LEGION_PRIME_ACCESS)

/obj/item/card/id/legion/veteran
	access = list(LEGION_VETERAN_ACCESS)

/obj/item/card/id/legion/decanus
	access = list(LEGION_DECANUS_ACCESS)

/obj/item/card/id/legion/leader
	access = list(LEGION_LEADER_ACCESS)

/obj/item/card/id/legion/support
	access = list(LEGION_SUPPORT_ACCESS)

/obj/item/card/id/legion/examine(mob/user)
	..()
	if(ishuman(user))
		to_chat(user, span_notice("It reads \"[registered_name] - [assignment] - [blood_type]\""))
