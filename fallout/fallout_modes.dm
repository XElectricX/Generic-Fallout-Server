#define NCR_VICTORY "NCR Victory"
#define LEGION_VICTORY "Legion Victory"

/datum/game_mode/fallout
	name = "Fallout"
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

/datum/game_mode/fallout/announce()
	to_chat(world, "<b>Survive in the Capital Wasteland. Enjoy your time!</b>")

/datum/game_mode/fallout/check_finished()
	if(!round_finished)
		return FALSE
	return TRUE

/datum/game_mode/fallout/declare_completion()
	. = ..()
	to_chat(world, span_round_header("|Round Complete|"))
	to_chat(world, span_round_body("The week has come to an end!"))
	var/sound/S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
	SEND_SOUND(world, S)

	log_game("[round_finished]\nGame mode: [name]\nRound time: [duration2text()]\nEnd round player population: [length(GLOB.clients)]\nTotal humans spawned: [GLOB.round_statistics.total_humans_created]")

	announce_medal_awards()
	announce_round_stats()

/datum/game_mode/fallout/ncr_vs_legion
	name = "NCR vs Legion"
	config_tag = "NCR vs Legion"
	valid_job_types = list(
		/datum/job/fallout/ncr = -1,
		/datum/job/fallout/ncr/medic = 5,
		/datum/job/fallout/ncr/engineer = 5,
		/datum/job/fallout/ncr/captain = 5,
		/datum/job/fallout/ncr/support = 5,
		/datum/job/fallout/ncr/leader = 1,
		/datum/job/fallout/legion = -1,
		/datum/job/fallout/legion/prime = 5,
		/datum/job/fallout/legion/veteran = 5,
		/datum/job/fallout/legion/decanus = 5,
		/datum/job/fallout/legion/support = 5,
		/datum/job/fallout/legion/leader = 1
		)

	var/objective_achieved

/datum/game_mode/fallout/ncr_vs_legion/announce()
	to_chat(world, "<b>It's NCR versus Legion, all-out warfare! Escalation rules do not apply during this game mode.</b>")

/datum/game_mode/fallout/ncr_vs_legion/check_finished(force_end)
	if(round_finished)
		return TRUE

	if(!force_end)
		return FALSE

	if(objective_achieved == NCR_VICTORY)
		message_admins("Round finished: [NCR_VICTORY]") //NCR took objective
		round_finished = NCR_VICTORY
		return TRUE
	if(objective_achieved == LEGION_VICTORY)
		message_admins("Round finished: [LEGION_VICTORY]") //Legion took objective
		round_finished = LEGION_VICTORY
		return TRUE
	return FALSE

/datum/game_mode/fallout/ncr_vs_legion/declare_completion()
	. = ..()
	to_chat(world, span_round_header("|Round Complete|"))
	to_chat(world, span_round_body("The battle is over!"))
	var/sound/S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
	SEND_SOUND(world, S)

	log_game("[round_finished]\nGame mode: [name]\nRound time: [duration2text()]\nEnd round player population: [length(GLOB.clients)]\nTotal humans spawned: [GLOB.round_statistics.total_humans_created]")

	announce_medal_awards()
	announce_round_stats()

/obj/item/end_round
	name = "End Round Button"
	desc = "Ends the round."

//debugging tool
/obj/item/end_round/interact(mob/user)
	. = ..()
	to_chat(world, "Interact is successful.")
	SSticker.force_ending = TRUE