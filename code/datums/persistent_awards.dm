/obj/item/tester
	name = "tester"
	icon_state = "multitool"

/obj/item/tester/attack(mob/living/M, mob/living/user)
	. = ..()
	M.client.awards_manager.add_award(M, user)

/datum/awards_manager
	var/list/awards = list()

/datum/awards_manager/proc/add_award(mob/recipient, mob/issuer)
	if(!recipient || !issuer)
		return FALSE

	var/award_type = tgui_input_text(issuer, "Enter the award type:", "Award Type", "Bronze Medal", 25)
	if(!award_type)
		return FALSE

	var/award_name = tgui_input_text(issuer, "Enter a name for the award:", "Award Title", "[award_type] of/for", 50)
	if(!award_name)
		return FALSE

	var/description = tgui_input_text(issuer, "Description of the recipient's actions:", "Award Inscription", "For exemplary service")
	if(!description)
		return FALSE

	to_chat(recipient, "You have been awarded the [award_name] by [issuer.name] for [description].", MESSAGE_TYPE_INFO)

	awards += new /datum/award(recipient.name, issuer.name, award_type, award_name, description, world.timeofday)

/datum/awards_manager/proc/view_awards(mob/viewer)
	if(!LAZYLEN(awards))
		return FALSE

	ui_interact(viewer)
	testing("view")

/datum/awards_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	testing("interact")
	if(!ui)
		ui = new(user, src, "persistent_awards", "what")
		ui.open()

/datum/awards_manager/ui_data(mob/user)
	//The complete list of all awards and their details
	var/list/awards_list = list()
	//Holds the actual details of the awards object, used in the for loop
	var/list/award_entry = list()
	var/counter = 0
	for(var/datum/award/award in awards)
		award_entry["character_name"] = award.character_name
		award_entry["issuer_name"] = award.issuer_name
		award_entry["award_type"] = award.award_type
		award_entry["award_name"] = award.award_name
		award_entry["description"] = award.description
		award_entry["date"] = award.date
		award_entry["round_id"] = award.round_id
		awards_list += award_entry	//Add the award's details to the list
		testing("[counter++]")
	return awards_list

/datum/awards_manager/ui_act(action, params)
	. = ..()
	if(.)
		return
	/*if(action == "remove")
		var/removing = params["remove"]*/

/datum/award
	var/character_name
	var/issuer_name
	var/award_type
	var/award_name
	var/description
	var/date
	var/round_id

//Assign all the awards details to the actual award object
/datum/award/New(recipient, issuer, award_type, award_name, description, date)
	character_name = recipient
	issuer_name = issuer
	award_type = award_type
	award_name = award_name
	description = description
	date = date
	round_id = round_id

/client
	var/datum/awards_manager/awards_manager = new /datum/awards_manager()
