/* Weather and weather-related code */

/datum/weather
	///If TRUE, the affected areas' ambience stops playing and only the weather ambience plays
	var/override_ambience = FALSE

/datum/weather/fallout
	area_type = /area
	protect_indoors = TRUE
	///How loud the weather sounds are
	var/volume = 100

/datum/weather/fallout/rain
	name = "rain"
	desc = "A welcome sight in the wastes."
	target_trait = ZTRAIT_FALLOUT_RAIN
	aesthetic = TRUE
	volume = 50
	probability = 30

	telegraph_duration = 3 MINUTES
	weather_duration = 5 MINUTES
	weather_duration_lower = 1 MINUTES
	weather_duration_upper = 10 MINUTES
	end_duration = 3 MINUTES

	telegraph_message = span_boldannounce("Light rain begins to drizzle from the sky...")
	telegraph_overlay = "rain_low"
	telegraph_sound = 'sound/weather/acidrain/acidrain_start.ogg'

	weather_message = span_notice("A torrent of water falls from the sky, soaking everything in sight...")
	weather_overlay = "rain_med"

	end_message = span_notice("The rain begins to let up, and the clouds start to part...")
	end_overlay = "rain_low"
	end_sound = 'sound/weather/acidrain/acidrain_end.ogg'

/datum/weather/fallout/sandstorm
	name = "sandstorm"
	desc = "A passing sandstorm blankets the area in sand."
	target_trait = ZTRAIT_FALLOUT_SANDSTORM
	protected_areas = list(/area/fallout/town)	//Town has preventative measures
	aesthetic = TRUE
	volume = 50
	probability = 15

	telegraph_duration = 1 MINUTES
	weather_duration = 5 MINUTES
	weather_duration_lower = 3 MINUTES
	weather_duration_upper = 7 MINUTES
	end_duration = 1 MINUTES

	telegraph_message = span_boldannounce("The wind begins to intensify, blowing sand up from the ground...")
	telegraph_overlay = "dust_low"
	telegraph_sound = 'sound/weather/ashstorm/inside/weak_start.ogg'

	weather_message = span_notice("Clouds of sand blanket the area, making it hard to see...")
	weather_overlay = "dust_med"

	end_message = span_notice("The wind quiets down, sand slowly settling back to the ground...")
	end_overlay = "dust_low"
	end_sound = 'sound/weather/ashstorm/inside/weak_end.ogg'

/datum/weather/fallout/radstorm
	name = "radstorm"
	desc = "Green clouds move over the area."
	target_trait = ZTRAIT_RADSTORM
	protected_areas = list(/area/fallout/town)	//Town has preventative measures
	weather_color = "green"
	probability = 5
	override_ambience = TRUE

	telegraph_duration = 1 MINUTES
	weather_duration = 5 MINUTES
	weather_duration_lower = 3 MINUTES
	weather_duration_upper = 7 MINUTES
	end_duration = 10 SECONDS

	telegraph_message = span_boldannounce("Winds pick up, with green clouds moving in from the horizon...")
	telegraph_overlay = "light_ash"
	telegraph_sound = 'fallout/fallout sounds/fallout weather sounds/radstorm/radstorm_lightning_distant_short+90+.ogg'

	weather_message = span_notice("A thick, green fog blankets the area and lightning begins striking the ground...")
	weather_overlay = "ash_storm"

	end_message = span_notice("The thick fog begins to dissipate, and the lightning stops...")
	end_overlay = "light_ash"

/datum/weather/fallout/radstorm/weather_act(mob/living/L)
	. = ..()
	L.adjust_radiation(5)

//Basically the same as the parent proc but adds code to change area's weather var
/datum/weather/fallout/update_areas()
	for(var/V in impacted_areas)
		var/area/N = V
		N.layer = overlay_layer
		N.plane = overlay_plane
		N.icon = 'icons/effects/weather_effects.dmi'
		N.color = weather_color
		N.weather = src
		switch(stage)
			if(STARTUP_STAGE)
				N.icon_state = telegraph_overlay
			if(MAIN_STAGE)
				N.icon_state = weather_overlay
			if(WIND_DOWN_STAGE)
				N.icon_state = end_overlay
			if(END_STAGE)
				N.color = null
				N.icon_state = ""
				N.icon = 'icons/turf/areas.dmi'
				N.layer = initial(N.layer)
				N.plane = initial(N.plane)
				N.set_opacity(FALSE)
				N.weather = null

/datum/controller/subsystem/weather
	///Associated list of clients that will hear weather ambience
	var/list/weather_listening_clients = list()

//Append weather ambience code to fire()
/datum/controller/subsystem/weather/fire()
	. = ..()
	//Only do weather ambience stuff if there is any actual weather in play
	if(length(processing))
		process_weather_ambience()

///Function that holds the weather ambience, for better organization; basically a copy of my area ambience code
/datum/controller/subsystem/weather/proc/process_weather_ambience()
	for(var/client/client_iterator AS in weather_listening_clients)
		var/area/current_area = get_area(client_iterator.mob)
		if(!current_area.weather)	//Check if it is null
			continue

		if(isnull(client_iterator))
			weather_listening_clients -= client_iterator
			continue

		if(weather_listening_clients[client_iterator] > world.time)
			continue //Not ready for the next sound

		//Save a reference instead of calling current_area.weather every time
		var/datum/weather/fallout/weather = current_area.weather

		if(weather.override_ambience)
			client_iterator?.mob?.stop_sound_channel(CHANNEL_AMBIENCE)
			if(client_iterator.prefs.toggles_sound & SOUND_AMBIENCE)
				SSambience.ambience_listening_clients[client_iterator] = world.time + 5 SECONDS	//Give it a few seconds before ambience resumes

		var/list/tracks_available = flist("fallout/fallout sounds/fallout weather sounds/[weather.name]/")	//Check the folder for available tracks
		var/track_to_play
		if(tracks_available.len)
			track_to_play = "fallout/fallout sounds/fallout weather sounds/[weather.name]/[pick(tracks_available)]"	//Pick a file from the folder
		var/list/L = splittext(track_to_play,"+")	//Files are named "file_name+[duration in deciseconds]+.ogg", the format is important
		if(L.len < 2)
			continue	//Someone did not adhere to the format!
		var/track_length = text2num(L[2])
		SEND_SOUND(client_iterator.mob, sound(track_to_play, repeat = 0, wait = 0, volume = weather.volume))

		weather_listening_clients[client_iterator] = world.time + track_length

//This proc already handles adding and removing clients from the area ambience list based on preference, so just appending weather ambience prefs to it
/client/update_ambience_pref()
	. = ..()
	if(prefs.toggles_sound & SOUND_WEATHER)
		if(SSweather.weather_listening_clients[src] > world.time)
			return // If already properly set we don't want to reset the timer.
		SSweather.weather_listening_clients[src] = world.time
	else
		SSweather.weather_listening_clients -= src
