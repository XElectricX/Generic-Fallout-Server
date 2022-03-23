//For displaying lobby screen images
/turf/closed/wall/indestructible/splashscreen
	name = "Lobby"
	icon = 'fallout/fallout icons/fallout_lobby.dmi'

/turf/closed/wall/indestructible/splashscreen/New()
	..()
	icon_state = "title[rand(1,13)]"