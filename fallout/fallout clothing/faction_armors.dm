//NCR
/obj/item/clothing/suit/storage/fallout/ncr
	name = "\improper NCR armor vest"
	desc = "A standard issue NCRA infantry armor vest."
	icon = 'fallout/fallout icons/fallout clothing/faction_armors.dmi'
	item_icons = list(slot_wear_suit_str = 'fallout/fallout icons/fallout clothing/faction_armors_worn.dmi')
	icon_state = "ncr_vest"
	item_state = "ncr_vest"
	atom_flags = CONDUCT
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	heat_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	soft_armor = list(MELEE = 25, BULLET = 40, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 0, ACID = 10, ACID = 10)
	slowdown = 0.3
	allowed = list(
		/obj/item/weapon/gun/fallout/pistol,
		/obj/item/weapon/gun/fallout/smg,
		/obj/item/weapon/gun/fallout/rifle,
		/obj/item/weapon/gun/fallout/shotgun,
		/obj/item/weapon/twohanded,
		/obj/item/weapon/fallout_melee,
		/obj/item/storage/holster/blade,
		/obj/item/storage/pouch/fallout,
		/obj/item/storage/backpack/fallout/satchel,
		/obj/item/flashlight/fallout,
		/obj/item/tank/emergency_oxygen)

/obj/item/clothing/suit/storage/fallout/ncr/reinforced
	name = "\improper NCR reinforced armor vest"
	desc = "A standard issue NCRA infantry vest reinforced with extra armor."
	icon_state = "ncr_vest_reinforced"
	item_state = "ncr_vest_reinforced"
	soft_armor = list(MELEE = 30, BULLET = 50, LASER = 40, ENERGY = 40, BOMB = 40, BIO = 20, ACID = 30, ACID = 20)
	slowdown = 0.4

/obj/item/clothing/suit/storage/fallout/ncr/mantle
	name = "\improper NCR mantle armor"
	desc = "A standard issue NCRA infantry vest with a mantle on the shoulder."
	icon_state = "ncr_mantle"
	item_state = "ncr_mantle"

/obj/item/clothing/suit/storage/fallout/ncr/mantle_reinforced
	name = "\improper NCR reinforced mantle armor"
	desc = "A standard issue NCRA infantry mantle vest reinforced with extra armor."
	icon_state = "ncr_mantle_reinforced"
	item_state = "ncr_mantle_reinforced"
	soft_armor = list(MELEE = 30, BULLET = 50, LASER = 40, ENERGY = 40, BOMB = 40, BIO = 20, ACID = 30, ACID = 20)
	slowdown = 0.4

/obj/item/clothing/suit/storage/fallout/ncr/officer
	name = "\improper NCR officer armor"
	desc = "A set of NCRA armor designed for officers. Has more padding than standard infantry armor."
	icon_state = "ncr_officer"
	item_state = "ncr_officer"
	soft_armor = list(MELEE = 40, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 45, BIO = 20, ACID = 35, ACID = 25)
	slowdown = 0.5

/obj/item/clothing/suit/storage/fallout/ncr/officer_reinforced
	name = "\improper NCR reinforced officer armor"
	desc = "A reinforced set of NCRA officer armor. Ceramic inserts protect the vital organs quite well. Designed to keep the brass safe in active war zones."
	icon_state = "ncr_officer_reinforced"
	item_state = "ncr_officer_reinforced"
	soft_armor = list(MELEE = 45, BULLET = 65, LASER = 55, ENERGY = 55, BOMB = 50, BIO = 30, ACID = 45, ACID = 30)
	slowdown = 0.6

/obj/item/clothing/suit/storage/fallout/ncr/patrol
	name = "\improper NCR heavy patrol armor"
	desc = "The standard issue heavy patrol armor is based on pre-war combat armor design, and has similar capabilities. Designed for NCRA troopers sent into active war zones."
	icon_state = "ncr_patrol"
	item_state = "ncr_patrol"
	soft_armor = list(MELEE = 60, BULLET = 80, LASER = 65, ENERGY = 65, BOMB = 40, BIO = 10, ACID = 10, ACID = 0)
	slowdown = 0.7

/obj/item/clothing/suit/storage/fallout/ncr/scout
	name = "\improper NCR scout armor"
	desc = "Light-weight armor designed for NCRA troops tasked with recon."
	icon_state = "ncr_scout"
	item_state = "ncr_scout"
	soft_armor = list(MELEE = 15, BULLET = 25, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 0, ACID = 5, ACID = 5)
	slowdown = 0.2

/obj/item/clothing/suit/storage/fallout/ncr/scout_officer
	name = "\improper NCR scout officer armor"
	desc = "Light-weight armor designed for NCRA recon officers."
	icon_state = "ncr_scout_officer"
	item_state = "ncr_scout_officer"
	soft_armor = list(MELEE = 20, BULLET = 30, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 0, ACID = 5, ACID = 5)
	slowdown = 0.3

/obj/item/clothing/suit/storage/fallout/ncr/officer_coat
	name = "\improper NCR armored officer coat"
	desc = "A special overcoat with dense padding. Designed for NCRA officers who seek a balance between style and self-preservation."
	icon_state = "ncr_officer_coat"
	item_state = "ncr_officer_coat"
	soft_armor = list(MELEE = 10, BULLET = 20, LASER = 15, ENERGY = 15, BOMB = 0, BIO = 10, ACID = 15, ACID = 5)
	slowdown = 0.1

/obj/item/clothing/suit/storage/fallout/ncr/ranger
	name = "\improper NCR ranger armor"
	desc = "The distinctive armor of the NCRA ranger. This particular design is of metal plates lining the upper body under a padded duster. Considered one of the most prestigious suits of armor to earn and wear while in service of the Republic."
	icon_state = "ncr_ranger"
	item_state = "ncr_ranger"
	soft_armor = list(MELEE = 45, BULLET = 45, LASER = 30, ENERGY = 25, BOMB = 25, BIO = 10, ACID = 35, ACID = 10)

/obj/item/clothing/suit/storage/fallout/ncr/combat
	name = "\improper NCR combat armor"
	desc = "Combat armor painted in the colors of the New California Republic Army, displaying its flag on the chest."
	icon_state = "ncr_combat"
	item_state = "ncr_combat"
	soft_armor = list(MELEE = 30, BULLET = 65, LASER = 60, ENERGY = 60, BOMB = 20, BIO = 10, ACID = 10, ACID = 10)
	slowdown = 0.4

/obj/item/clothing/suit/storage/fallout/ncr/exile
	name = "tattered NCR armor"
	desc = "Standard NCRA trooper armor that appears to have been repaired using metal parts. Looks to be nothing more than scrap metal now."
	icon_state = "ncr_tattered"
	item_state = "ncr_tattered"

//Legion
/obj/item/clothing/suit/storage/fallout/legion
	name = "\improper Legion recruit armor"
	desc = "Legion recruit armor is a common light armor, clearly inspired by gear worn by old world football players and baseball catchers, much of it restored ancient actual sports equipment, other newly made from mostly leather, tanned and boiled in oil."
	icon = 'fallout/fallout icons/fallout clothing/faction_armors.dmi'
	item_icons = list(slot_wear_suit_str = 'fallout/fallout icons/fallout clothing/faction_armors_worn.dmi')
	icon_state = "legion_recruit"
	item_state = "legion_recruit"
	atom_flags = CONDUCT
	armor_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	cold_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	heat_protection_flags = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	soft_armor = list(MELEE = 30, BULLET = 25, LASER = 10, ENERGY = 10, BOMB = 15, BIO = 20, ACID = 25, ACID = 0)
	slowdown = 0.3
	allowed = list(
		/obj/item/weapon/gun/fallout/pistol,
		/obj/item/weapon/gun/fallout/smg,
		/obj/item/weapon/gun/fallout/rifle,
		/obj/item/weapon/gun/fallout/shotgun,
		/obj/item/weapon/twohanded,
		/obj/item/weapon/fallout_melee,
		/obj/item/storage/holster/blade,
		/obj/item/storage/pouch/fallout,
		/obj/item/storage/backpack/fallout/satchel,
		/obj/item/flashlight/fallout,
		/obj/item/tank/emergency_oxygen)

/obj/item/clothing/suit/storage/fallout/legion/prime
	name = "\improper Legion prime armor"
	desc = "Legionary prime armor offers the same protection as a recruit's. However, this one does not reek of death."
	icon_state = "legion_prime"
	item_state = "legion_prime"

/obj/item/clothing/suit/storage/fallout/legion/explorer
	name = "\improper Legion explorer armor"
	desc = "Light armor with layered strips of laminated linen and leather. Has a pouch attached."
	icon_state = "legion_explorer"
	item_state = "legion_explorer"
	soft_armor = list(MELEE = 20, BULLET = 20, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 20, ACID = 25, ACID = 0)
	slowdown = 0.2

/obj/item/clothing/suit/storage/fallout/legion/veteran
	name = "\improper Legion veteran armor"
	desc = "Armor worn by veteran legionaries who have proven their combat prowess in many battles, its hardened leather is sturdier than that of previous ranks."
	icon_state = "legion_veteran"
	item_state = "legion_veteran"
	soft_armor = list(MELEE = 40, BULLET = 35, LASER = 15, ENERGY = 15, BOMB = 25, BIO = 20, ACID = 30, ACID = 5)
	slowdown = 0.3

/obj/item/clothing/suit/storage/fallout/legion/vexillarius
	name = "\improper Legion vexillarius armor"
	desc = "The armor appears to be based off of a suit of Legion veteran armor, with the addition of circular metal plates attached to the torso, as well as a banner displaying the flag of the Legion worn on the back."
	icon_state = "legion_vexillarius"
	item_state = "legion_vexillarius"
	soft_armor = list(MELEE = 45, BULLET = 40, LASER = 20, ENERGY = 20, BOMB = 30, BIO = 20, ACID = 35, ACID = 0)
	slowdown = 0.4

/obj/item/clothing/suit/storage/fallout/legion/gladiator
	name = "\improper Legion gladiator armor"
	desc = "Issued to slave masters to keep them cool during long hours of watching the slaves work in the sun."
	icon_state = "legion_gladiator"
	item_state = "legion_gladiator"
	soft_armor = list(MELEE = 50, BULLET = 10, LASER = 5, ENERGY = 0, BOMB = 10, BIO = 0, ACID = 10, ACID = 0)

/obj/item/clothing/suit/storage/fallout/legion/scout_coat
	name = "\improper Legion scout coat"
	desc = "A padded coat designed for runners and clandestine scouts of the Legion."
	icon_state = "legion_scout_coat"
	item_state = "legion_scout_coat"
	soft_armor = list(MELEE = 10, BULLET = 10, LASER = 5, ENERGY = 5, BOMB = 0, BIO = 10, ACID = 25, ACID = 0)
	slowdown = 0

/obj/item/clothing/suit/storage/fallout/legion/heavy
	name = "\improper Legion heavy armor"
	desc = "A suit with the standard metal reinforcements of a veteran and a patched bulletproof vest worn over it."
	icon_state = "legion_heavy"
	item_state = "legion_heavy"
	soft_armor = list(MELEE = 70, BULLET = 70, LASER = 30, ENERGY = 30, BOMB = 40, BIO = 20, ACID = 35, ACID = 10)
	slowdown = 0.7

/obj/item/clothing/suit/storage/fallout/legion/decanus
	name = "\improper Legion decanus armor"
	desc = "Legion armor crafted from metal plates and chainmail. Decent protection, but heavy."
	icon_state = "legion_decanus"
	item_state = "legion_decanus"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 25, ENERGY = 25, BOMB = 35, BIO = 20, ACID = 35, ACID = 20)
	slowdown = 0.5
	starting_attachments = list(/obj/item/armor_module/fallout/cape/legion/black)

/obj/item/clothing/suit/storage/fallout/legion/centurion
	name = "\improper Centurion armor"
	desc = "The Legion centurion armor is by far the strongest suit of armor available to Caesar's Legion. The armor is composed from other pieces of armor taken from that of the wearer's defeated opponents in combat."
	icon_state = "legion_centurion"
	item_state = "legion_centurion"
	soft_armor = list(MELEE = 70, BULLET = 50, LASER = 35, ENERGY = 35, BOMB = 40, BIO = 30, ACID = 40, ACID = 20)
	slowdown = 0.6
	starting_attachments = list(/obj/item/armor_module/fallout/cape/legion/side)

/obj/item/clothing/suit/storage/fallout/legion/centurion_ranger
	name = "\improper Centurion Ranger-hunter armor"
	desc = "A suit of armor collected over the years by the deaths of countless NCR rangers. Slightly lighter than the heavy metal Centurion suits as some of the metal plating is removed to take advantage of the padded Ranger duster."
	icon_state = "legion_centurion_ranger"
	item_state = "legion_centurion_ranger"
	soft_armor = list(MELEE = 60, BULLET = 40, LASER = 35, ENERGY = 35, BOMB = 40, BIO = 40, ACID = 50, ACID = 30)
	slowdown = 0.5

/obj/item/clothing/suit/storage/fallout/legion/centurion_powerarmor
	name = "\improper Centurion Paladin-slayer armor"
	desc = "The armor of a Centurion who has bested one or more Brotherhood Paladins, adding pieces of his prizes to his own defense. The symbol of the Legion is crudely painted on this once-marvelous suit of armor. Much heavier than normal Centurion armor, but offers superior protection."
	icon_state = "legion_centurion_powerarmor"
	item_state = "legion_centurion_powerarmor"
	soft_armor = list(MELEE = 80, BULLET = 80, LASER = 50, ENERGY = 50, BOMB = 60, BIO = 40, ACID = 60, ACID = 50)
	slowdown = 0.8

/obj/item/clothing/suit/storage/fallout/legion/legate
	name = "\improper Legate armor"
	desc = "The armor appears to be a full suit of heavy gauge steel and offers full body protection. It also has a cloak in excellent condition, but the armor itself bears numerous battle scars and the helmet is missing half of the left horn. The Legate's suit appears originally crafted, in contrast to other Legion armor which consists of repurposed pre-War sports equipment."
	icon_state = "legion_legate"
	item_state = "legion_legate"
	soft_armor = list(MELEE = 70, BULLET = 60, LASER = 45, ENERGY = 45, BOMB = 45, BIO = 30, ACID = 70, ACID = 40)
	slowdown = 0.7

/obj/item/clothing/suit/storage/fallout/legion/combat_armor
	name = "\improper Legion combat armor"
	desc = "Pre-war combat armor modified by Legion armorsmiths. Usually given to elite soldiers."
	icon_state = "legion_combat"
	item_state = "legion_combat"
	soft_armor = list(MELEE = 30, BULLET = 65, LASER = 60, ENERGY = 60, BOMB = 20, BIO = 10, ACID = 10, ACID = 10)
	slowdown = 0.4

/obj/item/clothing/suit/storage/fallout/legion/tattered
	name = "tattered Legion armor"
	desc = "Standard Legion armor that appears to have been repaired using metal parts. Looks to be nothing more than scrap metal now."
	icon_state = "legion_tattered"
	item_state = "legion_tattered"
	soft_armor = list(MELEE = 45, BULLET = 30, LASER = 20, ENERGY = 15, BOMB = 30, BIO = 25, ACID = 35, ACID = 0)
