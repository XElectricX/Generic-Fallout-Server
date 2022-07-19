//Computer template, empty for now
/obj/machinery/computer/fallout
	name = "terminal"
	desc = "A RobCo terminal."

//Objective for NCR vs Legion mode
/obj/machinery/computer/fallout/objective
	name = "factory control terminal"
	desc = "Administrative console of the factory."
	icon_state = "computer_generic"
	resistance_flags = INDESTRUCTIBLE|UNACIDABLE
	circuit = null
	var/total_segments = 5	//Times needed to run a program; when it reaches this number, round ends
	var/completed_segments = 0	//What segment we are on
	var/segment_time = 5 SECONDS	//How long it takes to start a program
	var/generate_time = 1 MINUTES	//How long it takes for a program to do its thing
	var/current_timer
	var/captured_by	= "legion" //Which faction is currently running the programs; Legion by default because of code shortcuts
	var/printing = FALSE	//If a program is being used or not
	var/list/technobabble = list(
		"Self-diagnostics system running",
		"WARNING: Database corrupted -- System settings defaulting, administrative permissions resetting",
		"ADMINISTRATIVE ACCESS GRANTED: User database updating, security systems updating -- Please stand by",
		"Databases updated, new users recognized, awaiting instruction -- RobCoS2.3")

/obj/machinery/computer/fallout/objective/process()
	. = ..()
	if(. || !current_timer)
		return
	deltimer(current_timer)
	current_timer = null
	visible_message("<b>[src]</b> shuts down as it loses power. Any running programs will now exit.")
	return PROCESS_KILL

/obj/machinery/computer/fallout/objective/attackby(obj/item/I, mob/living/user, params)
	return attack_hand(user)

/obj/machinery/computer/fallout/objective/interact(mob/user)
	. = ..()
	if(.)
		return
	var/obj/item/card/id/I = usr.get_idcard() //Checks what ID you have
	if(istype(I, /obj/item/card/id/ncr))	//If you are NCR and the Legion is controlling it, reset their progress
		if(captured_by == "legion")
			usr.visible_message("[usr] presses the shut down button on [src], restarting the terminal!", "You press the shut down button on [src], restarting the terminal!")
			captured_by = "ncr"
			completed_segments = 0
			return
	if(istype(I, /obj/item/card/id/legion))	//If you are Legion and the NCR is controlling it, reset their progress
		if(captured_by == "ncr")
			usr.visible_message("[usr] smashes [src], restarting the terminal!", "You smash [src], restarting the terminal!")
			captured_by = "legion"
			completed_segments = 0
			return
	var/dat = ""
	dat += "<div align='center'><a href='?src=[REF(src)];generate=1'>Run Program</a></div>"
	dat += "<br/>"
	dat += "<hr/>"
	dat += "<div align='center'><h2>Status</h2></div>"

	var/message = "ERROR"
	if(completed_segments >= total_segments)
		message = "Factory now in <b>[NCR_VICTORY ? "NCR" : "Legion"]</b> control."
	else if(current_timer)
		message = "Program running."
	else if(completed_segments == 0)
		message = "Idle"
	else if(completed_segments < total_segments)
		message = "Error. User input required."
	else
		message = "Unknown"

	var/progress = round((completed_segments / total_segments) * 100)

	dat += "<br/><span><b>Progress</b>: [progress]%</span>"
	dat += "<br/><span><b>Time left</b>: [current_timer ? round(timeleft(current_timer) * 0.1, 2) : 0.0]</span>"
	dat += "<br/><span><b>Message</b>: [message]</span>"

	var/flair = ""
	for(var/i in 1 to completed_segments)
		flair += "[technobabble[i]]<br />"

	dat += "<br /><br /><span style='font-family: monospace, monospace;'>[flair]</span>"

	var/datum/browser/popup = new(user, "computer", "<div align='center'>Factory Central Control Terminal</div>")
	popup.set_content(dat)
	popup.open()

/obj/machinery/computer/fallout/objective/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(href_list["generate"])
		if(printing || current_timer)	//Check if a program is running
			to_chat(usr, span_warning("A program is already running."))
			return
		if(completed_segments == 0)	//If first step, have it "boot" the terminal
			printing = TRUE
			addtimer(VARSET_CALLBACK(src, printing, FALSE), segment_time)
			usr.visible_message("[usr] has booted up [src].", "You boot up [src].")
			if(!do_after(usr, segment_time, TRUE, src, BUSY_ICON_GENERIC, null, null, CALLBACK(src, /datum.proc/process)))
				return
			current_timer = addtimer(CALLBACK(src, .proc/complete_segment), generate_time, TIMER_STOPPABLE)
			return
		printing = TRUE
		addtimer(VARSET_CALLBACK(src, printing, FALSE), segment_time)
		usr.visible_message("[usr] started a program on [src].", "You started a program on [src].")
		if(!do_after(usr, segment_time, TRUE, src, BUSY_ICON_GENERIC, null, null, CALLBACK(src, /datum.proc/process)))
			return
		current_timer = addtimer(CALLBACK(src, .proc/complete_segment), generate_time, TIMER_STOPPABLE)
	updateUsrDialog()

/obj/machinery/computer/fallout/objective/proc/complete_segment()
	playsound(src, 'sound/machines/ping.ogg', 25, 1)
	current_timer = null
	completed_segments = min(completed_segments + 1, total_segments)
	if(completed_segments >= total_segments)	//Check if the objective has been captured completely
		visible_message(span_notice("[src] beeps as the terminal is fully reconfigured."))
		var/datum/game_mode/ncr_vs_legion/mode = SSticker.mode
		if(captured_by == "ncr")
			message_admins("Round finished: NCR victory") //NCR took objective
			mode.round_finished = NCR_VICTORY
			return
		else
			message_admins("Round finished: Legion victory") //Legion took objective
			mode.round_finished = LEGION_VICTORY
			return
	visible_message(span_notice("[src] beeps, requiring further user input."))
