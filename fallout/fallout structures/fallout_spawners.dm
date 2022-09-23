//Mob spawners; pretty much the same code used by /obj/effect/ai_node/spawner
/obj/effect/ai_node/mob_spawner
	name = "mob spawner"
	desc = "Large hole in the ground that appears to be well-traveled."
	icon = 'fallout/fallout icons/fallout structures/fallout_mob_spawners.dmi'
	icon_state = "hole"
	invisibility = 0
	///typepath or list of typepaths for the spawner to pick from
	var/spawn_types
	///Amount of types to spawn for each squad created
	var/spawn_amount = 1
	///Delay between squad spawns, dont set this to below SSspawning wait
	var/spawn_delay = 4 SECONDS
	///Max amount of
	var/max_amount = 5
	///Whether we want to use the postspawn proc on the mobs created by the Spawner
	var/use_postspawn = FALSE
	///Distance the spawner uses when checking for nearby players to trigger spawning
	var/range = 7

/obj/effect/ai_node/mob_spawner/Initialize()
	if(!spawn_types || !spawn_amount)
		stack_trace("Invalid spawn parameters on AI spawn node, deleting")
		return INITIALIZE_HINT_QDEL
	/*if(spawndelay < SSspawning.wait)
		stack_trace("Spawndelay too low, deleting AI spawner node")
		return INITIALIZE_HINT_QDEL*/
	. = ..()
	START_PROCESSING(SSobj, src)

///This proc runs on the created mobs if use_postspawn is enabled, use this to equip humans and such
/obj/effect/ai_node/mob_spawner/proc/postspawn(list/squad)
	return

//To-do for a later date: make it so that spawners can go back to scanning for players in range if someone left and there are still spawns left
/obj/effect/ai_node/mob_spawner/process()
	var/mob_detected = get_nearest_target_in_view(src, range, ALL)
	if(mob_detected)
		spawner_toggle(mob_detected)
		STOP_PROCESSING(SSobj, src)

///Enable spawning
/obj/effect/ai_node/mob_spawner/proc/spawner_toggle(mob_detected)
	if(mob_detected)
		SSspawning.registerspawner(src, spawn_delay, spawn_types, max_amount, spawn_amount, use_postspawn ? CALLBACK(src, .proc/postspawn) : null)

/obj/effect/ai_node/mob_spawner/deathclaw
	name = "deathclaw hole"
	spawn_types = /mob/living/carbon/fallout/deathclaw
	max_amount = 1

/obj/effect/ai_node/mob_spawner/deathclaw/nest
	name = "deathclaw nest"
	//spawn_delay = 12 SECONDS
	max_amount = 5

/obj/effect/ai_node/mob_spawner/radroach
	name = "roach hole"
	spawn_types = /mob/living/carbon/fallout/radroach
	max_amount = 5

/obj/effect/ai_node/mob_spawner/radroach/nest
	name = "radroach nest"
	spawn_types = /mob/living/carbon/fallout/radroach
	spawn_amount = 3
	max_amount = 21

/obj/effect/ai_node/mob_spawner/molerat
	name = "molerat den"
	spawn_types = /mob/living/carbon/fallout/molerat
	spawn_amount = 2
	//spawn_delay = 8 SECONDS
	max_amount = 10

/obj/effect/ai_node/mob_spawner/feral_dog
	name = "feral dog den"
	spawn_types = /mob/living/carbon/fallout/feral_dog
	spawn_amount = 4
	//spawn_delay = 12 SECONDS
	max_amount = 8

/obj/effect/ai_node/mob_spawner/centaur
	name = "centaur tunnel"
	spawn_types = /mob/living/carbon/fallout/centaur
	spawn_amount = 1
	max_amount = 5

//Datum and subsystem stuff below
/datum/spawnerdata
	///Owner of this datum
	var/mob_spawner
	///Track how many mobs have been spawned by this spawner
	var/spawned_mobs

/datum/controller/subsystem/spawning/registerspawner(atom/spawner, delaytime = 30 SECONDS, spawntypes, maxmobs = 10, spawnamount = 1, datum/callback/postspawn)
	var/spawner_holder = spawner	//Temporarily hold the atom/spawner so we can set it after creating the datum
	spawnerdata[spawner] = new /datum/spawnerdata(delaytime/wait, spawntypes, maxmobs, spawnamount, postspawn)
	spawnerdata[spawner].mob_spawner = spawner_holder	//Assign the atom/spawner to the datum
	RegisterSignal(spawner, COMSIG_PARENT_QDELETING, .proc/unregisterspawner)

//Same as the overriden proc except for some necessary edits, see below
/datum/controller/subsystem/spawning/fire(resumed)
	if(totalspawned >= mobcap)
		return
	for(var/spawner in spawnerdata)
		if(++spawnerdata[spawner].fire_increment <= spawnerdata[spawner].required_increment)
			continue
		spawnerdata[spawner].fire_increment = 0
		var/turf/spawnpoint = get_turf(spawner)
		var/list/squad = list()
		for(var/b = 0 to spawnerdata[spawner].spawnamount)
			if(length(spawnerdata[spawner].spawnedmobs) >= spawnerdata[spawner].max_allowed_mobs)
				break
			var/spawntype = pick(spawnerdata[spawner].spawntypes)
			var/mob/newmob = new spawntype(spawnpoint)
			/* Fallout edit: we want to keep track of times each mob is spawned to then cease spawning functions */
			spawnerdata[spawner].spawned_mobs++

			var/datum/callback/deathcb = CALLBACK(src, .proc/decrement_spawnedmobs, newmob, spawner)
			callbacks_by_mob[newmob] = deathcb
			RegisterSignal(newmob, list(COMSIG_PARENT_QDELETING, COMSIG_MOB_DEATH), .proc/remove_mob)
			spawnerdata[spawner].spawnedmobs += newmob
			squad += newmob
			totalspawned++
		spawnerdata[spawner].post_spawn_cb?.Invoke(squad)
		if(TICK_CHECK)
			return
		/* Fallout edit: when the max_amount (derived from the mob_spawner itself) is reached, stop spawning in more mobs */
		if(spawnerdata[spawner].spawned_mobs >= spawnerdata[spawner].max_allowed_mobs)
			unregisterspawner(spawnerdata[spawner].mob_spawner)
