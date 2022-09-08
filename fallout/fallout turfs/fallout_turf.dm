//Editing to allow crawling movements; includes support for bump attacks because after all the work I put into it, may as well keep it
/turf/Enter(atom/movable/mover, direction)
	// Do not call ..()
	// Byond's default turf/Enter() doesn't have the behaviour we want with Bump()
	// By default byond will call Bump() on the first dense object in contents
	//Then, check the turf itself
	if(!CanPass(mover, src))
		switch(SEND_SIGNAL(mover, COMSIG_MOVABLE_PREBUMP_TURF, src))
			if(COMPONENT_MOVABLE_PREBUMP_STOPPED)
				return FALSE //No need for a bump, already procesed.
			if(COMPONENT_MOVABLE_PREBUMP_PLOWED)
				//Continue. We've plowed through the obstacle.
			else
				mover.Bump(src)
				return FALSE
	var/atom/firstbump
	var/mob/lying_mob
	var/mob/living_lying_mob
	for(var/i in contents)
		if(QDELETED(mover))
			return FALSE //We were deleted, do not attempt to proceed with movement.
		if(i == mover || i == mover.loc) // Multi tile objects and moving out of other objects
			continue
		var/atom/movable/thing = i
		if(CHECK_MULTIPLE_BITFIELDS(thing.flags_pass, HOVERING))
			continue
		if(thing.status_flags & INCORPOREAL)
			continue
		if(ismob(thing))
			lying_mob = thing	//Using this instead of firstbump for simplicity; I tried other methods, it gets messy
		if(lying_mob)
			if(lying_mob.lying_angle)
				if(lying_mob.stat == DEAD)	//If dead, repeat loop for the next mob
					continue
				else
					living_lying_mob = lying_mob	//This var serves to remember the last not-dead mob in this loop
		if(thing.Cross(mover))
			continue
		var/signalreturn = SEND_SIGNAL(mover, COMSIG_MOVABLE_PREBUMP_MOVABLE, thing)
		if(signalreturn & COMPONENT_MOVABLE_PREBUMP_STOPPED)
			return FALSE //Stopped, bump no longer necessary.
		if(signalreturn & COMPONENT_MOVABLE_PREBUMP_PLOWED)
			continue //We've plowed through.
		if(signalreturn & COMPONENT_MOVABLE_PREBUMP_ENTANGLED)
			return TRUE //We've entered the tile and gotten entangled inside it.
		if(QDELETED(mover)) //Mover deleted from Cross/CanPass, do not proceed.
			return FALSE
		else if(!firstbump || ((thing.layer > firstbump.layer || thing.flags_atom & ON_BORDER) && !(firstbump.flags_atom & ON_BORDER)))
			firstbump = thing
	if(QDELETED(mover)) //Mover deleted from Cross/CanPass/Bump, do not proceed.
		return FALSE
	if(firstbump)
		return mover.Bump(firstbump)
	if(living_lying_mob)	//The way this works is if there is a mob on the ground, you bump attack them but still return TRUE so you can cross into the tile
		SEND_SIGNAL(mover, COMSIG_MOVABLE_BUMP, living_lying_mob)
	return TRUE
