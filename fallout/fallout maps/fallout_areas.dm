/area/start
	ambience = null	//For some reason it has this enabled and because of it, ambience code bugs out

//General areas
/area/fallout
	name = "Fallout"
	icon = 'fallout/fallout icons/fallout_areas.dmi'
	icon_state = "wasteland"
	ambience = "wasteland"	//The variable points to a folder, so in this case music is located under cfg/wasteland
	min_ambience_cooldown = 5 SECONDS
	max_ambience_cooldown = 120 SECONDS

/area/fallout/wasteland
	name = "Wasteland"

/area/fallout/underground
	name = "Underground"
	ambience = "underground"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE

/area/fallout/ncr
	name = "NCR Camp"
	icon_state = "ncr"
	ambience = "ncr"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE

/area/fallout/legion
	name = "Legion Camp"
	icon_state = "legion"
	ambience = "legion"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE

//Tunnel map
/area/fallout/tunnel
	name = "Tunnel"
	icon_state = "tunnel"
	ambience = "underground"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE

/area/fallout/tunnel/east
	name = "Eastern Tunnel"

/area/fallout/tunnel/west
	name = "Western Tunnel"

//Munitions factory map
/area/fallout/factory
	name = "Munitions Factory"
	icon_state = "objective"
	ceiling = CEILING_METAL
	outside = FALSE
	ambience = "underground"

/area/fallout/house
	name = "House"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/apartments
	name = "Apartments"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/police_station
	name = "Police Station"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/town_hall
	name = "Town Hall"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/clinic
	name = "Clinic"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/power_station
	name = "Power Station"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/store
	name = "Store"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/park
	name = "Park"

/area/fallout/farm_house
	name = "Farm House"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/army_camp
	name = "Army Camp"
	icon_state = "enclave"
	ceiling = CEILING_METAL
	outside = FALSE
