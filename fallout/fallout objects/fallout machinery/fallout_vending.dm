//Vending machine template for future vending machines
/obj/machinery/vending/fallout
	name = "vending machine"
	desc = "A generic vending machine from pre-war times."
	icon = 'fallout/fallout icons/fallout structures/fallout_vending.dmi'
	icon_state = ""
	vend_delay = 1
	coverage = 100

//Change sprite to use "_" instead of "-"
//Note that the the open panel sprites still need to use "-panel" because the proc it is in needs too much work to change easily
/obj/machinery/vending/fallout/update_icon()
	if(machine_stat & BROKEN)
		icon_state = "[initial(icon_state)]_broken"
	else if(!(machine_stat & NOPOWER) )
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_off"

//Same here
/obj/machinery/vending/fallout/malfunction()
	. = ..()
	src.icon_state = "[initial(icon_state)]_broken"

//Food and drink vendors
/obj/machinery/vending/fallout/nuka
	name = "\improper Nuka Cola vending machine"
	desc = "Pre-war vending machine from the Nuka Cola company. Practically on every corner."
	icon_state = "nuka"
	icon_deny = "nuka_deny"
	products = list(/obj/item/reagent_containers/food/drinks/cans/nuka_cola = -1)

/obj/machinery/vending/fallout/sarsaparilla
	name = "\improper Sunset Sarsaparilla vending machine"
	desc = "Stylized to look like something out of a saloon, this vending machine is a cowboy's friend."
	icon_state = "sarsaparilla"
	icon_deny = "sarsaparilla"
	products = list(/obj/item/reagent_containers/food/drinks/cans/sarsaparilla = -1)

/obj/machinery/vending/fallout/vim
	name = "\improper Vim! vending machine"
	desc = "Pre-war vending machine from the Nuka Cola company. Practically on every corner."
	icon_state = "vim"
	icon_deny = "vim"
	products = list(/obj/item/reagent_containers/food/drinks/cans/vim = -1)

/obj/machinery/vending/fallout/bawls
	name = "\improper Bawls Guarana vending machine"
	desc = "Dispenses caffeinated energy drinks."
	icon_state = "bawls"
	icon_deny = "bawls"
	products = list(/obj/item/reagent_containers/food/drinks/cans/bawls = -1)

//Gear vendors
/obj/machinery/vending/fallout/tools
	name = "\improper RobCo Handy Hardware vending machine"
	desc = "A pre-war RobCo vending machine that dispenses tools, equipment, and devices."
	icon_state = "robco"
	icon_deny = "robco_deny"
	products = list(
		/obj/item/stack/cable_coil = -1,
		/obj/item/tool/crowbar = -1,
		/obj/item/tool/weldingtool = -1,
		/obj/item/tool/wirecutters = -1,
		/obj/item/tool/wrench = -1,
		/obj/item/tool/screwdriver = -1,
		/obj/item/clothing/head/welding = -1,
		/obj/item/clothing/gloves/yellow = -1,
		/obj/item/cell/fallout/fission = -1)

//NCR vendor
/obj/machinery/vending/fallout/ncr
	name = "\improper NCR Supply Vendor"
	desc = "Standard dispenser of Republic gear."
	icon_state = "ncr"
	icon_vend = "ncr_vend"
	icon_deny = "ncr"
	wrenchable = FALSE
	shut_up = TRUE
	isshared = TRUE
	products = list(
		"Submachineguns" = list(
			/obj/item/weapon/gun/fallout_smg/ten = -1,
			/obj/item/ammo_magazine/fallout_smg/ten = -1,
			/obj/item/weapon/gun/fallout_smg/thompson = -1,
			/obj/item/ammo_magazine/fallout_smg/acp/thompson = -1,
			/obj/item/ammo_magazine/fallout_smg/acp/drum = -1),
		"Shotguns" = list(
			/obj/item/weapon/gun/fallout_shotgun = -1,
			/obj/item/weapon/gun/fallout_shotgun/short = -1,
			/obj/item/weapon/gun/fallout_shotgun/combat = -1,
			/obj/item/weapon/gun/fallout_shotgun/combat/short = -1,
			/obj/item/ammo_magazine/fallout_shotgun = -1,
			/obj/item/ammo_magazine/box/shotgun = -1),
		"Rifles" = list(
			/obj/item/weapon/gun/fallout_rifle = -1,
			/obj/item/ammo_magazine/fallout_rifle = -1,
			/obj/item/ammo_magazine/fallout_rifle/extended = -1,
			/obj/item/weapon/gun/fallout_rifle/hunting = -1,
			/obj/item/weapon/gun/fallout_rifle/hunting/short = -1,
			/obj/item/ammo_magazine/fallout_rifle/winchester = -1,
			/obj/item/ammo_magazine/fallout_rifle/winchester/extended = -1,
			/obj/item/weapon/gun/fallout_rifle/delisle = -1,
			/obj/item/weapon/gun/fallout_rifle/varmint = -1),
		"Sidearms" = list(
			/obj/item/weapon/gun/fallout_pistol/p220 = -1,
			/obj/item/weapon/gun/fallout_pistol/m9fs = -1,
			/obj/item/ammo_magazine/fallout_pistol = -1,
			/obj/item/weapon/gun/fallout_pistol/n99 = -1,
			/obj/item/ammo_magazine/fallout_pistol/ten = -1,
			/obj/item/weapon/gun/fallout_pistol/m1911 = -1,
			/obj/item/ammo_magazine/fallout_pistol/acp = -1,
			/obj/item/weapon/gun/fallout_pistol/ruger = -1,
			/obj/item/ammo_magazine/fallout_pistol/subsonic = -1,
			/obj/item/weapon/gun/fallout_pistol/deagle = -1,
			/obj/item/ammo_magazine/fallout_pistol/action_express = -1,
			/obj/item/weapon/gun/fallout_pistol/police_revolver = -1,
			/obj/item/ammo_magazine/fallout_pistol/magnum357 = -1,
			/obj/item/weapon/gun/fallout_pistol/magnum44 = -1,
			/obj/item/ammo_magazine/fallout_pistol/magnum44 = -1,
			/obj/item/weapon/gun/fallout_pistol/sequoia = -1,
			/obj/item/ammo_magazine/fallout_pistol/govt = -1),
		"Ammo Boxes" = list(
			/obj/item/ammo_magazine/box = -1,
			/obj/item/ammo_magazine/box/ten = -1,
			/obj/item/ammo_magazine/box/acp = -1,
			/obj/item/ammo_magazine/box/subsonic = -1,
			/obj/item/ammo_magazine/box/magnum357 = -1,
			/obj/item/ammo_magazine/box/magnum44 = -1,
			/obj/item/ammo_magazine/box/assault_rifle = -1,
			/obj/item/ammo_magazine/box/winchester = -1,
			/obj/item/ammo_magazine/box/govt = -1),
		"Melee" = list(
			/obj/item/weapon/fallout_melee = -1,
			/obj/item/weapon/fallout_melee/knife = -1,
			/obj/item/weapon/fallout_melee/knife/hunting = -1,
			/obj/item/weapon/fallout_melee/knife/bowie = -1,
			/obj/item/weapon/fallout_melee/knife/trench = -1,
			/obj/item/weapon/fallout_melee/knife/switchblade = -1,
			/obj/item/weapon/fallout_melee/knife/bone = -1,
			/obj/item/weapon/fallout_melee/axe/fire = -1,
			/obj/item/weapon/fallout_melee/bat = -1,
			/obj/item/weapon/fallout_melee/bat/metal = -1,
			/obj/item/weapon/fallout_melee/knuckles = -1,
			/obj/item/weapon/shield/fallout_shield = -1,
			/obj/item/weapon/shield/fallout_shield/reinforced = -1),
		"Explosives & Ordnance" = list(
			/obj/item/explosive/grenade/m15 = -1,
			/obj/item/mortal_shell/he = -1,
			/obj/item/mortal_shell/incendiary = -1,
			/obj/item/mortal_shell/smoke = -1,
			/obj/item/mortal_shell/flare = -1),
		"Equipment" = list(
			/obj/item/flashlight/fallout = -1,
			/obj/item/flashlight/fallout/flare = -1,
			/obj/item/radio/fallout = -1,
			/obj/item/binoculars/fallout = -1,
			/obj/item/tool/extinguisher = -1,
			/obj/item/tool/shovel = -1,
			/obj/item/stack/sandbags_empty/full = -1),
		"Clothing, Armor, and Accessories" = list(
			/obj/item/clothing/under/fallout/ncr = -1,
			/obj/item/clothing/suit/storage/fallout/ncr = -1,
			/obj/item/clothing/head/helmet/fallout/ncr = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/reinforced = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/mantle = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/mantle_reinforced = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/officer = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/officer_reinforced = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/patrol = -1,
			/obj/item/clothing/head/helmet/fallout/ncr/patrol = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/scout = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/scout_officer = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/officer_coat = -1,
			/obj/item/clothing/suit/storage/fallout/ncr/combat = -1,
			/obj/item/clothing/head/helmet/fallout/ncr/combat = -1,
			/obj/item/clothing/mask/fallout/ncr = -1,
			/obj/item/clothing/head/helmet/fallout/ncr/goggles = -1,
			/obj/item/clothing/head/helmet/fallout/ncr/helmet_gambler = -1,
			/obj/item/clothing/head/helmet/fallout/ncr/helmet_bandolier = -1,
			/obj/item/clothing/head/helmet/fallout/ncr/helmet_mp = -1,
			/obj/item/clothing/head/helmet/fallout/ncr/helmet_medic = -1,
			/obj/item/clothing/head/helmet/fallout/ncr/helmet_engineer = -1,
			/obj/item/clothing/head/fallout/ncr = -1,
			/obj/item/clothing/head/fallout/ncr/flapcap = -1,
			/obj/item/clothing/head/fallout/ncr/hat_slouch = -1,
			/obj/item/clothing/head/fallout/ncr/formal_cap = -1,
			/obj/item/clothing/head/fallout/ncr/hat_officer = -1,
			/obj/item/clothing/head/fallout/ncr/beret = -1,
			/obj/item/clothing/head/fallout/ncr/beret_medical = -1,
			/obj/item/clothing/head/fallout/ncr/beret_engineering = -1,
			/obj/item/clothing/head/fallout/ncr/beret_recon = -1,
			/obj/item/clothing/head/fallout/ncr/beret_officer = -1,
			/obj/item/clothing/head/fallout/ncr/beret_staff = -1,
			/obj/item/storage/belt/fallout/ncr = -1,
			/obj/item/storage/belt/fallout/tools = -1,
			/obj/item/storage/belt/fallout/medical = -1,
			/obj/item/storage/belt/fallout/bandolier = -1,
			/obj/item/storage/belt/fallout/bandolier/alt = -1,
			/obj/item/storage/pouch/fallout = -1,
			/obj/item/storage/pouch/fallout/magazine = -1,
			/obj/item/storage/pouch/fallout/medical = -1,
			/obj/item/storage/pouch/fallout/medical/doctor = -1,
			/obj/item/clothing/shoes/fallout/ncr = -1,
			/obj/item/clothing/shoes/fallout/ncr/scout = -1,
			/obj/item/clothing/gloves/fallout/ncr/fingerless = -1,
			/obj/item/clothing/gloves/fallout/ncr/patrol = -1),
		"Medical" = list(/obj/item/reagent_containers/hypospray/fallout/stimpak = -1, /obj/item/stack/medical/splint = -1))

//Legion vendor
/obj/machinery/vending/fallout/legion
	name = "\improper Legion Supply Vendor"
	desc = "Standard dispenser of Legion gear."
	icon_state = "legion"
	icon_vend = "legion_vend"
	icon_deny = "legion"
	wrenchable = FALSE
	shut_up = TRUE
	isshared = TRUE
	products = list(
		"Submachineguns" = list(
			/obj/item/weapon/gun/fallout_smg = -1,
			/obj/item/ammo_magazine/fallout_smg = -1,
			/obj/item/weapon/gun/fallout_smg/uzi = -1,
			/obj/item/ammo_magazine/fallout_smg/acp = -1,
			/obj/item/weapon/gun/fallout_smg/american180 = -1,
			/obj/item/ammo_magazine/fallout_smg/subsonic = -1),
		"Shotguns" = list(
			/obj/item/weapon/gun/fallout_shotgun = -1,
			/obj/item/weapon/gun/fallout_shotgun/short = -1,
			/obj/item/weapon/gun/fallout_shotgun/combat = -1,
			/obj/item/weapon/gun/fallout_shotgun/combat/short = -1,
			/obj/item/ammo_magazine/fallout_shotgun = -1,
			/obj/item/ammo_magazine/box/shotgun = -1),
		"Rifles" = list(
			/obj/item/weapon/gun/fallout_rifle/cowboy_repeater = -1,
			/obj/item/weapon/gun/fallout_rifle/hunting = -1,
			/obj/item/weapon/gun/fallout_rifle/hunting/short = -1,
			/obj/item/ammo_magazine/fallout_rifle/winchester = -1,
			/obj/item/ammo_magazine/fallout_rifle/winchester/extended = -1,
			/obj/item/weapon/gun/fallout_rifle/delisle = -1,
			/obj/item/weapon/gun/fallout_rifle/varmint = -1),
		"Sidearms" = list(
			/obj/item/weapon/gun/fallout_pistol = -1,
			/obj/item/ammo_magazine/fallout_pistol = -1,
			/obj/item/weapon/gun/fallout_pistol/type17 = -1,
			/obj/item/ammo_magazine/fallout_pistol/ten = -1,
			/obj/item/weapon/gun/fallout_pistol/m1911 = -1,
			/obj/item/ammo_magazine/fallout_pistol/acp = -1,
			/obj/item/weapon/gun/fallout_pistol/ruger = -1,
			/obj/item/ammo_magazine/fallout_pistol/subsonic = -1,
			/obj/item/weapon/gun/fallout_pistol/deagle = -1,
			/obj/item/ammo_magazine/fallout_pistol/action_express = -1,
			/obj/item/weapon/gun/fallout_pistol/colt357 = -1,
			/obj/item/ammo_magazine/fallout_pistol/magnum357 = -1,
			/obj/item/weapon/gun/fallout_pistol/magnum44 = -1,
			/obj/item/ammo_magazine/fallout_pistol/magnum44 = -1,
			/obj/item/weapon/gun/fallout_pistol/hunting_revolver = -1,
			/obj/item/ammo_magazine/fallout_pistol/govt = -1),
		"Ammo Boxes" = list(
			/obj/item/ammo_magazine/box = -1,
			/obj/item/ammo_magazine/box/ten = -1,
			/obj/item/ammo_magazine/box/acp = -1,
			/obj/item/ammo_magazine/box/subsonic = -1,
			/obj/item/ammo_magazine/box/magnum357 = -1,
			/obj/item/ammo_magazine/box/magnum44 = -1,
			/obj/item/ammo_magazine/box/assault_rifle = -1,
			/obj/item/ammo_magazine/box/winchester = -1,
			/obj/item/ammo_magazine/box/govt = -1),
		"Melee" = list(
			/obj/item/weapon/fallout_melee = -1,
			/obj/item/weapon/fallout_melee/gladius = -1,
			/obj/item/weapon/fallout_melee/scrap = -1,
			/obj/item/weapon/fallout_melee/bumper = -1,
			/obj/item/weapon/fallout_melee/knife = -1,
			/obj/item/weapon/fallout_melee/knife/hunting = -1,
			/obj/item/weapon/fallout_melee/knife/bowie = -1,
			/obj/item/weapon/fallout_melee/knife/trench = -1,
			/obj/item/weapon/fallout_melee/knife/switchblade = -1,
			/obj/item/weapon/fallout_melee/knife/bone = -1,
			/obj/item/weapon/fallout_melee/spear = -1,
			/obj/item/weapon/fallout_melee/spear/throwing = -1,
			/obj/item/weapon/fallout_melee/spear/scrap = -1,
			/obj/item/weapon/fallout_melee/spear/bone = -1,
			/obj/item/weapon/fallout_melee/axe/fire = -1,
			/obj/item/weapon/fallout_melee/axe/bone = -1,
			/obj/item/weapon/fallout_melee/hammer = -1,
			/obj/item/weapon/fallout_melee/bat = -1,
			/obj/item/weapon/fallout_melee/bat/spiked = -1,
			/obj/item/weapon/fallout_melee/bat/metal = -1,
			/obj/item/weapon/fallout_melee/gauntlet = -1,
			/obj/item/weapon/fallout_melee/gauntlet/punch = -1,
			/obj/item/weapon/fallout_melee/gauntlet/mole = -1,
			/obj/item/weapon/fallout_melee/knuckles = -1,
			/obj/item/weapon/fallout_melee/knuckles/spiked = -1,
			/obj/item/weapon/shield/fallout_shield/buckler = -1,
			/obj/item/weapon/shield/fallout_shield/reinforced/legion = -1,
			/obj/item/weapon/shield/fallout_shield/roman = -1),
		"Explosives & Ordnance" = list(
			/obj/item/explosive/grenade/stick = -1,
			/datum/ammo/rocket/atgun_shell = -1),
		"Equipment" = list(
			/obj/item/flashlight/fallout/lantern = -1,
			/obj/item/flashlight/fallout/flare/torch = -1,
			/obj/item/radio/fallout = -1,
			/obj/item/binoculars/fallout = -1,
			/obj/item/tool/extinguisher = -1,
			/obj/item/tool/shovel = -1,
			/obj/item/stack/sandbags_empty/full = -1),
		"Clothing, Armor, and Accessories" = list(
			/obj/item/clothing/under/fallout/legion = -1,
			/obj/item/clothing/suit/storage/fallout/legion = -1,
			/obj/item/clothing/head/helmet/fallout/legion = -1,
			/obj/item/clothing/suit/storage/fallout/legion/prime = -1,
			/obj/item/clothing/head/helmet/fallout/legion/prime = -1,
			/obj/item/clothing/suit/storage/fallout/legion/explorer = -1,
			/obj/item/clothing/head/helmet/fallout/legion/explorer = -1,
			/obj/item/clothing/suit/storage/fallout/legion/veteran = -1,
			/obj/item/clothing/head/helmet/fallout/legion/veteran = -1,
			/obj/item/clothing/suit/storage/fallout/legion/vexillarius = -1,
			/obj/item/clothing/head/helmet/fallout/legion/vexillarius = -1,
			/obj/item/clothing/suit/storage/fallout/legion/slavemaster = -1,
			/obj/item/clothing/head/helmet/fallout/legion/slavemaster = -1,
			/obj/item/clothing/suit/storage/fallout/legion/scout_coat = -1,
			/obj/item/clothing/suit/storage/fallout/legion/venator = -1,
			/obj/item/clothing/head/helmet/fallout/legion/venator = -1,
			/obj/item/clothing/suit/storage/fallout/legion/heavy = -1,
			/obj/item/clothing/head/helmet/fallout/legion/heavy = -1,
			/obj/item/clothing/head/helmet/fallout/legion/decanus = -1,
			/obj/item/clothing/head/helmet/fallout/legion/decanus_prime = -1,
			/obj/item/clothing/head/helmet/fallout/legion/decanus_veteran = -1,
			/obj/item/clothing/mask/fallout/legion = -1,
			/obj/item/clothing/mask/fallout/legion/black = -1,
			/obj/item/clothing/mask/fallout/legion/decanus = -1,
			/obj/item/clothing/mask/fallout/legion/centurion = -1,
			/obj/item/clothing/head/fallout/legion = -1,
			/obj/item/storage/belt/fallout/legion = -1,
			/obj/item/storage/belt/fallout/tools = -1,
			/obj/item/storage/belt/fallout/medical = -1,
			/obj/item/storage/belt/fallout/bandolier = -1,
			/obj/item/storage/belt/fallout/bandolier/alt = -1,
			/obj/item/storage/pouch/fallout = -1,
			/obj/item/storage/pouch/fallout/magazine = -1,
			/obj/item/storage/pouch/fallout/medical = -1,
			/obj/item/storage/pouch/fallout/medical/doctor = -1,
			/obj/item/clothing/shoes/fallout/legion = -1,
			/obj/item/clothing/shoes/fallout/legion/sandals = -1,
			/obj/item/clothing/shoes/fallout/legion/pelt = -1,
			/obj/item/clothing/shoes/fallout/legion/metal = -1,
			/obj/item/clothing/gloves/fallout/legion = -1,
			/obj/item/clothing/gloves/fallout/metal = -1),
		"Medical" = list(/obj/item/stack/medical/heal_pack/healing_powder = -1, /obj/item/stack/medical/splint = -1))
