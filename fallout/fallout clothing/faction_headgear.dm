//NCR helmets
/obj/item/clothing/head/helmet/fallout/ncr
	name = "NCR trooper helmet"
	desc = "A standard issue NCRA steel helmet."
	icon = 'fallout/fallout icons/fallout clothing/faction_headgear.dmi'
	item_icons = list(slot_head_str = 'fallout/fallout icons/fallout clothing/faction_headgear_worn.dmi')
	icon_state = "ncr_helmet"
	item_state = "ncr_helmet"

/obj/item/clothing/head/helmet/fallout/ncr/goggles
	name = "NCR storm helmet"
	desc = "A standard issue NCRA steel helmet, issued with a pair of storm goggles for weather resistance."
	icon_state = "ncr_helmet_goggles"
	item_state = "ncr_helmet_goggles"

/obj/item/clothing/head/helmet/fallout/ncr/helmet_engineer
	name = "NCR engineer helmet"
	desc = "A helmet issued to NCRA field engineers. Bears resemblance to a hard hat, but this one can stop bullets!"
	icon_state = "ncr_helmet_engineer"
	item_state = "ncr_helmet_engineer"
	light_range = 5
	light_power = 4
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/head/helmet/fallout/ncr/helmet_engineer/Initialize()
	. = ..()
	GLOB.nightfall_toggleable_lights += src

/obj/item/clothing/head/helmet/fallout/ncr/helmet_engineer/Destroy()
	GLOB.nightfall_toggleable_lights -= src
	return ..()

/obj/item/clothing/head/helmet/fallout/ncr/helmet_engineer/attack_self(mob/user)
	if(!isturf(user.loc))
		to_chat(user, "You cannot turn the light on while in [user.loc]")
		return
	turn_light(user, !light_on)

/obj/item/clothing/head/helmet/fallout/ncr/helmet_engineer/turn_light(mob/user, toggle_on)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	set_light_on(toggle_on)
	if(user == loc)
		var/mob/M = loc
		M.update_inv_head()
	update_action_button_icons()
	update_icon()

/obj/item/clothing/head/helmet/fallout/ncr/helmet_medic
	name = "NCR medic helmet"
	desc = "A standard issue NCRA helmet with a red cross denoting a medic."
	icon_state = "ncr_helmet_medic"
	item_state = "ncr_helmet_medic"

/obj/item/clothing/head/helmet/fallout/ncr/helmet_mp
	name = "NCR military police helmet"
	desc = "A standard issue NCRA helmet emblazoned with the initials of the military police."
	icon_state = "ncr_helmet_mp"
	item_state = "ncr_helmet_mp"

/obj/item/clothing/head/helmet/fallout/ncr/helmet_gambler
	name = "NCR gambler helmet"
	desc = "A standard issue NCRA infantry helmet with playing cards strapped to it."
	icon_state = "ncr_helmet_gambler"
	item_state = "ncr_helmet_gambler"

/obj/item/clothing/head/helmet/fallout/ncr/helmet_bandolier
	name = "NCR bandolier helmet"
	desc = "A standard issue NCRA infantry helmet with bullet casings strapped to it."
	icon_state = "ncr_helmet_bandolier"
	item_state = "ncr_helmet_bandolier"

/obj/item/clothing/head/helmet/fallout/ncr/patrol
	name = "NCR heavy patrol helmet"
	desc = "A combat helmet hand-manufactured with heavy materials in the NCRA. Designed to be used in active war zones."
	icon_state = "ncr_patrol_helmet"
	item_state = "ncr_patrol_helmet"

/obj/item/clothing/head/helmet/fallout/ncr/ranger
	name = "NCR ranger helmet"
	desc = "The distinctive helmet of NCRA Rangers. Combines a pre-war riot helmet with old military technology to create one of the most advanced helmets in the wasteland."
	icon_state = "ncr_ranger"
	item_state = "ncr_ranger"

/obj/item/clothing/head/helmet/fallout/ncr/ranger_desert
	name = "NCR desert ranger helmet"
	desc = "A standard NCRA ranger helmet modified for dealing with arid desert environments."
	icon_state = "ncr_ranger_desert"
	item_state = "ncr_ranger_desert"

//Map spawn only, should be something good to secure
/obj/item/clothing/head/helmet/fallout/ncr/ranger_elite
	name = "elite riot gear helmet"
	desc = "Prestigious helmet only issued to the very best of the NCRA Rangers. Outfitted with advanced polymers to make the sturdiest possible helmet and experimental military electronics."
	icon_state = "ncr_ranger_elite"
	item_state = "ncr_ranger_elite"

/obj/item/clothing/head/helmet/fallout/ncr/combat
	name = "NCR combat helmet"
	desc = "An old military grade pre-war combat helmet, repainted to the colour scheme of the New California Republic."
	icon_state = "ncr_combathelmet"
	item_state = "ncr_combathelmet"

/obj/item/clothing/head/helmet/fallout/ncr/combat_mk2
	name = "reinforced NCR combat helmet"
	desc = "An advanced pre-war titanium plated, ceramic coated, kevlar, padded helmet designed to withstand extreme punishment of all forms, repainted to the colour scheme of the New California Republic."
	icon_state = "ncr_combathelmet_mk2"
	item_state = "ncr_combathelmet_mk2"

//NCR hats
/obj/item/clothing/head/fallout/ncr
	name = "NCR garrison cap"
	desc = "A simple cloth garrison cap to be worn when a helmet isn't necessary."
	icon = 'fallout/fallout icons/fallout clothing/faction_headgear.dmi'
	item_icons = list(slot_head_str = 'fallout/fallout icons/fallout clothing/faction_headgear_worn.dmi')
	icon_state = "ncr_cap"
	item_state = "ncr_cap"

/obj/item/clothing/head/fallout/ncr/flapcap
	name = "NCR field cap"
	desc = "A special issue canvas NCR field cap with cotton neckflap, for sun protection in arid climates."
	icon_state = "ncr_flapcap"
	item_state = "ncr_flapcap"

/obj/item/clothing/head/fallout/ncr/hat_slouch
	name = "NCR slouch hat"
	desc = "An irregular issue NCR sun hat, the left side of the brim is pinned to the crown for ease with shouldering rifles."
	icon_state = "ncr_hat_slouch"
	item_state = "ncr_hat_slouch"

/obj/item/clothing/head/fallout/ncr/beret
	name = "NCR SOF beret"
	desc = "A brown beret issued to NCRA infantry."
	icon_state = "ncr_beret"
	item_state = "ncr_beret"

/obj/item/clothing/head/fallout/ncr/beret_engineering
	name = "NCR Sapper beret"
	desc = "A grey beret, issued to field engineers of the NCRA."
	icon_state = "ncr_beret_engineering"
	item_state = "ncr_beret_engineering"

/obj/item/clothing/head/fallout/ncr/beret_medical
	name = "NCR medical beret"
	desc = "A white beret, issued to medical personnel."
	icon_state = "ncr_beret_medical"
	item_state = "ncr_beret_medical"

/obj/item/clothing/head/fallout/ncr/beret_recon
	name = "NCR recon beret"
	desc = "A red beret, issued to NCR scouts."
	icon_state = "ncr_beret_recon"
	item_state = "ncr_beret_recon"

/obj/item/clothing/head/fallout/ncr/beret_officer
	name = "NCR officer beret"
	desc = "A green beret, standard issue for all commissioned NCRA officers."
	icon_state = "ncr_beret_officer"
	item_state = "ncr_beret_officer"

/obj/item/clothing/head/fallout/ncr/beret_staff
	name = "NCR logistics beret"
	desc = "A tan beret, issued to members of the Field Preparations Division."
	icon_state = "ncr_beret_staff"
	item_state = "ncr_beret_staff"

/obj/item/clothing/head/fallout/ncr/hat_officer
	name = "NCR officer hat"
	desc = "A khaki hat popular among officers in the NCRA."
	icon_state = "ncr_hat_officer"
	item_state = "ncr_hat_officer"

/obj/item/clothing/head/fallout/ncr/formal_cap
	name = "NCR formal cap"
	desc = "A tan peaked cap with a silver pin."
	icon_state = "ncr_dresscap"
	item_state = "ncr_dresscap"

//Legion helmets
/obj/item/clothing/head/helmet/fallout/legion
	name = "Legion recruit helmet "
	desc = "A leather skullcap issued to recruits."
	icon = 'fallout/fallout icons/fallout clothing/faction_headgear.dmi'
	item_icons = list(slot_head_str = 'fallout/fallout icons/fallout clothing/faction_headgear_worn.dmi')
	icon_state = "legion_recruit"
	item_state = "legion_recruit"

/obj/item/clothing/head/helmet/fallout/legion/prime
	name = "Legion prime helmet"
	desc = "A leather helmet with a red peak."
	item_state = "legion_prime"
	icon_state = "legion_prime"

/obj/item/clothing/head/helmet/fallout/legion/explorer
	name = "legion explorer hood"
	desc = "A leather hood with metal reinforcements."
	icon_state = "legion_explorer"
	item_state = "legion_explorer"

/obj/item/clothing/head/helmet/fallout/legion/veteran
	name = "Legion veteran helmet"
	desc = "A metallic helmet used by Legion veterans, offering more protection than the helmets of recruits and primes."
	icon_state = "legion_veteran"
	item_state = "legion_veteran"

/obj/item/clothing/head/helmet/fallout/legion/vexillarius
	name = "Legion fox vexillarius helmet"
	desc = "This helmet is decorated with the pelt of a desert fox."
	icon_state = "legion_vexillarius"
	item_state = "legion_vexillarius"

/obj/item/clothing/head/helmet/fallout/legion/vexillarius/alt
	name = "Legion bear vexillarius helmet"
	desc = "This helmet is decorated with the pelt of a ashland bear."
	icon_state = "legion_vexillarius_alt"
	item_state = "legion_vexillarius_alt"

/obj/item/clothing/head/helmet/fallout/legion/slavemaster
	name = "Legion slavemaster helmet"
	desc = "The distinct helmet used by slavemasters."
	icon_state = "legion_slavemaster"
	item_state = "legion_slavemaster"

/obj/item/clothing/head/helmet/fallout/legion/venator
	name = "Legion venator hood"
	desc = "A leather hood with a sturdy metal skullcap and a gold bull insignia in the front."
	icon_state = "legion_metal"
	item_state = "legion_venator"	//Need a more metallic helmet sprite for a full metal set of armor

/obj/item/clothing/head/helmet/fallout/legion/heavy
	name = "Legion heavy helmet"
	desc = "A pre-war riot helmet modified with metal plates and a plume of feathers on top. Issued to Legion infantry who's lives have worth."
	icon_state = "legion_heavy"
	item_state = "legion_heavy"
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/head/helmet/fallout/legion/decanus
	name = "Legion recruit decanus helmet"
	desc = "This reinforced leather helmet has a plume of black and dark red feathers."
	icon_state = "legion_decanus"
	item_state = "legion_decanus"

/obj/item/clothing/head/helmet/fallout/legion/decanus_prime
	name = "Legion prime decanus helmet"
	desc = "This reinforced leather helmet with a red peak has a plume of black feathers."
	item_state = "legion_decanus_prime"
	icon_state = "legion_decanus_prime"

/obj/item/clothing/head/helmet/fallout/legion/decanus_veteran
	name = "reinforced legion veteran decanus helmet"
	desc = "A metal helmet with an array of red, white and black feathers, unmistakably a Veteran Decanus."
	icon_state = "legion_decanus_veteran"
	item_state = "legion_decanus_veteran"

/obj/item/clothing/head/helmet/fallout/legion/centurion
	name = "Centurion helmet"
	desc = "A sturdy helmet from steel and brass with a red horizontal plume."
	icon_state = "legion_centurion"
	item_state = "legion_centurion"

/obj/item/clothing/head/helmet/fallout/legion/centurion_ranger
	name = "Centurion Ranger-hunter helmet"
	desc = "The helmet of an NCR ranger, refit to serve as a Centurions helmet."
	icon_state = "legion_centurion_ranger"
	item_state = "legion_centurion_ranger"

/obj/item/clothing/head/helmet/fallout/legion/centurion_powerarmor
	name = "Centurion Paladin-slayer helmet"
	desc = "The once-marvelous helmet of the T-45d power armor set, repurposed by the Legion into a symbol of its might. It has a large plume of red horse hair across the top of it going horizontally, donoting the rank of Centurion."
	icon_state = "legion_centurion_powerarmor"
	item_state = "legion_centurion_powerarmor"

/obj/item/clothing/head/helmet/fallout/legion/legate
	name = "Legate helmet"
	desc = "A custom forged steel full helmet complete with abstract points and arches. The face is extremely intimidating, as it was meant to be. This particular one was ordered to be forged by Caesar, given to his second legate in exchange for his undying loyalty to Caesar."
	icon_state = "legion_legate"
	item_state = "legion_legate"
/* Commented out pending balance concerns, and the suit needs a better sprite
/obj/item/clothing/head/helmet/fallout/legion/combat
	name = "Legion combat helmet"
	desc = "An old military grade pre-war helmet, repainted to the colour scheme of Caesar's Legion."
	icon_state = "legion-combat"
	item_state = "legion-combat"

/obj/item/clothing/head/helmet/fallout/legion/combat_mk2
	name = "reinforced Legion combat helmet"
	desc = "A pre-war helmet in good condition, made from advanced materialas and paintend in the colors of Caesar's Legion."
	icon_state = "legion_combathelmet_mk2"
	item_state = "legion-combathelmet_mk2"
*/
//Legion hats
/obj/item/clothing/head/fallout/legion
	name = "Legion auxillary cap"
	desc = "A soft red cap with a black band, used by Legion auxillary personnel."
	icon = 'fallout/fallout icons/fallout clothing/faction_headgear.dmi'
	item_icons = list(slot_head_str = 'fallout/fallout icons/fallout clothing/faction_headgear_worn.dmi')
	icon_state = "legion_auxillary"
	item_state = "legion_auxillary"

/obj/item/clothing/head/fallout/legion/headdress
	name = "patrician headdress"
	desc = "A headdress made of feathers and decorated with two golden tassles."
	icon_state = "legion_headdress"
	item_state = "legion_headdress"

/obj/item/clothing/head/fallout/legion/slave
	name = "Legion slave headwear"
	desc = "A simple uncoloured linen cloth wrapped around the head, the mark of a servant slave trained in household work."
	icon_state = "legion_slave"
	item_state = "legion_slave"

//Enclave
/obj/item/clothing/head/fallout/enclave
	name = "Enclave cap"
	desc = "Standard issue cap provided to Enclave soldiers."
	icon = 'fallout/fallout icons/fallout clothing/faction_headgear.dmi'
	item_icons = list(slot_head_str = 'fallout/fallout icons/fallout clothing/faction_headgear_worn.dmi')
	icon_state = "enclave_cap"
	item_state = "enclave_cap"

/obj/item/clothing/head/fallout/enclave/beret
	name = "Enclave beret"
	desc = "A black beret used by Enclave personnel."
	icon_state = "enclave_beret"
	item_state = "enclave_beret"

/obj/item/clothing/head/fallout/enclave/beret_science
	name = "Enclave science beret"
	desc = "Blue beret signifying the wearer is a Science Officer of the Enclave."
	icon_state = "enclave_beret_science"
	item_state = "enclave_beret_science"

/obj/item/clothing/head/fallout/enclave/officer
	name = "Enclave officer cap"
	desc = "A black, military-style cap. Symbols of authority for Enclave officers."
	icon_state = "enclave_cap_officer"
	item_state = "enclave_cap_officer"
