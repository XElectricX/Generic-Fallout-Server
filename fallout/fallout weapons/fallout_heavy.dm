/obj/item/weapon/gun/fallout/heavy
	name = "\improper Vickers machinegun"
	desc = "Ol' reliable Vickers. Easy to maintain and rarely breaks down. Modified to be air-cooled and use belts of .308 Winchester."
	icon = 'fallout/fallout icons/fallout weapons/fallout_heavy.dmi'
	icon_state = "vickers"
	fire_sound = 'sound/weapons/guns/fire/hmg.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/T42_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/type71_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/minigun_cocked.ogg'
	windup_sound = 'sound/weapons/guns/fire/tank_minigun_start.ogg'
	w_class = WEIGHT_CLASS_HUGE
	gun_skill_category = GUN_SKILL_HEAVY_WEAPONS
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	flags_item = IS_DEPLOYABLE|TWOHANDED
	flags_gun_features = GUN_DEPLOYED_FIRE_ONLY
	default_ammo_type = /obj/item/ammo_magazine/fallout_belt/winchester
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_belt/winchester)
	caliber = CALIBER_308WIN
	max_shells = 250
	fire_delay = 0.2 SECONDS
	force = 50
	scatter = 0
	scatter_unwielded = 10
	deploy_time = 10 SECONDS
	undeploy_time = 10 SECONDS
	starting_attachment_types = list(/obj/item/attachable/scope/machinegun_sights)
	attachable_allowed = list(/obj/item/attachable/scope/machinegun_sights)
	attack_speed = ATTACK_SPEED_VERY_SLOW
	deployable_item = /obj/machinery/deployable/mounted

/obj/item/weapon/gun/fallout/heavy/maxim
	name = "\improper Maxim machinegun"
	desc = "World's first fully automatic machinegun. Simple enough to produce and maintain, but very bulky. Good thing it's on wheels."
	icon_state = "maxim"
	fire_sound = 'sound/weapons/guns/fire/t42.ogg'
	flags_item = DEPLOY_ON_INITIALIZE|IS_DEPLOYABLE|DEPLOYED_NO_PICKUP|TWOHANDED
	fire_delay = 0.3 SECONDS
	scatter = 5
	deployable_item = /obj/machinery/deployable/mounted/moveable

/obj/item/weapon/gun/fallout/heavy/m1919
	name = "\improper Browning M1919"
	desc = "Widely used medium machinegun from the 20th century. More compact and mobile than the .50 caliber M2s for ease of transporting. Re-chambered in the plentiful 5.56mm."
	icon_state = "browning"
	fire_sound = 'sound/weapons/guns/fire/hmg2.ogg'
	default_ammo_type = /obj/item/ammo_magazine/fallout_belt
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_belt)
	caliber = CALIBER_556X45
	max_shells = 300
	fire_delay = 0.15 SECONDS
	scatter = 5

/obj/item/weapon/gun/fallout/heavy/minigun
	name = "\improper CZ53 Rockwell minigun"
	desc = "Absolute peak dakka. Can use either machinegun magazines or be attached to an ammo backpack. Has a deployable tripod."
	icon_state = "minigun"
	fire_animation = "minigun_fire"
	muzzleflash_iconstate = "muzzle_flash"
	fire_sound = 'sound/weapons/guns/fire/minigun.ogg'
	unload_sound = 'sound/weapons/guns/interact/minigun_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/minigun_reload.ogg'
	flags_item = IS_DEPLOYABLE|TWOHANDED
	flags_gun_features = GUN_CAN_POINTBLANK|GUN_WIELDED_STABLE_FIRING_ONLY
	default_ammo_type = /obj/item/ammo_magazine/fallout_rifle/machinegun
	allowed_ammo_types = list(/obj/item/ammo_magazine/fallout_rifle/machinegun, /obj/item/ammo_magazine/fallout_ammopack)
	caliber = CALIBER_556X45
	max_shells = 500
	fire_delay = 0.1 SECONDS
	force = 40
	windup_delay = 0.5 SECONDS
	wield_delay = 1.5 SECONDS
	aim_slowdown = 3.5
	scatter = 10
	scatter_unwielded = 40
	deployed_scatter_change = -8
	recoil = 1
	recoil_unwielded = 20
	deploy_time = 5 SECONDS
	undeploy_time = 5 SECONDS
	attachable_offset = list("rail_x" = 26, "rail_y" = 20, "under_x" = 30, "under_y" = 8)
	starting_attachment_types = null
	attachable_allowed = list(/obj/item/attachable/flashlight, /obj/item/attachable/lasersight)

//For switching the sprite to the one with a belt
/obj/item/weapon/gun/fallout/heavy/minigun/update_icon()
	..()
	if(!length(chamber_items))
		icon_state = base_gun_icon + "_u"
		fire_animation = initial(fire_animation)
	else
		icon_state = base_gun_icon
	if(length(chamber_items) && !rounds)
		icon_state = base_gun_icon + "_e"
	for(var/obj/item/ammo_magazine/belt in chamber_items)	//Check if it has a belt mag
		if(istype(belt, /obj/item/ammo_magazine/fallout_ammopack))
			icon_state = base_gun_icon + "_b"
			fire_animation = initial(fire_animation) + "_b"
			if(!rounds)
				icon_state = base_gun_icon + "_u"
