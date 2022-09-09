/obj/item/radio/fallout
	name = "handheld radio"
	desc = "A simple communication device that transmits and receives audio using radio waves.\nUse ; when speaking with the radio in your hand to transmit."
	icon = 'fallout/fallout icons/fallout items/fallout_tools.dmi'
	icon_state = "hand_radio_on"
	frequency = FREQ_COMMON //common chat
	listening = TRUE  // Whether the radio is currently receiving.
	freerange = TRUE  // If true, the radio has access to the full spectrum.
	subspace_transmission = FALSE  // If true, the radio transmits and receives on subspace exclusively.
	subspace_switchable = TRUE  // If true, subspace_transmission can be toggled at will.
	independent = TRUE  // If true, can say/hear over non common channels without working tcomms equipment (for ERTs mostly).

//Facilitate the use of radios by just using ; key
/mob/living/carbon/human/radio(message, message_mode, list/spans, language)
	//Adding the parent proc code too because ..() would just call the previous definition of human/radio
	switch(message_mode)
		if(MODE_WHISPER)
			return ITALICS
		if(MODE_R_HAND)
			if(r_hand)
				return r_hand.talk_into(src, message, , spans, language)
			return ITALICS | REDUCE_RANGE
		if(MODE_L_HAND)
			if(l_hand)
				return l_hand.talk_into(src, message, , spans, language)
			return ITALICS | REDUCE_RANGE
		if(MODE_INTERCOM)
			for(var/obj/item/radio/intercom/I in view(1, null))
				I.talk_into(src, message, , spans, language)
			return ITALICS | REDUCE_RANGE
		if(MODE_BINARY)
			return ITALICS | REDUCE_RANGE //Does not return 0 since this is only reached by humans, not borgs or AIs.
	/* End of proc/radio code */

	if(isxeno(loc))
		message = Gibberish(message, 100)
	switch(message_mode)
		if(MODE_HEADSET)
			if(istype(l_hand || r_hand, /obj/item/radio))	//Does either hand have a radio?
				playsound(loc, 'sound/effects/radiostatic.ogg', 15, 1)
				var/obj/item/radio/hand_radio = l_hand || r_hand
				hand_radio.talk_into(src, message, , spans, language)
			else if(wear_ear)	//If you already had a radio in your hand and you are attempting to speak via ; key, skip this!
				playsound(loc, 'sound/effects/radiostatic.ogg', 15, 1)
				wear_ear.talk_into(src, message, , spans, language)
			return ITALICS | REDUCE_RANGE
		if(MODE_DEPARTMENT)
			if(wear_ear)
				playsound(loc, 'sound/effects/radiostatic.ogg', 15, 1)
				wear_ear.talk_into(src, message, message_mode, spans, language)
			return ITALICS | REDUCE_RANGE
	if(message_mode in GLOB.radiochannels)
		if(wear_ear)
			playsound(loc, 'sound/effects/radiostatic.ogg', 15, 1)
			wear_ear.talk_into(src, message, message_mode, spans, language)
			return ITALICS | REDUCE_RANGE
	return 0

//Deleted the code that specifically made it unable to send messages if the radio was in a hand slot... why???
/obj/item/radio/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	//This is from proc/hear
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, message, speaker, message_language, raw_message, radio_freq, spans, message_mode)

	if(radio_freq || !broadcasting || get_dist(src, speaker) > canhear_range)
		return
	if(canhear_range && get_dist(src, speaker) >= canhear_range)	//Check if the speaker is on the edge of radio range
		if(message_mode == MODE_WHISPER || message_mode == MODE_WHISPER_CRIT)	//Radio won't hear you whispering that far
			return
		raw_message = stars(raw_message, 50)	//Scramble the distant message
	if(message_mode == MODE_WHISPER || message_mode == MODE_WHISPER_CRIT)
		// radios don't pick up whispers very well
		raw_message = stars(raw_message)
	talk_into(speaker, raw_message, , spans, language = message_language)
