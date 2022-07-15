//default wastelander
/datum/outfit/job/fallout
	name = WASTELANDER
	w_uniform = /obj/item/clothing/under/fallout
	back = /obj/item/storage/backpack/fallout
	shoes = /obj/item/clothing/shoes/black

//NCR
/datum/outfit/job/fallout/ncr
	name = NCR_PRIVATE
	w_uniform = /obj/item/clothing/under/fallout/ncr
	wear_suit = /obj/item/clothing/suit/storage/fallout/ncr
	back = /obj/item/storage/backpack/fallout/trekker
	belt =	/obj/item/storage/belt/gun/fallout
	gloves = /obj/item/clothing/gloves/marine
	shoes = /obj/item/clothing/shoes/marine/full
	head = /obj/item/clothing/head/helmet/fallout/ncr
	id = /obj/item/card/id/ncr
	l_store = /obj/item/storage/pouch/fallout/medical/full
	r_store = /obj/item/storage/pouch/fallout/magazine
	suit_store = /obj/item/weapon/gun/fallout_rifle

/datum/outfit/job/fallout/ncr/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/fallout_pistol, SLOT_IN_B_HOLSTER)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol, SLOT_IN_BELT)

/datum/outfit/job/fallout/ncr/medic
	name = NCR_MEDIC
	back = /obj/item/storage/backpack/marine/satchel/corpsman
	belt = /obj/item/storage/belt/fallout/medical/full
	head = /obj/item/clothing/head/helmet/fallout/ncr/helmet_medic
	glasses = /obj/item/clothing/glasses/hud/health
	id = /obj/item/card/id/ncr/medic
	l_store = /obj/item/ammo_magazine/rifle/standard_carbine
	r_store = /obj/item/ammo_magazine/rifle/standard_carbine
	suit_store = /obj/item/weapon/gun/rifle/standard_carbine
	r_hand = /obj/item/ammo_magazine/rifle/standard_carbine
	l_hand = /obj/item/ammo_magazine/rifle/standard_carbine

/datum/outfit/job/fallout/ncr/engineer
	name = NCR_ENGINEER
	back = /obj/item/storage/backpack/marine/satchel/tech
	belt = /obj/item/storage/belt/fallout/tools/full
	gloves = /obj/item/clothing/gloves/marine/insulated
	head = /obj/item/clothing/head/helmet/fallout/ncr/helmet_engineer
	id = /obj/item/card/id/ncr/engineer
	l_store = /obj/item/ammo_magazine/smg/standard_smg
	r_store = /obj/item/ammo_magazine/smg/standard_smg
	suit_store = /obj/item/weapon/gun/smg/standard_smg
	r_hand = /obj/item/ammo_magazine/smg/standard_smg
	l_hand = /obj/item/ammo_magazine/smg/standard_smg

/datum/outfit/job/fallout/ncr/captain
	name = NCR_CAPTAIN
	w_uniform = /obj/item/clothing/under/fallout/ncr/officer
	wear_suit = /obj/item/clothing/suit/storage/fallout/ncr/officer
	id = /obj/item/card/id/ncr/captain
	l_store = /obj/item/ammo_magazine/rifle/standard_skirmishrifle
	r_store = /obj/item/ammo_magazine/rifle/standard_skirmishrifle
	suit_store = /obj/item/weapon/gun/rifle/standard_skirmishrifle
	r_hand = /obj/item/ammo_magazine/rifle/standard_skirmishrifle
	l_hand = /obj/item/ammo_magazine/rifle/standard_skirmishrifle

/datum/outfit/job/fallout/ncr/leader
	name = NCR_LEADER
	w_uniform = /obj/item/clothing/under/fallout/ncr/officer
	wear_suit = /obj/item/clothing/suit/storage/fallout/ncr/officer_reinforced
	id = /obj/item/card/id/ncr/leader
	l_store = /obj/item/ammo_magazine/rifle/tx11
	r_store = /obj/item/ammo_magazine/rifle/tx11
	suit_store = /obj/item/weapon/gun/rifle/tx11
	r_hand = /obj/item/ammo_magazine/rifle/tx11
	l_hand = /obj/item/ammo_magazine/rifle/tx11

/datum/outfit/job/fallout/ncr/support
	name = NCR_SUPPORT
	w_uniform = /obj/item/clothing/under/fallout/ncr/staff
	wear_suit = null
	back = /obj/item/storage/backpack/satchel/norm
	belt =	null
	gloves = null
	shoes = /obj/item/clothing/shoes/black
	head = /obj/item/clothing/head/fallout/ncr/beret_staff
	id = /obj/item/card/id/ncr/support
	l_store = null
	r_store = null
	suit_store = null
	r_hand = null
	l_hand = null

//Legion
/datum/outfit/job/fallout/legion
	name = LEGION_RECRUIT
	w_uniform = /obj/item/clothing/under/fallout/legion
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion
	back = /obj/item/storage/backpack/satchel
	belt = /obj/item/weapon/gun/pistol/g22
	gloves = /obj/item/clothing/gloves/marine
	shoes = /obj/item/clothing/shoes/marine/full
	head = /obj/item/clothing/head/helmet/fallout/legion
	id = /obj/item/card/id/legion
	l_store = /obj/item/storage/pouch/magazine/pistol
	r_store = /obj/item/ammo_magazine/pistol/g22
	suit_store = /obj/item/storage/holster/blade/machete/full
	r_hand = /obj/item/ammo_magazine/pistol/g22
	l_hand = /obj/item/ammo_magazine/pistol/g22

/datum/outfit/job/fallout/legion/prime
	name = LEGION_PRIME
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion/prime
	belt = /obj/item/weapon/gun/revolver/single_action/m44
	head = /obj/item/clothing/head/helmet/fallout/legion/prime
	id = /obj/item/card/id/legion/prime
	l_store = /obj/item/ammo_magazine/fallout_pistol/magnum44
	r_store = /obj/item/storage/pouch/fallout
	r_hand = /obj/item/weapon/shield/fallout_shield/buckler
	l_hand = null

/datum/outfit/job/fallout/legion/prime/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/magnum44, SLOT_IN_R_POUCH)

/datum/outfit/job/fallout/legion/veteran
	name = LEGION_VETERAN
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion/veteran
	belt = /obj/item/storage/belt/marine
	head = /obj/item/clothing/head/helmet/fallout/legion/veteran
	id = /obj/item/card/id/legion/veteran
	l_store = null
	r_store = null
	suit_store = /obj/item/weapon/gun/fallout_rifle/cowboy_repeater
	r_hand = null
	l_hand = null

/datum/outfit/job/fallout/legion/veteran/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/box/magnum357, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/legion/decanus
	name = LEGION_DECANUS
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion/venator
	belt = /obj/item/storage/belt/gun/ts34/full
	head = /obj/item/clothing/head/helmet/fallout/legion/decanus
	id = /obj/item/card/id/legion/decanus
	l_store = null
	r_store = /obj/item/ammo_magazine/smg/skorpion
	suit_store = /obj/item/weapon/gun/smg/skorpion
	r_hand = /obj/item/weapon/shield/fallout_shield/reinforced/legion
	l_hand = /obj/item/ammo_magazine/smg/skorpion

/datum/outfit/job/fallout/legion/leader
	name = LEGION_LEADER
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion/centurion
	belt = /obj/item/storage/belt/gun/mateba
	head = /obj/item/clothing/head/helmet/fallout/legion/centurion
	id = /obj/item/card/id/legion/leader
	l_store = null
	r_store = /obj/item/megaphone
	suit_store = /obj/item/weapon/gun/smg/skorpion
	r_hand = /obj/item/weapon/shield/fallout_shield/reinforced/legion
	l_hand = /obj/item/ammo_magazine/smg/skorpion

/datum/outfit/job/fallout/legion/support
	name = LEGION_SUPPORT
	w_uniform = /obj/item/clothing/under/fallout/legion/auxillary_male
	wear_suit = null
	belt =	null
	gloves = null
	shoes = /obj/item/clothing/shoes/black
	head = /obj/item/clothing/head/fallout/legion
	id = /obj/item/card/id/legion/support
	l_store = null
	r_store = null
	suit_store = null
	r_hand = null
	l_hand = null

/datum/outfit/job/fallout/legion/support/female
	w_uniform = /obj/item/clothing/under/fallout/legion/auxillary_female
