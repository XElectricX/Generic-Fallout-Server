/obj/machinery/microwave/fallout
	name = "microwave"
	desc = "Revolutionary home appliance. Near-instant heating of food!"
	icon = 'fallout/fallout icons/fallout structures/fallout_machinery.dmi'
	icon_state = "mw"

/obj/machinery/microwave/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(isscrewdriver(I))
		TOGGLE_BITFIELD(machine_stat, PANEL_OPEN)
		to_chat(user, "You [CHECK_BITFIELD(machine_stat, PANEL_OPEN) ? "open" : "close"] the maintenance panel.")
		overlays.Cut()
		if(CHECK_BITFIELD(machine_stat, PANEL_OPEN))
			overlays += image(icon, "[initial(icon_state)]_panel")
		updateUsrDialog()

/obj/machinery/processor/fallout
	name = "chopping block"
	desc = "Old-fashioned way of preparing food."
	icon = 'fallout/fallout icons/fallout structures/fallout_machinery.dmi'
	icon_state = "chopping_block"
	use_power = NO_POWER_USE

/obj/machinery/grill/fallout
	icon = 'fallout/fallout icons/fallout structures/fallout_machinery.dmi'

/obj/machinery/reagentgrinder/fallout
	icon = 'fallout/fallout icons/fallout structures/fallout_machinery.dmi'

/obj/machinery/cell_charger/fallout
	icon = 'fallout/fallout icons/fallout structures/fallout_machinery.dmi'
