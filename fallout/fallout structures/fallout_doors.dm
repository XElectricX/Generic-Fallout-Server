//TO DO: Port lock and key sprites, fix auto closing
#define iskey(A) istype(A, /obj/item/key)
#define islock(A) istype(A, /obj/item/lock_construct)

GLOBAL_LIST_EMPTY(global_locks)

/obj/item/lock_construct
	name = "\improper lock"
	icon = 'fallout/fallout icons/fallout structures/fallout_doors.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/lock_data
	var/static/lock_uid = 1
	var/locked = FALSE
	var/prying = FALSE //if somebody is trying to pry us off

/obj/item/lock_construct/Initialize() // Same system machines use for UID. Could probably add a global UID for everything if you wanted and use it for shenanigans, or simpler loading.
	. = ..()
	lock_data = lock_uid++
	desc = "A heavy-duty lock for doors. It has [lock_data] engraved on it."
	GLOB.global_locks += src

/obj/item/lock_construct/Destroy()
	..()
	GLOB.global_locks -= src

/obj/item/lock_construct/attackby(obj/item/I, mob/user) // Blatantly borrowed from Baystation coders and modified for simplicity. Thanks for pointing me in that direction, Rhicora.
	if(iskey(I))
		var/obj/item/key/K = I
		if(!K.lock_data)
			to_chat(user, "<span class='notice'>You fashion \the [I] to unlock \the [src]</span>")
			K.lock_data = lock_data
			K.desc = "A simple key for locks. It has [K.lock_data] engraved on it."
		else
			to_chat(user, "<span class='warning'>\The [I] already unlocks something...</span>")
		return
	if(islock(I))
		var/obj/item/lock_construct/L = I
		L.lock_data = src.lock_data
		to_chat(user, "<span class='notice'>You copy the lock from \the [src] to \the [L], making them identical.</span>")
		L.desc = "A heavy-duty lock for doors. It has [L.lock_data] engraved on it."
		return
	..()

/obj/item/lock_construct/proc/check_key(obj/item/key/K, mob/user = null)
	if(K.lock_data == src.lock_data) //if the key matches us
		if(locked)
			user.visible_message("<span class='warning'>[user] unlocks \the [src].</span>")
			locked = FALSE
		else
			user.visible_message("<span class='warning'>[user] locks \the [src].</span>")
			locked = TRUE
	else
		to_chat(user, "<span class='warning'>This is the wrong key!</span>")

/obj/item/lock_construct/proc/check_locked()
	return locked

/obj/item/lock_construct/proc/pry_off(mob/living/user, atom/A)
	if(!prying)
		user.visible_message("<span class='notice'>[user] starts prying [src] off [A].</span>", \
							"<span class='notice'>You start prying [src] off [A].</span>")
		var/time_to_open = 50
		if(locked)
			time_to_open = 500
		playsound(src, 'sound/effects/metal_creaking.ogg', 100, 1) //is it aliens or just the CE being a dick?
		prying = TRUE
		var/result = do_after(user, time_to_open, target = A)
		prying = FALSE
		if(result)
			playsound(src, 'sound/items/crowbar.ogg', 100, 1)
			user.visible_message("<span class='notice'>[src] breaks off [A] and falls to pieces.</span>")
			return TRUE
	return FALSE

/obj/item/key
	name = "\improper key"
	icon = 'fallout/fallout icons/fallout structures/fallout_doors.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/lock_data = ""

/obj/item/key/Initialize()
	. = ..()
	desc = "A simple key for locks. It has [src.lock_data ? src.lock_data : "nothing"] engraved on it."

/obj/item/key/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/M = I
		to_chat(user, "<span class='notice'>You begin to shape a rod into [src]...</span>")
		if(do_after(user, 35, target = src))
			if(M.get_amount() < 1 || !M)
				return
			var/obj/item/key/S = new /obj/item/key
			M.use(1)
			user.put_in_hands(S)
			to_chat(user, "<span class='notice'>You make a [S] identical to the old [src].</span>")
			S.lock_data = src.lock_data
	else
		return ..()

/obj/item/door_key
	name = "unusable key"
	desc = "A small grey key."
	icon = 'fallout/fallout icons/fallout structures/fallout_doors.dmi'
	icon_state = "empty_key"
	w_class = WEIGHT_CLASS_TINY
	flags_equip_slot = SLOT_BELT
	var/id = null
	var/static/list/used_ids = list()

/obj/item/door_key/New()
	..()
	if(id)
		attach_id(id)

/obj/item/door_key/attack_self(mob/user as mob)
	if(!id)
		return
	src.name = input("Choose key label.",,copytext(src.name,0, length(src.name) - 3)) + " key"
	return

/obj/item/door_key/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/door_key))
		var/obj/item/door_key/K = W
		if((!src.id && !K.id) || (src.id && K.id))
			return 0
		if(alert(user,"You want to make copy of key?",,"Yes","No") == "No")
			return 0
		if(src.id && !K.id)
			K.attach_id(src.id)
		else
			src.attach_id(K.id)
		return 1
	. = ..()

/obj/item/door_key/proc/attach_id(id)
	src.id = id
	src.name = "key"
	src.icon_state = "key"
	if(!overlays || !overlays["usable_key"])
		var/icon/O = icon('fallout/fallout icons/fallout structures/fallout_doors.dmi', "key_overlay")
		if(!used_ids[num2text(id)])
			var/color = rgb(rand(50,255), rand(50,255), rand(50,255))
			O.ColorTone(color)
			used_ids[num2text(id)] = color
		else
			O.ColorTone(used_ids[num2text(id)])
		add_overlay("usable_key", O)

/obj/item/door_key/proc/random_id()
	var/try_id = 1
	if(used_ids.len)
		try_id = text2num(used_ids[used_ids.len]) + 1
	while(used_ids[num2text(try_id)])
		try_id++
	return try_id++

/obj/item/storage/keys_set
	name = "key chain"
	desc = "Put your keys here and make using doors comfortable!"
	icon = 'fallout/fallout icons/fallout structures/fallout_doors.dmi'
	icon_state = "keychain_0"
	w_class = WEIGHT_CLASS_TINY
	flags_equip_slot = SLOT_BELT
/*
/obj/item/storage/keys_set/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.can_hold = typecacheof(list(/obj/item/key))
	STR.max_combined_w_class = 35
*/
/obj/item/storage/keys_set/update_icon()
	if(contents.len <= 4)
		icon_state = "keychain_[contents.len]"
	else
		icon_state = "keychain_4"

/obj/item/storage/keys_set/proc/get_key_with_id(id)
	for(var/obj/item/door_key/K in contents)
		if(K.id == id)
			return K
	return null

/obj/item/lock
	name = "unusable padlock"
	desc = "A small grey lock."
	icon = 'fallout/fallout icons/fallout structures/fallout_doors.dmi'
	icon_state = "closed_lock"
	w_class = WEIGHT_CLASS_TINY
	layer = 100
	var/open = FALSE
	var/id = null

/obj/item/lock/New(location)
	..()
	layer = OBJ_LAYER
	if(id)
		attach_id(id)
		var/obj/structure/simple_door/D = locate(/obj/structure/simple_door) in loc
		if(istype(D) && D.can_hold_padlock)
			D.attach_padlock(src, TRUE)

/obj/item/lock/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/storage/keys_set))
		var/obj/item/storage/keys_set/S = W
		var/obj/item/door_key/K = S.get_key_with_id(id)
		if(istype(K))
			W = K

	if(istype(W,/obj/item/door_key))
		var/obj/item/door_key/K = W
		if(id)
			if(id == K.id)
				to_chat(user, "<span class='notice'>You begin [open ? "locking" : "unlocking"] padlock.</span>")
				if(do_after(user, 15, target = loc))
					toggle()
			else
				to_chat(user, "<span class='warning'>Wrong key!</span>")
		else
			if(K.id)
				attach_id(K.id)
				to_chat(user, "<span class='notice'>[src] is attached by [K].</span>")
			else
				var/new_id
				new_id = K.random_id()
				K.attach_id(new_id)
				src.attach_id(new_id)
				to_chat(user, "<span class='notice'>[K] sets for [src] now.</span>")
		return 1
	. = ..()

/obj/item/lock/proc/attach_id(id)
	src.id = id
	src.name = "padlock"

/obj/item/lock/proc/toggle()
	open = !open
	update_icon()

/obj/item/lock/update_icon()
	icon_state = open ? "opened_lock" : "closed_lock"

/*/obj/structure/mineral_door/fallout
	name = "template door"
	desc = "Report bug if you see this."
	icon = 'fallout/fallout icons/fallout structures/fallout_doors.dmi'
	icon_state = "storechain"
	oreAmount = 5

/obj/structure/mineral_door/fallout/wood
	icon_state = "wood"
	mineralType = "wood"

/obj/structure/mineral_door/wood/Open()
	isSwitchingStates = TRUE
	playsound(loc, 'sound/effects/doorcreaky.ogg', 25, 1)
	flick("[mineralType]opening",src)
	sleep(10)
	density = FALSE
	opacity = FALSE
	state = 1
	update_icon()
	isSwitchingStates = FALSE

/obj/structure/mineral_door/wood/Close()
	isSwitchingStates = TRUE
	playsound(loc, 'sound/effects/doorcreaky.ogg', 25, 1)
	flick("[mineralType]closing",src)
	sleep(10)
	density = TRUE
	opacity = TRUE
	state = 0
	update_icon()
	isSwitchingStates = FALSE

/obj/structure/mineral_door/wood/Dismantle(devastated = 0)
	if(!devastated)
		for(var/i = 1, i <= oreAmount, i++)
			new/obj/item/stack/sheet/wood(get_turf(src))
	qdel(src)
*/



//In the beginning of time, there was a door subtype called /dooor/ to allow a shitcode copypaste.
// "Fuck them copypastes, someone pls, make a system for dooor so no one gets to copypaste shit!"
//  - bartnixon
// "The system was always there, you just needed to use it ..."
//  - bauen1, the guy having to clean up the mess
// "I know what you feel, bro (and thx)."
//  - maxyo

// Ok, this is the main door directory. They open, they close, they take padlocks, easy. For ID locked doors use either airlocks for mechanical ones, or machinery/unpowered for secure wooden doors or cell doors.

//Copy-pasta'ing this because why not, it works after all
/obj/structure/simple_door
	name = "old house door"
	desc = "It opens and closes - nothing out of the ordinary."
	icon = 'fallout/fallout icons/fallout structures/fallout_doors.dmi'
	icon_state = "house"
	opacity = TRUE
	density = TRUE
	anchored = TRUE
	layer = DOOR_CLOSED_LAYER
	max_integrity = 120
	explosion_block = 0.5
	var/can_hold_padlock = TRUE
	var/obj/item/lock_construct/padlock
	var/door_type = "house"
	var/base_opacity = TRUE
	var/manual_opened = 0
	var/material_count = 4
	var/hard_open = FALSE
	var/moving = 0
	var/material_type = /obj/item/stack/sheet/wood
	var/can_disassemble = 1
	var/open_sound = 'sound/machines/door_open.ogg'
	var/close_sound = 'sound/machines/door_close.ogg'
	var/opening_time = 2
	var/closing_time = 4

/obj/structure/simple_door/Initialize()
	. = ..()
	icon_state = door_type

/obj/structure/simple_door/Destroy()
	if(padlock)
		padlock.forceMove(get_turf(src))
		padlock = null
	return ..()

/obj/structure/simple_door/proc/attach_padlock(obj/item/lock_construct/P, force = FALSE, mob/user)
	if(!force && (!can_hold_padlock || !P ))
		return FALSE
	if(padlock)
		to_chat(user, "[src] already has \a [padlock] attached")
		return FALSE
	padlock = P
	padlock.forceMove(src)
	add_overlay("padlock", "[initial(icon_state)]_padlock")

/obj/structure/simple_door/proc/remove_padlock(force = FALSE)
	if(!force && (!padlock))
		return FALSE
	padlock.forceMove(get_turf(src))
	padlock = null
	cut_overlay("padlock")

/obj/structure/simple_door/Bumped(atom/user)
	..()
	if(density)
		if(hard_open)
			return TryToSwitchState(user, 0)
		else
			return TryToSwitchState(user, 1)
	return

/obj/structure/simple_door/proc/Open(animate)
	playsound(src.loc, open_sound, 30, 0, 0)
	if(animate)
		moving = 1
		flick("[door_type]_opening", src)
		sleep(opening_time)
		moving = 0
	set_opacity(0)
	density = 0
	icon_state = "[door_type]_open"
	layer = DOOR_OPEN_LAYER

/obj/structure/simple_door/proc/Close(animate)
	playsound(src.loc, close_sound, 30, 0, 0)
	manual_opened = 0
	density = 1
	if(animate)
		moving = 1
		flick("[door_type]_closing", src)
		sleep(closing_time)
	icon_state = door_type
	set_opacity(base_opacity)
	moving = 0
	layer = DOOR_CLOSED_LAYER

/* can crowbar off a lock, to force a door open. This is overriden in airlock so shouldnt be an issue */
/obj/structure/simple_door/proc/try_to_crowbar(obj/item/I, mob/user)
	if(padlock) /* attempt to pry the lock off */
		if(padlock.pry_off(user,src))
			qdel(padlock)
			padlock = null
			src.desc = "[initial(desc)]"
	return

/obj/structure/simple_door/proc/SwitchState(animate)
	if(density)
		if(padlock)
			if(!padlock.locked)
				Open(animate)
			else
				playsound(src.loc, 'sound/machines/door_locked.ogg', 80, 0, 0)
		else
			Open(animate)
	else
		var/turf/T = get_turf(src)
		for(var/mob/living/L in T)
			return
		Close(animate)
	return 1

/obj/structure/simple_door/attackby(obj/item/weapon/I, mob/living/user, params)
	if(user.a_intent != INTENT_HARM && (istype(I, /obj/item/tool/crowbar) || istype(I, /obj/item/weapon/twohanded/fireaxe)))
		try_to_crowbar(I, user)
		return TRUE
	/*if(!istype(I, /obj/item/stack/sheet/mineral/wood))
		for(var/obj/structure/barricade/wooden/planks/P in loc)
			P.attackby(I, user, params)
			return TRUE*/
	if(istype(I, /obj/item/tool/screwdriver))
		if(padlock)
			to_chat(user, "<span class='warning'>Remove padlock before door dissasembling.</span>")
			return 1
		else
			if(can_disassemble && do_after(user, 60, target = src))
				for(var/i = 1, i <= material_count, i++)
					new material_type(get_turf(src))
				to_chat(user,"<span class='notice'>You disassemble [name].</span>")
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, -3)
				qdel(src)
				return 1
/*	if(istype(I, /obj/item/storage/keys_set))
		var/obj/item/storage/keys_set/S = I
		if(padlock)
			var/obj/item/key/K = S.get_key_with_id(padlock.id)
			if(istype(K))
				I = K
		if(istype(user.get_inactive_held_item(), /obj/item/lock))
			var/obj/item/lock/L = user.get_inactive_held_item()
			var/obj/item/key/K = S.get_key_with_id(L.id)
			if(istype(K))
				I = K
				*/
				//I'll deal with that shit later -harcourt
	if(istype(I, /obj/item/lock_construct) && can_hold_padlock)
		if(padlock)
			to_chat(user, "[src] already has \a [padlock] attached")
			return
		else
			if(user.transferItemToLoc(I, src))
				user.visible_message("<span class='notice'>[user] adds [I] to [src].</span>", \
								"<span class='notice'>You add [I] to [src].</span>")
				if (istype(I, /obj/item/lock_construct))
					desc = "[src.desc] Has a lock."//Fuck it im not doing this bullshit tonight. This will do. :) -with love, harcourt
				padlock = I
	if(istype(I, /obj/item/key))
		if(!padlock)
			to_chat(user, "[src] has no lock attached")
			return
		else
			return padlock.check_key(I,user)
	if(user.a_intent == INTENT_HARM)
//		if(padlock)
//			add_logs(user, src, "attacked", src)
		return ..()
	attack_hand(user)

/obj/structure/simple_door/proc/TryToSwitchState(atom/user, animate)
	if(moving)
		return 0
	else if(isliving(user))
		var/mob/living/M = user
		if(/obj/structure/barricade in src.loc)
			M << "It won't budge!"
			return 0
		if(M.client)
			if(iscarbon(M))
				var/mob/living/carbon/C = M
				if(!C.handcuffed)
					SwitchState(animate)
					return 1
			else
				SwitchState(animate)
				return 1
	return 0

/obj/structure/simple_door/attack_hand(mob/user)
	if(TryToSwitchState(user, 1) && !density)
		manual_opened = 1
//	user.changeNext_move(CLICK_CD_MELEE)
	..()

/obj/structure/simple_door/attack_tk(mob/user)
	if(TryToSwitchState(user, 1) && !density)
		manual_opened = 1
	if(padlock.locked)
		playsound(src.loc, pick('fallout/fallout sounds/door_knock1.wav', 'fallout/fallout sounds/door_knock2.wav', 'fallout/fallout sounds/door_knock3.wav', 'fallout/fallout sounds/door_knock4.wav'), 80, 0, 0)
//	user.changeNext_move(CLICK_CD_MELEE)
	..()
/*
/obj/structure/simple_door/CanPass(atom/movable/mover, border_dir, height=0)
	if(mover.loc == loc)
		return 1
	return !density
*/
//Auto-closing - FIX LATER
/obj/structure/simple_door/Exited(atom/movable/M, direction)
	. = ..()
	if(!density && !manual_opened && ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.client && H.stat != 2)
			if(hard_open)
				TryToSwitchState(H)
			else
				TryToSwitchState(H,1)
	if(M.loc == loc)
		return 1
	return !density

//Wooden doors
/obj/structure/simple_door/house
	name = "house door"
	icon_state = "houseclean"
	door_type = "houseclean"

/obj/structure/simple_door/wood
	name = "wooden cabin door"
	icon_state = "wood"
	door_type = "wood"

/obj/structure/simple_door/interior
	name = "wooden panel door"
	icon_state = "interior"
	door_type = "interior"

/obj/structure/simple_door/room
	name = "wooden door"
	icon_state = "room"
	door_type = "room"

/obj/structure/simple_door/room/dirty
	name = "dirty wooden door"
	icon_state = "room_d"
	door_type = "room_d"

/obj/structure/simple_door/repaired
	name = "old damaged door"
	desc = "Battered and hastily repaired."
	icon_state = "room_repaired"
	door_type = "room_repaired"

//Tent doors
/obj/structure/simple_door/tent
	name = "tent flap"
	desc = "A fairly simple looking entrance to a war tent."
	icon_state = "tent"
	door_type = "tent"
	material_type = /obj/item/stack/sheet/cloth
	open_sound = "sound/effects/curtain.ogg"
	close_sound = "sound/effects/curtain.ogg"
	max_integrity = 100

/obj/structure/simple_door/tent/cloth
	name = "cotton tent entrance"
	icon_state = "tentflap_cloth"
	door_type = "tentflap_cloth"

/obj/structure/simple_door/tent/leather
	name = "brahminskin tent entrance"
	icon_state = "tentflap_leather"
	door_type = "tentflap_leather"
	material_type = /obj/item/stack/sheet/leather

//Metal doors
/obj/structure/simple_door/metal
	name = "shabby metal door"
	icon_state = "metal"
	door_type = "metal"
	material_type = /obj/item/stack/sheet/metal
	open_sound = "fallout/fallout sounds/door_metal_open.ogg"
	close_sound = "fallout/fallout sounds/door_metal_close.ogg"
	max_integrity = 200
	explosion_block = 1.5

/obj/structure/simple_door/metal/iron
	name = "iron door"
	desc = "A heavy iron door."
	icon_state = "iron"
	door_type = "iron"
	max_integrity = 500
	explosion_block = 5
	opening_time = 21
	closing_time = 21
	material_count = 10

/obj/structure/simple_door/metal/store
	name = "metal door"
	desc = "A metal frame door with glass panels."
	icon_state = "store"
	door_type = "store"
	opacity = FALSE
	base_opacity = FALSE

/obj/structure/simple_door/metal/store/dirty
	name = "dirty metal door"
	desc = "A metal door with dirty glass, hard to see anything behind it."
	icon_state = "dirtystore"
	door_type = "dirtystore"

/obj/structure/simple_door/metal/blastdoor
	name = "blast door"
	desc = "Highly reinforced door meant to withstand anything up to an atomic bomb."
	icon_state = "blastdoor"
	door_type = "blastdoor"
	open_sound = "fallout/fallout sounds/door_mechanical_open.ogg"
	close_sound = "fallout/fallout sounds/door_mechanical_close.ogg"
	max_integrity = 1000
	explosion_block = 20
	opening_time = 27
	closing_time = 27
	material_type = /obj/item/stack/sheet/plasteel
	material_count = 25

/obj/structure/simple_door/metal/airlock
	name = "airlock"
	desc = "Commonly found in military facilities."
	icon_state = "airlock"
	door_type = "airlock"
	open_sound = "sound/machines/airlock.ogg"
	close_sound = "sound/machines/airlock.ogg"
	max_integrity = 400
	explosion_block = 1.5
	opening_time = 9
	closing_time = 9
	material_type = /obj/item/stack/sheet/plasteel

/obj/structure/simple_door/metal/airlock/glass
	name = "windowed airlock"
	icon_state = "airlock_glass"
	door_type = "airlock_glass"
	opacity = FALSE
	base_opacity = FALSE

/obj/structure/simple_door/metal/ventilation
	name = "ventilation panel"
	desc = "As you take a closer look, you notice a handle at the bottom of the access hatch."
	icon_state = "ventilation"
	door_type = "ventilation"
	open_sound = "fallout/fallout sounds/door_mechanical_open.ogg"
	close_sound = "fallout/fallout sounds/door_mechanical_close.ogg"
	opening_time = 29
	closing_time = 11

//Gates, kind of like doors but you can shoot and see through them
/obj/structure/simple_door/gate
	name = "iron gate"
	desc = "Bars. No matter which side we're on, aren't we always behind them?"
	icon_state = "gate"
	door_type = "gate"
	open_sound = "fallout/fallout sounds/door_chainlink_open.ogg"
	close_sound = "fallout/fallout sounds/door_chainlink_close.ogg"
	opacity = FALSE
	base_opacity = FALSE
	max_integrity = 200
	explosion_block = 1.5
	coverage = 40
	material_count = 12
	material_type = /obj/item/stack/rods

/obj/structure/simple_door/gate/cell
	name = "cell gate"
	icon_state = "gate_cell"
	door_type = "gate_cell"
	max_integrity = 400

/obj/structure/simple_door/gate/wire
	name = "wire fence gate"
	desc = "83% chance the door knob is stuck."
	icon_state = "gate_wire"
	door_type = "gate_wire"
	flags_atom = ON_BORDER
	layer = ABOVE_ALL_MOB_LAYER
	max_integrity = 150
	coverage = 20
	material_count = 8

/obj/structure/simple_door/gate/wire/setDir(newdir)
	. = ..()
	update_layer()

//For keeping the gate sprite over stuff if not facing north, like fences
/obj/structure/simple_door/gate/wire/proc/update_layer()
	switch(dir)
		if(SOUTH)
			layer = initial(layer)
		if(NORTH)
			layer = BELOW_OBJ_LAYER
		else
			layer = initial(layer) - 0.01

/obj/structure/simple_door/gate/wire/Open(animate)
	. = ..()
	update_layer()

/obj/structure/simple_door/gate/wire/Close(animate)
	. = ..()
	update_layer()

//Following stuff allows wire gates to act like wire fences, but not for wooden gates because it only has a single directional sprite
/obj/structure/simple_door/gate/wire/Initialize()
	. = ..()
	update_layer()
	var/static/list/connections = list(COMSIG_ATOM_EXIT = PROC_REF(on_try_exit))
	AddElement(/datum/element/connect_loc, connections)

/obj/structure/simple_door/gate/wire/on_try_exit(datum/source, atom/movable/mover, direction, list/knownblockers)
	if(CHECK_BITFIELD(mover.allow_pass_flags, PASS_DEFENSIVE_STRUCTURE))
		return NONE
	if(!density || !(flags_atom & ON_BORDER) || !(direction & dir) || (mover.status_flags & INCORPOREAL))
		return NONE
	knownblockers += src
	return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/simple_door/gate/wire/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(CHECK_BITFIELD(mover.allow_pass_flags, PASS_DEFENSIVE_STRUCTURE))
		return TRUE
	if(istype(mover, /obj/vehicle/multitile))
		visible_message(span_danger("[mover] drives over and destroys [src]!"))
		deconstruct(FALSE)
		return FALSE
	if(density)
		if((mover.flags_atom & ON_BORDER) && get_dir(loc, target) & dir)
			return FALSE
		if(get_dir(loc, target) & dir)
			return FALSE
		else
			return TRUE
	else
		return TRUE

/obj/structure/simple_door/gate/wood
	name = "wooden fence gate"
	desc = "For keeping your ranch critters in or keeping raiders out."
	icon_state = "gate_wood"
	door_type = "gate_wood"
	max_integrity = 120
	coverage = 20
	material_type = /obj/item/stack/sheet/wood
	material_count = 4

//Glass doors
/obj/structure/simple_door/glass
	name = "glass panel door"
	desc = "The glass is quite clean, someone took care of this door."
	icon_state = "glass"
	door_type = "glass"
	opacity = FALSE
	base_opacity = FALSE

/obj/structure/simple_door/glass/dirty
	name = "dirty glass panel door"
	desc = "The glass is dirty, hard to see anything behind it."
	icon_state = "dirtyglass"
	door_type = "dirtyglass"

/obj/structure/simple_door/glass/broken
	name = "shattered glass door"
	desc = "A glass panel door, but without the glass."
	icon_state = "brokenglass"
	door_type = "brokenglass"
