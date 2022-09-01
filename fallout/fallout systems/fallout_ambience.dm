//Substantial changes made to how background music is played; music is stored on the server itself because the total size is large
/datum/controller/subsystem/ambience/fire(resumed)
	for(var/client/client_iterator AS in ambience_listening_clients)
		var/area/current_area = get_area(client_iterator.mob)   //Moved this up so that it can check if var/ambience is a list sooner
		if(!current_area.ambience)	//Check if it is null
			continue
		if(islist(current_area.ambience))   //If it's a base TGMC ambience track, do as normal
			..()
			continue
		if(isnull(client_iterator))	//Don't need that lobby check, causes problems, easier to set area/start var/ambience to null
			ambience_listening_clients -= client_iterator
			to_chat(world, "Ambience list is being fucked with.")
			continue
		if(ambience_listening_clients[client_iterator] > world.time)
			continue //Not ready for the next sound
		/* The following is our code for how we play background tracks */
		var/list/tracks_available = flist("[global.config.directory]/[current_area.ambience]/") //Check the folder determined by var/ambience in /area
		var/track_to_play
		if(tracks_available.len)
			track_to_play = "[global.config.directory]/[current_area.ambience]/[pick(tracks_available)]"    //Pick a file from the folder
		//Snippet I took from /tg/ juke box code for determining track length
		var/list/L = splittext(track_to_play,"+")   //Music files are named "music+[duration in deciseconds]+.ogg", the format is important
		if(L.len < 2)
			continue    //Someone did not adhere to the format!
		var/track_length = text2num(L[2])
		SEND_SOUND(client_iterator.mob, sound(track_to_play, repeat = 0, wait = 0, volume = 25, channel = CHANNEL_AMBIENCE))

		ambience_listening_clients[client_iterator] = world.time + rand(current_area.min_ambience_cooldown, current_area.max_ambience_cooldown) + track_length
