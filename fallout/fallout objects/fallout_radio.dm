/obj/item/radio/fallout
	name = "handheld radio"
	icon = 'fallout/fallout icons/fallout items/fallout_tools.dmi'
	icon_state = "hand_radio_on"
	frequency = FREQ_COMMON //common chat
	broadcasting = TRUE  // Whether the radio will transmit dialogue it hears nearby.
	listening = TRUE  // Whether the radio is currently receiving.
	freerange = TRUE  // If true, the radio has access to the full spectrum.
	subspace_transmission = FALSE  // If true, the radio transmits and receives on subspace exclusively.
	subspace_switchable = TRUE  // If true, subspace_transmission can be toggled at will.
	independent = TRUE  // If true, can say/hear over non common channels without working tcomms equipment (for ERTs mostly).
