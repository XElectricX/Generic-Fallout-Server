//How long each day or night is
#define CYCLE_TIME 20 MINUTES
//How long the transition between day and night is
#define TRANSITION_TIME 10 MINUTES

/area
	///Reference to active weather in this area
	var/datum/weather/fallout/weather

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
	///The timer ID for the day/night cycle
	var/timer_id

/area/fallout/wasteland
	name = "Wasteland"

/area/fallout/underground
	name = "Underground"
	ambience = "underground"
	ceiling = CEILING_UNDERGROUND
	outside = FALSE

/area/fallout/ncr
	name = "NCR Camp"
	icon_state = "ncr"
	ambience = "ncr"
	ceiling = CEILING_UNDERGROUND_METAL
	outside = FALSE

/area/fallout/legion
	name = "Legion Camp"
	icon_state = "legion"
	ambience = "legion"
	ceiling = CEILING_UNDERGROUND_METAL
	outside = FALSE

//Tunnel map
/area/fallout/tunnel
	name = "Tunnel"
	icon_state = "tunnel"
	ambience = "underground"
	ceiling = CEILING_UNDERGROUND
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

//Capital Wasteland map
/area/fallout/town
	name = TOWN
	icon_state = "town"

/area/fallout/town/clinic
	name = TOWN + " Clinic"
	icon_state = "town_clinic"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/town/bar
	name = TOWN + " Bar"
	icon_state = "town_bar"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/town/security_department
	name = TOWN + " Guard Station"
	icon_state = "town_security"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/town/residences
	name = TOWN + " Residences"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/town/maintenance
	name = TOWN + " Maintenance"
	icon_state = "town_maintenance"
	ceiling = CEILING_METAL
	outside = FALSE

/area/fallout/town/shop
	name = TOWN + " Shop"
	icon_state = "town_shop"
	ceiling = CEILING_METAL
	outside = FALSE

/* -------------------- */
/* Day/night cycle code */

///Code to start the day/night cycle; starts in day time
/area/fallout/proc/start_day_night_cycle()
	if(!outside || timer_id)
		return

	set_base_lighting(new_alpha = 255)

	timer_id = addtimer(CALLBACK(src, PROC_REF(process_day_night_cycle)), CYCLE_TIME, TIMER_STOPPABLE)

///Runs when a day or night ends, beginning the transition to dusk or dawn
/area/fallout/proc/process_day_night_cycle()
	deltimer(timer_id)
	timer_id = null
	transition(base_lighting_alpha == 255)

///Transition from day to night, or night to day
/area/fallout/proc/transition(is_day)
	//If TRANSITION_TIME is 10 minutes, alpha is changed by 25.5 every minute
	//The transition timer is always called 10 times, so for smaller TRANSITION_TIME values there will be less time between timer calls
	if(is_day)
		set_base_lighting(new_alpha = base_lighting_alpha - (255 / (TRANSITION_TIME / (TRANSITION_TIME / 10))))
		if(base_lighting_alpha <= 0)
			deltimer(timer_id)
			timer_id = addtimer(CALLBACK(src, PROC_REF(process_day_night_cycle)), CYCLE_TIME, TIMER_STOPPABLE)
			return
	else
		set_base_lighting(new_alpha = base_lighting_alpha + (255 / (TRANSITION_TIME / (TRANSITION_TIME / 10))))
		if(base_lighting_alpha >= 255)
			deltimer(timer_id)
			timer_id = addtimer(CALLBACK(src, PROC_REF(process_day_night_cycle)), CYCLE_TIME, TIMER_STOPPABLE)
			return

	deltimer(timer_id)
	timer_id = addtimer(CALLBACK(src, PROC_REF(transition), is_day), TRANSITION_TIME / 10, TIMER_STOPPABLE)

//Couldn't find a better solution to the issue of lightning not loading at roundstart, so just calling area's day night cycle proc when lighting SS is initialized
/datum/controller/subsystem/lighting/Initialize()
	. = ..()

	for(var/area/fallout/new_area in world)
		new_area.start_day_night_cycle()

	return .

#undef CYCLE_TIME
#undef TRANSITION_TIME
