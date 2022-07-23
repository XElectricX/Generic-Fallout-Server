/// SEE job_defines.dm FOR ALL JOB-RELATED DEFINES, SEE access_defines.dm FOR ALL ACCESS-RELATED DEFINES ///

/* FALLOUT JOB EASY-TO-EDIT TEMPLATE
/datum/job/fallout/  Parent path of all Fallout-related jobs
	title = JOB TITLE DEFINE GOES HERE
	outfit = /datum/outfit/job/fallout/  Parent path of all Fallout-related job outfits
	access = ACCESS GROUP DEFINE GOES HERE
	comm_title = ""  Comms tag that is appended at the front of each message
	total_positions = -1  Job slots, leave as -1 for unlimited slots
	job_category = JOB CATEGORY DEFINE GOES HERE
	desc = "JOB DESCRIPTION GOES HERE"
	faction_desc = "FLAVOR TEXT ABOUT YOUR FACTION GOES HERE"
*/

//Basic role, wastelander
/datum/job/fallout
	title = "Wastelander"
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_NOHEADSET
	total_positions = -1
	job_category = JOB_CAT_WASTELAND
	selection_color = "#909090"
	var/desc = "Explore, scavenge, hunt, build, trade. Maybe you're a native to the Capital Wasteland, or just passing by?"
	var/faction_desc = "You are your own person in the vast wasteland. Do as you wish."

/datum/job/fallout/radio_help_message(mob/M)
	to_chat(M, {"
		[span_role_body("/*------------------------------------------------------------------*\\")]
		[span_role_header("You are \an [title]!")]
		[span_role_body("\n[desc]")]
		[span_role_body(span_notice("<font color='#8df02a'> \n[faction_desc]</span>"))]
		[span_role_body("\\*------------------------------------------------------------------*/")]
		"})
	if(!(job_flags & JOB_FLAG_NOHEADSET))
		to_chat(M, "<b>Prefix your message with ; to speak on the default radio channel. To see other prefixes, look closely at your headset.</b>")
	if(req_admin_notify)
		to_chat(M, "<span clas='danger'>You are playing a job that is important for game progression. If you have to disconnect, please head to hypersleep, if you can't make it there, notify the admins via adminhelp.</span>")

//NCR jobs
/datum/job/fallout/ncr
	title = NCR_PRIVATE
	outfit = /datum/outfit/job/fallout/ncr
	skills_type = /datum/skills/ncr_private
	access = NCR_ACCESS
	comm_title = "PVT"
	job_category = JOB_CAT_NCR
	selection_color = "#97794c"
	desc = "A grunt in the New California Republic's army. Follow your superiors' orders and kick Legion ass. Make your country proud."
	faction_desc = "The New California Republic is, whether you were willing or not, your home and what you fight for. You won't go quietly, the Legion can count on that!"

/datum/job/fallout/ncr/medic
	title = NCR_MEDIC
	outfit = /datum/outfit/job/fallout/ncr/medic
	skills_type = /datum/skills/ncr_medic
	access = NCR_MEDIC_ACCESS
	comm_title = "FMD"
	total_positions = 5
	job_category = JOB_CAT_NCR
	desc = "You are given an impossible task: keep your allies alive."

/datum/job/fallout/ncr/engineer
	title = NCR_ENGINEER
	outfit = /datum/outfit/job/fallout/ncr/engineer
	skills_type = /datum/skills/ncr_engineer
	access = NCR_ENGINEER_ACCESS
	comm_title = "ENG"
	total_positions = 5
	job_category = JOB_CAT_NCR
	desc = "Construct defenses, repair equipment, and clear obstacles."

/datum/job/fallout/ncr/captain
	title = NCR_CAPTAIN
	outfit = /datum/outfit/job/fallout/ncr/captain
	skills_type = /datum/skills/ncr_captain
	access = NCR_CAPTAIN_ACCESS
	comm_title = "CPT"
	total_positions = 5
	job_category = JOB_CAT_NCR
	desc = "Corral your squad of tax collectors."

/datum/job/fallout/ncr/leader
	title = NCR_LEADER
	outfit = /datum/outfit/job/fallout/ncr/leader
	skills_type = /datum/skills/ncr_leader
	access = NCR_LEADER_ACCESS
	comm_title = "MAJ"
	total_positions = 1
	job_category = JOB_CAT_NCR
	desc = "Lead your tan army to victory."

/datum/job/fallout/ncr/support
	title = NCR_SUPPORT
	outfit = /datum/outfit/job/fallout/ncr/support
	skills_type = /datum/skills/ncr_support
	access = NCR_SUPPORT_ACCESS
	comm_title = "OPS"
	total_positions = 5
	job_category = JOB_CAT_NCR
	desc = "Provide logistical and medical support to the troops."

//Legion jobs
/datum/job/fallout/legion
	title = LEGION_RECRUIT
	outfit = /datum/outfit/job/fallout/legion
	skills_type = /datum/skills/legion_recruit
	access = LEGION_ACCESS
	comm_title = "REC"
	job_category = JOB_CAT_LEGION
	selection_color = "#6d0d0d"
	desc = "A lowly peon for the Legion. Overcome the odds or die in battle."
	faction_desc = "Whoever you were before does not matter. Your sole duty and purpose in this life is to bend to Caesar's will!"

/datum/job/fallout/legion/prime
	title = LEGION_PRIME
	outfit = /datum/outfit/job/fallout/legion/prime
	skills_type = /datum/skills/legion_prime
	access = LEGION_PRIME_ACCESS
	comm_title = "PRM"
	total_positions = 5
	job_category = JOB_CAT_LEGION
	desc = "A battle-tested soldier, but your suffering is only just starting."

/datum/job/fallout/legion/veteran
	title = LEGION_VETERAN
	outfit = /datum/outfit/job/fallout/legion/veteran
	skills_type = /datum/skills/legion_veteran
	access = LEGION_VETERAN_ACCESS
	comm_title = "VET"
	total_positions = 5
	job_category = JOB_CAT_LEGION
	desc = "Legion's skilled infantrymen who have managed to survive several battles. Make Caesar proud."

/datum/job/fallout/legion/decanus
	title = LEGION_DECANUS
	outfit = /datum/outfit/job/fallout/legion/decanus
	skills_type = /datum/skills/legion_decanus
	access = LEGION_DECANUS_ACCESS
	comm_title = "DEC"
	total_positions = 5
	job_category = JOB_CAT_LEGION
	desc = "An experienced soldier who has proven they can lead others into battle."

/datum/job/fallout/legion/leader
	title = LEGION_LEADER
	outfit = /datum/outfit/job/fallout/legion/leader
	skills_type = /datum/skills/legion_leader
	access = LEGION_LEADER_ACCESS
	comm_title = "CNT"
	total_positions = 1
	job_category = JOB_CAT_LEGION
	desc = "Show the profligates what real power is. Take charge of your legionaries and declare victory at all costs."

/datum/job/fallout/legion/support
	title = LEGION_SUPPORT
	outfit = /datum/outfit/job/fallout/legion/support
	skills_type = /datum/skills/legion_support
	access = LEGION_SUPPORT_ACCESS
	comm_title = "MED"
	total_positions = 5
	job_category = JOB_CAT_LEGION
	desc = "An educated Legionnaire tasked with serving in a support role. Assist the Legion by mending fellow soldiers, growing crops, or building fortifications."
