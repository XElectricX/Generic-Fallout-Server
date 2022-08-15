/*	I suppose put anything related to basic mob stuff here	*/

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
