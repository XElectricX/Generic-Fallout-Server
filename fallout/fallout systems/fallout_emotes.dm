//I hate the emote cooldowns; have to paste everything because the cooldown is hard coded...
/datum/emote/can_run_emote(mob/user, status_check = TRUE, intentional = FALSE)
	. = TRUE

	if(!is_type_in_typecache(user, mob_type_allowed_typecache))
		return FALSE

	if(is_type_in_typecache(user, mob_type_blacklist_typecache))
		return FALSE

	if(intentional)
		if(flags_emote & EMOTE_FORCED_AUDIO)
			return FALSE

		if(sound || get_sound(user))
			if(HAS_TRAIT(user, TRAIT_MUTED))
				user.balloon_alert(user, "You are muted!")
				return FALSE
			if(TIMER_COOLDOWN_CHECK(user, COOLDOWN_EMOTE))
				user.balloon_alert(user, "You just did an audible emote")
				return FALSE
			else
				TIMER_COOLDOWN_START(user, COOLDOWN_EMOTE, 1 SECONDS)	//Very cool, having it hard coded

		if(user.client)
			if(user.client.prefs.muted & MUTE_IC)
				to_chat(user, span_warning("You cannot send emotes (muted)."))
				return FALSE

			if(user.client.handle_spam_prevention(message, MUTE_IC))
				return FALSE

			if(is_banned_from(user.ckey, "Emote"))
				to_chat(user, span_warning("You cannot send emotes (banned)."))
				return FALSE

	if(status_check && !is_type_in_typecache(user, mob_type_ignore_stat_typecache))
		if(user.stat > stat_allowed)
			if(!intentional)
				return FALSE

			switch(user.stat)
				if(UNCONSCIOUS)
					to_chat(user, span_notice("You cannot [key] while unconscious."))
				if(DEAD)
					to_chat(user, span_notice("You cannot [key] while dead."))

			return FALSE

		if(flags_emote & EMOTE_RESTRAINT_CHECK)
			if(isliving(user))
				var/mob/living/L = user
				if(L.incapacitated())
					if(!intentional)
						return FALSE
					user.balloon_alert(user, "You cannot [key] while stunned")
					return FALSE

		if(flags_emote & EMOTE_ARMS_CHECK)
			///okay snapper
			var/mob/living/carbon/snapper = user
			var/datum/limb/left_hand = snapper.get_limb("l_hand")
			var/datum/limb/right_hand = snapper.get_limb("r_hand")
			if((!left_hand.is_usable()) && (!right_hand.is_usable()))
				to_chat(user, span_notice("You cannot [key] without a working hand."))
				return FALSE

		if((flags_emote & EMOTE_RESTRAINT_CHECK) && user.restrained())
			if(!intentional)
				return FALSE
			user.balloon_alert(user, "You cannot [key] while restrained")
			return FALSE

/datum/custom_emote
	cooldown = 3 SECONDS	//A bit long, just to prevent a situation of spamming a giant paragraph of an emote every second

//Just pasting it in to remove the spammy message
/datum/custom_emote/run_custom_emote(mob/user)
	if(!message)
		return
	if(TIMER_COOLDOWN_CHECK(user, "custom_emotes[id]"))
		//user.balloon_alert(user, "You used that emote too recently")	//THIS IS ANNOYING
		return
	TIMER_COOLDOWN_START(user, "custom_emotes[id]", cooldown)
	if(user.stat > CONSCIOUS)
		to_chat(user, span_notice("You cannot use that emote while unconscious."))
		return
	if(spoken_emote)
		user.say(message)
		return
	user.me_verb(message)
