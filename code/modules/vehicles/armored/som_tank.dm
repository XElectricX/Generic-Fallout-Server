//3x4
/obj/vehicle/sealed/armored/multitile/som_tank
	name = "\improper Malleus hover tank"
	desc = "A terrifying behemoth, the Malleus pattern hover tank is the SOM's main battle tank. Combining excellent mobility and formidable weaponry, it has earned a fearsome reputation among TerraGov forces that have faced it."
	icon = 'icons/obj/armored/3x4/som_tank.dmi'
	turret_icon = 'icons/obj/armored/3x4/som_tank_gun.dmi'
	damage_icon_path = 'icons/obj/armored/3x4/tank_damage.dmi'
	icon_state = "tank"
	hitbox = /obj/hitbox/rectangle/som_tank
	interior = /datum/interior/armored/som
	minimap_icon_state = "tank"
	minimap_flags = MINIMAP_FLAG_MARINE_SOM
	required_entry_skill = SKILL_LARGE_VEHICLE_DEFAULT
	armored_flags = ARMORED_HAS_PRIMARY_WEAPON|ARMORED_HAS_SECONDARY_WEAPON|ARMORED_HAS_HEADLIGHTS
	pass_flags = PASS_LOW_STRUCTURE|PASS_DEFENSIVE_STRUCTURE|PASS_FIRE
	pixel_x = -65
	pixel_y = -80
	max_integrity = 1200
	soft_armor = list(MELEE = 90, BULLET = 95 , LASER = 95, ENERGY = 95, BOMB = 85, BIO = 100, FIRE = 100, ACID = 70)
	hard_armor = list(MELEE = 5, BULLET = 5, LASER = 5, ENERGY = 10, BOMB = 30, BIO = 100, FIRE = 0, ACID = 0)
	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.55, VEHICLE_SIDE_ARMOUR = 1, VEHICLE_BACK_ARMOUR = 1.6)
	permitted_weapons = list(/obj/item/armored_weapon/volkite_carronade, /obj/item/armored_weapon/particle_lance, /obj/item/armored_weapon/coilgun, /obj/item/armored_weapon/secondary_mlrs)
	permitted_mods = list(/obj/item/tank_module/ability/smoke_launcher)
	max_occupants = 4
	move_delay = 0.3 SECONDS
	glide_size = 4.333 //todo: Fix glidesize for vehicles. It generates visibly choppy glide, possibly related to how vehicles use cooldown for movedelay
	ram_damage = 80
	easy_load_list = list(
		/obj/item/ammo_magazine/tank,
	)
	engine_sound = SFX_HOVER_TANK
	engine_sound_length = 1.2 SECONDS
	vis_range_mod = 4
	faction = FACTION_SOM

/obj/vehicle/sealed/armored/multitile/som_tank/Initialize(mapload)
	. = ..()
	add_filter("shadow", 2, drop_shadow_filter(0, -8, 1))
	animate_hover()
	var/obj/item/tank_module/module = new /obj/item/tank_module/ability/smoke_launcher()
	module.on_equip(src)

/obj/vehicle/sealed/armored/multitile/som_tank/generate_actions()
	. = ..()
	initialize_controller_action_type(/datum/action/vehicle/sealed/armored/strafe, VEHICLE_CONTROL_DRIVE)

/obj/vehicle/sealed/armored/multitile/som_tank/setDir(newdir)
	. = ..()
	swivel_turret(null, newdir)

/obj/vehicle/sealed/armored/multitile/som_tank/swivel_turret(atom/A, new_weapon_dir)
	if(new_weapon_dir != dir)
		return FALSE
	if(turret_overlay.dir == new_weapon_dir)
		return FALSE
	turret_overlay.setDir(new_weapon_dir)
	return TRUE

/obj/vehicle/sealed/armored/multitile/som_tank/play_engine_sound(freq_vary = TRUE, sound_freq = 32000) //arg override
	return ..()

/obj/vehicle/sealed/armored/multitile/som_tank/lava_act()
	return //we flying baby

///Animates the bob for the tank and its desants
/obj/vehicle/sealed/armored/multitile/som_tank/proc/animate_hover()
	var/list/hover_list = list(src)
	if(length(hitbox.tank_desants))
		hover_list += hitbox.tank_desants
	for(var/atom/atom AS in hover_list)
		animate(atom, time = 1.2 SECONDS, loop = -1, easing = SINE_EASING, flags = ANIMATION_RELATIVE|ANIMATION_END_NOW, pixel_y = 3)
		animate(time = 1.2 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE, pixel_y = -3)

/obj/vehicle/sealed/armored/multitile/som_tank/add_desant(mob/living/new_desant)
	. = ..()
	animate_hover()

/obj/vehicle/sealed/armored/multitile/som_tank/remove_desant(mob/living/old_desant)
	. = ..()
	animate(old_desant)
