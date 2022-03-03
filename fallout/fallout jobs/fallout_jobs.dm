/// SEE access_defines.dm FOR ALL JOB-RELATED DEFINES ///

/* FALLOUT JOB EASY-TO-EDIT TEMPLATE
/datum/job/fallout/  Parent path of all Fallout-related jobs
	title = JOB TITLE DEFINE GOES HERE
	outfit = /datum/outfit/job/fallout/  Parent path of all Fallout-related job outfits
	access = ACCESS GROUP DEFINE GOES HERE
	comm_title = ""  Comms tag that is appended at the front of each message
	total_positions = -1  Job slots, leave as -1 for unlimited slots
	job_category = JOB CATEGORY DEFINE GOES HERE
	html_description = {"JOB DESCRIPTION GOES HERE"}
*/

//Basic role, wastelander
/datum/job/fallout
	title = "Wastelander"
	total_positions = -1
	job_category = JOB_CAT_WASTELAND
	selection_color = "#909090"
	html_description = {"Explore, scavenge, hunt, build, trade. Maybe you're a native to the Capital Wasteland, or just passing by?"}

/datum/job/fallout/radio_help_message(mob/M)
	to_chat(M, {"
		[span_role_body("|______________________|")]
		[span_role_header("You are \an [title]!")]
		[span_role_body("\nJust a simple wanderer of the Capital Wasteland.")]
		[span_role_body("|______________________|")]
		"})

//NCR jobs
/datum/job/fallout/ncr
	title = NCR_PRIVATE
	outfit = /datum/outfit/job/fallout/ncr
	access = NCR_ACCESS
	comm_title = "PVT"
	job_category = JOB_CAT_NCR
	selection_color = "#97794c"
	html_description = {"A grunt in the New California Republic's Army. Follow your superiors' orders and kick Legion ass. Make your country proud."}

/datum/job/fallout/ncr/medic
	title = NCR_MEDIC
	outfit = /datum/outfit/job/fallout/ncr/medic
	access = NCR_MEDIC_ACCESS
	comm_title = "FMD"
	total_positions = 5
	job_category = JOB_CAT_NCR
	html_description = {"You are given an impossible task: keep your allies alive."}

/datum/job/fallout/ncr/engineer
	title = NCR_ENGINEER
	outfit = /datum/outfit/job/fallout/ncr/engineer
	access = NCR_ENGINEER_ACCESS
	comm_title = "ENG"
	total_positions = 5
	job_category = JOB_CAT_NCR
	html_description = {"Construct defenses, repair equipment, and clear obstacles."}

/datum/job/fallout/ncr/captain
	title = NCR_CAPTAIN
	outfit = /datum/outfit/job/fallout/ncr/captain
	access = NCR_CAPTAIN_ACCESS
	comm_title = "CPT"
	total_positions = 5
	job_category = JOB_CAT_NCR
	html_description = {"Corral your squad of tax collectors."}

/datum/job/fallout/ncr/leader
	title = NCR_LEADER
	outfit = /datum/outfit/job/fallout/ncr/leader
	access = NCR_LEADER_ACCESS
	comm_title = "MAJ"
	total_positions = 1
	job_category = JOB_CAT_NCR
	html_description = {"Lead your tan army to victory."}

/datum/job/fallout/ncr/support
	title = NCR_SUPPORT
	outfit = /datum/outfit/job/fallout/ncr/support
	access = NCR_SUPPORT_ACCESS
	comm_title = "OPS"
	total_positions = 5
	job_category = JOB_CAT_NCR
	html_description = {"Provide logistical and medical support to the troops."}

//Legion jobs
/datum/job/fallout/legion
	title = LEGION_RECRUIT
	outfit = /datum/outfit/job/fallout/legion
	access = LEGION_ACCESS
	comm_title = "REC"
	job_category = JOB_CAT_LEGION
	selection_color = "#6d0d0d"
	html_description = {"A lowly peon for the Legion. Overcome the odds or die in battle."}

/datum/job/fallout/legion/prime
	title = LEGION_PRIME
	outfit = /datum/outfit/job/fallout/legion/prime
	access = LEGION_PRIME_ACCESS
	comm_title = "PRM"
	total_positions = 5
	job_category = JOB_CAT_LEGION
	html_description = {"A battle-tested soldier, but your suffering is only just starting."}

/datum/job/fallout/legion/veteran
	title = LEGION_VETERAN
	outfit = /datum/outfit/job/fallout/legion/veteran
	access = LEGION_VETERAN_ACCESS
	comm_title = "VET"
	total_positions = 5
	job_category = JOB_CAT_LEGION
	html_description = {"Legion's skilled infantrymen who have managed to survive several battles. Make Caesar proud."}

/datum/job/fallout/legion/decanus
	title = LEGION_DECANUS
	outfit = /datum/outfit/job/fallout/legion/decanus
	access = LEGION_DECANUS_ACCESS
	comm_title = "DEC"
	total_positions = 5
	job_category = JOB_CAT_LEGION
	html_description = {"An experienced soldier who has proven they can lead others into battle."}

/datum/job/fallout/legion/leader
	title = LEGION_LEADER
	outfit = /datum/outfit/job/fallout/legion/leader
	access = LEGION_LEADER_ACCESS
	comm_title = "CNT"
	total_positions = 1
	job_category = JOB_CAT_LEGION
	html_description = {"Show the profligates what real power is. Take charge of your legionaries and declare victory at all costs."}

/datum/job/fallout/legion/support
	title = LEGION_SUPPORT
	outfit = /datum/outfit/job/fallout/legion/support
	access = LEGION_SUPPORT_ACCESS
	comm_title = "MED"
	total_positions = 5
	job_category = JOB_CAT_LEGION
	html_description = {"An educated slave tasked with serving Caesar's Legion on the frontlines in a support role."}
