//Basic Fallout mob
/mob/living/carbon/fallout
	name = "abomination"
	desc = "What... what is this?!"
	icon = 'fallout/fallout icons/fallout mobs/fallout_nonhumanoids.dmi'
	gender = NEUTER
	health_threshold_dead = 0	//In the future, give mobs special actions during crit
	var/attack_speed = ATTACK_SPEED_MEDIUM
	var/attack_effect = "claw"
	var/datum/looping_sound/idle/idle_sound_loop
	///What to play when idling, if anything
	var/idle_sound
	///Plays on initial encounter
	var/aggro_sound
	var/datum/looping_sound/hostile/combat_sound_loop
	///Played when hostile
	var/combat_sound
	///Played on mob death
	var/death_sound
	///The Y position of effects
	var/effect_offset_y

/mob/living/carbon/fallout/Initialize()
	. = ..()
	idle_sound_loop = new(list(src), FALSE)
	idle_sound_loop.start(src)
	combat_sound_loop = new(list(src), FALSE)
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno/fallout, null)

/mob/living/carbon/fallout/Destroy()
	. = ..()
	QDEL_NULL(combat_sound_loop)

/mob/living/carbon/fallout/update_icons()
	if(HAS_TRAIT(src, TRAIT_MOB_ICON_UPDATE_BLOCKED))
		return
	if(stat == DEAD)
		icon_state = "[initial(icon_state)]_dead"

/mob/living/carbon/fallout/update_transform()
	return update_icons()

//To-do: use add hard-armor system to these mobs, they only calculate soft armor
/mob/living/carbon/fallout/apply_damage(damage, damagetype, def_zone, blocked, sharp, edge, updating_health)
	if(..())
		SEND_SIGNAL(src, COMSIG_MOB_TAKING_DAMAGE, damage)

/mob/living/carbon/fallout/on_death()
	. = ..()
	if(death_sound)
		playsound(src, death_sound, 100, FALSE, 7, 1)
	idle_sound_loop.stop()
	combat_sound_loop.stop()

/mob/living/carbon/fallout/UnarmedAttack(atom/A, has_proximity, modifiers)
	if(!(isopenturf(A))) //We don't care about open turfs; they don't trigger our melee click cooldown
		changeNext_move(attack_speed)
	A.attack_animal(src)

/mob/living/carbon/fallout/attack_animal(mob/living/carbon/fallout/M as mob)
	if(M.melee_damage == 0)
		M.emote("me", EMOTE_VISIBLE, "[M.friendly] [src]")
	else
		if(M.attack_sound)
			playsound(loc, M.attack_sound, 25, 1)
		visible_message(span_danger("[M] [M.attacktext] [src]!"))
		var/damage = M.melee_damage
		var/armor = get_soft_armor("melee")
		apply_damage(damage, BRUTE, null, armor, updating_health = TRUE)
		M.do_attack_animation(src, M.attack_effect)

//Leave it here for now
/obj/attack_animal(mob/living/user)
	if(user.melee_damage && istype(user, /mob/living/carbon/fallout))
		return attack_alien(user, user.melee_damage)
	else
		. = ..()

//Taken from xeno code; what happens when a human touches the mob with an empty hand
/mob/living/carbon/fallout/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	if(status_flags & INCORPOREAL)
		return
	var/mob/living/carbon/human/H = user
	H.changeNext_move(7)
	switch(H.a_intent)
		if(INTENT_HELP)
			if(stat == DEAD)
				H.visible_message(span_warning("\The [H] pokes \the [src], but nothing happens."), \
				span_warning("You poke \the [src], but nothing happens."), null, 5)
			else
				H.visible_message(span_notice("\The [H] pets \the [src]."), \
					span_notice("You pet \the [src]."), null, 5)
		if(INTENT_GRAB)
			if(H == src || anchored)
				return 0
			H.start_pulling(src)
		if(INTENT_DISARM, INTENT_HARM)
			var/datum/unarmed_attack/attack = H.species.unarmed
			if(!attack.is_usable(H))
				attack = H.species.secondary_unarmed
			if(!attack.is_usable(H))
				return FALSE
			if(!H.melee_damage)
				H.do_attack_animation(src)
				playsound(loc, attack.miss_sound, 25, TRUE)
				visible_message(span_danger("[H] tried to [pick(attack.attack_verb)] [src]!"), null, null, 5)
				return FALSE
			H.do_attack_animation(src, ATTACK_EFFECT_YELLOWPUNCH)
			playsound(loc, attack.attack_sound, 50, TRUE, 10)
			visible_message(span_danger("[H] [pick(attack.attack_verb)]ed [src]!"), null, null, 5)
			apply_damage(melee_damage + attack.damage, BRUTE, "chest", soft_armor.getRating("melee"), updating_health = TRUE)

///Little ping animation that plays
/mob/living/carbon/fallout/proc/alerted(mob/living/carbon/fallout/M)
	playsound(loc, aggro_sound, 100, FALSE, 7)
	var/image/I = image('fallout/fallout icons/fallout_effects.dmi', M, "exclamation", CHAT_LAYER-1, 1, 0 - pixel_x, 0)
	flick_overlay_view(I, M, 3 SECONDS)
	I.alpha = 0
	animate(I, alpha = 255, time = 1 SECONDS)
	I.alpha = 255
	animate(I, pixel_z = effect_offset_y, time = 2 SECONDS, easing = BOUNCE_EASING)

/datum/ai_behavior/xeno/fallout
	target_distance = 6
	var/is_hostile
	///Time before a mob stops searching for it's target
	var/aggro_time = 20 SECONDS
	///Timer that counts down from aggro_time; mob loses aggro when it does
	var/current_timer
	var/mob/living/current_target

/datum/ai_behavior/xeno/fallout/start_ai()
	RegisterSignal(mob_parent, COMSIG_MOB_TAKING_DAMAGE, .proc/on_damage_taken)
	return ..()

/datum/ai_behavior/xeno/fallout/late_initialize()
	if(current_action == FOLLOWING_PATH)	//To stop mobs getting stuck in FOLLOWING_PATH mode when next to a node
		change_action(MOVING_TO_NODE, current_node)
	..()

/datum/ai_behavior/xeno/fallout/look_for_new_state()
	switch(current_action)
		if(ESCORTING_ATOM)
			if(get_dist(escorted_atom, mob_parent) > 10)
				cleanup_current_action()
				base_action = MOVING_TO_NODE
				late_initialize()
				return
			var/atom/next_target = get_nearest_target_in_view(escorted_atom, target_distance, ALL, mob_parent.faction)
			if(!next_target)
				return
			change_action(MOVING_TO_ATOM, next_target)
		if(FOLLOWING_PATH)
			var/atom/next_target = get_nearest_target_in_view(mob_parent, target_distance, ALL, mob_parent.faction)
			if(!next_target)
				return
			change_action(MOVING_TO_ATOM, next_target)
		if(MOVING_TO_NODE)
			var/atom/next_target = get_nearest_target_in_view(mob_parent, target_distance, ALL, mob_parent.faction)
			if(!next_target)
				return
			change_action(MOVING_TO_ATOM, next_target)
		if(MOVING_TO_ATOM)
			if(escorted_atom && get_dist(escorted_atom, mob_parent) > target_distance)
				change_action(ESCORTING_ATOM, escorted_atom)
				return
			var/atom/next_target = get_nearest_target_in_view(mob_parent, target_distance, ALL, mob_parent.faction)
			if(!next_target && current_target && !current_timer)
				current_timer = addtimer(CALLBACK(src, .proc/lose_aggro), aggro_time, TIMER_STOPPABLE)
			if(!next_target)//We didn't find a target
				if(!is_hostile)
					cleanup_current_action()
					late_initialize()
				return
			current_target = next_target
			if(next_target == atom_to_walk_to)//We didn't find a better target
				return
			change_action(null, next_target)//We found a better target, change course!
		if(MOVING_TO_SAFETY)
			var/atom/next_target = get_nearest_target_in_view(escorted_atom, target_distance, ALL, mob_parent.faction)
			if(!next_target)//We are safe, try to find some weeds
				target_distance = initial(target_distance)
				cleanup_current_action()
				late_initialize()
				RegisterSignal(mob_parent, COMSIG_MOB_TAKING_DAMAGE, .proc/on_damage_taken)
				return
			if(next_target == atom_to_walk_to)
				return
			change_action(null, next_target, INFINITY)
		if(IDLE)
			var/atom/next_target = get_nearest_target_in_view(escorted_atom, target_distance, ALL, mob_parent.faction)
			if(!next_target)
				return
			change_action(MOVING_TO_ATOM, next_target)

/datum/ai_behavior/xeno/fallout/change_action(next_action, atom/next_target, special_distance_to_maintain)
	if(next_action == MOVING_TO_ATOM)
		var/mob/living/carbon/fallout/living_mob = mob_parent
		living_mob.alerted(living_mob)
		is_hostile = TRUE
		living_mob.a_intent = INTENT_HARM
		living_mob.idle_sound_loop.stop()
		living_mob.combat_sound_loop.start(living_mob)
		current_target = atom_to_walk_to
	. = ..()

//Removing the bit regarding current_node = null
/datum/ai_behavior/xeno/fallout/cleanup_current_action(next_action)
	if(current_action == ESCORTING_ATOM && next_action != ESCORTING_ATOM)
		clean_escorted_atom()
	unregister_action_signals(current_action)

/datum/ai_behavior/xeno/fallout/ask_for_pathfinding()
	if(get_dist(mob_parent, current_node) <= 1)
		return
	..()

/datum/ai_behavior/xeno/fallout/look_for_next_node(ignore_current_node, should_reset_goal_nodes)
	if(get_dist(mob_parent, current_node) <= 4)
		if(!current_action)	//Need to set an action because it is null when a mob is spawned in near a node
			change_action(MOVING_TO_NODE, current_node)
		return
	. = ..()

//We don't care about goal nodes and all that, we want to keep the first node found as the only node to use
/datum/ai_behavior/xeno/fallout/look_for_node_path()
	if(QDELETED(current_node))
		return
	if(!current_node)
		look_for_next_node()

/datum/ai_behavior/xeno/fallout/finished_node_move()
	return COMSIG_MAINTAIN_POSITION

///Called when current_timer reaches 0
/datum/ai_behavior/xeno/fallout/proc/lose_aggro()
	current_timer = null
	is_hostile = FALSE
	current_target = null
	var/mob/living/carbon/fallout/living_mob = mob_parent
	living_mob.a_intent = INTENT_HELP
	living_mob.idle_sound_loop.start(living_mob)
	living_mob.combat_sound_loop.stop()
	if(current_action == MOVING_TO_ATOM)
		change_action(MOVING_TO_NODE, current_node)

///Attack anyone that damages the mob from far away
/datum/ai_behavior/xeno/fallout/proc/on_damage_taken(datum/source, damage)
	SIGNAL_HANDLER
	if(!is_hostile)	//If it's in move to node mode, it's likely not aggro'ed so good time to call it
		is_hostile = TRUE
		target_distance = 30	//Should be far enough for even the longest scopes
		var/atom/next_target = get_nearest_target_in_view(mob_parent, target_distance, ALL, mob_parent.faction, mob_parent.get_xeno_hivenumber())
		change_action(MOVING_TO_ATOM, next_target)
		addtimer(VARSET_CALLBACK(src, target_distance, initial(target_distance)), 10 SECONDS)
	return

///Same thing as get_nearest_target but uses oview() for the calculation to prevent mobs from seeing through walls
/proc/get_nearest_target_in_view(atom/source, distance, target_flags, attacker_faction, attacker_hive)
	if(!source)
		return
	var/atom/nearest_target
	var/shorter_distance = distance + 1
	if(target_flags & TARGET_HUMAN)
		for(var/mob/living/nearby_human in oview(distance, source))
			if(nearby_human.stat == DEAD || nearby_human.faction == attacker_faction || nearby_human.alpha <= SCOUT_CLOAK_RUN_ALPHA)
				continue
			if(get_dist(source, nearby_human) < shorter_distance)
				nearest_target = nearby_human
				shorter_distance = get_dist(source, nearby_human) //better to recalculate than to save the var
	if(target_flags & TARGET_XENO)
		for(var/mob/nearby_xeno AS in cheap_get_xenos_near(source, shorter_distance - 1))
			if(source.issamexenohive(nearby_xeno))
				continue
			if(nearby_xeno.stat == DEAD || nearby_xeno.alpha <= HUNTER_STEALTH_RUN_ALPHA)
				continue
			if((nearby_xeno.status_flags & GODMODE) || (nearby_xeno.status_flags & INCORPOREAL)) //No attacking invulnerable/ai's eye!
				continue
			if(get_dist(source, nearby_xeno) < shorter_distance)
				nearest_target = nearby_xeno
				shorter_distance = get_dist(source, nearby_xeno)
	if(target_flags & TARGET_HUMAN_TURRETS)
		for(var/atom/nearby_turret AS in GLOB.marine_turrets)
			if(source.z != nearby_turret.z)
				continue
			if(!(get_dist(source, nearby_turret) < shorter_distance))
				continue
			nearest_target = nearby_turret
	if(target_flags & TARGET_UNMANNED_VEHICLE)
		for(var/atom/nearby_vehicle AS in GLOB.unmanned_vehicles)
			if(source.z != nearby_vehicle.z)
				continue
			if(!(get_dist(source, nearby_vehicle) < shorter_distance))
				continue
			nearest_target = nearby_vehicle
	return nearest_target
