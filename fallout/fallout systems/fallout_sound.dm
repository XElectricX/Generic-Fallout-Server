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
/datum/element/footstep/play_humanstep(mob/living/carbon/human/source, force_play = FALSE, volume_multiplier = 1, range_adjustment = 0)
	var/turf/open/source_loc
	if(force_play)
		source_loc = get_turf(source)
		if(!istype(source_loc))
			return
	else
		source_loc = prepare_step(source)

	if(!source_loc)
		return

	if(HAS_TRAIT(source, TRAIT_HEAVY_STEP))
		volume_multiplier += 0.3
		range_adjustment += 3

	if(HAS_TRAIT(source, TRAIT_LIGHT_STEP))
		volume_multiplier -= 0.5
		range_adjustment += -3

	if(source.m_intent == MOVE_INTENT_WALK)
		volume_multiplier -= 0.5
		range_adjustment += -3

	/* Walk and run sounds for power armor */
	if(source.is_wearing_power_armor)
		if(!source.m_intent)
			playsound(
				source_loc,
				pick('sound/effects/alien_footstep_medium1.ogg', 'sound/effects/alien_footstep_medium2.ogg', 'sound/effects/alien_footstep_medium3.ogg'),
				volume * volume_multiplier,
				sound_vary,
				DEFAULT_FOOTSTEP_SOUND_RANGE + e_range + range_adjustment)
			return
		playsound(
			source_loc,
			pick('sound/effects/alien_footstep_large1.ogg', 'sound/effects/alien_footstep_large2.ogg', 'sound/effects/alien_footstep_large3.ogg'),
			volume * volume_multiplier,
			sound_vary,
			DEFAULT_FOOTSTEP_SOUND_RANGE + e_range + range_adjustment)
		return

	var/override_sound = source_loc.get_footstep_override()
	var/footstep_type

	if((source.wear_suit?.flags_armor_protection | source.w_uniform?.flags_armor_protection | source.shoes?.flags_armor_protection) & FEET) //We are not disgusting barefoot bandits
		var/static/list/footstep_sounds = GLOB.shoefootstep //static is faster
		footstep_type = override_sound ? override_sound : source_loc.shoefootstep
		playsound(
			source_loc,
			pick(footstep_sounds[footstep_type][1]),
			footstep_sounds[footstep_type][2] * volume * volume_multiplier,
			sound_vary,
			DEFAULT_FOOTSTEP_SOUND_RANGE + footstep_sounds[footstep_type][3] + e_range + range_adjustment,
		)
	else
		var/static/list/bare_footstep_sounds = GLOB.barefootstep
		footstep_type = override_sound ? override_sound : source_loc.barefootstep
		playsound(
			source_loc,
			pick(GLOB.barefootstep[footstep_type][1]),
			GLOB.barefootstep[footstep_type][2] * volume * volume_multiplier,
			sound_vary,
			DEFAULT_FOOTSTEP_SOUND_RANGE + GLOB.barefootstep[footstep_type][3] + e_range + range_adjustment,
		)

/* Lobby and round end music */
//Find available songs and pick one to play
/datum/controller/subsystem/ticker/choose_lobby_song()
	var/list/songs = flist("[global.config.directory]/lobby_music/")
	if(length(songs))
		return "[global.config.directory]/lobby_music/[pick(songs)]"

//Stop the lobby music once you spawn in
/mob/living/carbon/human/on_spawn(mob/new_player/summoner)
	. = ..()
	summoner.client.stop_sounds()

//Round end music!
/datum/game_mode/declare_completion()
	. = ..()
	for(var/client/player AS in GLOB.clients)
		player.play_round_end_song()

/client/proc/play_round_end_song(vol = 85)
	//Obey client preferences and don't do anything if the player is still in the lobby
	if(prefs?.toggles_sound & SOUND_NOENDOFROUND || isnewplayer(mob))
		return
	var/list/songs = flist("[global.config.directory]/end_music/")
	if(!length(songs))
		return
	var/song_to_play = "[global.config.directory]/end_music/[pick(songs)]"
	SEND_SOUND(src, sound(song_to_play, channel = CHANNEL_LOBBYMUSIC, volume = vol))
