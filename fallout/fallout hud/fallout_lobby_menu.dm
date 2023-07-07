//Have to override the HUD to change what lobby text objects to use because by default it loads them in order of declaration
//This problem results in the selected character and year texts being displayed at the bottom
/datum/hud/new_player/New(mob/owner, ui_style='icons/mob/screen/white.dmi', ui_color, ui_alpha = 230)
	/* hud/New */
	mymob = owner
	hide_actions_toggle = new

	for(var/mytype in subtypesof(/atom/movable/screen/plane_master) - /atom/movable/screen/plane_master/rendering_plate)
		var/atom/movable/screen/plane_master/instance = new mytype()
		plane_masters["[instance.plane]"] = instance
		instance.backdrop(mymob)
	/* hud/new_player/New */
	var/list/buttons = subtypesof(/atom/movable/screen/text/lobby/fallout)
	buttons -= /atom/movable/screen/text/lobby/fallout/clickable //skip the parent type for clickables
	var/ycoord = 12
	for(var/button in buttons)
		var/atom/movable/screen/text/lobby/fallout/screen = new button()
		screen.hud = src
		static_inventory += screen
		screen.set_position(2, ycoord--)

//Fallout-specific lobby objects; using the old menu-style, before the one with the icons
/atom/movable/screen/text/lobby/fallout
	maptext_x = 5
	maptext_y = 8
	maptext = "If you see this yell at coders"

/atom/movable/screen/text/lobby/fallout/title
	icon_state = ""
	maptext = "<span class=menutitle>Terminal booting...</span>"

/atom/movable/screen/text/lobby/fallout/title/Initialize()
	. = ..()
	maptext = "<span class=menutitle>[SSmapping.configs[GROUND_MAP].map_name]</span>"

INITIALIZE_IMMEDIATE(/atom/movable/screen/text/lobby/fallout/year)
/atom/movable/screen/text/lobby/fallout/year
	maptext = "<span class=menutext>Current Year: Loading...</span>"

/atom/movable/screen/text/lobby/fallout/year/Initialize()
	. = ..()
	maptext = "<span class=menutext>Current Year: 2286</span>"

/atom/movable/screen/text/lobby/fallout/owners_char
	maptext = "<span class=menutext>Loading...</span>"
	///Bool, whether we registered to listen for charachter updates already
	var/registered = FALSE

/atom/movable/screen/text/lobby/fallout/owners_char/Initialize(mapload)
	. = ..()
	if(!mapload)
		INVOKE_NEXT_TICK(src, PROC_REF(set_text))//stupid fucking initialize bug fuck you
		return
	set_text()

/atom/movable/screen/text/lobby/fallout/owners_char/set_text()
	maptext = "<span class=menutext>Current character: [hud?.mymob.client ? hud.mymob.client.prefs.real_name : "Unknown User"]</span>"
	if(!registered)
		RegisterSignal(hud.mymob.client, COMSIG_CLIENT_PREFERENCES_UIACTED, PROC_REF(set_text))
		registered = TRUE

//The buttons in the lobby you click on
/atom/movable/screen/text/lobby/fallout/clickable
	icon_state = "middle"
	icon = 'fallout/fallout icons/fallout_lobby_buttons.dmi'
	maptext_x = 20
	mouse_opacity = MOUSE_OPACITY_ICON

/atom/movable/screen/text/lobby/fallout/clickable/MouseEntered(location, control, params)
	color = COLOR_DARK_MODERATE_LIME_GREEN
	var/mob/new_player/player = usr
	player.playsound_local(player, 'fallout/fallout sounds/obj_switch_button_b.wav',50)

/atom/movable/screen/text/lobby/fallout/clickable/MouseExited(location, control, params)
	color = initial(color)

/atom/movable/screen/text/lobby/fallout/clickable/Click()
	var/mob/new_player/player = usr
	player.playsound_local(player, 'fallout/fallout sounds/obj_switch_button_a.wav', 50)

/atom/movable/screen/text/lobby/fallout/clickable/setup_character
	icon_state = "top"
	maptext = "<span class=menutext>Configure Character</span>"

/atom/movable/screen/text/lobby/fallout/clickable/setup_character/Click()
	. = ..()
	hud.mymob.client?.prefs.ShowChoices(hud.mymob)

/atom/movable/screen/text/lobby/fallout/clickable/join_game
	maptext = "<span class=menutext>Join Game</span>"

/atom/movable/screen/text/lobby/fallout/clickable/join_game/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	player.attempt_late_join()

/atom/movable/screen/text/lobby/fallout/clickable/observe
	maptext = "<span class=menutext>Observe</span>"

/atom/movable/screen/text/lobby/fallout/clickable/observe/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	player.try_to_observe()

/atom/movable/screen/text/lobby/fallout/clickable/ready
	maptext = "<span class=menutext>You are: Not Ready</span>"

/atom/movable/screen/text/lobby/fallout/clickable/ready/set_text()
	var/mob/new_player/player = hud.mymob
	maptext = "<span class=menutext>You are: [player.ready ? "" : "Not "]Ready</span>"

/atom/movable/screen/text/lobby/fallout/clickable/ready/Click()
	. = ..()
	var/mob/new_player/player = usr
	player.toggle_ready()
	set_text()

/atom/movable/screen/text/lobby/fallout/clickable/manifest
	maptext = "<span class=menutext>View Manifest</span>"

/atom/movable/screen/text/lobby/fallout/clickable/manifest/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	player.view_manifest()

/atom/movable/screen/text/lobby/fallout/clickable/background
	maptext = "<span class=menutext>Background</span>"

/atom/movable/screen/text/lobby/fallout/clickable/background/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	player.view_lore()

/atom/movable/screen/text/lobby/fallout/clickable/changelog
	maptext = "<span class=menutext>Changelog</span>"

/atom/movable/screen/text/lobby/fallout/clickable/changelog/Click()
	. = ..()
	hud.mymob.client?.changes()

/atom/movable/screen/text/lobby/fallout/clickable/polls
	icon_state = "bottom"
	maptext = "<span class=menutext>Polls</span>"

/atom/movable/screen/text/lobby/fallout/clickable/polls/Initialize(mapload, atom/one, atom/two)
	. = ..()
	if(!mapload)
		INVOKE_NEXT_TICK(src, PROC_REF(fetch_polls))//stupid fucking initialize bug fuck you
		return
	INVOKE_ASYNC(src, PROC_REF(fetch_polls))

/atom/movable/screen/text/lobby/fallout/clickable/polls/Click()
	. = ..()
	var/mob/new_player/player = hud.mymob
	player.handle_playeR_DBRANKSing()
	fetch_polls()

/atom/movable/screen/text/lobby/fallout/clickable/polls/proc/fetch_polls()
	var/mob/new_player/player = hud.mymob
	var/hasnewpolls = player.check_playerpolls()
	if(isnull(hasnewpolls))
		maptext = "<span class=menutext>No Database!</span>"
		return
	maptext = "<span class=menutext>Show Polls[hasnewpolls ? " (NEW!)" : ""]</span>"

//Lore text used for the Background button; currently uses marines and aliens stuff, needs to be changed another time
/mob/new_player/view_lore()
	var/output = "<div align='center'>"
	output += "<a href='byond://?src=[REF(src)];lobby_choice=marines'>New California Republic Army</A><br><br><a href='byond://?src=[REF(src)];lobby_choice=aliens'>Caesar's Legion</A>"
	output += "</div>"

	var/datum/browser/popup = new(src, "lore", "<div align='center'>Current Year: 2286</div>", 240, 300)
	popup.set_content(output)
	popup.open(FALSE)

/mob/new_player/view_marines()
	var/output = "<div align='center'>"
	output += "<p><i>The <b>New California Republic Army</b> (NCRA) is the standing army of the New California Republic (NCR) and is by far the largest and one of the most effective military forces in the post-nuclear United States.\
				\nSince it's inception, the NCR has continued to expand out from the California area. After arriving in the Mojave Wasteland, they met resistance with Caesar's Legion. The NCR has slowed their expansion efforts as a result of their losses since.\
				\nThe independent Desert Rangers, previously a group of elite law enforcement who targetted slavers, were absorbed into the NCRA as the New California Republic Rangers who's missions include reconnaissance, border security, and disruption operations.</i></p>"
	output += "</div>"

	var/datum/browser/popup = new(src, "marines", "<div align='center'>New California Republic Army</div>", 480, 280)
	popup.set_content(output)
	popup.open(FALSE)

/mob/new_player/view_aliens()
	var/output = "<div align='center'>"
	output += "<p><i>The charismatic leader Caesar founded the <b>Legion</b> by conquering and uniting tribes from the Grand Canyon and expanding outwards, continuing to absorb any groups found.\
				\nAfter his mysterious death, Caesar was immortalized as a diety throughout the Legion territories. The Legate Lanius being his successor was crowned emperor of the Legion.\
				\nThe Legion's army is composed primarily of young and inexperienced men. Those who survive rigorous combat rise through the ranks, but they are always expendable.\
				\nThe Legion prohibits use of chems and advanced technology, relying instead on natural remedies and simple machines. Slave labor is the driving force of their army's logistics and production.</i></p>"
	output += "</div>"

	var/datum/browser/popup = new(src, "aliens", "<div align='center'>Caesar's Legion</div>", 480, 280)
	popup.set_content(output)
	popup.open(FALSE)
