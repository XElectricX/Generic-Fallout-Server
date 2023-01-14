//Editing existing defines because it's easier than making new ones
/atom/movable/screen/text/lobby/title
	maptext = "<span class=menutitle>Terminal booting...</span>"

/atom/movable/screen/text/lobby/title/Initialize()
	. = ..()
	maptext = "<span class=menutitle>[SSmapping.configs[GROUND_MAP].map_name]</span>"

/atom/movable/screen/text/lobby/year/Initialize()
	. = ..()
	maptext = "<span class=menutext>Current Year: 2286</span>"

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

//The buttons in the lobby you click on
/atom/movable/screen/text/lobby/clickable
	maptext_x = 20
	icon = 'fallout/fallout icons/fallout_lobby_buttons.dmi'
	icon_state = "middle"

/atom/movable/screen/text/lobby/clickable/setup_character
	maptext = "<span class=menutext>Setup Character</span>"
	icon_state = "top"

/atom/movable/screen/text/lobby/clickable/polls
	maptext = "<span class=menutext>Polls</span>"
	icon_state = "bottom"

/atom/movable/screen/text/lobby/clickable/MouseEntered(location, control, params)
	color = COLOR_DARK_MODERATE_LIME_GREEN
	var/mob/new_player/player = usr
	player.playsound_local(player, 'fallout/fallout sounds/obj_switch_button_b.wav',50)

/atom/movable/screen/text/lobby/clickable/MouseExited(location, control, params)
	color = initial(color)

/atom/movable/screen/text/lobby/clickable/Click()
	var/mob/new_player/player = usr
	player.playsound_local(player, 'fallout/fallout sounds/obj_switch_button_a.wav', 50)
