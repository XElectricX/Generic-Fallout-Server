/obj/item/attachable/suppressor
	attach_shell_speed_mod = -0.5
	accuracy_mod = 0
	recoil_mod = -0.2
	scatter_mod = 0
	recoil_unwielded_mod = -0.2
	scatter_unwielded_mod = 0
	damage_falloff_mod = 0.2

//In the future, make it so bayonet sets force to 30 or something rather than add, because you are no longer using the gun as a club
/obj/item/attachable/bayonet
	desc = "A sharp blade for mounting on a weapon."
	force = 10
	throwforce = 10
	melee_mod = 10
	accuracy_mod = 0
	accuracy_unwielded_mod = 0
	size_mod = 0	//Most guns are already huge, no need to make them bigger

/obj/item/attachable/extended_barrel
	desc = "A lengthened barrel allows for reduced scatter, faster projectile speed, and lessen damage fall-off."
	damage_falloff_mod = 0.5	//This is a multiplier, so 50% as guns have it 0 by default
	attach_shell_speed_mod = 0.5
	accuracy_mod = 0
	accuracy_unwielded_mod = 0
	scatter_mod = -1
	scatter_unwielded_mod = -1
	size_mod = 0	//Guns are big already, as said above

/obj/item/attachable/compensator
	desc = "A muzzle attachment that significantly reduces recoil by diverting expelled gasses upwards."
	scatter_mod = 0
	scatter_unwielded_mod = 0
	recoil_mod = -1
	recoil_unwielded_mod = -1

/obj/item/attachable/reddot
	desc = "A red-dot sight for short to medium range. Increases weapon accuracy while aiming."
	accuracy_mod = 0.3
	accuracy_unwielded_mod = 0
	aim_mode_delay_mod = 0

/obj/item/attachable/flashlight
	desc = "A simple flashlight used for mounting on a firearm."
	light_mod = 5

/obj/item/attachable/quickfire
	desc = "An enhanced and upgraded autoloading mechanism for faster firing. \nHowever, it increases spread and recoil."
	delay_mod = -0.1	//This is a multiplier, lower is faster rate of fire
	scatter_mod = 1
	scatter_unwielded_mod = 1
	recoil_mod = 1
	recoil_unwielded_mod = 1
	accuracy_mod = 0
	accuracy_unwielded_mod = 0
	burst_mod = 0

/obj/item/attachable/verticalgrip
	desc = "A foregrip that provides stability for the user. Slightly reduces recoil and scatter when aiming. Opposite effect when not."
	scatter_mod = -0.5
	scatter_unwielded_mod = 0.5
	burst_scatter_mod = 0
	recoil_mod = -0.5
	recoil_unwielded_mod = 0.5
	accuracy_mod = 0
	accuracy_unwielded_mod = 0
	aim_speed_mod = 0
	aim_mode_movement_mult = 0
	size_mod = 0

/obj/item/attachable/angledgrip
	desc = "Ergonomic grip that greatly reduces wielding time."
	wield_delay_mod = -0.5 SECONDS
	scatter_unwielded_mod = 0
	recoil_mod = 0
	scatter_mod = 0
	accuracy_unwielded_mod = 0
	size_mod = 0

/obj/item/attachable/gyro
	desc = "A set of weights and balances to stabilize the weapon when moving or firing. Greatly reduces recoil."
	scatter_mod = 0
	scatter_unwielded_mod = 0
	recoil_mod = -1
	recoil_unwielded_mod = -1
	accuracy_unwielded_mod = 0
	movement_acc_penalty_mod = -0.5
	aim_mode_movement_mult = 0
	shot_marine_damage_falloff = 0

/obj/item/attachable/lasersight
	desc = "A laser sight placed under the barrel. Greatly increases hip firing accuracy and slightly increases aimed accuracy."
	accuracy_mod = 0.1
	accuracy_unwielded_mod = 0.3

/obj/item/attachable/foldable/bipod
	desc = "A simple set of telescopic poles to keep a weapon stabilized during firing. \nGreatly increases accuracy and reduces recoil and scatter when properly placed."
	deploy_time = 1 SECONDS
	melee_mod = 0
	size_mod = 0
	accuracy_mod = 0.3
	recoil_mod = -2
	scatter_mod = -2
	burst_scatter_mod = 0

/obj/item/attachable/scope/mini
	name = "short range scope"
	desc = "A small rail mounted sight with slight magnification."
	accuracy_unwielded_mod = 0
	aim_speed_mod = 0.2
	zoom_slowdown = 0.3
	zoom_tile_offset = 3

/obj/item/attachable/scope/anti_materiel
	name = "\improper Hecate rifle scope"
	desc = "Exclusive to the Hecate II anti-materiel rifle, this scope is fine tuned for long distance shooting."
	icon = 'fallout/fallout icons/fallout weapons/fallout_attachments.dmi'
	icon_state = "scope_hecate"
	zoom_tile_offset = 11
	zoom_viewsize = 6
	accuracy_unwielded_mod = 0

/obj/item/attachable/scope/missile_launcher
	name = "missile launcher targeting scope"
	desc = "Provides magnification and targeting lock."
	icon_state = "sniperscope_invisible"
	zoom_tile_offset = 11
	zoom_viewsize = 6
