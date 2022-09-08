/*	Fallout chemicals and their effects -- See fallout_drinks.dm for beverages

	Stimfluid - What goes inside stimpaks, heals brute and burns
	Med-X - Increase max health and pain tolerance
	Bitter Drink - Heals brute and burns slowly over time
	Hydra - Repairs bones, slight painkiller effect, anti-venom
	Jet - Spacedrugs equivalent with minor stamina healing
	Turbo - Jet but with a speed and stamina bonus
	Methamphetamine - Slight max health and max stamina boosts, makes you high
	Psycho - Makes user stronger and more aggressive
	Buffout - Make user stronger and increase max health, like Psycho and Med-X but inferior to both	*/

#define COMSIG_STAMINA_REGEN "stamina_regen"

//Want all chemicals to show up on health scanner for now
/datum/reagent
	scannable = TRUE

//Medicinal drugs
/datum/reagent/medicine/stimpak
	name = "Stim Fluid"
	description = "Advanced medicinal solution that boosts the body's natural regeneration from physical injuries and increases blood cell production. Depletes the patient's energy."
	color = "#eb0000"
	taste_description = "antiseptic"
	overdose_threshold = REAGENTS_OVERDOSE/1.5	//20 units
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.6	//30 units
	custom_metabolism = REAGENTS_METABOLISM * 5	//Metabolizes quickly at 1 unit per tick

/datum/reagent/medicine/stimpak/on_mob_life(mob/living/L, metabolism)
	L.heal_limb_damage(5, 5)
	var/mob/living/carbon/C = L
	C.adjust_nutrition(-5)
	..()

/datum/reagent/medicine/stimpak/overdose_process(mob/living/L, metabolism)
	L.adjustToxLoss(1)
	var/mob/living/carbon/C = L
	C.adjust_nutrition(-3)

/datum/reagent/medicine/stimpak/overdose_crit_process(mob/living/L, metabolism)
	L.adjustToxLoss(3)
	var/mob/living/carbon/human/H = L
	var/affected_organ = pick("heart","lungs","liver","kidneys")
	var/datum/internal_organ/I =  H.internal_organs_by_name[affected_organ]
	I.take_damage(4)
	var/mob/living/carbon/C = L
	C.adjust_nutrition(-10)

/datum/reagent/medicine/stimpak/on_overdose_crit_start(mob/living/L, metabolism)
	to_chat(L, span_userdanger("Something is horribly wrong with your body! You feel weaker and weaker..."))

/datum/reagent/medicine/medx
	name = "Med-X Fluid"
	description = "Med-X is a potent painkiller, allowing users to withstand high amounts of pain and continue functioning. Addictive. Prolonged presence in the body can cause seizures and organ damage."
	color = "#6D6374"
	taste_description = "numbness"
	overdose_threshold = REAGENTS_OVERDOSE/1.5	//20 units
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.6	//30 units
	addiction_threshold = 25
	custom_metabolism = REAGENTS_METABOLISM/2

/datum/reagent/medicine/medx/on_mob_add(mob/living/L, metabolism)
	to_chat(L, span_notice("You feel tougher, able to shrug off pain more easily."))
	L.health_threshold_dead -= 50
	L.health_threshold_crit -= 50

/datum/reagent/medicine/medx/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_notice("The numbness fades..."))
	L.health_threshold_dead += 50
	L.health_threshold_crit += 50
	L.adjust_blurriness(20)
	L.dizzy(150)

/datum/reagent/medicine/medx/on_mob_life(mob/living/L, metabolism)
	L.reagent_pain_modifier += PAIN_REDUCTION_MEDIUM
	..()

/datum/reagent/medicine/medx/overdose_process(mob/living/L, metabolism)
	L.reagent_pain_modifier += PAIN_REDUCTION_HEAVY
	L.adjustToxLoss(2)

/datum/reagent/medicine/medx/overdose_crit_process(mob/living/L, metabolism)
	L.reagent_pain_modifier += PAIN_REDUCTION_VERY_HEAVY	//Maximum numbing!!!!
	L.adjustToxLoss(4)
	L.adjustOxyLoss(3)
	var/mob/living/carbon/human/H = L
	var/affected_organ = pick("heart","lungs","liver","kidneys")
	var/datum/internal_organ/I =  H.internal_organs_by_name[affected_organ]
	I.take_damage(4)

/datum/reagent/medicine/medx/on_overdose_crit_start(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You can't feel anything except your insides burning!"))

/datum/reagent/medicine/medx/addiction_act_stage1(mob/living/M)

/datum/reagent/medicine/medx/addiction_act_stage2(mob/living/M)


/datum/reagent/medicine/medx/addiction_act_stage3(mob/living/M)


/datum/reagent/medicine/medx/addiction_act_stage4(mob/living/M)

//Herbal remedies
/datum/reagent/medicine/bitter_drink
	name = "Bitter Drink"
	description = "An especially pungent beverage. Slow acting but very healthy for the body."
	color ="#A9FBFB"
	taste_description = "gut wrenching bitterness"
	overdose_threshold = REAGENTS_OVERDOSE/1.5	//20 units
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.6	//30 units
	custom_metabolism = REAGENTS_METABOLISM

/datum/reagent/medicine/bitter_drink/on_mob_life(mob/living/L, metabolism)
	L.heal_limb_damage(2, 2)
	..()

/datum/reagent/medicine/bitter_drink/overdose_process(mob/living/L, metabolism)
	L.adjustToxLoss(2)

/datum/reagent/medicine/bitter_drink/overdose_crit_process(mob/living/L, metabolism)
	L.adjustToxLoss(3)
	L.adjustOxyLoss(2)
	var/mob/living/carbon/human/H = L
	var/affected_organ = pick("heart","lungs","liver","kidneys")
	var/datum/internal_organ/I =  H.internal_organs_by_name[affected_organ]
	I.take_damage(3)

/datum/reagent/medicine/bitter_drink/on_overdose_crit_start(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You stomach is in agony!"))

/datum/reagent/medicine/hydra
	name = "Hydra"
	description = "A cocktail of herbal medicines designed to mend broken bones, provide pain relief, and cure poisoning."
	color ="#501c5a"
	taste_description = "something tingly with a bit of iron"
	overdose_threshold = REAGENTS_OVERDOSE/1.5	//20 units
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.6	//30 units
	custom_metabolism = REAGENTS_METABOLISM/2
	var/mending_ticker	//Track how long it has been
	var/time_to_mend = 500	//Time needed to fix a bone

/datum/reagent/medicine/hydra/on_mob_life(mob/living/carbon/human/L, metabolism)
	L.adjustToxLoss(-3)
	L.reagent_pain_modifier += PAIN_REDUCTION_LIGHT
	for(var/datum/limb/target_limb in L.limbs)
		if(target_limb.limb_status & LIMB_BROKEN)	//Only tick if you have broken limbs, no medicating in advance of a broken bone
			mending_ticker++
			if(mending_ticker >= time_to_mend)	//Enough time has passed to repair a bone!
				target_limb.remove_limb_flags(LIMB_BROKEN)
				mending_ticker = 0	//Reset the ticker
				to_chat(L, "<span class='green'>The broken bones in your [target_limb.display_name] have been mended!</span>")
	..()

/datum/reagent/medicine/hydra/overdose_process(mob/living/carbon/human/L, metabolism)
	L.adjustToxLoss(3)

/datum/reagent/medicine/hydra/overdose_crit_process(mob/living/carbon/human/L, metabolism)
	L.adjustToxLoss(8)

/datum/reagent/medicine/hydra/on_overdose_crit_start(mob/living/carbon/human/L, metabolism)
	to_chat(L, span_userdanger("You feel bone hurting juice coursing through your body!"))

//Recreational drugs
/datum/reagent/jet
	name = "Jet Inhalant"
	description = "A chemical used to induce a euphoric high derived from brahmin dung. Fast-acting, powerful, and highly addictive."
	color = "#60A584"
	overdose_threshold = 20
	addiction_threshold = 10

/datum/reagent/jet/on_mob_add(mob/living/L, metabolism)
	..()
	to_chat(L, span_notice("You feel an incredible high! You just absolutely love life in this moment!"))

/datum/reagent/jet/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_notice("You come down from your high. The wild ride is unfortunately over..."))
	L.dizzy(2)

/datum/reagent/jet/on_mob_life(mob/living/L, metabolism)
	L.adjustStaminaLoss(-1) //Refreshes user's stamina
	L.set_drugginess(20)
	if(prob(10) && !L.incapacitated(TRUE) && !L.pulledby && isfloorturf(L.loc))
		step(L, pick(GLOB.alldirs))
	if(prob(10))
		L.emote(pick("twitch","sniff","moan","cough"))
	..()

/datum/reagent/jet/overdose_process(mob/living/L, metabolism)
	to_chat(L, span_userdanger("Everything is slowing down even further!"))
	if(L.hallucination < volume && prob(20))
		L.hallucination += 10
		L.adjustToxLoss(10, 0)
		//L.adjustOrganLoss(ORGAN_SLOT_BRAIN, 60)
	..()

/datum/reagent/jet/addiction_act_stage1(mob/living/L, metabolism)
	if(prob(5))
		L.emote(pick("twitch","drool","shiver"))
	..()

/datum/reagent/jet/addiction_act_stage2(mob/living/L, metabolism)
	L.dizzy(5)
	if(prob(10))
		L.emote(pick("twitch","drool","shiver"))
	L.stuttering += 1
	..()

/datum/reagent/jet/addiction_act_stage3(mob/living/L, metabolism)
	if(prob(10) && !L.incapacitated(TRUE) && !L.pulledby && isfloorturf(L.loc))
		step(L, pick(GLOB.alldirs))
	L.dizzy(10)
	if(prob(20))
		L.emote(pick("twitch","drool","shiver"))
	L.stuttering += 1
	..()

/datum/reagent/jet/addiction_act_stage4(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel the energy from your body evaporating..."))
	L.max_stamina_buffer = 25 //Halved user's stamina "health"
	L.adjust_blurriness(10)
	L.dizzy(30)
	if(prob(50))
		L.emote(pick("twitch","drool","shiver"))
	L.stuttering += 2
	..()

/datum/reagent/turbo	//Turbo twice as potent as Jet, thus half the thresholds
	name = "Turbo Inhalant"
	description = "A chemical compound derived from Jet that increases speed and stamina."
	reagent_state = LIQUID
	color = "#FAFAFA"
	taste_description = "something sour and awful"
	overdose_threshold = REAGENTS_OVERDOSE/3	//10u overdose
	addiction_threshold = 5
	custom_metabolism = REAGENTS_METABOLISM/2	//Metabolizes twice as slow to compensate for potency

/mob/living/handle_staminaloss()
	var/list/regen_modifier = list()
	var/regen_bonus = 1
	SEND_SIGNAL(src, COMSIG_STAMINA_REGEN, regen_modifier)
	for(var/values in regen_modifier)
		regen_bonus *= values
	if(world.time < last_staminaloss_dmg + 3 SECONDS)
		return
	if(staminaloss > 0)
		adjustStaminaLoss((-maxHealth * 0.2) * regen_bonus, TRUE, FALSE)	//Default tired regen speed is 20 per tick
	else if(staminaloss > -max_stamina_buffer)
		adjustStaminaLoss((-max_stamina_buffer * 0.08) * regen_bonus, TRUE, FALSE)	//Default normal regen speed is 4 per tick

/datum/reagent/turbo/proc/modify_stamina_regen(datum/source, regen_modifier)
	if(volume > 0)
		regen_modifier += 2
		return

/datum/reagent/turbo/on_mob_add(mob/living/L, metabolism)
	..()
	RegisterSignal(L, COMSIG_STAMINA_REGEN, .proc/modify_stamina_regen)
	to_chat(L, span_notice("The world around you slows down slightly. You feel like you could run for hours!"))
	L.add_movespeed_modifier(type, TRUE, 0, NONE, TRUE, -0.2)
	L.max_stamina_buffer += 25	//1.5x more stamina "health"
	L.adjustStaminaLoss(-25)	//Initial stamina boost to pair with the increase in max stamina

/datum/reagent/turbo/on_mob_delete(mob/living/L, metabolism)
	UnregisterSignal(L, COMSIG_STAMINA_REGEN)
	to_chat(L, span_notice("You feel out of breath, the world returning to normal..."))
	L.remove_movespeed_modifier(type)
	L.max_stamina_buffer -= 25	//Restore max stamina to default
	L.adjustStaminaLoss(20)	//To simulate the user being "drained" of energy after it wears off
	..()

/datum/reagent/turbo/on_mob_life(mob/living/L, metabolism)
	if(prob(5))
		to_chat(L, span_userdanger("Faster, faster, faster!"))
	L.jitter(5)
	if(prob(10))
		L.emote(pick("twitch", "shiver","blinkr"))
	..()

/datum/reagent/turbo/overdose_process(mob/living/L, metabolism)
	to_chat(L, span_userdanger("Everything is slowing down even further!"))
	if(prob(20))
		if(!L.incapacitated(TRUE) && !L.pulledby && isfloorturf(L.loc))
			step(L, pick(GLOB.alldirs))
		L.visible_message("<span class='danger'>[L]'s limbs spasm!")
		L.drop_all_held_items()
	L.adjustToxLoss(3)
	L.adjustOxyLoss(2)
	L.adjust_blurriness(10)
	L.jitter(10)
	..()

/datum/reagent/turbo/addiction_act_stage1(mob/living/L, metabolism)
	L.jitter(5)
	if(prob(10))
		L.emote(pick("twitch","drool","shiver"))
	..()

/datum/reagent/turbo/addiction_act_stage2(mob/living/L, metabolism)
	L.jitter(10)
	L.dizzy(10)
	if(prob(20))
		L.emote(pick("twitch","drool","shiver"))
	..()

/datum/reagent/turbo/addiction_act_stage3(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel the energy from your body evaporating..."))
	if(prob(10) && !L.incapacitated(TRUE) && !L.pulledby && isfloorturf(L.loc))
		step(L, pick(GLOB.alldirs))
	L.max_stamina_buffer = 25	//Halved user's stamina "health"
	L.jitter(20)
	L.dizzy(20)
	if(prob(40))
		L.emote(pick("twitch","drool","shiver"))
	L.stuttering += 1
	..()

/datum/reagent/turbo/addiction_act_stage4(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel out of breath, the rest of the world going by faster than you!"))
	if(prob(30) && !L.incapacitated(TRUE) && !L.pulledby && isfloorturf(L.loc))
		step(L, pick(GLOB.alldirs))
	L.max_stamina_buffer = 10	//Severely lowers stamina "health"
	L.jitter(50)
	L.dizzy(40)
	if(prob(50))
		L.emote(pick("twitch","drool","shiver"))
	L.stuttering += 2
	..()

/datum/reagent/methamphetamine
	name = "Methamphetamine"
	description = "Performance enhancing recreational drug. Highly addictive."
	color = "#d6f6ff"
	taste_description = "tiny crystals and tingling"
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL/1.25	//40 units
	addiction_threshold = 25
	custom_metabolism = REAGENTS_METABOLISM/2

/datum/reagent/methamphetamine/on_mob_add(mob/living/L, metabolism)
	to_chat(L, span_notice("Your mind feels clear and your muscles twitch."))
	L.health_threshold_crit -= 20
	L.health_threshold_dead -= 20
	L.max_stamina_buffer += 15
	L.adjustStaminaLoss(-15)

/datum/reagent/methamphetamine/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_notice("Your mind begins to cloud, and your muscles feel sore."))
	L.health_threshold_dead += 20
	L.health_threshold_crit += 20
	L.max_stamina_buffer -= 15
	L.adjustStaminaLoss(15)

/datum/reagent/methamphetamine/on_mob_life(mob/living/L, metabolism)
	L.adjustStaminaLoss(-1) //Refreshes user's stamina
	L.jitter(2)
	if(prob(2))
		L.emote(pick("twitch","sniff","laugh","scream"))
	..()

/datum/reagent/methamphetamine/overdose_process(mob/living/L, metabolism)
	L.adjustToxLoss(2)
	var/mob/living/carbon/human/H = L
	var/affected_organ = pick("heart","lungs","liver","kidneys")
	var/datum/internal_organ/I =  H.internal_organs_by_name[affected_organ]
	I.take_damage(1)

/datum/reagent/methamphetamine/overdose_crit_process(mob/living/L, metabolism)
	L.adjustToxLoss(4)
	L.adjustOxyLoss(3)
	var/mob/living/carbon/human/H = L
	var/affected_organ = pick("heart","lungs","liver","kidneys","brain")
	var/datum/internal_organ/I =  H.internal_organs_by_name[affected_organ]
	I.take_damage(4)

/datum/reagent/methamphetamine/on_overdose_crit_start(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel like your brain is being electrocuted!"))

/datum/reagent/methamphetamine/addiction_act_stage1(mob/living/M)

/datum/reagent/methamphetamine/addiction_act_stage2(mob/living/M)

/datum/reagent/methamphetamine/addiction_act_stage3(mob/living/M)

/datum/reagent/methamphetamine/addiction_act_stage4(mob/living/M)

/* Do Psycho and Buffout later
/datum/reagent/psycho
	name = "Psycho Fluid"
	description = "Makes the user hit harder and shrug off slight stuns, but causes slight brain damage and carries a risk of addiction."
	reagent_state = LIQUID
	color = "#FF0000"
	overdose_threshold = 15
	addiction_threshold = 12.5
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	var/datum/brain_trauma/special/psychotic_brawling/bath_salts/rage


/datum/reagent/psycho/on_mob_life(mob/living/L, metabolism)
	var/high_message = pick("<br><font color='#FF0000'><b>FUCKING KILL!</b></font>", "<br><font color='#FF0000'><b>RAAAAR!</b></font>", "<br><font color='#FF0000'><b>BRING IT!</b></font>")
	if(prob(20))
		to_chat(L, span_notice("[high_message]")
	L.AdjustStun(-25, 0)
	L.AdjustKnockdown(-25, 0)
	L.AdjustUnconscious(-25, 0)
	L.adjustStaminaLoss(-5, 0)
	L.Jitter(2)
	..()
	. = TRUE

/datum/reagent/psycho/on_mob_add(mob/living/L, metabolism)
	..()
	ADD_TRAIT(L, TRAIT_SLEEPIMMUNE, "[type]")
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		rage = new()
		C.gain_trauma(rage, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/psycho/on_mob_delete(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_SLEEPIMMUNE, "[type]")
	if(rage)
		QDEL_NULL(rage)
	..()

/datum/reagent/psycho/overdose_process(mob/living/L, metabolism)
	L.hallucination += 20
	if(CHECK_MOBILITY(L, MOBILITY_MOVE) && !ismovableatom(L.loc) && !isspaceturf(L.loc))
		for(var/i = 0, i < 8, i++)
			step(L, pick(GLOB.cardinals))
	if(prob(20))
		L.emote(pick("twitch","scream","laugh"))
	L.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2)
	L.set_heartattack(TRUE)
	L.visible_message(span_userdanger("[M] clutches at their chest as if their heart stopped!"))
	to_chat(L, "<span class='danger'>Your vision goes black and your heart stops beating as the amount of drugs in your system shut down your organs one by one. Say hello to Elvis in the afterlife. ")
	..()
	return TRUE

/datum/reagent/psycho/addiction_act_stage1(mob/living/L, metabolism)
	L.hallucination += 10
	L.Jitter(5)
	L.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
	if(prob(20))
		L.emote(pick("twitch","scream","laugh"))
	..()
	return
/datum/reagent/psycho/addiction_act_stage2(mob/living/L, metabolism)
	L.hallucination += 20
	L.Jitter(10)
	L.Dizzy(10)
	L.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
	if(prob(30))
		L.emote(pick("twitch","scream","laugh"))
	..()
	return
/datum/reagent/psycho/addiction_act_stage3(mob/living/L, metabolism)
	L.hallucination += 30
	if(CHECK_MOBILITY(L, MOBILITY_MOVE) && !ismovableatom(L.loc) && !isspaceturf(L.loc))
		for(var/i = 0, i < 2, i++)
			step(L, pick(GLOB.cardinals))
	L.Jitter(15)
	L.Dizzy(15)
	L.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	if(prob(40))
		L.emote(pick("twitch","scream","laugh"))
	..()
	return
/datum/reagent/psycho/addiction_act_stage4(mob/living/L, metabolism)
	L.hallucination += 40
	if(CHECK_MOBILITY(L, MOBILITY_MOVE) && !ismovableatom(L.loc) && !isspaceturf(L.loc))
		for(var/i = 0, i < 4, i++)
			step(L, pick(GLOB.cardinals))
	L.Jitter(50)
	L.Dizzy(50)
	L.adjustToxLoss(5)
	L.adjustOrganLoss(ORGAN_SLOT_BRAIN, 15)
	if(prob(50))
		L.emote(pick("twitch","scream","laugh"))
	..()
	return

/datum/reagent/buffout
	name = "Buffout Powder"
	description = "A powerful steroid which increases the user's strength and endurance."
	color = "#FF9900"
	reagent_state = SOLID
	overdose_threshold = 20
	addiction_threshold = 11
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	var/datum/brain_trauma/special/psychotic_brawling/bath_salts/rage

/datum/reagent/buffout/on_mob_add(mob/living/L, metabolism)
	..()
	if(islivingL)
		to_chat(L, span_notice("You feel stronger, and like you're able to endure more."))
		ADD_TRAIT(L, TRAIT_BUFFOUT_BUFF, "buffout")
		ADD_TRAIT(L, TRAIT_PERFECT_ATTACKER, "buffout")
		L.maxHealth += 25
		L.health += 25

/datum/reagent/buffout/on_mob_delete(mob/living/L, metabolism)
	..()
	if(islivingL)
		to_chat(L, span_notice("You feel weaker."))
		REMOVE_TRAIT(L, TRAIT_BUFFOUT_BUFF, "buffout")
		REMOVE_TRAIT(L, TRAIT_PERFECT_ATTACKER, "buffout")
		L.maxHealth -= 25
		L.health -= 25

/datum/reagent/buffout/on_mob_life(mob/living/L, metabolism)
	L.AdjustStun(-10*REAGENTS_EFFECT_MULTIPLIER, 0)
	L.AdjustKnockdown(-10*REAGENTS_EFFECT_MULTIPLIER, 0)
	..()
	. = TRUE

/datum/reagent/buffout/overdose_process(mob/living/L, metabolism)
	if(iscarbonL)
		var/mob/living/carbon/C = M
		rage = new()
		C.gain_trauma(rage, TRAUMA_RESILIENCE_ABSOLUTE)
	var/datum/disease/D = new /datum/disease/heart_failure
	L.ForceContractDisease(D)
	if(prob(33))
		L.visible_message("<span class='danger'>[M]'s muscles spasm, making them drop what they were holding!")
		L.drop_all_held_items()
	L.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2)
	..()

/datum/reagent/buffout/addiction_act_stage1(mob/living/L, metabolism)
	to_chat(L, span_notice("Your muscles ache slightly."))
	L.adjustBruteLoss(1.5)
	if(prob(15))
		L.emote(pick("twitch"))
	..()
	return

/datum/reagent/buffout/addiction_act_stage2(mob/living/L, metabolism)
	to_chat(L, span_notice("Your muscles feel incredibly sore."))
	L.adjustBruteLoss(4)
	if(prob(30))
		to_chat(L, span_notice("Your muscles spasm, making you drop what you were holding."))
		L.drop_all_held_items()
		L.emote(pick("twitch"))
	..()
	return

/datum/reagent/buffout/addiction_act_stage3(mob/living/L, metabolism)
	to_chat(L, span_notice("Your muscles start to hurt badly, and everything feels like it hurts more."))
	L.adjustBruteLoss(7.5)
	L.maxHealth -= 1.5
	L.health -= 1.5
	if(prob(50))
		to_chat(L, span_notice("Your muscles spasm, making you drop what you were holding. You're not even sure if you can control your arms!"))
		L.drop_all_held_items()
		L.emote(pick("twitch"))
	..()
	return

/datum/reagent/buffout/addiction_act_stage4(mob/living/L, metabolism)
	to_chat(L, "<span class='danger'>Your muscles are in incredible pain! When will it stop!?")
	L.adjustBruteLoss(12.5)
	L.maxHealth -= 5
	L.health -= 5
	if(prob(90))
		to_chat(L, "<span class='danger'>You can't even keep control of your muscles anymore!")
		L.drop_all_held_items()
		L.emote(pick("twitch"))
	if(CHECK_MOBILITY(L, MOBILITY_MOVE) && !isspaceturf(L.loc) && prob(25))
		step(L, pick(GLOB.cardinals))
	L.adjustOrganLoss(ORGAN_SLOT_HEART, 20)
	..()
	return
*/



/*
// SUPER STIMPAK FLUID REAGENT
/datum/reagent/medicine/stimpakimitation
	name = "Imitation Stim Fluid"
	description = "Rapidly heals damage when injected. A poor man's stimpak."
	reagent_state = LIQUID
	color = "#FFA500"

/datum/reagent/medicine/stimpakimitation/on_mob_life(mob/living/L, metabolism)

/datum/reagent/medicine/super_stimpak
	name = "super stim chemicals"
	description = "Chemicals found in pre-war stimpaks."
	reagent_state = LIQUID
	color = "#e50d0d"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 20
	addiction_threshold = 16

datum/reagent/medicine/super_stimpak/on_mob_life(mob/living/M)

/datum/reagent/medicine/super_stimpak/overdose_process(mob/living/M)

// HEALING POULTICE REAGENT
/datum/reagent/medicine/healing_powder/poultice
	name = "healing poultice"
	description = "Restores limb condition and heals rapidly."
	color = "#C8A5DC"
	overdose_threshold = 20

// RAD-X REAGENT
/datum/reagent/medicine/radx
	name = "Rad-X"
	description = "Reduces massive amounts of radiation and some toxin damage."
	reagent_state = LIQUID
	color = "#ff6100"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/radx/on_mob_life(mob/living/L, metabolism)
	if(M.radiation > 0)
		M.radiation -= min(M.radiation, 8)
	M.adjustToxLoss(-0.5*REAGENTS_EFFECT_MULTIPLIER)
	. = TRUE
	..()


// ---------------------------
// RADAWAY REAGENT

/datum/reagent/medicine/radaway
	name = "Radaway"
	description = "A potent anti-toxin drug."
	reagent_state = LIQUID
	color = "#ff7200"
	metabolization_rate = 2 * REAGENTS_METABOLISM

/datum/reagent/medicine/radaway/on_mob_life(mob/living/L, metabolism)
	M.adjustToxLoss(-3*REAGENTS_EFFECT_MULTIPLIER)
	M.radiation -= min(M.radiation, 16)
	if(ishuman(M) && prob(7))
		var/mob/living/carbon/human/H = M
		H.confused = max(M.confused, 3)
	. = TRUE
	..()

// MENTAT REAGENT
/datum/reagent/medicine/mentat
	name = "Mentat Powder"
	description = "A powerful drug that heals and increases the perception and intelligence of the user."
	color = "#C8A5DC"
	reagent_state = SOLID
	overdose_threshold = 25
	addiction_threshold = 15

/datum/reagent/medicine/mentat/on_mob_life(mob/living/L, metabolism)


/datum/reagent/medicine/mentat/overdose_process(mob/living/M)


/datum/reagent/medicine/mentat/addiction_act_stage1(mob/living/M)


/datum/reagent/medicine/mentat/addiction_act_stage2(mob/living/M)


/datum/reagent/medicine/mentat/addiction_act_stage3(mob/living/M)


/datum/reagent/medicine/mentat/addiction_act_stage4(mob/living/M)

// FIXER REAGENT
/datum/reagent/medicine/fixer
	name = "Fixer Powder"
	description = "Treats addictions while also purging other chemicals from the body. Side effects include nausea."
	reagent_state = SOLID
	color = "#C8A5DC"

/datum/reagent/medicine/fixer/on_mob_life(mob/living/L, metabolism)
	for(var/datum/reagent/R in M.reagents.addiction_list)
		M.reagents.addiction_list.Remove(R)
		to_chat(M, span_notice("You feel like you've gotten over your need for [R.name]."))
	if(ishuman(M) && prob(5))
		var/mob/living/carbon/human/H = M
		H.vomit(10)
	..()
	. = TRUE
*/