//Redirects the config folder to the fallout folder
/datum/controller/configuration
	directory = "cfg"

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

//It was hardcoded to only check under the "_map" folder, that has been removed now
#define CHECK_EXISTS(X) if(!istext(json[X])) { log_world("[##X] missing from json!"); return; }
/datum/map_config/LoadConfig(filename, error_if_missing, maptype, load_default)
	if(!fexists(filename))
		if(error_if_missing)
			log_world("map_config not found: [filename]")
		if(!load_default)
			return
		switch(maptype)
			if(GROUND_MAP)
				return LoadConfig("_maps/lv624.json", error_if_missing, maptype)
			if(SHIP_MAP)
				return LoadConfig("_maps/pillar_of_spring.json", error_if_missing, maptype)

	var/json = file(filename)
	if(!json)
		log_world("Could not open map_config: [filename]")
		return

	json = file2text(json)
	if(!json)
		log_world("map_config is not text: [filename]")
		return

	json = json_decode(json)
	if(!json)
		log_world("map_config is not json: [filename]")
		return

	config_filename = filename

	CHECK_EXISTS("map_name")
	map_name = json["map_name"]
	CHECK_EXISTS("map_path")
	map_path = json["map_path"]
	announce_text = json["announce_text"]

	map_file = json["map_file"]
	// "map_file": "BoxStation.dmm"
	if (istext(map_file))
		if (!fexists("[map_path]/[map_file]"))
			log_world("Map file ([map_file]) does not exist!")
			return
	// "map_file": ["Lower.dmm", "Upper.dmm"]
	else if (islist(map_file))
		for (var/file in map_file)
			if (!fexists("[map_path]/[file]"))
				log_world("Map file ([file]) does not exist!")
				return
	else
		log_world("map_file missing from json!")
		return

	if (islist(json["shuttles"]))
		var/list/L = json["shuttles"]
		for(var/key in L)
			var/value = L[key]
			shuttles[key] = value
	else if ("shuttles" in json)
		log_world("map_config shuttles is not a list!")
		return

	traits = json["traits"]
	if (islist(traits))
		// "Ground" is set by default, but it's assumed if you're setting
		// traits you want to customize which level is cross-linked
		// we only set ground if not mainship
		for (var/level in traits)
			if (!(ZTRAIT_GROUND in level) && !(ZTRAIT_MARINE_MAIN_SHIP in level))
				level[ZTRAIT_GROUND] = TRUE
	// "traits": null or absent -> default
	else if (!isnull(traits))
		log_world("map_config traits is not a list!")
		return

	var/temp = json["space_empty_levels"]
	if (isnum(temp))
		space_empty_levels = temp
	else if (!isnull(temp))
		log_world("map_config space_empty_levels is not a number!")
		return

	temp = json["squads"]
	if(isnum(temp))
		squads_max_num = temp
	else if(!isnull(temp))
		log_world("map_config squads_max_num is not a number!")
		return

	allow_custom_shuttles = json["allow_custom_shuttles"] != FALSE

	if(json["armor"])
		armor_style = json["armor"]

	if(islist(json["environment_traits"]))
		environment_traits = json["environment_traits"]
	else if(!isnull(json["environment_traits"]))
		log_world("map_config environment_traits is not a list!")
		return

	var/list/gamemode_names = list()
	for(var/t in subtypesof(/datum/game_mode))
		var/datum/game_mode/G = t
		if(initial(G.config_tag))
			gamemode_names += initial(G.config_tag)

	if(islist(json["gamemodes"]))
		for(var/g in json["gamemodes"])
			if(!(g in gamemode_names))
				log_world("map_config has an invalid gamemode name!")
				return
			gamemodes += g
	else if(!isnull(json["gamemodes"]))
		log_world("map_config gamemodes is not a list!")
		return
	else
		for(var/a in subtypesof(/datum/game_mode))
			var/datum/game_mode/G = a
			if(initial(G.config_tag))
				gamemodes += initial(G.config_tag)

	defaulted = FALSE
	return TRUE
#undef CHECK_EXISTS

//More "_map" removals
/datum/map_config/GetFullMapPaths()
	if (istext(map_file))
		return list("[map_path]/[map_file]")
	. = list()
	for (var/file in map_file)
		. += "[map_path]/[file]"

//Even MORE "_map" removals
#define INIT_ANNOUNCE(X) to_chat(world, span_notice("[X]")); log_world(X)
/datum/controller/subsystem/mapping/LoadGroup(list/errorList, name, path, files, list/traits, list/default_traits, silent = FALSE)
	. = list()
	var/start_time = REALTIMEOFDAY

	if (!islist(files))  // handle single-level maps
		files = list(files)

	// check that the total z count of all maps matches the list of traits
	var/total_z = 0
	var/list/parsed_maps = list()
	for (var/file in files)
		var/full_path = "[path]/[file]"
		var/datum/parsed_map/pm = new(file(full_path))
		var/bounds = pm?.bounds
		if (!bounds)
			errorList |= full_path
			continue
		parsed_maps[pm] = total_z  // save the start Z of this file
		total_z += bounds[MAP_MAXZ] - bounds[MAP_MINZ] + 1

	if (!length(traits))  // null or empty - default
		for (var/i in 1 to total_z)
			traits += list(default_traits)
	else if (total_z != traits.len)  // mismatch
		INIT_ANNOUNCE("WARNING: [traits.len] trait sets specified for [total_z] z-levels in [path]!")
		if (total_z < traits.len)  // ignore extra traits
			traits.Cut(total_z + 1)
		while (total_z > traits.len)  // fall back to defaults on extra levels
			traits += list(default_traits)

	// preload the relevant space_level datums
	var/start_z = world.maxz + 1
	var/i = 0
	for (var/level in traits)
		add_new_zlevel("[name][i ? " [i + 1]" : ""]", level)
		++i

	// load the maps
	for (var/P in parsed_maps)
		var/datum/parsed_map/pm = P
		if (!pm.load(1, 1, start_z + parsed_maps[P], no_changeturf = TRUE))
			errorList |= pm.original_path
	if(!silent)
		INIT_ANNOUNCE("Loaded [name] in [(REALTIMEOFDAY - start_time)/10]s!")
	return parsed_maps

//Stuff needed to use YouTube-dl for music instead of files
/datum/controller/subsystem/ticker/choose_lobby_song()
	var/all_music = CONFIG_GET(keyed_list/lobby_music)
	var/key = SAFEPICK(all_music)
	if(key)
		var/music_options = splittext(all_music[key], " ")
		return list(music_options[1])

/client/play_title_music()
	if(prefs && (prefs.toggles_sound & SOUND_LOBBY))
		var/ytdl = CONFIG_GET(string/invoke_youtubedl)
		if(!ytdl || !SSticker.login_music)
			return
		var/list/output = world.shelleo("[ytdl] --format \"bestaudio\[ext=mp3]/best\[ext=mp4]\[height<=360]/bestaudio\[ext=m4a]/bestaudio\[ext=aac]\" --dump-single-json --no-playlist -- \"[shell_url_scrub(SSticker.login_music[1])]\"")
		var/stdout = output[SHELLEO_STDOUT]
		var/list/data = list()
		data = safe_json_decode(stdout)
		if(!data)
			stack_trace("Lobby music - [SSticker.login_music[1]] failed to parse correctly")
			return
		var/web_sound_url = ""
		web_sound_url = data["url"]
		var/list/music_extra_data = list()
		music_extra_data["title"] = data["title"]
		music_extra_data["start"] = data["start_time"]
		music_extra_data["end"] = data["end_time"]
		tgui_panel?.play_music(web_sound_url,music_extra_data)

//Stop the lobby music once you spawn in
/mob/living/carbon/human/on_spawn(mob/new_player/summoner)
	..()
	summoner.client.stop_sounds()

//Round end music!
/datum/config_entry/keyed_list/round_end_music
	key_mode = KEY_MODE_TEXT
	value_mode = VALUE_MODE_TEXT

/datum/game_mode/declare_completion()
	for(var/client/player AS in GLOB.clients)
		player.play_round_end_song()
	..()

/client/proc/play_round_end_song()
	if(prefs && (prefs.toggles_sound & SOUND_NOENDOFROUND))
		return
	var/ytdl = CONFIG_GET(string/invoke_youtubedl)
	if(!ytdl)
		return
	var/all_music = CONFIG_GET(keyed_list/round_end_music)
	var/key = SAFEPICK(all_music)
	var/music_options = splittext(all_music[key], " ")
	var/list/output = world.shelleo("[ytdl] --format \"bestaudio\[ext=mp3]/best\[ext=mp4]\[height<=360]/bestaudio\[ext=m4a]/bestaudio\[ext=aac]\" --dump-single-json --no-playlist -- \"[shell_url_scrub(music_options[1])]\"")
	var/stdout = output[SHELLEO_STDOUT]
	var/list/data = list()
	data = safe_json_decode(stdout)
	if(!data)
		stack_trace("End round music - [music_options[1]] failed to parse correctly")
		return
	var/web_sound_url = ""
	web_sound_url = data["url"]
	var/list/music_extra_data = list()
	music_extra_data["title"] = data["title"]
	music_extra_data["start"] = data["start_time"]
	music_extra_data["end"] = data["end_time"]
	tgui_panel?.play_music(web_sound_url,music_extra_data)

//Very likely safe to overwrite as the last time this proc was updated was 3 years ago
/world/update_status()
	var/server_name = CONFIG_GET(string/server_name)
	if(!server_name || Master?.current_runlevel == RUNLEVEL_INIT)
		// If you didn't see a server name, or the master controller
		// is stilling initing, we don't update the hub.
		return
	// Start generating the hub status
	// Note: Hub content is limited to 254 characters, including HTML/CSS. Image width is limited to 450 pixels.
	// Current outputt should look like
	/*
	Something — Lost in space...	|	TerraGov Marine Corps — Sulaco
	Map: Loading...					|	Map: Icy Caves
	Mode: Lobby						|	Mode: Crash
	Round time: 0:0					|	Round time: 4:54
	*/
	var/discord_url = CONFIG_GET(string/discordurl)
	var/webmap_host = CONFIG_GET(string/webmap_host)
	var/title = CONFIG_GET(string/title) ? CONFIG_GET(string/title) : "Lost in space..."
	//var/shipname = length(SSmapping?.configs) && SSmapping.configs[SHIP_MAP] ? SSmapping.configs[SHIP_MAP].map_name : "Lost in space..."
	var/map_name = length(SSmapping.configs) && SSmapping.configs[GROUND_MAP] ? SSmapping.configs[GROUND_MAP].map_name : "Loading..."
	var/ground_map_file = length(SSmapping.configs) && SSmapping.configs[GROUND_MAP] ? SSmapping.configs[GROUND_MAP].map_file : ""
	var/new_status = ""
	new_status += "<b><a href='[discord_url ? discord_url : "#"]'>[title] &#8212; [server_name]</a></b>"
	new_status += "<br>Map: <a href='[webmap_host][ground_map_file]'><b>[map_name]</a></b>"
	new_status += "<br>Mode: <b>[SSticker.mode ? SSticker.mode.name : "Lobby"]</b>"
	new_status += "<br>Round time: <b>[gameTimestamp("hh:mm")]</b>"
	// Finally set the new status
	status = new_status
