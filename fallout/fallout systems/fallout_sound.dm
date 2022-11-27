/datum/looping_sound/idle
	mid_sounds = list('sound/items/bikehorn.ogg')	//This gets overriden anyways
	mid_length = 10 SECONDS
	start_length = 5 SECONDS
	range = 12
	falloff = 1
	vary = TRUE

/datum/looping_sound/idle/New(list/_output_atoms=list(), start_immediately=FALSE, _direct=FALSE)
	. = ..()
	var/mob/living/carbon/fallout/living_mob = output_atoms[1]
	mid_sounds = living_mob.idle_sound

/datum/looping_sound/hostile
	mid_sounds = list('sound/items/bikehorn.ogg')	//This gets overriden anyways
	mid_length = 5 SECONDS
	start_length = 5 SECONDS
	range = 12
	falloff = 1
	vary = TRUE

/datum/looping_sound/hostile/New(list/_output_atoms=list(), start_immediately=FALSE, _direct=FALSE)
	. = ..()
	var/mob/living/carbon/fallout/living_mob = output_atoms[1]
	mid_sounds = living_mob.combat_sound

//Rewriting footstep sounds to include power armor feet
/datum/component/footstep/play_humanstep()
	var/mob/living/carbon/human/H = parent
	if(CHECK_MULTIPLE_BITFIELDS(H.flags_pass, HOVERING))//We don't make step sounds when flying
		return
	var/turf/open/T = prepare_step()
	if(!T)
		return
	if(locate(/obj/alien/weeds) in T)
		playsound(T, pick(GLOB.barefootstep[FOOTSTEP_RESIN][1]),
			GLOB.barefootstep[FOOTSTEP_RESIN][2] * volume,
			TRUE,
			GLOB.barefootstep[FOOTSTEP_RESIN][3] + e_range)
		return
	if(H.is_wearing_power_armor)	//Walk and run sounds for power armor
		if(!H.m_intent)
			playsound(T, pick('sound/effects/alien_footstep_medium1.ogg', 'sound/effects/alien_footstep_medium2.ogg', 'sound/effects/alien_footstep_medium3.ogg'), 100 * volume, TRUE, 7, 1)
			return
		playsound(T, pick('sound/effects/alien_footstep_large1.ogg', 'sound/effects/alien_footstep_large2.ogg', 'sound/effects/alien_footstep_large3.ogg'), 50 * volume, TRUE, 10, 2)
		return
	if(H.shoes) //are we wearing shoes
		playsound(T, pick(GLOB.shoefootstep[T.shoefootstep][1]),
			GLOB.shoefootstep[T.shoefootstep][2] * volume,
			TRUE,
			GLOB.shoefootstep[T.shoefootstep][3] + e_range)
		return
	playsound(T, pick(GLOB.barefootstep[T.barefootstep][1]),
		GLOB.barefootstep[T.barefootstep][2] * volume,
		TRUE,
		GLOB.barefootstep[T.barefootstep][3] + e_range)
