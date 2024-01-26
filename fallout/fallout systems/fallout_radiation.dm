/* Anything radiation-related goes in this file */
/*----------------------------------------------*/

//Changing the way radiation works so that the status effect is infinite
/mob/living/adjust_radiation(amount, ignore_canstun = FALSE)
	if(status_flags & GODMODE)
		return
	var/datum/status_effect/incapacitating/irradiated/irradiated = is_irradiated(FALSE)
	if(!irradiated)
		irradiated = apply_status_effect(STATUS_EFFECT_IRRADIATED)
	irradiated.rads += amount
	return irradiated

/datum/status_effect/incapacitating/irradiated
	duration = -1	//Radiation won't just go away Ed boy
	tick_interval = 10 SECONDS
	alert_type = null

	var/rads = 0

/datum/status_effect/incapacitating/irradiated/tick()
	var/mob/living/living_owner = owner
	//Roulette of bad things
	switch(rads)
		if(0)
			living_owner.remove_status_effect(STATUS_EFFECT_IRRADIATED)
		if(1 to MAX_RADS / 10)
			if(prob(10))
				living_owner.adjustCloneLoss(rand(1, 3))
			if(prob(10))
				living_owner.adjustToxLoss(rand(1, 3))
		if(MAX_RADS_INTERVAL to MAX_RADS_INTERVAL * 2)
			if(prob(30))
				living_owner.adjustCloneLoss(rand(1, 5))
			if(prob(30))
				living_owner.adjustToxLoss(rand(1, 5))
		if(MAX_RADS_INTERVAL * 2 to MAX_RADS_INTERVAL * 3)
			if(prob(80))
				living_owner.adjustCloneLoss(rand(3, 5))
			living_owner.adjustToxLoss(rand(3, 5))
			if(prob(25))
				living_owner.blur_eyes(10)
		if(MAX_RADS_INTERVAL * 3 to MAX_RADS_INTERVAL * 4)
			living_owner.adjustCloneLoss(rand(5, 10))
			living_owner.adjustToxLoss(rand(5, 10))
			damage_organs(1, 5)
			if(prob(25))
				living_owner.blur_eyes(10)
		if(MAX_RADS_INTERVAL * 4 to MAX_RADS_INTERVAL * 5)
			living_owner.adjustCloneLoss(rand(10, 20))
			living_owner.adjustToxLoss(rand(10, 20))
			damage_organs(2, 10)
			if(prob(10))
				living_owner.vomit()
			if(prob(25))
				living_owner.blur_eyes(10)
		if(MAX_RADS_INTERVAL * 5 to MAX_RADS_INTERVAL * 6)
			living_owner.adjustCloneLoss(rand(20, 30))
			living_owner.adjustToxLoss(rand(20, 30))
			damage_organs(5, 10)
			if(prob(25))
				living_owner.vomit()
				living_owner.blur_eyes(10)
		if(MAX_RADS_INTERVAL * 6 to MAX_RADS_INTERVAL * 7)
			living_owner.adjustCloneLoss(rand(20, 30))
			living_owner.adjustToxLoss(rand(20, 30))
			damage_organs(5, 25)
			living_owner.blur_eyes(10)
			if(prob(50))
				living_owner.vomit()
		if(MAX_RADS_INTERVAL * 7 to MAX_RADS_INTERVAL * 8)
			living_owner.adjustCloneLoss(rand(10, 20))
			living_owner.adjustToxLoss(rand(10, 20))
			damage_organs(5, 50)
			living_owner.blur_eyes(25)
			if(prob(80))
				living_owner.vomit()
		if(MAX_RADS_INTERVAL * 8 to MAX_RADS_INTERVAL * 9)
			living_owner.adjust_Losebreath(5)	//Getting hard to breathe
			living_owner.adjustCloneLoss(rand(20, 30))
			living_owner.adjustToxLoss(rand(20, 30))
			damage_organs(5)
			living_owner.blur_eyes(50)
			living_owner.vomit()
			to_chat(living_owner, span_warning("Your insides are burning!"))
		if(MAX_RADS_INTERVAL * 9 to MAX_RADS)
			living_owner.adjust_Losebreath(10)
			living_owner.adjustCloneLoss(rand(30, 40))
			living_owner.adjustToxLoss(rand(30, 40))
			damage_organs(10)
			living_owner.blur_eyes(100)
			living_owner.vomit()
			to_chat(living_owner, span_warning("Your body is falling apart!"))
		else
			living_owner.adjustCloneLoss(200)
			living_owner.adjustToxLoss(200)
			if(living_owner.stat != DEAD)	//Just die already
				living_owner.death()

/datum/status_effect/incapacitating/irradiated/proc/damage_organs(amount, probability = 100)
	if(!carbon_owner || !prob(probability))
		return

	var/datum/internal_organ/organ = pick(carbon_owner.internal_organs)
	if(organ)
		organ.take_damage(amount)
