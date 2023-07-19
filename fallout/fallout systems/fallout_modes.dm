/datum/game_mode/capital_wasteland
	name = "Capital Wasteland"
	config_tag = "Fallout"
	valid_job_types = list(/datum/job/fallout = -1)
	/*valid_job_types = list(
		/datum/job/fallout/town = 20,
		/datum/job/fallout/town/leader = 1,
		/datum/job/fallout/bos = 5,
		/datum/job/fallout/bos/scribe = 5,
		/datum/job/fallout/bos/paladin = 1,
		/datum/job/fallout/bos/leader = 1,
		/datum/job/fallout/enclave = 5,
		/datum/job/fallout/enclave/scientist = 5,
		/datum/job/fallout/enclave/captain = 1,
		/datum/job/fallout/enclave/leader = 1,
		/datum/job/fallout/raider = 10,
		/datum/job/fallout/raider/leader = 1,
		/datum/job/fallout/talon_company = 4,
		/datum/job/fallout/talon_company/leader = 1,
		/datum/job/fallout/regulator = 4,
		/datum/job/fallout/regulator/leader = 1
		)*/

/datum/game_mode/capital_wasteland/announce()
	to_chat(world, "<b>Survive in the Capital Wasteland. Enjoy your time!</b>")

/datum/game_mode/capital_wasteland/check_finished()
	if(!round_finished)
		return FALSE
	return TRUE

/datum/game_mode/capital_wasteland/declare_completion()
	. = ..()
	to_chat(world, span_round_header("|Round Complete|"))
	to_chat(world, span_round_body("The week has come to an end!"))
	var/sound/S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
	SEND_SOUND(world, S)
	log_game("[round_finished]\nGame mode: [name]\nRound time: [duration2text()]\nEnd round player population: [length(GLOB.clients)]\nTotal humans spawned: [GLOB.round_statistics.total_humans_created]")
	announce_medal_awards()
	announce_round_stats()

/datum/game_mode/ncr_vs_legion
	name = "NCR vs Legion"
	config_tag = "NCR vs Legion"
	flags_round_type = MODE_LATE_OPENING_SHUTTER_TIMER
	shutters_drop_time = 7 MINUTES
	respawn_time = 3 MINUTES	//Increase to 5 when out of testing
	factions = list(NCR, LEGION)
	round_end_states = list(DRAW, NCR_VICTORY, LEGION_VICTORY)
	valid_job_types = list(
		/datum/job/fallout/ncr = -1,
		/datum/job/fallout/ncr/heavy = 1,
		/datum/job/fallout/ncr/medic = 3,
		/datum/job/fallout/ncr/engineer = 3,
		/datum/job/fallout/ncr/captain = 3,
		/datum/job/fallout/ncr/support = 2,
		/datum/job/fallout/ncr/leader = 1,
		/datum/job/fallout/legion = -1,
		/datum/job/fallout/legion/prime = 5,
		/datum/job/fallout/legion/veteran = 5,
		/datum/job/fallout/legion/decanus = 1,
		/datum/job/fallout/legion/decanus/prime = 1,
		/datum/job/fallout/legion/decanus/veteran = 1,
		/datum/job/fallout/legion/vexillarius = 1,
		/datum/job/fallout/legion/support = 2,
		/datum/job/fallout/legion/leader = 1)

/datum/game_mode/ncr_vs_legion/announce()
	to_chat(world, "<b>It's NCR versus Legion, all-out warfare!</b>")

//Simple check, but most is handled by the objective computer in fallout_computers.dm
/datum/game_mode/ncr_vs_legion/check_finished()
	if(round_finished)
		return TRUE
	return FALSE

/datum/game_mode/ncr_vs_legion/declare_completion()
	. = ..()
	to_chat(world, span_round_header("|Round Complete|"))
	to_chat(world, span_round_body("The battle is over! [round_finished] won."))
	log_game("[round_finished] won.\nGame mode: [name]\nRound time: [duration2text()]\nEnd round player population: [length(GLOB.clients)]\nTotal humans spawned: [GLOB.round_statistics.total_humans_created]")
	announce_medal_awards()
	announce_round_stats()

/datum/game_mode/ncr_vs_legion/announce_round_stats()
	var/ncr_survival_stat
	var/ncr_accuracy_stat
	var/legion_survival_stat
	var/legion_accuracy_stat
	if(GLOB.round_statistics.total_human_deaths[NCR])
		if(GLOB.round_statistics.total_human_revives[NCR])
			ncr_survival_stat = "[GLOB.round_statistics.total_human_revives[NCR]] were revived, for a [(GLOB.round_statistics.total_human_revives[NCR] / max(GLOB.round_statistics.total_human_deaths[NCR], 1)) * 100]% revival rate and a [((GLOB.round_statistics.total_humans_created[NCR] + GLOB.round_statistics.total_human_revives[NCR] - GLOB.round_statistics.total_human_deaths[NCR]) / GLOB.round_statistics.total_humans_created[NCR]) * 100]% survival rate."
		else
			ncr_survival_stat = "None were revived, for a [((GLOB.round_statistics.total_humans_created[NCR] - GLOB.round_statistics.total_human_deaths[NCR]) / GLOB.round_statistics.total_humans_created[NCR]) * 100]% survival rate."
	if(GLOB.round_statistics.total_human_deaths[LEGION])
		if(GLOB.round_statistics.total_human_revives[LEGION])
			legion_survival_stat = "[GLOB.round_statistics.total_human_revives[LEGION]] were revived, for a [(GLOB.round_statistics.total_human_revives[LEGION] / max(GLOB.round_statistics.total_human_deaths[LEGION], 1)) * 100]% revival rate and a [((GLOB.round_statistics.total_humans_created[LEGION] + GLOB.round_statistics.total_human_revives[LEGION] - GLOB.round_statistics.total_human_deaths[LEGION]) / GLOB.round_statistics.total_humans_created[LEGION]) * 100]% survival rate."
		else
			legion_survival_stat = "None were revived, for a [((GLOB.round_statistics.total_humans_created[LEGION] - GLOB.round_statistics.total_human_deaths[LEGION]) / GLOB.round_statistics.total_humans_created[LEGION]) * 100]% survival rate."
	if(GLOB.round_statistics.total_projectile_hits[LEGION] && GLOB.round_statistics.total_projectiles_fired[NCR])
		ncr_accuracy_stat = ", for an accuracy of [(GLOB.round_statistics.total_projectile_hits[LEGION] / GLOB.round_statistics.total_projectiles_fired[NCR]) * 100]%!"
	if(GLOB.round_statistics.total_projectile_hits[NCR] && GLOB.round_statistics.total_projectiles_fired[LEGION])
		legion_accuracy_stat = ", for an accuracy of [(GLOB.round_statistics.total_projectile_hits[NCR] / GLOB.round_statistics.total_projectiles_fired[LEGION]) * 100]%!"

	var/list/parts = list({"[span_round_body("The end of round statistics are:")]<br>
		<br>[GLOB.round_statistics.total_humans_created[NCR]] NCR personnel were deployed, and [GLOB.round_statistics.total_human_deaths[NCR] ? GLOB.round_statistics.total_human_deaths[NCR] : "no"] NCR personnel were killed. [ncr_survival_stat ? ncr_survival_stat : ""]
		<br>[GLOB.round_statistics.total_humans_created[LEGION]] Legion were deployed, and [GLOB.round_statistics.total_human_deaths[LEGION] ? GLOB.round_statistics.total_human_deaths[LEGION] : "none of the"] Legion were killed. [legion_survival_stat ? legion_survival_stat : ""]
		<br>
		<br>There were [GLOB.round_statistics.total_projectiles_fired[NCR] + GLOB.round_statistics.total_projectiles_fired[LEGION]] total projectiles fired.
		<br>The New California Republic fired [GLOB.round_statistics.total_projectiles_fired[NCR] ? GLOB.round_statistics.total_projectiles_fired[NCR] : "no"] projectiles. [GLOB.round_statistics.total_projectile_hits[LEGION] ? GLOB.round_statistics.total_projectile_hits[LEGION] : "No"] projectiles managed to hit enemy Legion[ncr_accuracy_stat ? ncr_accuracy_stat : "."]
		<br>Caesar's Legion fired [GLOB.round_statistics.total_projectiles_fired[LEGION] ? GLOB.round_statistics.total_projectiles_fired[LEGION] : "no"] projectiles. [GLOB.round_statistics.total_projectile_hits[NCR] ? GLOB.round_statistics.total_projectile_hits[NCR] : "No"] projectiles managed to hit NCR personnel[legion_accuracy_stat ? legion_accuracy_stat : "."]
		<br>"})

	if(GLOB.round_statistics.grenades_thrown)
		parts += "[GLOB.round_statistics.grenades_thrown] total grenades exploding."
	else
		parts += "No grenades exploded."
	if(GLOB.round_statistics.mortar_shells_fired)
		parts += "[GLOB.round_statistics.mortar_shells_fired] mortar shells were fired."
	if(GLOB.round_statistics.howitzer_shells_fired)
		parts += "[GLOB.round_statistics.howitzer_shells_fired] howitzer shells were fired."
	if(GLOB.round_statistics.rocket_shells_fired)
		parts += "[GLOB.round_statistics.rocket_shells_fired] rocket artillery shells were fired."
	if(length(GLOB.round_statistics.workout_counts))
		for(var/faction in GLOB.round_statistics.workout_counts)
			parts += "The [faction] faction did [GLOB.round_statistics.workout_counts[faction]] workout sets."
	if(GLOB.round_statistics.total_human_deaths)
		var/deaths = GLOB.round_statistics.total_human_deaths[NCR] + GLOB.round_statistics.total_human_deaths[LEGION]
		var/revives = GLOB.round_statistics.total_human_revives[NCR] + GLOB.round_statistics.total_human_revives[LEGION]
		var/respawns = GLOB.round_statistics.total_human_respawns
		parts += "<br>In total, [deaths] people died, among which [revives ? revives : "none"] were revived and [respawns ? respawns : "none"] respawned. For a [(revives / deaths) * 100]% revival rate and a [(respawns / deaths) * 100]% respawn rate."
	if(length(parts))
		return "<div class='panel stationborder'>[parts.Join("<br>")]</div>"
	else
		return ""
