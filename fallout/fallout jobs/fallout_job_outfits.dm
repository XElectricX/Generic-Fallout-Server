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
	back = /obj/item/storage/backpack/fallout/satchel/trekker
	belt =	/obj/item/storage/belt/fallout/ncr
	gloves = /obj/item/clothing/gloves/fallout/ncr
	shoes = /obj/item/clothing/shoes/fallout/ncr
	head = /obj/item/clothing/head/helmet/fallout/ncr
	mask = /obj/item/clothing/mask/fallout/ncr
	id = /obj/item/card/id/ncr
	suit_store = /obj/item/weapon/gun/fallout_rifle
	l_store = /obj/item/storage/pouch/fallout/medical/stimpak
	r_store = /obj/item/flashlight/fallout

/datum/outfit/job/fallout/ncr/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/ncr/medic
	name = NCR_MEDIC
	belt = /obj/item/storage/belt/fallout/medical/full
	gloves = /obj/item/clothing/gloves/latex
	head = /obj/item/clothing/head/helmet/fallout/ncr/helmet_medic
	glasses = /obj/item/clothing/glasses/hud/health
	id = /obj/item/card/id/ncr/medic
	suit_store = /obj/item/weapon/gun/fallout_smg/ten
	l_store = /obj/item/storage/pouch/fallout/magazine
	r_hand = null
	l_hand = null

/datum/outfit/job/fallout/ncr/medic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/ten, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/ten, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/ten, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/storage/pouch/fallout/medical/stimpak, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tweezers, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/ncr/engineer
	name = NCR_ENGINEER
	belt = /obj/item/storage/belt/fallout/tools/full
	gloves = /obj/item/clothing/gloves/yellow
	head = /obj/item/clothing/head/helmet/fallout/ncr/helmet_engineer
	id = /obj/item/card/id/ncr/engineer
	suit_store = /obj/item/weapon/gun/fallout_rifle/hunting
	l_store = /obj/item/storage/pouch/fallout/magazine
	r_hand = null
	l_hand = null

/datum/outfit/job/fallout/ncr/engineer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle/winchester/extended, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle/winchester/extended, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_rifle/winchester/extended, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/storage/pouch/fallout/medical/stimpak, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/ncr/captain
	name = NCR_CAPTAIN
	w_uniform = /obj/item/clothing/under/fallout/ncr/officer
	wear_suit = /obj/item/clothing/suit/storage/fallout/ncr/officer
	id = /obj/item/card/id/ncr/captain
	suit_store = /obj/item/weapon/gun/fallout_smg/thompson

/datum/outfit/job/fallout/ncr/captain/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/acp/thompson, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/acp/thompson, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/acp/thompson, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/acp/thompson, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/whistle, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/ncr/leader
	name = NCR_LEADER
	w_uniform = /obj/item/clothing/under/fallout/ncr/officer
	wear_suit = /obj/item/clothing/suit/storage/fallout/ncr/officer_reinforced
	belt = /obj/item/storage/belt/fallout/holster
	mask = null
	id = /obj/item/card/id/ncr/leader
	suit_store = /obj/item/weapon/fallout_melee/chinese

/datum/outfit/job/fallout/ncr/leader/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/fallout_pistol/sequoia, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/govt, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/govt, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/ncr/support
	name = NCR_SUPPORT
	w_uniform = /obj/item/clothing/under/fallout/ncr/staff
	wear_suit = null
	belt =	/obj/item/storage/belt/fallout/medical/full
	gloves = null
	shoes = /obj/item/clothing/shoes/black
	head = /obj/item/clothing/head/fallout/ncr/beret_staff
	mask = null
	id = /obj/item/card/id/ncr/support
	l_store = /obj/item/storage/pouch/fallout/medical/doctor/full
	suit_store = null
	r_hand = null
	l_hand = null

/datum/outfit/job/fallout/ncr/support/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/tweezers, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

//Legion
/datum/outfit/job/fallout/legion
	name = LEGION_RECRUIT
	w_uniform = /obj/item/clothing/under/fallout/legion
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion
	back = /obj/item/storage/backpack/fallout/quiver/full
	belt = /obj/item/weapon/fallout_melee
	gloves = /obj/item/clothing/gloves/fallout/legion
	shoes = /obj/item/clothing/shoes/fallout/legion
	head = /obj/item/clothing/head/helmet/fallout/legion
	mask = /obj/item/clothing/mask/fallout/legion
	id = /obj/item/card/id/legion
	suit_store = /obj/item/weapon/fallout_melee/spear/throwing
	l_store = /obj/item/storage/pouch/fallout/medical/healing_powder
	r_store = /obj/item/flashlight/fallout/lantern
	l_hand = /obj/item/weapon/shield/fallout_shield/buckler

/datum/outfit/job/fallout/legion/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/legion/prime
	name = LEGION_PRIME
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion/prime
	belt = /obj/item/storage/belt/fallout/holster
	head = /obj/item/clothing/head/helmet/fallout/legion/prime
	id = /obj/item/card/id/legion/prime
	suit_store = /obj/item/weapon/gun/fallout_pistol/colt357
	l_store = /obj/item/weapon/fallout_melee/gladius
	l_hand = /obj/item/weapon/shield/fallout_shield

/datum/outfit/job/fallout/legion/prime/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/fallout_pistol/colt357, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/magnum357, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/magnum357, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/legion/veteran
	name = LEGION_VETERAN
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion/veteran
	back = /obj/item/storage/backpack/fallout/satchel/explorer
	belt = /obj/item/storage/belt/fallout/holster
	head = /obj/item/clothing/head/helmet/fallout/legion/veteran
	id = /obj/item/card/id/legion/veteran
	suit_store = /obj/item/weapon/gun/fallout_rifle/cowboy_repeater
	r_hand = null
	l_hand = null

/datum/outfit/job/fallout/legion/veteran/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/box/magnum357, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/fallout_pistol/colt357, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/magnum357, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/magnum357, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/legion/decanus
	name = LEGION_DECANUS
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion/decanus
	back = /obj/item/storage/backpack/fallout/satchel/explorer
	belt = /obj/item/storage/belt/fallout/legion
	gloves = /obj/item/clothing/gloves/fallout/metal
	shoes = /obj/item/clothing/shoes/fallout/legion/metal
	head = /obj/item/clothing/head/helmet/fallout/legion/decanus
	mask = /obj/item/clothing/mask/fallout/legion/decanus
	id = /obj/item/card/id/legion/decanus
	suit_store = /obj/item/weapon/gun/fallout_smg/uzi
	l_hand = /obj/item/weapon/shield/fallout_shield/reinforced/legion
	r_hand = /obj/item/weapon/fallout_melee/gladius

/datum/outfit/job/fallout/legion/decanus/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/acp, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/acp, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/acp, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_smg/acp, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/legion/leader
	name = LEGION_LEADER
	wear_suit = /obj/item/clothing/suit/storage/fallout/legion/centurion
	back = /obj/item/storage/backpack/fallout/satchel/explorer
	belt = /obj/item/storage/belt/fallout/holster
	gloves = /obj/item/clothing/gloves/fallout/metal
	shoes = /obj/item/clothing/shoes/fallout/legion/metal
	head = /obj/item/clothing/head/helmet/fallout/legion/centurion
	mask = /obj/item/clothing/mask/fallout/legion/centurion
	id = /obj/item/card/id/legion/leader
	suit_store = /obj/item/weapon/fallout_melee/hammer/rocket
	l_hand = null

/datum/outfit/job/fallout/legion/leader/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/fallout_pistol/hunting_revolver, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/govt, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/govt, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/fallout_pistol/govt, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)

/datum/outfit/job/fallout/legion/support
	name = LEGION_SUPPORT
	w_uniform = /obj/item/clothing/under/fallout/legion/auxillary_male
	wear_suit = null
	back = /obj/item/storage/backpack/fallout/satchel/explorer
	belt =	/obj/item/storage/belt/fallout/medical/full
	gloves = /obj/item/clothing/gloves/fallout/blacksmith
	shoes = /obj/item/clothing/shoes/fallout/legion/sandals
	head = /obj/item/clothing/head/fallout/legion
	mask = null
	id = /obj/item/card/id/legion/support
	l_store = /obj/item/storage/pouch/fallout/medical/doctor/full
	suit_store = null
	l_hand = null

/datum/outfit/job/fallout/legion/support/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/tweezers, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/radio/fallout, SLOT_IN_BACKPACK)