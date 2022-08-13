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
