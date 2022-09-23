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

/datum/looping_sound/idle/on_start()
	nextlooptime = REALTIMEOFDAY + start_length
	start_time = nextlooptime
	BINARY_INSERT(src, SSloopingsounds.looping_sound_queue, /datum/looping_sound, src, nextlooptime, COMPARE_KEY)

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

/datum/looping_sound/hostile/on_start()
	nextlooptime = REALTIMEOFDAY + start_length
	start_time = nextlooptime
	BINARY_INSERT(src, SSloopingsounds.looping_sound_queue, /datum/looping_sound, src, nextlooptime, COMPARE_KEY)
