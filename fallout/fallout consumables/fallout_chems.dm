/obj/item/reagent_containers/hypospray/fallout
	name = "junk injector"
	desc = "Dirty and useless, probably from before the War."
	icon = 'fallout/fallout icons/fallout items/fallout_medical.dmi'
	icon_state = ""
	init_reagent_flags = DRAWABLE
	skilllock = 0
	possible_transfer_amounts = list(1,3,5,10,15,20)

/obj/item/reagent_containers/hypospray/fallout/interact(mob/user)
	var/N = tgui_input_list(user, "Amount per transfer from this:", "[src]", possible_transfer_amounts)
	if(!N)
		return
	amount_per_transfer_from_this = N

/obj/item/reagent_containers/hypospray/fallout/update_icon()
	if(!(reagents.total_volume) && is_drawable())
		name = "expended [name]"
		icon_state += "_empty"
		DISABLE_BITFIELD(reagents.reagent_flags, DRAWABLE)
	else if(reagents.total_volume && !CHECK_BITFIELD(reagents.reagent_flags, DRAWABLE))
		icon_state = initial(icon_state)
		name = initial(name)
		ENABLE_BITFIELD(reagents.reagent_flags, DRAWABLE)

/obj/item/reagent_containers/hypospray/fallout/stimpak
	name = "stimpak"
	desc = "A handheld delivery system for medicine, used to rapidly heal physical damage to the body."
	icon_state = "stimpak"
	volume = 10
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/medicine/stimpak = 10)
/*
/obj/item/reagent_containers/hypospray/fallout/stimpak/imitation
	name = "imitation stimpak"
	desc = "A handheld delivery system for medicine. This one is filled with ground up flower juice, but hey, whatever gets you moving, right?"
	list_reagents = list(/datum/reagent/medicine/stimpakimitation = 10)

/obj/item/reagent_containers/hypospray/fallout/stimpak/super
	name = "super stimpak"
	desc = "The super version comes in a hypodermic, but with an additional vial containing more powerful drugs than the basic model and a leather belt to strap the needle to the injured limb."
	icon_state = "hypo_superstimpak"
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/medicine/super_stimpak = 10)
*/
/obj/item/reagent_containers/hypospray/fallout/medx
	name = "med-X injector"
	desc = "A short-lasting shot of Med-X applied via hypodermic needle."
	icon_state = "medx"
	volume = 20
	amount_per_transfer_from_this = 20
	list_reagents = list(/datum/reagent/medicine/medx = 20)

/obj/item/reagent_containers/hypospray/fallout/jet
	name = "jet inhaler"
	desc = "A crude inhaler meant to aerolize and deliver Jet."
	icon_state = "jet"
	volume = 20
	amount_per_transfer_from_this = 20
	list_reagents = list(/datum/reagent/jet = 20)

/obj/item/reagent_containers/hypospray/fallout/jet/afterattack(atom/A, mob/living/user)
	if(!A.reagents)
		return
	if(!istype(user))
		return
	if(!in_range(A, user) || !user.Adjacent(A))
		return
	if(!reagents.total_volume)
		to_chat(user, span_warning("[src] is empty."))
		return
	if(ismob(A))
		var/mob/M = A
		if(!M.can_inject(user, TRUE, user.zone_selected, TRUE))
			return
		if(M != user && M.stat != DEAD && M.a_intent != INTENT_HELP && !M.incapacitated() && M.skills.getRating("cqc") >= SKILL_CQC_MP)
			user.Paralyze(60)
			log_combat(M, user, "blocked", addition="using their cqc skill (hypospray injection)")
			M.visible_message(span_danger("[M]'s reflexes kick in and knock [user] to the ground before they could use \the [src]'!"), \
				span_warning("You knock [user] to the ground before they could inject you!"), null, 5)
			playsound(user.loc, 'sound/weapons/thudswoosh.ogg', 25, 1, 7)
			return FALSE
	var/list/injected = list()
	for(var/datum/reagent/R in reagents.reagent_list)
		injected += R.name
	log_combat(user, A, "injected", src, "Reagents: [english_list(injected)]")
	if(ismob(A))
		var/mob/M = A
		to_chat(user, span_notice("[M] takes a mouthful from the [src]."))
		to_chat(M, span_warning("A rush of air enters through your mouth!"))
	playsound(loc, 'sound/effects/spray.ogg', 20, 1)
	reagents.reaction(A, INJECT)
	reagents.trans_to(A, amount_per_transfer_from_this)
	return TRUE

/obj/item/reagent_containers/hypospray/fallout/turbo
	name = "turbo inhaler"
	desc = "A Jet inhaler strapped to a bottle of chemicals. The combined cocktail creates Turbo."
	icon_state = "turbo"
	volume = 10
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/turbo = 10)

/obj/item/reagent_containers/hypospray/fallout/turbo/afterattack(atom/A, mob/living/user)
	if(!A.reagents)
		return
	if(!istype(user))
		return
	if(!in_range(A, user) || !user.Adjacent(A))
		return
	if(!reagents.total_volume)
		to_chat(user, span_warning("[src] is empty."))
		return
	if(ismob(A))
		var/mob/M = A
		if(!M.can_inject(user, TRUE, user.zone_selected, TRUE))
			return
		if(M != user && M.stat != DEAD && M.a_intent != INTENT_HELP && !M.incapacitated() && M.skills.getRating("cqc") >= SKILL_CQC_MP)
			user.Paralyze(60)
			log_combat(M, user, "blocked", addition="using their cqc skill (hypospray injection)")
			M.visible_message(span_danger("[M]'s reflexes kick in and knock [user] to the ground before they could use \the [src]'!"), \
				span_warning("You knock [user] to the ground before they could inject you!"), null, 5)
			playsound(user.loc, 'sound/weapons/thudswoosh.ogg', 25, 1, 7)
			return FALSE
	var/list/injected = list()
	for(var/datum/reagent/R in reagents.reagent_list)
		injected += R.name
	log_combat(user, A, "injected", src, "Reagents: [english_list(injected)]")
	if(ismob(A))
		var/mob/M = A
		to_chat(user, span_notice("[M] takes a mouthful from the [src]."))
		to_chat(M, span_warning("A rush of air enters through your mouth!"))
	playsound(loc, 'sound/effects/spray.ogg', 20, 1)
	reagents.reaction(A, INJECT)
	reagents.trans_to(A, amount_per_transfer_from_this)
	return TRUE

/*
/obj/item/reagent_containers/hypospray/fallout/psycho
	name = "Psycho"
	desc = "Contains Psycho, a drug that makes the user hit harder and shrug off slight stuns, but causes slight brain damage and carries a risk of addiction."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "hypo_psycho"
	volume = 10
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/psycho = 10)
*/
/* --- Herbal remedies --- */

//Powders are applied topically
/obj/item/stack/medical/heal_pack/healing_powder
	name = "healing powder"
	singular_name = "healing powder"
	desc = "A herbal remedy made from crushed and heated broc and xander."
	icon = 'fallout/fallout icons/fallout items/fallout_medical.dmi'
	icon_state = "healing_powder"
	amount = 3
	max_amount = 3
	heal_brute = 30
	heal_burn = 30
	heal_flags = 7

/obj/item/reagent_containers/glass/bitter_drink
	name = "bitter drink"
	desc = "A clay bottle with decorative markings, usually containing the \"bitter drink\" herbal medicine."
	icon = 'fallout/fallout icons/fallout items/fallout_medical.dmi'
	icon_state = "bitter_drink"
	init_reagent_flags = OPENCONTAINER_NOUNIT
	volume = 10
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1,5,10)
	list_reagents = list(/datum/reagent/medicine/bitter_drink = 10)

//Merge this and hydra's attack() whenever chemicals are re-organized
/obj/item/reagent_containers/glass/bitter_drink/attack(mob/living/M, mob/living/user)
	var/datum/reagents/R = src.reagents
	if(!R.total_volume || !R)
		to_chat(user, span_warning("The [src.name] is empty!"))
		return FALSE
	if(iscarbon(M))
		if(M == user)
			usr.visible_message("[usr] takes a drink from [src].", "You drink from [src].")
			reagents.reaction(M, INGEST)
			reagents.trans_to(M, amount_per_transfer_from_this)
			playsound(M.loc,'sound/items/drink.ogg', 15, 1)
			return TRUE
		else
			usr.visible_message(span_warning("[usr] attempts to feed [M] [src]."), span_warning("You attempt to feed [M] [src]!"))
			if(!do_mob(user, M, 30, BUSY_ICON_FRIENDLY))
				return FALSE
			usr.visible_message(span_warning("[usr] fed [M] [src]."), span_warning("You fed [M] [src]."))
			var/rgt_list_text = get_reagent_list_text()
			log_combat(user, M, "fed", src, "Reagents: [rgt_list_text]")
			if(reagents.total_volume)	//Keep this is a check in case it is empty after the timer is finished
				reagents.reaction(M, INGEST)
				reagents.trans_to(M, amount_per_transfer_from_this)
			playsound(M.loc,'sound/items/drink.ogg', 15, 1)
			return TRUE
	return FALSE

/obj/item/reagent_containers/glass/hydra
	name = "hydra"
	desc = "Serving as a natural remedy for broken bones and poisonings, this bottle with vials connected to it serves as the package for the potent hydra medicine."
	icon = 'fallout/fallout icons/fallout items/fallout_medical.dmi'
	icon_state = "hydra"
	init_reagent_flags = OPENCONTAINER_NOUNIT
	volume = 10
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(1,5,10)
	list_reagents = list(/datum/reagent/medicine/hydra = 10)	//According to the math, 2 bones should be fixed with this dosage

/obj/item/reagent_containers/glass/hydra/attack(mob/living/M, mob/living/user)
	var/datum/reagents/R = src.reagents
	if(!R.total_volume || !R)
		to_chat(user, span_warning("The [src.name] is empty!"))
		return FALSE
	if(iscarbon(M))
		if(M == user)
			usr.visible_message("[usr] takes a drink from [src].", "You drink from [src].")
			reagents.reaction(M, INGEST)
			reagents.trans_to(M, amount_per_transfer_from_this)
			playsound(M.loc,'sound/items/drink.ogg', 15, 1)
			return TRUE
		else
			usr.visible_message(span_warning("[usr] attempts to feed [M] [src]."), span_warning("You attempt to feed [M] [src]!"))
			if(!do_mob(user, M, 30, BUSY_ICON_FRIENDLY))
				return FALSE
			usr.visible_message(span_warning("[usr] fed [M] [src]."), span_warning("You fed [M] [src]."))
			var/rgt_list_text = get_reagent_list_text()
			log_combat(user, M, "fed", src, "Reagents: [rgt_list_text]")
			if(reagents.total_volume)	//Keep this is a check in case it is empty after the timer is finished
				reagents.reaction(M, INGEST)
				reagents.trans_to(M, amount_per_transfer_from_this)
			playsound(M.loc,'sound/items/drink.ogg', 15, 1)
			return TRUE
	return FALSE

/obj/item/berserk_powder
	name = "berserk powder"
	desc = "Potent powders that enhance one's abilities."
	icon = 'fallout/fallout icons/fallout items/fallout_medical.dmi'
	icon_state = "berserk_powder"
	w_class = WEIGHT_CLASS_SMALL
	reagents = /datum/reagent/methamphetamine	//Meth. It's meth.
	var/amount = 20
	var/time_to_apply = 3 SECONDS

/obj/item/berserk_powder/attack(mob/living/M)
	. = ..()
	if(!ismob(M))
		return
	if(M == usr)	//Check if you are using it on yourself or someone else
		M.reagents.add_reagent(reagents, amount)	//Add drugs
		usr.visible_message("[usr] huffs [src]!", "You huff [src]!")
		qdel(src)
	else
		if(!do_after(usr, time_to_apply, TRUE, M, BUSY_ICON_MEDICAL))
			return
		M.reagents.add_reagent(reagents, amount)	//Add drugs
		usr.visible_message("[usr] makes [M] huff [src]!", "You make [M] huff [src]!")
		qdel(src)

/obj/item/stack/medical/heal_pack/bandage
	name = "bandages"
	singular_name = "bandage"
	desc = "Clean cloth rolls for stopping bleeding and protecting burnt flesh."
	icon = 'fallout/fallout icons/fallout items/fallout_medical.dmi'
	icon_state = "bandage"
	heal_brute = 20
	heal_burn = 20
	heal_flags = 7
