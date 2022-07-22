//NCR
/obj/item/clothing/suit/storage/fallout/ncr
	name = "NCR armor vest"
	desc = "A standard issue NCRA infantry armor vest."
	icon = 'fallout/fallout icons/fallout clothing/faction_armors.dmi'
	item_icons = list(slot_wear_suit_str = 'fallout/fallout icons/fallout clothing/faction_armors_worn.dmi')
	icon_state = "ncr_vest"
	item_state = "ncr_vest"
	flags_atom = CONDUCT
	flags_armor_protection = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	flags_cold_protection = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	flags_heat_protection = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	soft_armor = list("melee" = 25, "bullet" = 40, "laser" = 15, "energy" = 15, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 10)
	slowdown = 0.3
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/weapon/twohanded,
		/obj/item/weapon/fallout_melee,
		/obj/item/storage/holster/blade,
		/obj/item/storage/pouch/fallout,
		/obj/item/flashlight/fallout,
		/obj/item/tank/emergency_oxygen)

/obj/item/clothing/suit/storage/fallout/ncr/reinforced
	name = "NCR reinforced armor vest"
	desc = "A standard issue NCRA infantry vest reinforced with extra armor."
	icon_state = "ncr_vest_reinforced"
	item_state = "ncr_vest_reinforced"
	soft_armor = list("melee" = 30, "bullet" = 50, "laser" = 40, "energy" = 40, "bomb" = 40, "bio" = 20, "rad" = 25, "fire" = 30, "acid" = 20)
	slowdown = 0.4

/obj/item/clothing/suit/storage/fallout/ncr/mantle
	name = "NCR mantle armor"
	desc = "A standard issue NCRA infantry vest with a mantle on the shoulder."
	icon_state = "ncr_mantle"
	item_state = "ncr_mantle"

/obj/item/clothing/suit/storage/fallout/ncr/mantle_reinforced
	name = "NCR reinforced mantle armor"
	desc = "A standard issue NCRA infantry mantle vest reinforced with extra armor."
	icon_state = "ncr_mantle_reinforced"
	item_state = "ncr_mantle_reinforced"
	soft_armor = list("melee" = 30, "bullet" = 50, "laser" = 40, "energy" = 40, "bomb" = 40, "bio" = 20, "rad" = 25, "fire" = 30, "acid" = 20)
	slowdown = 0.4

/obj/item/clothing/suit/storage/fallout/ncr/officer
	name = "NCR officer armor"
	desc = "A set of NCRA armor designed for officers. Has more padding than standard infantry armor."
	icon_state = "ncr_officer"
	item_state = "ncr_officer"
	soft_armor = list("melee" = 40, "bullet" = 60, "laser" = 50, "energy" = 50, "bomb" = 45, "bio" = 20, "rad" = 25, "fire" = 35, "acid" = 25)
	slowdown = 0.5

/obj/item/clothing/suit/storage/fallout/ncr/officer_reinforced
	name = "NCR reinforced officer armor"
	desc = "A reinforced set of NCRA officer armor. Ceramic inserts protect the vital organs quite well. Designed to keep the brass safe in active war zones."
	icon_state = "ncr_officer_reinforced"
	item_state = "ncr_officer_reinforced"
	soft_armor = list("melee" = 45, "bullet" = 65, "laser" = 55, "energy" = 55, "bomb" = 50, "bio" = 30, "rad" = 35, "fire" = 45, "acid" = 30)
	slowdown = 0.6

/obj/item/clothing/suit/storage/fallout/ncr/patrol
	name = "heavy patrol armor"
	desc = "The standard issue heavy patrol armor is based on pre-war combat armor design, and has similar capabilities. Designed for NCRA troopers sent into active war zones."
	icon_state = "ncr_patrol"
	item_state = "ncr_patrol"
	soft_armor = list("melee" = 60, "bullet" = 80, "laser" = 65, "energy" = 65, "bomb" = 40, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 0)
	slowdown = 0.7

/obj/item/clothing/suit/storage/fallout/ncr/scout
	name = "NCR scout armor"
	desc = "Light-weight armor designed for NCRA troops tasked with recon."
	icon_state = "ncr_scout"
	item_state = "ncr_scout"
	soft_armor = list("melee" = 15, "bullet" = 25, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 5)
	slowdown = 0.2

/obj/item/clothing/suit/storage/fallout/ncr/scout_officer
	name = "NCR scout officer armor"
	desc = "Light-weight armor designed for NCRA recon officers."
	icon_state = "ncr_scout_officer"
	item_state = "ncr_scout_officer"
	soft_armor = list("melee" = 20, "bullet" = 30, "laser" = 15, "energy" = 15, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 5)
	slowdown = 0.3

/obj/item/clothing/suit/storage/fallout/ncr/officer_coat
	name = "NCR armored officer coat"
	desc = "A special overcoat with dense padding. Designed for NCRA officers who seek a balance between style and self-preservation."
	icon_state = "ncr_officer_coat"
	item_state = "ncr_officer_coat"
	soft_armor = list("melee" = 10, "bullet" = 20, "laser" = 15, "energy" = 15, "bomb" = 0, "bio" = 10, "rad" = 10, "fire" = 15, "acid" = 5)
	slowdown = 0.1

/obj/item/clothing/suit/storage/fallout/ncr/ranger
	name = "NCR ranger armor"
	desc = "The distinctive armor of the NCRA ranger. This particular design is of metal plates lining the upper body under a padded duster. Considered one of the most prestigious suits of armor to earn and wear while in service of the Republic."
	icon_state = "ncr_ranger"
	item_state = "ncr_ranger"
	soft_armor = list("melee" = 45, "bullet" = 45, "laser" = 30, "energy" = 25, "bomb" = 25, "bio" = 10, "rad" = 20, "fire" = 35, "acid" = 10)

/obj/item/clothing/suit/storage/fallout/ncr/combat
	name = "NCR combat armor"
	desc = "Combat armor painted in the colors of the New California Republic Army, displaying its flag on the chest."
	icon_state = "ncr_combat"
	item_state = "ncr_combat"
	soft_armor = list("melee" = 30, "bullet" = 65, "laser" = 60, "energy" = 60, "bomb" = 20, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 10)
	slowdown = 0.4

/obj/item/clothing/suit/storage/fallout/ncr/exile
	name = "tattered NCR armor"
	desc = "Standard NCRA trooper armor that appears to have been repaired using metal parts. Looks to be nothing more than scrap metal now."
	icon_state = "ncr_tattered"
	item_state = "ncr_tattered"

//Legion
/obj/item/clothing/suit/storage/fallout/legion
	name = "Legion recruit armor"
	desc = "Legion recruit armor is a common light armor, clearly inspired by gear worn by old world football players and baseball catchers, much of it restored ancient actual sports equipment, other newly made from mostly leather, tanned and boiled in oil."
	icon = 'fallout/fallout icons/fallout clothing/faction_armors.dmi'
	item_icons = list(slot_wear_suit_str = 'fallout/fallout icons/fallout clothing/faction_armors_worn.dmi')
	icon_state = "legion_recruit"
	item_state = "legion_recruit"
	flags_atom = CONDUCT
	flags_armor_protection = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	flags_cold_protection = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	flags_heat_protection = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	soft_armor = list("melee" = 30, "bullet" = 25, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0)
	slowdown = 0.3
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/weapon/twohanded,
		/obj/item/weapon/fallout_melee,
		/obj/item/storage/holster/blade,
		/obj/item/storage/pouch/fallout,
		/obj/item/flashlight/fallout,
		/obj/item/tank/emergency_oxygen)

/obj/item/clothing/suit/storage/fallout/legion/prime
	name = "Legion prime armor"
	desc = "Legionary prime armor offers the same protection as a recruit's. However, this one does not reek of death."
	icon_state = "legion_prime"
	item_state = "legion_prime"

/obj/item/clothing/suit/storage/fallout/legion/explorer
	name = "Legion explorer armor"
	desc = "Light armor with layered strips of laminated linen and leather. Has a pouch attached."
	icon_state = "legion_explorer"
	item_state = "legion_explorer"
	soft_armor = list("melee" = 20, "bullet" = 20, "laser" = 15, "energy" = 15, "bomb" = 10, "bio" = 20, "rad" = 20, "fire" = 25, "acid" = 0)
	slowdown = 0.2

/obj/item/clothing/suit/storage/fallout/legion/veteran
	name = "Legion veteran armor"
	desc = "Armor worn by veteran legionaries who have proven their combat prowess in many battles, its hardened leather is sturdier than that of previous ranks."
	icon_state = "legion_veteran"
	item_state = "legion_veteran"
	soft_armor = list("melee" = 40, "bullet" = 35, "laser" = 15, "energy" = 15, "bomb" = 25, "bio" = 20, "rad" = 25, "fire" = 30, "acid" = 5)
	slowdown = 0.3

/obj/item/clothing/suit/storage/fallout/legion/vexillarius
	name = "Legion vexillarius armor"
	desc = "The armor appears to be based off of a suit of Legion veteran armor, with the addition of circular metal plates attached to the torso, as well as a banner displaying the flag of the Legion worn on the back."
	icon_state = "legion_vexillarius"
	item_state = "legion_vexillarius"
	soft_armor = list("melee" = 45, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 20, "rad" = 25, "fire" = 35, "acid" = 0)
	slowdown = 0.4

/obj/item/clothing/suit/storage/fallout/legion/slavemaster
	name = "Legion slavemaster armor"
	desc = "Issued to slave masters to keep them cool during long hours of watching the slaves work in the sun."
	icon_state = "legion_slavemaster"
	item_state = "legion_slavemaster"

/obj/item/clothing/suit/storage/fallout/legion/scout_coat
	name = "Legion scout coat"
	desc = "A padded coat designed for runners and clandestine scouts of the Legion."
	icon_state = "legion_scout_coat"
	item_state = "legion_scout_coat"
	soft_armor = list("melee" = 10, "bullet" = 10, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 10, "rad" = 20, "fire" = 25, "acid" = 0)
	slowdown = 0

/obj/item/clothing/suit/storage/fallout/legion/venator
	name = "Legion venator armor"
	desc = "Legion armor crafted from metal plates and chainmail. Decent protection, but heavy."
	icon_state = "legion_venator"
	item_state = "legion_venator"
	soft_armor = list("melee" = 50, "bullet" = 50, "laser" = 25, "energy" = 25, "bomb" = 35, "bio" = 20, "rad" = 25, "fire" = 35, "acid" = 20)
	slowdown = 0.5

/obj/item/clothing/suit/storage/fallout/legion/heavy
	name = "Legion heavy armor"
	desc = "A suit with the standard metal reinforcements of a veteran and a patched bulletproof vest worn over it."
	icon_state = "legion_metal" //placeholder until we get an item sprite
	item_state = "legion_heavy"
	soft_armor = list("melee" = 70, "bullet" = 70, "laser" = 30, "energy" = 30, "bomb" = 40, "bio" = 20, "rad" = 25, "fire" = 35, "acid" = 10)
	slowdown = 0.7

/obj/item/clothing/suit/storage/fallout/legion/centurion
	name = "Centurion armor"
	desc = "The Legion centurion armor is by far the strongest suit of armor available to Caesar's Legion. The armor is composed from other pieces of armor taken from that of the wearer's defeated opponents in combat."
	icon_state = "legion_centurion"
	item_state = "legion_centurion"
	soft_armor = list("melee" = 70, "bullet" = 50, "laser" = 35, "energy" = 35, "bomb" = 40, "bio" = 30, "rad" = 20, "fire" = 40, "acid" = 20)
	slowdown = 0.6

/obj/item/clothing/suit/storage/fallout/legion/centurion_ranger
	name = "Centurion Ranger-hunter armor"
	desc = "A suit of armor collected over the years by the deaths of countless NCR rangers. Slightly lighter than the heavy metal Centurion suits as some of the metal plating is removed to take advantage of the padded Ranger duster."
	icon_state = "legion_centurion_ranger"
	item_state = "legion_centurion_ranger"
	soft_armor = list("melee" = 60, "bullet" = 40, "laser" = 35, "energy" = 35, "bomb" = 40, "bio" = 40, "rad" = 35, "fire" = 50, "acid" = 30)
	slowdown = 0.5

/obj/item/clothing/suit/storage/fallout/legion/centurion_powerarmor
	name = "Centurion Paladin-slayer armor"
	desc = "The armor of a Centurion who has bested one or more Brotherhood Paladins, adding pieces of his prizes to his own defense. The symbol of the Legion is crudely painted on this once-marvelous suit of armor. Much heavier than normal Centurion armor, but offers superior protection."
	icon_state = "legion_centurion_powerarmor"
	item_state = "legion_centurion_powerarmor"
	soft_armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 60, "bio" = 40, "rad" = 40, "fire" = 60, "acid" = 50)
	slowdown = 0.8

/obj/item/clothing/suit/storage/fallout/legion/legate
	name = "Legate armor"
	desc = "The armor appears to be a full suit of heavy gauge steel and offers full body protection. It also has a cloak in excellent condition, but the armor itself bears numerous battle scars and the helmet is missing half of the left horn. The Legate's suit appears originally crafted, in contrast to other Legion armor which consists of repurposed pre-War sports equipment."
	icon_state = "legion_legate"
	item_state = "legion_legate"
	soft_armor = list("melee" = 70, "bullet" = 60, "laser" = 45, "energy" = 45, "bomb" = 45, "bio" = 30, "rad" = 30, "fire" = 70, "acid" = 40)
	slowdown = 0.7
/* Commented out due to possible balance concerns with Legion in combat armor, and the armor itself needs a better sprite
/obj/item/clothing/suit/storage/fallout/legion/combat_armor
	name = "Legion combat armor"
	desc = "An old military grade pre war combat armor and, repainted to the colour scheme of Caesar's Legion."
	icon_state = "legion_combatarmor"
	item_state = "legion_combatarmor"
	soft_armor = list("melee" = 30, "bullet" = 65, "laser" = 60, "energy" = 60, "bomb" = 20, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 10)
*/
/obj/item/clothing/suit/storage/fallout/legion/tattered
	name = "tattered Legion armor"
	desc = "Standard Legion armor that appears to have been repaired using metal parts. Looks to be nothing more than scrap metal now."
	icon_state = "legion_tattered"
	item_state = "legion_tattered"
	soft_armor = list("melee" = 45, "bullet" = 30, "laser" = 20, "energy" = 15, "bomb" = 30, "bio" = 25, "rad" = 20, "fire" = 35, "acid" = 0)
