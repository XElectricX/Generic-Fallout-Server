//NCR
/obj/item/clothing/under/fallout/ncr
	name = "NCR trooper fatigues"
	desc = "Standard issue New California Republic Army trooper fatigues."
	icon = 'fallout/fallout icons/fallout clothing/faction_uniforms.dmi'
	item_icons = list(slot_w_uniform_str = 'fallout/fallout icons/fallout clothing/faction_uniforms_worn.dmi')
	icon_state = "ncr_uniform"
	item_state = "ncr_uniform"
	adjustment_variants = list("Open" = "_open")

/obj/item/clothing/under/fallout/ncr/officer
	name = "NCR officer fatigues"
	desc = "A standard service uniform for commissioned officers of the New California Republic Army."
	icon_state = "ncr_officer"
	item_state = "ncr_officer"
	adjustment_variants = list("Roll Up Sleeves" = "_shortsleeved")

/obj/item/clothing/under/fallout/ncr/marksman
	name = "NCR marksman fatigues"
	desc = "A standard duty uniform for snipers of the New California Republic Army."
	icon_state = "ncr_snipermgs"
	item_state = "ncr_snipermgs"
	adjustment_variants = list()

/obj/item/clothing/under/fallout/ncr/pants
	name = "NCR fatigue pants"
	desc = "A set of standard issue fatigue pants without the upper overcoat. For when you really need to show off your guns."
	icon_state = "ncr_pants"
	item_state = "ncr_pants"
	adjustment_variants = list()

/obj/item/clothing/under/fallout/ncr/shorts
	name = "NCR fatigue shorts"
	desc = "A set of uniform shorts and lightweight shirt for NCRA troopers deployed in hot climates."
	icon_state = "ncr_shorts"
	item_state = "ncr_shorts"

/obj/item/clothing/under/fallout/ncr/dress
	name = "NCR dress uniform"
	desc = "A crisp tan NCRA dress uniform, complete with tie."
	icon_state = "ncr_formal"
	item_state = "ncr_formal"
	adjustment_variants = list("Roll Up Sleeves" = "_shortsleeved")

/obj/item/clothing/under/fallout/ncr/staff
	name = "NCR operations uniform"
	desc = "Common outfit of NCRA operations staff."
	icon_state = "ncr_staff"
	item_state = "ncr_staff"
	adjustment_variants = list("Roll Up Sleeves" = "_shortsleeved")

/obj/item/clothing/under/fallout/ncr/tattered
	name = "tattered NCR fatigues"
	desc = "A disheveled and torn uniform resembling NCR fatigues."
	icon_state = "ncr_tattered"
	item_state = "ncr_tattered"
	adjustment_variants = list()

//Legion
/obj/item/clothing/under/fallout/legion
	name = "legionary fatigues"
	desc = "A long-sleeve cotton shirt with a thick leather skirt serves as the standard uniform for the Legion."
	icon = 'fallout/fallout icons/fallout clothing/faction_uniforms.dmi'
	item_icons = list(slot_w_uniform_str = 'fallout/fallout icons/fallout clothing/faction_uniforms_worn.dmi')
	icon_state = "legion_skirt"
	item_state = "legion_skirt"
	var/sleeves_adjusted = 0
	adjustment_variants = list("Roll Down Shirt" = "_half")

/obj/item/clothing/under/fallout/legion/auxillary_male
	name = "male Legion auxillary uniform"
	desc = "A short sleeved cotton robe with Legion colors. Exclusively worn by the support personnel of the Legion."
	icon_state = "legion_auxillary_m"
	item_state = "legion_auxillary_m"
	adjustment_variants = list()

/obj/item/clothing/under/fallout/legion/auxillary_female
	name = "female Legion auxillary uniform"
	desc = "A short sleeved cotton robe with Legion colors. Exclusively worn by the support personnel of the Legion."
	icon_state = "legion_auxillary_f"
	item_state = "legion_auxillary_f"
	adjustment_variants = list()

/obj/item/clothing/under/fallout/legion/priestess
	name = "priestess of Mars dress"
	desc = "The silk robes worn by a Priestess of Mars."
	icon_state = "legion_priestess"
	item_state = "legion_priestess"
	adjustment_variants = list()

/obj/item/clothing/under/fallout/legion/tattered
	name = "tattered Legionary fatigues"
	desc = "A disheveled and torn uniform resembling Legion standard fatigues."
	icon_state = "legion_tattered"
	item_state = "legion_tattered"
	adjustment_variants = list()

/obj/item/clothing/under/fallout/legion/slave_male
	name = "male Legion slave clothing"
	desc = "A roughly made long tunic, held in place by a rope. It is marked with a big red X, denoting the wearer is property of the Legion."
	icon_state = "legion_slave_m"
	item_state = "legion_slave_m"
	adjustment_variants = list()

/obj/item/clothing/under/fallout/legion/slave_female
	name = "female Legion slave clothing"
	desc = "A roughly made long tunic, held in place by a rope. It is marked with a big red X, denoting the wearer is property of the Legion."
	icon_state = "legion_slave_f"
	item_state = "legion_slave_f"
	adjustment_variants = list()

/obj/item/clothing/under/fallout/legion/robe_male
	name = "male plebian robe"
	desc = "A simple olive robe commonly worn by plebians."
	icon_state = "legion_robe_m"
	item_state = "legion_robe_m"
	adjustment_variants = list()

/obj/item/clothing/under/fallout/legion/robe_female
	name = "female plebian robe"
	desc = "A simple olive robe commonly worn by plebians."
	icon_state = "legion_robe_f"
	item_state = "legion_robe_f"
	adjustment_variants = list()

//Enclave
/obj/item/clothing/under/fallout/enclave
	name = "enclave soldier uniform"
	desc = "Khaki Enclave uniform over a black turtleneck."
	icon = 'fallout/fallout icons/fallout clothing/faction_uniforms.dmi'
	item_icons = list(slot_w_uniform_str = 'fallout/fallout icons/fallout clothing/faction_uniforms_worn.dmi')
	icon_state = "enclave_uniform"
	item_state = "enclave_uniform"
	adjustment_variants = list("Open" = "_open")

/obj/item/clothing/under/fallout/enclave/science
	name = "science officer uniform"
	desc = "White military style uniform for Enclave scientists."
	icon_state = "enclave_science"
	item_state = "enclave_science"

/obj/item/clothing/under/fallout/enclave/officer
	name = "enclave officer uniform"
	desc = "Khaki Enclave officers uniform with gold trimming over a black turtleneck."
	icon_state = "enclave_officer"
	item_state = "enclave_officer"
