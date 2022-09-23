/mob/living/simple_animal/fallout
	name = "friendly animal"
	desc = "This little critter should not exist."
	icon = 'fallout/fallout icons/fallout mobs/fallout_nonhumanoids.dmi'
	turns_per_move = 15

/mob/living/simple_animal/fallout/brahmin
	name = "brahmin"
	desc = "Moo."
	icon_state = "brahmin"
	maxHealth = 200	//They fat boys
	speak = list("moo?","moo","MOOOOOO")
	speak_emote = list("moos","moos hauntingly")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.")
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "kicks"
	attacktext = "kicks"
	attack_sound = 'sound/weapons/punch1.ogg'
	var/datum/reagent/milk_reagent = /datum/reagent/consumable/drink/milk
	/*butcher_results = list(/obj/item/reagent_containers/food/snacks/meat = 6)
	var/food_type = /obj/item/reagent_containers/food/snacks/grown/wheat
	var/is_calf = 0
	var/has_calf = 0
	var/young_type = null*/

/mob/living/simple_animal/fallout/brahmin/Initialize()
	. = ..()
	AddComponent(/datum/component/udder)

/mob/living/simple_animal/fallout/brahmin/attack_hand(mob/living/user)
	if(!stat && user.a_intent == INTENT_DISARM && !resting)
		user.visible_message(span_warning("[user] tips over [src]."),
			span_notice("You tip over [src]."))
		to_chat(src, span_userdanger("You are tipped over by [user]!"))
		Paralyze(20 SECONDS)
		set_resting(TRUE, TRUE)
		spawn(rand(20, 50))
			if(!stat && user)
				var/external
				var/internal
				switch(pick(1,2,3,4))
					if(1,2,3)
						var/text = pick("imploringly.", "pleadingly.",
							"with a resigned expression.")
						external = "[src] looks at [user] [text]"
						internal = "You look at [user] [text]"
					if(4)
						external = "[src] seems resigned to its fate."
						internal = "You resign yourself to your fate."
				visible_message(span_notice("[external]"),
					span_revennotice("[internal]"))
	else
		return ..()
