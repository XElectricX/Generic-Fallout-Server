//Redirects the config folder to the fallout folder
/datum/controller/configuration
	directory = "fallout/fallout config"

//Editing the ticker because the startup messages are built into it
/datum/controller/subsystem/ticker/fire()
	switch(current_state)
		if(GAME_STATE_STARTUP)
			if(Master.initializations_finished_with_no_players_logged_in && !length(GLOB.clients))
				return
			if(isnull(start_at))
				start_at = time_left || world.time + (CONFIG_GET(number/lobby_countdown) * 10)
			for(var/client/C in GLOB.clients)
				window_flash(C)
			to_chat(world, span_role_body("Welcome to the lobby of [CONFIG_GET(string/server_name)]! The game has begun."))
			//to_chat(world, span_role_body("The game has begun."))
			current_state = GAME_STATE_PREGAME
			//to_chat(world, SSpersistence.seasons_info_message())
			fire()

		if(GAME_STATE_PREGAME)
			if(isnull(time_left))
				time_left = max(0, start_at - world.time)
			if(start_immediately)
				time_left = 0

			if(time_left <= 300 && !tipped)
				send_tip_of_the_round()
				tipped = TRUE

			//countdown
			if(time_left < 0)
				return
			time_left -= wait

			if(time_left <= 0)
				current_state = GAME_STATE_SETTING_UP
				Master.SetRunLevel(RUNLEVEL_SETUP)
				if(start_immediately)
					fire()

		if(GAME_STATE_SETTING_UP)
			setup_failed = !setup()
			if(setup_failed)
				current_state = GAME_STATE_STARTUP
				time_left = null
				start_at = world.time + (CONFIG_GET(number/lobby_countdown) * 10)
				start_immediately = FALSE
				Master.SetRunLevel(RUNLEVEL_LOBBY)

		if(GAME_STATE_PLAYING)
			mode.process(wait * 0.1)
			check_queue()

			if(!roundend_check_paused && mode.check_finished(force_ending) || force_ending)
				current_state = GAME_STATE_FINISHED
				GLOB.ooc_allowed = TRUE
				GLOB.dooc_allowed = TRUE
				mode.declare_completion(force_ending)
				addtimer(CALLBACK(SSvote, /datum/controller/subsystem/vote/proc/automatic_vote), 2 SECONDS)
				addtimer(CALLBACK(src, .proc/Reboot), CONFIG_GET(number/vote_period) * 3 + 9 SECONDS)
				Master.SetRunLevel(RUNLEVEL_POSTGAME)