//Funny vehicles
//Bikes
/obj/vehicle/ridden/motorbike/fallout
	name = "motorcycle"
	desc = "An old bike restored to working condition. Has straps for carrying a single bulky item."
	icon = 'fallout/fallout icons/fallout vehicles/fallout_vehicles.dmi'
	icon_state = "motorcycle"
	motorbike_cover = "motorcycle_cover"

/obj/vehicle/ridden/motorbike/fallout/Initialize()
	. = ..()
	motorbike_cover = mutable_appearance(icon, "motorcycle_cover", MOB_LAYER + 0.1)
	fuel_count = fuel_max

//Can't easily stop bikes from spawning with storage so just gonna make it have space for one bulky item (like a jerry can)
/obj/item/storage/internal/motorbike_pack
	storage_slots = 1
	max_w_class = WEIGHT_CLASS_BULKY
	max_storage_space = 4
