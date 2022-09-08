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
/atom/proc/notification(mob/viewer, text)
	SHOULD_NOT_SLEEP(TRUE)
	INVOKE_ASYNC(src, .proc/notification_perform, viewer, text)

/// Essentially balloon alerts but in the style of Fallout notifications, only called by proc/notification
/atom/proc/notification_perform(mob/viewer, text)
	var/client/viewer_client = viewer.client
	if (isnull(viewer_client))
		return
	var/screen_offset = splittext(viewer_client.view, "x")	//Get the dimensions of the user's screen
	var/image/balloon_alert = image(loc = get_atom_on_turf(src), layer = ABOVE_MOB_LAYER)
	balloon_alert.plane = BALLOON_CHAT_PLANE
	balloon_alert.alpha = 0
	balloon_alert.appearance_flags = RESET_ALPHA|RESET_COLOR|RESET_TRANSFORM
	balloon_alert.maptext = MAPTEXT("<span style='-dm-text-outline: 2px #0005'><font color='#4AEF98'>[text]</span>")
	balloon_alert.maptext_height = WXH_TO_HEIGHT(viewer_client?.MeasureText(text, null, BALLOON_TEXT_WIDTH))
	balloon_alert.maptext_width = BALLOON_TEXT_WIDTH
	balloon_alert.maptext_x = -32*((text2num(screen_offset[1])-1)/2) + 32
	//I don't know why the formula below works but it does; through countless trial and error, the text is aligned
	var/y_positional_calculation = (balloon_alert.maptext_height - 12)*0.9 ? (balloon_alert.maptext_height - 12)*0.9 : 0	//Separating it into a var for simplicity
	//What the auto_center does is to lower the Y position of the text if the entire message is smaller than the notification icon
	//Why have this? Because if not, something like "hello world" will appear in the top left corner leaving a bunch of empty space below
	var/y_auto_center = (y_positional_calculation < 32) ? ((y_positional_calculation/2) ? (y_positional_calculation/2) : 0) - 12 : 0
	balloon_alert.maptext_y = 32*((text2num(screen_offset[2])-1)/2) - y_positional_calculation + y_auto_center + 12
	viewer_client?.images += balloon_alert
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

	//Deletes the map text
	addtimer(CALLBACK(GLOBAL_PROC, .proc/remove_image_from_client, balloon_alert, viewer_client), BALLOON_TEXT_TOTAL_LIFETIME(additional_duration))
	//Calls the notification graphics
	notification_icon(viewer, BALLOON_TEXT_FULLY_VISIBLE_TIME, additional_duration, BALLOON_TEXT_SPAWN_TIME, BALLOON_TEXT_FADE_TIME, balloon_alert.maptext_x - 32, 32*((text2num(screen_offset[2])-1)/2) - 12, "#4AEF98")

/atom/proc/notification_icon(mob/viewer, time_visible, additional_duration, fade_in_time, fade_out_time, x_pos, y_pos, icon_color)
	var/client/viewer_client = viewer.client
	if(isnull(viewer_client))
		return

	//The little vault boy face in the corner
	var/image/notification_icon = image(icon = 'fallout/fallout icons/notification_icons.dmi', loc = viewer, icon_state = "positive_grayscale", layer = ABOVE_MOB_LAYER)
	notification_icon.plane = BALLOON_CHAT_PLANE
	notification_icon.alpha = 0
	notification_icon.color = icon_color
	notification_icon.pixel_x = x_pos
	notification_icon.pixel_y = y_pos
	viewer_client.images += notification_icon
	animate(notification_icon, alpha = 255, time = fade_in_time, easing = LINEAR_EASING, flags = ANIMATION_PARALLEL)
	animate(alpha = 255, time = time_visible + additional_duration)
	animate(alpha = 0, time = fade_out_time, easing = LINEAR_EASING)

	//The border overlay
	var/image/notification_border = image(icon = 'fallout/fallout icons/notification_icons.dmi', loc = viewer, icon_state = "border", layer = ABOVE_MOB_LAYER)
	notification_border.plane = BALLOON_CHAT_PLANE
	notification_border.alpha = 0
	notification_border.color = icon_color
	notification_border.pixel_x = x_pos
	notification_border.pixel_y = y_pos
	viewer_client.images += notification_border
	animate(notification_border, alpha = 255, time = fade_in_time, easing = LINEAR_EASING, flags = ANIMATION_PARALLEL)
	animate(alpha = 255, time = time_visible + additional_duration)
	animate(alpha = 0, time = fade_out_time, easing = LINEAR_EASING)

	//Removes the graphics after use
	addtimer(CALLBACK(GLOBAL_PROC, .proc/remove_image_from_client, notification_icon, viewer_client), fade_in_time + time_visible + additional_duration + fade_out_time)
	addtimer(CALLBACK(GLOBAL_PROC, .proc/remove_image_from_client, notification_border, viewer_client), fade_in_time + time_visible + additional_duration + fade_out_time)

#undef BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MIN
#undef BALLOON_TEXT_CHAR_LIFETIME_INCREASE_MULT
#undef BALLOON_TEXT_FADE_TIME
#undef BALLOON_TEXT_FULLY_VISIBLE_TIME
#undef BALLOON_TEXT_SPAWN_TIME
#undef BALLOON_TEXT_TOTAL_LIFETIME
#undef BALLOON_TEXT_WIDTH
