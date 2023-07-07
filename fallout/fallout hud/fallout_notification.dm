/* balloon_alert.dm undefines stuff so need to paste the defines in */
#define BALLOON_TEXT_WIDTH 150
#define BALLOON_TEXT_SPAWN_TIME (0.5 SECONDS)
#define BALLOON_TEXT_FADE_TIME (0.5 SECONDS)
#define BALLOON_TEXT_FULLY_VISIBLE_TIME (4 SECONDS)
#define BALLOON_TEXT_TOTAL_LIFETIME(extra_time) (BALLOON_TEXT_SPAWN_TIME + BALLOON_TEXT_FULLY_VISIBLE_TIME + extra_time + BALLOON_TEXT_FADE_TIME)
/// The increase in duration per character in seconds
#define BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MULT (0.05)
/// The amount of characters needed before this increase takes into effect
#define BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MIN 5

/// Starts the process for making a Fallout-like notification message
/// Necessary to seperate the procs because SpacemanDMM spits out warnings about SHOULD_NOT_SLEEP if it is only one proc
/mob/proc/notification(text, color = "#4AEF98")
	if(!client)	//No one to notify
		return
	SHOULD_NOT_SLEEP(TRUE)
	INVOKE_ASYNC(src, PROC_REF(notification_perform), text, color)

/// Essentially balloon alerts but in the style of Fallout notifications, only called by proc/notification
/mob/proc/notification_perform(text, color)
	var/screen_offset = splittext(client.view, "x")	//Get the dimensions of the user's screen
	var/image/balloon_alert = image(loc = get_atom_on_turf(src), layer = HUD_LAYER)
	balloon_alert.appearance_flags = RESET_ALPHA|RESET_COLOR|RESET_TRANSFORM
	balloon_alert.plane = HUD_PLANE
	balloon_alert.alpha = 0
	balloon_alert.color = color
	balloon_alert.maptext = MAPTEXT("<span style='-dm-text-outline: 2px #0005'>[text]</span>")
	WXH_TO_HEIGHT(client.MeasureText(text, null, BALLOON_TEXT_WIDTH), balloon_alert.maptext_height)
	balloon_alert.maptext_width = BALLOON_TEXT_WIDTH
	balloon_alert.maptext_x = -32*((text2num(screen_offset[1])-1)/2) + 32
	//I don't know why the formula below works but it does; through countless trial and error, the text is aligned
	var/y_positional_calculation = (balloon_alert.maptext_height - 12)*0.9 ? (balloon_alert.maptext_height - 12)*0.9 : 0	//Separating it into a var for simplicity
	//What the auto_center does is to lower the Y position of the text if the entire message is smaller than the notification icon
	//Why have this? Because if not, something like "hello world" will appear in the top left corner leaving a bunch of empty space below
	var/y_auto_center = (y_positional_calculation < 32) ? ((y_positional_calculation/2) ? (y_positional_calculation/2) : 0) - 12 : 0
	balloon_alert.maptext_y = 32*((text2num(screen_offset[2])-1)/2) - y_positional_calculation + y_auto_center + 12
	client.images += balloon_alert
	var/additional_duration = 0
	var/duration_length = length(text) - BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MIN
	if(duration_length > 0)
		additional_duration += duration_length*BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MULT SECONDS

	//Fading in
	animate(balloon_alert, alpha = 255, time = BALLOON_TEXT_SPAWN_TIME, easing = LINEAR_EASING, flags = ANIMATION_PARALLEL)
	//This is to keep it visible at full alpha until the fading out animation
	animate(alpha = 255, time = BALLOON_TEXT_FULLY_VISIBLE_TIME + additional_duration)
	//Fading out
	animate(alpha = 0, time = BALLOON_TEXT_FADE_TIME, easing = LINEAR_EASING)

	//The little vault boy icon
	var/image/notification_icon = image(icon = 'fallout/fallout icons/notification_icons.dmi', loc = client.mob, icon_state = "positive_grayscale", layer = HUD_LAYER)
	notification_icon.appearance_flags = RESET_ALPHA|RESET_COLOR|RESET_TRANSFORM
	notification_icon.plane = HUD_PLANE
	notification_icon.alpha = 0
	notification_icon.color = color
	notification_icon.pixel_x = balloon_alert.maptext_x - 32
	notification_icon.pixel_y = 32*((text2num(screen_offset[2])-1)/2) - 12
	client.images += notification_icon
	animate(notification_icon, alpha = 255, time = BALLOON_TEXT_SPAWN_TIME, easing = LINEAR_EASING, flags = ANIMATION_PARALLEL)
	animate(alpha = 255, time = BALLOON_TEXT_FULLY_VISIBLE_TIME + additional_duration)
	animate(alpha = 0, time = BALLOON_TEXT_FADE_TIME, easing = LINEAR_EASING)

	//The border overlay
	var/image/notification_border = image(icon = 'fallout/fallout icons/notification_icons.dmi', loc = client.mob, icon_state = "border", layer = HUD_LAYER)
	notification_border.appearance_flags = RESET_ALPHA|RESET_COLOR|RESET_TRANSFORM
	notification_border.plane = HUD_PLANE
	notification_border.alpha = 0
	notification_border.color = color
	notification_border.pixel_x = balloon_alert.maptext_x - 32
	notification_border.pixel_y = 32*((text2num(screen_offset[2])-1)/2) - 12
	client.images += notification_border
	animate(notification_border, alpha = 255, time = BALLOON_TEXT_SPAWN_TIME, easing = LINEAR_EASING, flags = ANIMATION_PARALLEL)
	animate(alpha = 255, time = BALLOON_TEXT_FULLY_VISIBLE_TIME + additional_duration)
	animate(alpha = 0, time = BALLOON_TEXT_FADE_TIME, easing = LINEAR_EASING)

	//Delete maptext and graphics after use
	addtimer(CALLBACK(GLOBAL_PROC, PROC_REF(remove_image_from_client), balloon_alert, client), BALLOON_TEXT_TOTAL_LIFETIME(additional_duration))
	addtimer(CALLBACK(GLOBAL_PROC, PROC_REF(remove_image_from_client), notification_icon, client), BALLOON_TEXT_TOTAL_LIFETIME(additional_duration))
	addtimer(CALLBACK(GLOBAL_PROC, PROC_REF(remove_image_from_client), notification_border, client), BALLOON_TEXT_TOTAL_LIFETIME(additional_duration))

#undef BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MIN
#undef BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MULT
#undef BALLOON_TEXT_FADE_TIME
#undef BALLOON_TEXT_FULLY_VISIBLE_TIME
#undef BALLOON_TEXT_SPAWN_TIME
#undef BALLOON_TEXT_TOTAL_LIFETIME
#undef BALLOON_TEXT_WIDTH
