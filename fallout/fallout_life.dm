/*	I suppose put anything related to basic mob stuff here	*/

/mob/living
	var/can_crawl = FALSE	//If this kind of mob can crawl while lying down or not
	var/crawl_speed = 8	//Multiplicative; see on_floored_trait_gain in init_signals.dm

/mob/living/carbon/human
	can_crawl = TRUE

/mob/living/carbon/human/attack_animal(mob/living/M as mob)
	. = ..()
	if(M.melee_damage && istype(M, /mob/living/carbon/fallout))
		var/mob/living/carbon/fallout/living_mob = M
		M.do_attack_animation(src, living_mob.attack_effect)

#define MOVESPEED_ID_CRAWLING "CRAWLING"
//These 3 procs handle who can crawl or not
/mob/living/on_floored_trait_gain(datum/source)
	if(buckled && buckled.buckle_lying != -1)
		set_lying_angle(buckled.buckle_lying) //Might not actually be laying down, like with chairs, but the rest of the logic applies.
	else if(!lying_angle)
		set_lying_angle(pick(90, 270))
	if(!can_crawl)
		set_canmove(FALSE)
	add_movespeed_modifier(MOVESPEED_ID_CRAWLING, TRUE, 0, NONE, TRUE, crawl_speed)

/mob/living/on_floored_trait_loss(datum/source)
	if(lying_angle)
		set_lying_angle(0)
	if(!can_crawl && !HAS_TRAIT(src, TRAIT_IMMOBILE))	//If you're incapacitated, you can't move anyways
		set_canmove(TRUE)
	remove_movespeed_modifier(MOVESPEED_ID_CRAWLING)

/mob/living/on_immobile_trait_loss(datum/source)
	if(!HAS_TRAIT(src, TRAIT_FLOORED) || can_crawl)
		set_canmove(TRUE)

/mob/living/set_lying_angle(new_lying)
	if(new_lying == lying_angle)
		return
	. = lying_angle
	lying_angle = new_lying
	update_transform()
	lying_prev = lying_angle
	SEND_SIGNAL(src, COMSIG_LIVING_SET_LYING_ANGLE)
	if(lying_angle)
		density = FALSE
		var/obj/item/item_to_unwield = get_held_item()	//Check for unwielding any wielded guns you lie down with
		if(item_to_unwield)
			item_to_unwield.unwield(usr)
		if(layer == initial(layer)) //to avoid things like hiding larvas.
			layer = LYING_MOB_LAYER //so mob lying always appear behind standing mobs
	else
		density = TRUE
		if(layer == LYING_MOB_LAYER)
			layer = initial(layer)

//No reason for this to be running at all
/mob/living/ff_check(total_damage, mob/living/victim)
	return

/*	Rather than using slowdown variable, editing this proc so that walk speed is not affected at the same rate sprinting is
	The problem with using the config values was that it affected every single mob, resulting in unintended consequences	*/
#define HUMAN_WALK_SPEED 3.5
#define HUMAN_RUN_SPEED 2

/mob/living/carbon/human/update_move_intent_effects()
	if(status_flags & INCORPOREAL)
		return FALSE
	switch(m_intent)
		if(MOVE_INTENT_WALK)
			add_movespeed_modifier(MOVESPEED_ID_MOB_WALK_RUN_CONFIG_SPEED, TRUE, 100, NONE, TRUE, HUMAN_WALK_SPEED + CONFIG_GET(number/movedelay/walk_delay))
		if(MOVE_INTENT_RUN)
			add_movespeed_modifier(MOVESPEED_ID_MOB_WALK_RUN_CONFIG_SPEED, TRUE, 100, NONE, TRUE, HUMAN_RUN_SPEED + CONFIG_GET(number/movedelay/run_delay))

//TGMC bomb values are way too strong, lowering them here
/mob/living/carbon/human/ex_act(severity)
	if(status_flags & GODMODE)
		return
	var/b_loss = 0
	var/f_loss = 0
	var/armor = get_soft_armor("bomb") * 0.01 //Gets average bomb armor over all limbs.
	switch(severity)
		if(EXPLODE_DEVASTATE)
			b_loss += rand(60, 100)
			f_loss += rand(60, 100)
			if(!istype(wear_ear, /obj/item/clothing/ears/earmuffs))
				adjust_ear_damage(60 - (60 * armor), 240 - (240 * armor))
			adjust_stagger(12 - (12 * armor))
			add_slowdown((120 - round(120 * armor, 1)) * 0.01)
		if(EXPLODE_HEAVY)
			b_loss += rand(25, 60)
			f_loss += rand(25, 60)
			if(!istype(wear_ear, /obj/item/clothing/ears/earmuffs))
				adjust_ear_damage(30 - (30 * armor), 120 - (120 * armor))
			adjust_stagger(6 - (6 * armor))
			add_slowdown((60 - round(60 * armor, 1)) * 0.1)
		if(EXPLODE_LIGHT)
			b_loss += rand(10, 25)
			f_loss += rand(10, 25)
			if(!istype(wear_ear, /obj/item/clothing/ears/earmuffs))
				adjust_ear_damage(10 - (10 * armor), 30 - (30 * armor))
			adjust_stagger(3 - (3 * armor))
			add_slowdown((30 - round(30 * armor, 1)) * 0.1)
	#ifdef DEBUG_HUMAN_ARMOR
	to_chat(world, "DEBUG EX_ACT: armor: [armor * 100], b_loss: [b_loss], f_loss: [f_loss]")
	#endif
	take_overall_damage(b_loss, f_loss, armor * 100, updating_health = TRUE)

/* All of this is necessary just to stop blood splattering effect when damage taken is 0, incredible */
//Need to redefine because projectile.dm undefined them -_-
#define BULLET_FEEDBACK_PEN (1<<0)
#define BULLET_FEEDBACK_SOAK (1<<1)
#define BULLET_FEEDBACK_FIRE (1<<2)
#define BULLET_FEEDBACK_SCREAM (1<<3)
#define BULLET_FEEDBACK_SHRAPNEL (1<<4)
#define BULLET_FEEDBACK_IMMUNE (1<<5)
#define PROJECTILE_HIT 1

//Adding FALSE values if damage is 0
/mob/living/bullet_act(obj/projectile/proj)
	/* Need to paste in the code from atom/bullet_act because if I use ..() it will just call living/bullet_act twice */
	if(HAS_TRAIT(proj, TRAIT_PROJ_HIT_SOMETHING))
		proj.damage *= proj.ammo.on_pierce_multiplier
		proj.penetration *= proj.ammo.on_pierce_multiplier
		proj.sundering *= proj.ammo.on_pierce_multiplier
	ADD_TRAIT(proj, TRAIT_PROJ_HIT_SOMETHING, BULLET_ACT_TRAIT)
	SEND_SIGNAL(src, COMSIG_ATOM_BULLET_ACT, proj)
	/* The actual living/bullet_act below */
	if(stat == DEAD)
		return
	var/damage = max(0, proj.damage - round(proj.distance_travelled * proj.damage_falloff))
	if(!damage)
		return FALSE	//Fallout edit
	damage = check_shields(COMBAT_PROJ_ATTACK, damage, proj.ammo.armor_type)
	if(!damage)
		proj.ammo.on_shield_block(src, proj)
		bullet_ping(proj)
		return FALSE	//Fallout edit
	flash_weak_pain()
	var/feedback_flags = NONE
	var/living_hard_armor = (proj.ammo.flags_ammo_behavior & AMMO_IGNORE_ARMOR) ? 0 : get_hard_armor(proj.armor_type, proj.def_zone, proj.dir)
	var/living_soft_armor = (proj.ammo.flags_ammo_behavior & AMMO_IGNORE_ARMOR) ? 0 : get_soft_armor(proj.armor_type, proj.def_zone, proj.dir)
	if(living_hard_armor || living_soft_armor)
		if(proj.penetration > 0)
			if(proj.shot_from && src == proj.shot_from.sniper_target(src))
				damage *= SNIPER_LASER_DAMAGE_MULTIPLIER
				proj.penetration *= SNIPER_LASER_ARMOR_MULTIPLIER
				add_slowdown(SNIPER_LASER_SLOWDOWN_STACKS)
			if(living_hard_armor)
				living_hard_armor = max(0, living_hard_armor - (living_hard_armor * proj.penetration * 0.01)) //AP reduces a % of hard armor.
			if(living_soft_armor)
				living_soft_armor = max(0, living_soft_armor - proj.penetration) //Flat removal.
		if(iscarbon(proj.firer))
			var/mob/living/carbon/shooter_carbon = proj.firer
			if(shooter_carbon.stagger)
				damage *= STAGGER_DAMAGE_MULTIPLIER //Since we hate RNG, stagger reduces damage by a % instead of reducing accuracy; consider it a 'glancing' hit due to being disoriented.
		if(!living_hard_armor && !living_soft_armor) //Armor fully penetrated.
			feedback_flags |= BULLET_FEEDBACK_PEN
		else
			if(living_hard_armor)
				damage = max(0, damage - living_hard_armor) //Damage soak.
			if(!damage) //Damage fully negated by hard armor.
				bullet_soak_effect(proj)
				feedback_flags |= BULLET_FEEDBACK_IMMUNE
			else if(living_soft_armor >= 100) //Damage fully negated by soft armor.
				damage = 0
				bullet_soak_effect(proj)
				feedback_flags |= BULLET_FEEDBACK_SOAK
			else if(living_soft_armor) //Soft armor/padding, damage reduction.
				damage = max(0, damage - (damage * living_soft_armor * 0.01))
	if(proj.ammo.flags_ammo_behavior & AMMO_INCENDIARY)
		//We are checking the total distributed mob's armor now, not just the limb.
		//Fire mod represents our fire resistance, while hard armor represents certain armor's resistance to burning material sticking to it.
		var/fire_mod = get_fire_resist()
		var/fire_hard_armor = get_hard_armor("fire", BODY_ZONE_CHEST)
		if(fire_mod > 0 && fire_hard_armor < 100) //If the modifier is not bigger than zero or the hard armor is 100 then the armor fully absorbs this effect.
			adjust_fire_stacks(CEILING(proj.ammo.incendiary_strength * fire_mod * ((100- fire_hard_armor) * 0.01), 1)) //We could add an ammo fire strength in time, as a variable.
			IgniteMob()
			feedback_flags |= (BULLET_FEEDBACK_FIRE|BULLET_FEEDBACK_SCREAM)
	if(proj.ammo.flags_ammo_behavior & AMMO_SUNDERING)
		adjust_sunder(proj.sundering)
	if(damage)
		var/shrapnel_roll = do_shrapnel_roll(proj, damage)
		if(shrapnel_roll)
			feedback_flags |= (BULLET_FEEDBACK_SHRAPNEL|BULLET_FEEDBACK_SCREAM)
		else if(prob(damage * 0.25))
			feedback_flags |= BULLET_FEEDBACK_SCREAM
		bullet_message(proj, feedback_flags, damage)
		proj.play_damage_effect(src)
		apply_damage(damage, proj.ammo.damage_type, proj.def_zone, updating_health = TRUE) //This could potentially delete the source.
		if(shrapnel_roll)
			embed_projectile_shrapnel(proj)
	else
		bullet_message(proj, feedback_flags)
	GLOB.round_statistics.total_projectile_hits[faction]++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "total_projectile_hits[faction]")
	/* Fallout edit */
	if(damage)
		return TRUE
	else
		return FALSE

/mob/living/carbon/do_projectile_hit(obj/projectile/proj)
	proj.ammo.on_hit_mob(src, proj)
	if(!bullet_act(proj))	//If damage from a bullet is 0, no blood splatter
		return
	if(!(species?.species_flags & NO_BLOOD) && proj.ammo.flags_ammo_behavior & AMMO_BALLISTIC)
		new /obj/effect/temp_visual/dir_setting/bloodsplatter(loc, proj.dir, get_blood_color())
