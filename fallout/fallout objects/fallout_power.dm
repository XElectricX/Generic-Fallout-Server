//Our APC
/obj/machinery/power/apc/fallout
	req_access = list()
	cell_type = /obj/item/cell/fallout/ecp
	start_charge = 100

/obj/machinery/power/apc/fallout/fission_battery
	cell_type = /obj/item/cell/fallout/fission

/obj/machinery/power/apc/fallout/fusion_core
	cell_type = /obj/item/cell/fallout

//Cell charger
/obj/machinery/cell_charger/fallout
	name = "cell recharger"
	desc = "Crude machine designed to recharge spent batteries and cells."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'

//Power cells
/obj/item/cell/fallout
	name = "fusion core"
	desc = "A specialized high density battery used to power lasguns."
	icon = 'fallout/fallout icons/fallout weapons/fallout_ammunition.dmi'
	icon_state = "fusion_core"
	item_state = "fusion_core"
	charge_overlay = "fusion_core"
	w_class = WEIGHT_CLASS_SMALL
	///How much energy gets drained per action while in power armor; sum of all armor piece energy costs
	var/action_energy_drain = 0
	///How much energy gets drained while using modules in power armor; sum of all active module energy costs
	var/passive_energy_drain = 0
	maxcharge = 30000
	//materials = list(/datum/material/metal = 5000)
	/*	Gun-related stuff for when energy guns are implemented
	var/reload_delay = 0
	///Magazine flags.
	var/flags_magazine_features = MAGAZINE_REFUND_IN_CHAMBER
	///if the magazine has a special overlay associated with it, i.e. extended mags etc
	var/bonus_overlay = null	*/

//No overlays yet
/obj/item/cell/fallout/update_overlays()
	..()

///Calculates energy consumption
/obj/item/cell/fallout/proc/drain_power(power_usage)
	if(charge < power_usage)
		return FALSE
	else
		return charge -= power_usage

/obj/item/cell/fallout/fission
	name = "fission battery"
	desc = "Pre-War portable power source, often found in machinery and devices."
	icon_state = "fission_battery"
	item_state = "fission_battery"
	charge_overlay = "fission_battery"
	w_class = WEIGHT_CLASS_TINY
	maxcharge = 1000
	//materials = list(/datum/material/metal = 500)

/obj/item/cell/fallout/mfc
	name = "microfusion cell"
	desc = "Best in portable power storage, second only to fusion cores. Has a high maximum charge and is used in most energy weapons."
	icon_state = "mfc"
	item_state = "mfc"
	charge_overlay = "mfc"
	w_class = WEIGHT_CLASS_TINY
	maxcharge = 10000
	//materials = list(/datum/material/metal = 1000)

/obj/item/cell/fallout/ecp
	name = "electron charge pack"
	desc = "An array of small energy cells assembled inside a casing. Larger and holds less charge than microfusion cells, but more common."
	icon_state = "ecp"
	item_state = "ecp"
	charge_overlay = "ecp"
	maxcharge = 5000
	//materials = list(/datum/material/metal = 2000)
