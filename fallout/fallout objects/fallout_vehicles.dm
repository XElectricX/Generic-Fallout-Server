//Funny vehicles
//Bikes
/obj/vehicle/ridden/motorbike/fallout
	name = "motorcycle"
	desc = "An old bike restored to working condition. Has straps for carrying a single bulky item."
	icon = 'fallout/fallout icons/fallout vehicles/fallout_vehicles.dmi'
	icon_state = "motorcycle"

/obj/vehicle/ridden/motorbike/fallout/Initialize()
	. = ..()
	motorbike_cover = mutable_appearance(icon, "motorcycle_cover", MOB_LAYER + 0.1)
	fuel_count = fuel_max
	if(storage_datum)	//Unfortunately, motorbikes create the storage datum via Intialize(), so just going to edit it after the fact
		storage_datum.max_w_class = WEIGHT_CLASS_BULKY
		storage_datum.storage_slots = 1
		storage_datum.max_storage_space = 4

/obj/vehicle/ridden/motorbike/fallout/buckle_mob(mob/living/buckling_mob, force, check_loc, lying_buckle, hands_needed, target_hands_needed, silent)
	if(buckling_mob.mob_size >= MOB_SIZE_XENO)	//Prevent big mobs (mainly power armor users) from getting on
		buckling_mob.notification("You are too big to ride [src].")
		return FALSE

	return ..()
