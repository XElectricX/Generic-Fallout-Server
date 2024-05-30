/obj/item/lock
	name = "lock"
	desc = "Can be attached to doors."
	icon_state = "coin"	//Needs a new sprite
	w_class = WEIGHT_CLASS_SMALL
	///Reference to the door this lock is attached to; used for deletion purposes
	var/obj/structure/door/door
	///Time to attach this lock to a door
	var/attach_time = 2 SECONDS
	///Time to detach this lock from a door
	var/detach_time = 2 SECONDS
	///The % chance of the lock stopping a forced opening; number from 0 to 100, where 100 always keeps the door closed
	var/lock_strength = 50
	///Boolean for if the lock is locked
	var/locked = FALSE
	///String ID for the lock; will be assigned a string if from a mapped-in door with a lock
	var/personal_lock_id
	///Counter for automatically creating unique IDs for locks
	var/static/next_available_lock_id = 1

/obj/item/lock/Initialize(mapload, unique_id)
	. = ..()
	initialize_lock_id(unique_id)

/obj/item/lock/Destroy()
	if(door)
		door.lock = null
		door = null
	return ..()

/obj/item/lock/examine(mob/user)
	. = ..()
	//Delete the open and closed lines if there are ever sprites to represent these states
	. += span_notice("It is [span_bold("[locked ? "closed" : "open"]")] and has [span_bold(personal_lock_id)] engraved on it.")

/obj/item/lock/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(isdoorkey(I))
		toggle(user, I)

///Call this if you want to open or close the lock; both arguments are optional
/obj/item/lock/proc/toggle(mob/user, obj/item/key/door/key)
	if(personal_lock_id != key.personal_lock_id)
		if(user)
			balloon_alert(user, "Key doesn't fit")
		return

	if(locked)
		if(user)
			balloon_alert(user, "Unlocked")
		unlock()
		return

	if(user)
		balloon_alert(user, "Locked")
	lock()

///Handle locking
/obj/item/lock/proc/lock()
	locked = TRUE
	//icon_state = "[initial(icon_state)]_locked"
	update_icon()

///Handle unlocking
/obj/item/lock/proc/unlock()
	locked = FALSE
	//icon_state = initial(icon_state)
	update_icon()

///For assigning locks their ID on creation; pass a unique_id to assign a specific ID, like "storage room"
/obj/item/lock/proc/initialize_lock_id(unique_id)
	if(personal_lock_id)
		return

	if(unique_id)
		personal_lock_id = unique_id
		return

	personal_lock_id = num2text(next_available_lock_id++)
