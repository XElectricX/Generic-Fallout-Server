/*	I suppose put anything related to basic mob stuff here	*/

/mob/living
	var/can_crawl = FALSE	//If this kind of mob can crawl while lying down or not
	var/crawl_speed = 8	//Multiplicative; see on_floored_trait_gain in init_signals.dm

/mob/living/carbon/human
	can_crawl = TRUE
	///Holder for power armor battery
	var/obj/item/cell/fallout/pa_cell
	var/is_wearing_power_armor = FALSE

/mob/living/carbon/human/Stat()
	. = ..()
	if(is_wearing_power_armor)
		if(statpanel("Power Armor"))
			if(pa_cell)
				stat("Internal Power Systems Info:", "[src.pa_cell.name] - [src.pa_cell.charge]/[src.pa_cell.maxcharge] | [src.pa_cell.charge/src.pa_cell.maxcharge*100]% | \
				Mechanical Power Cost - [src.pa_cell.action_energy_drain] | Current Module Energy Usage Rate - [src.pa_cell.passive_energy_drain]")
			var/obj/item/module	//Holder for modules
			var/obj/item/armor_module/fallout/armor_piece	//Holder for armor pieces
			if(istype(head, /obj/item/armor_module/fallout/helmet))
				armor_piece = head
				for(var/attachments in armor_piece.attachments_by_slot)
					if(!armor_piece.attachments_by_slot[attachments])
						stat("[armor_piece.name]:", "NO MODULE")
						continue
					module = armor_piece.attachments_by_slot[attachments]
					stat("[armor_piece.name]:", "[module.active ? "ACTIVE - " : ""][module.name]")
			if(istype(wear_suit, /obj/item/armor_module/fallout/torso) && wear_suit != /obj/item/armor_module/fallout/torso)
				armor_piece = wear_suit
				for(var/attachments in armor_piece.attachments_by_slot)
					if(!armor_piece.attachments_by_slot[attachments])
						stat("[armor_piece.name]:", "NO MODULE")
						continue
					module = armor_piece.attachments_by_slot[attachments]
					stat("[armor_piece.name]:", "[module.active ? "ACTIVE - " : ""][module.name]")
			if(istype(gloves, /obj/item/armor_module/fallout/arms) && gloves != /obj/item/armor_module/fallout/arms)
				armor_piece = gloves
				for(var/attachments in armor_piece.attachments_by_slot)
					if(!armor_piece.attachments_by_slot[attachments])
						stat("[armor_piece.name]:", "NO MODULE")
						continue
					module = armor_piece.attachments_by_slot[attachments]
					stat("[armor_piece.name]:", "[module.active ? "ACTIVE - " : ""][module.name]")
			if(istype(shoes, /obj/item/armor_module/fallout/legs) && shoes != /obj/item/armor_module/fallout/legs)
				armor_piece = shoes
				for(var/attachments in armor_piece.attachments_by_slot)
					if(!armor_piece.attachments_by_slot[attachments])
						stat("[armor_piece.name]:", "NO MODULE")
						continue
					module = armor_piece.attachments_by_slot[attachments]
					stat("[armor_piece.name]:", "[module.active ? "ACTIVE - " : ""][module.name]")

/mob/living/carbon/human/Moved(atom/oldloc, direction)
	. = ..()
	if(is_wearing_power_armor && pa_cell)
		if(!pa_cell.drain_power(pa_cell.action_energy_drain) && !HAS_TRAIT(src, TRAIT_IMMOBILE))
			to_chat(src, span_warning("The internal battery is out of power!"))
			playsound_local(src, 'sound/mecha/lowpowernano.ogg', 100)
			playsound_local(src, 'sound/mecha/lowpower.ogg', 50)
			ADD_TRAIT(src, TRAIT_IMMOBILE, "power_armor_no_energy")

/mob/living/carbon/human/attack_animal(mob/living/M as mob)
	. = ..()
	if(M.melee_damage && istype(M, /mob/living/carbon/fallout))
		var/mob/living/carbon/fallout/living_mob = M
		M.do_attack_animation(src, living_mob.attack_effect)

#define MOVESPEED_ID_CRAWLING "CRAWLING"
//These 3 procs handle who can crawl or not
/mob/living/on_floored_trait_gain(datum/source)
	if(buckled && buckled.buckle_lying != -1)
		set_lying_angle(buckled.buckle_lying) //Might not actually be laying down, like with chairs, but the rest of the logic applies.
	else if(!lying_angle)
		set_lying_angle(pick(90, 270))
	if(!can_crawl)
		set_canmove(FALSE)
	add_movespeed_modifier(MOVESPEED_ID_CRAWLING, TRUE, 0, NONE, TRUE, crawl_speed)

/mob/living/on_floored_trait_loss(datum/source)
	if(lying_angle)
		set_lying_angle(0)
	if(!can_crawl && !HAS_TRAIT(src, TRAIT_IMMOBILE))	//If you're incapacitated, you can't move anyways
		set_canmove(TRUE)
	remove_movespeed_modifier(MOVESPEED_ID_CRAWLING)

/mob/living/on_immobile_trait_loss(datum/source)
	if(!HAS_TRAIT(src, TRAIT_FLOORED) || can_crawl)
		set_canmove(TRUE)

/mob/living/set_lying_angle(new_lying)
	if(new_lying == lying_angle)
		return
	. = lying_angle
	lying_angle = new_lying
	update_transform()
	lying_prev = lying_angle
	SEND_SIGNAL(src, COMSIG_LIVING_SET_LYING_ANGLE)
	if(lying_angle)
		density = FALSE
		var/obj/item/item_to_unwield = get_held_item()	//Check for unwielding any wielded guns you lie down with
		if(item_to_unwield)
			item_to_unwield.unwield(usr)
		if(layer == initial(layer)) //to avoid things like hiding larvas.
			layer = LYING_MOB_LAYER //so mob lying always appear behind standing mobs
	else
		density = TRUE
		if(layer == LYING_MOB_LAYER)
			layer = initial(layer)

//No reason for this to be running at all
/mob/living/ff_check(total_damage, mob/living/victim)
	return

/*	Rather than using slowdown variable, editing this proc so that walk speed is not affected at the same rate sprinting is
	The problem with using the config values was that it affected every single mob, resulting in unintended consequences	*/
#define HUMAN_WALK_SPEED 3.5
#define HUMAN_RUN_SPEED 2

/mob/living/carbon/human/update_move_intent_effects()
	if(status_flags & INCORPOREAL)
		return FALSE
	switch(m_intent)
		if(MOVE_INTENT_WALK)
			add_movespeed_modifier(MOVESPEED_ID_MOB_WALK_RUN_CONFIG_SPEED, TRUE, 100, NONE, TRUE, HUMAN_WALK_SPEED + CONFIG_GET(number/movedelay/walk_delay))
		if(MOVE_INTENT_RUN)
			add_movespeed_modifier(MOVESPEED_ID_MOB_WALK_RUN_CONFIG_SPEED, TRUE, 100, NONE, TRUE, HUMAN_RUN_SPEED + CONFIG_GET(number/movedelay/run_delay))

//TGMC bomb values are way too strong, lowering them here
/mob/living/carbon/human/ex_act(severity)
	if(status_flags & GODMODE)
		return
	var/b_loss = 0
	var/f_loss = 0
	var/armor = get_soft_armor("bomb") * 0.01 //Gets average bomb armor over all limbs.
	switch(severity)
		if(EXPLODE_DEVASTATE)
			b_loss += rand(60, 100)
			f_loss += rand(60, 100)
			if(!istype(wear_ear, /obj/item/clothing/ears/earmuffs))
				adjust_ear_damage(60 - (60 * armor), 240 - (240 * armor))
			adjust_stagger(12 - (12 * armor))
			add_slowdown((120 - round(120 * armor, 1)) * 0.01)
		if(EXPLODE_HEAVY)
			b_loss += rand(25, 60)
			f_loss += rand(25, 60)
			if(!istype(wear_ear, /obj/item/clothing/ears/earmuffs))
				adjust_ear_damage(30 - (30 * armor), 120 - (120 * armor))
			adjust_stagger(6 - (6 * armor))
			add_slowdown((60 - round(60 * armor, 1)) * 0.1)
		if(EXPLODE_LIGHT)
			b_loss += rand(10, 25)
			f_loss += rand(10, 25)
			if(!istype(wear_ear, /obj/item/clothing/ears/earmuffs))
				adjust_ear_damage(10 - (10 * armor), 30 - (30 * armor))
			adjust_stagger(3 - (3 * armor))
			add_slowdown((30 - round(30 * armor, 1)) * 0.1)
	#ifdef DEBUG_HUMAN_ARMOR
	to_chat(world, "DEBUG EX_ACT: armor: [armor * 100], b_loss: [b_loss], f_loss: [f_loss]")
	#endif
	take_overall_damage(b_loss, BRUTE, BOMB, updating_health = TRUE)
	take_overall_damage(f_loss, BURN, BOMB, updating_health = TRUE)

/* All of this is necessary just to stop blood splattering effect when damage taken is 0, incredible */
//Need to redefine because projectile.dm undefined them -_-
#define BULLET_FEEDBACK_PEN (1<<0)
#define BULLET_FEEDBACK_SOAK (1<<1)
#define BULLET_FEEDBACK_FIRE (1<<2)
#define BULLET_FEEDBACK_SCREAM (1<<3)
#define BULLET_FEEDBACK_SHRAPNEL (1<<4)
#define BULLET_FEEDBACK_IMMUNE (1<<5)

//Adding FALSE values if damage is 0
/mob/living/bullet_act(obj/projectile/proj)
	/* Need to paste in the code from atom/bullet_act because if I use ..() it will just call living/bullet_act twice */
	if(HAS_TRAIT(proj, TRAIT_PROJ_HIT_SOMETHING))
		proj.damage *= proj.ammo.on_pierce_multiplier
		proj.penetration *= proj.ammo.on_pierce_multiplier
		proj.sundering *= proj.ammo.on_pierce_multiplier
	ADD_TRAIT(proj, TRAIT_PROJ_HIT_SOMETHING, BULLET_ACT_TRAIT)
	SEND_SIGNAL(src, COMSIG_ATOM_BULLET_ACT, proj)
	/* The actual living/bullet_act below */
	if(stat == DEAD)
		return
	var/damage = max(0, proj.damage - round(proj.distance_travelled * proj.damage_falloff))
	if(!damage)
		return FALSE	//Fallout edit
	damage = check_shields(COMBAT_PROJ_ATTACK, damage, proj.ammo.armor_type, FALSE, proj.penetration)
	if(!damage)
		proj.ammo.on_shield_block(src, proj)
		bullet_ping(proj)
		return FALSE	//Fallout edit
	if(!damage)
		return FALSE	//Fallout edit
	flash_weak_pain()
	var/feedback_flags = NONE
	if(proj.shot_from && src == proj.shot_from.sniper_target(src))
		damage *= SNIPER_LASER_DAMAGE_MULTIPLIER
		proj.penetration *= SNIPER_LASER_ARMOR_MULTIPLIER
		add_slowdown(SNIPER_LASER_SLOWDOWN_STACKS)
	if(iscarbon(proj.firer))
		var/mob/living/carbon/shooter_carbon = proj.firer
		if(shooter_carbon.stagger)
			damage *= STAGGER_DAMAGE_MULTIPLIER //Since we hate RNG, stagger reduces damage by a % instead of reducing accuracy; consider it a 'glancing' hit due to being disoriented.
	var/original_damage = damage
	damage = modify_by_armor(damage, proj.armor_type, proj.penetration, proj.def_zone)
	if(damage == original_damage)
		feedback_flags |= BULLET_FEEDBACK_PEN
	else if(!damage)
		feedback_flags |= BULLET_FEEDBACK_SOAK
		bullet_soak_effect(proj)
	if(proj.ammo.flags_ammo_behavior & AMMO_INCENDIARY)
		adjust_fire_stacks(proj.ammo.incendiary_strength)
		if(IgniteMob())
			feedback_flags |= (BULLET_FEEDBACK_FIRE)
	if(proj.ammo.flags_ammo_behavior & AMMO_SUNDERING)
		adjust_sunder(proj.sundering * get_sunder())
	if(damage)
		var/shrapnel_roll = do_shrapnel_roll(proj, damage)
		if(shrapnel_roll)
			feedback_flags |= (BULLET_FEEDBACK_SHRAPNEL|BULLET_FEEDBACK_SCREAM)
		else if(prob(damage * 0.25))
			feedback_flags |= BULLET_FEEDBACK_SCREAM
		bullet_message(proj, feedback_flags, damage)
		proj.play_damage_effect(src)
		apply_damage(damage, proj.ammo.damage_type, proj.def_zone, updating_health = TRUE) //This could potentially delete the source.
		if(shrapnel_roll)
			embed_projectile_shrapnel(proj)
	else
		bullet_message(proj, feedback_flags)
	GLOB.round_statistics.total_projectile_hits[faction]++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "total_projectile_hits[faction]")
	/* Fallout edit */
	if(damage)
		return TRUE
	else
		return FALSE

/mob/living/carbon/do_projectile_hit(obj/projectile/proj)
	proj.ammo.on_hit_mob(src, proj)
	if(!bullet_act(proj))	//If damage from a bullet is 0, no blood splatter
		return
	if(!(species?.species_flags & NO_BLOOD) && proj.ammo.flags_ammo_behavior & AMMO_BALLISTIC)
		new /obj/effect/temp_visual/dir_setting/bloodsplatter(loc, proj.dir, get_blood_color())

//Override fracture() to use the notification system instead of a self message
/datum/limb/fracture()
	if(limb_status & (LIMB_BROKEN|LIMB_DESTROYED|LIMB_ROBOT) )
		return
	owner.notification("Your [display_name] is broken.")
	owner.visible_message(span_warning("You hear a loud cracking sound coming from [owner]!"))
	var/F = pick('sound/effects/bone_break1.ogg','sound/effects/bone_break2.ogg','sound/effects/bone_break3.ogg','sound/effects/bone_break4.ogg','sound/effects/bone_break5.ogg','sound/effects/bone_break6.ogg','sound/effects/bone_break7.ogg')
	playsound(owner,F, 45, 1)
	if(owner.species && !(owner.species.species_flags & NO_PAIN))
		owner.emote("scream")
	add_limb_flags(LIMB_BROKEN)
	remove_limb_flags(LIMB_REPAIRED)
	broken_description = pick("broken","fracture","hairline fracture")
	// Fractures have a chance of getting you out of restraints
	if (prob(25))
		release_restraints()
	/// Emit a signal for autodoc to support the life if available
	SEND_SIGNAL(owner, COMSIG_HUMAN_LIMB_FRACTURED, src)
	return

/mob/living/carbon/adjust_nutrition_speed(old_nutrition)
	var/mob/human = src
	switch(nutrition)
		if(0 to NUTRITION_HUNGRY) //Level where a yellow food pip shows up, aka hunger level 3 at 250 nutrition and under
			add_movespeed_modifier(MOVESPEED_ID_HUNGRY, TRUE, 0, NONE, TRUE, round(1.5 - (nutrition / 250), 0.1)) //From 0.5 to 1.5
			if(old_nutrition < NUTRITION_HUNGRY)	//Prevent spam
				return
			human.notification("You are hungry.")
		if(NUTRITION_HUNGRY to NUTRITION_OVERFED)
			switch(old_nutrition)	//More checks to prevent spam
				if(0 to NUTRITION_HUNGRY)
					human.notification("You are satisfied.")
				if(NUTRITION_HUNGRY to NUTRITION_OVERFED)
					return
				if(NUTRITION_OVERFED to INFINITY)
					human.notification("You feel fit again.")
			remove_movespeed_modifier(MOVESPEED_ID_HUNGRY)
		if(NUTRITION_OVERFED to INFINITY) //Overeating
			if(old_nutrition > NUTRITION_OVERFED)
				return
			human.notification("You feel bloated.")
			add_movespeed_modifier(MOVESPEED_ID_HUNGRY, TRUE, 0, NONE, TRUE, 0.5)

//Overriding to use notification() instead of some chat messages
/mob/living/carbon/human/handle_blood()
	if(species.species_flags & NO_BLOOD)
		return
	if(stat != DEAD && bodytemperature >= 170)	//Dead or cryosleep people do not pump the blood.
		//Blood regeneration if there is some space
		if(blood_volume < BLOOD_VOLUME_NORMAL)
			blood_volume += 0.1 // regenerate blood VERY slowly
		if(blood_volume > BLOOD_VOLUME_MAXIMUM) //Warning: contents under pressure.
			var/spare_blood = blood_volume - ((BLOOD_VOLUME_MAXIMUM + BLOOD_VOLUME_NORMAL) / 2) //Knock you to the midpoint between max and normal to not spam.
			if(drip(spare_blood))
				var/bleed_range = 0
				switch(spare_blood)
					if(0 to 30) //20 is the functional minimum due to midpoint calc
						to_chat(src, span_notice("Some spare blood leaks out of your nose."))
					if(30 to 100)
						to_chat(src, span_notice("Spare blood gushes out of your ears and mouth. Must've had too much."))
						bleed_range = 1
					if(100 to INFINITY)
						visible_message(span_notice("Several jets of blood open up across [src]'s body and paint the surroundings red. How'd [p_they()] do that?"), \
							span_notice("Several jets of blood open up across your body and paint your surroundings red. You feel like you aren't under as much pressure any more."))
						bleed_range = 3
				if(bleed_range)
					for(var/turf/canvas in RANGE_TURFS(bleed_range, src))
						add_splatter_floor(canvas)
					for(var/mob/canvas in viewers(bleed_range, src))
						canvas.add_blood(species.blood_color) //Splash zone
					playsound(loc, 'sound/effects/splat.ogg', 25, TRUE, 7)
	//Effects of bloodloss
		switch(blood_volume)
			if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
				if(prob(1))
					var/word = pick("dizzy","woozy","faint","light headed")
					notification("You feel [word].")
				if(oxyloss < 20)
					adjustOxyLoss(3)
			if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
				if(eye_blurry < 50)
					adjust_blurriness(5)
				if(oxyloss < 40)
					adjustOxyLoss(6)
				else
					adjustOxyLoss(3)
				if(prob(10) && stat == UNCONSCIOUS)
					adjustToxLoss(1)
				if(prob(15))
					Unconscious(rand(20,60))
					var/word = pick("extremely dizzy","very woozy","weak","fatigued","unable to focus")
					notification("You feel [word].")
			if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
				adjustOxyLoss(5)
				adjustToxLoss(2)
				if(prob(15))
					var/word = pick("your head pounding","your life draining from your body","extremely weak","horribly fatigued")
					notification("You feel [word].")
			if(0 to BLOOD_VOLUME_SURVIVE)
				death()
		// Without enough blood you slowly go hungry.
		if(blood_volume < BLOOD_VOLUME_SAFE)
			switch(nutrition)
				if(300 to INFINITY)
					adjust_nutrition(-10)
				if(200 to 300)
					adjust_nutrition(-3)
		//Bleeding out
		var/blood_max = 0
		for(var/l in limbs)
			var/datum/limb/temp = l
			if(!(temp.limb_status & LIMB_BLEEDING) || temp.limb_status & LIMB_ROBOT)
				continue
			blood_max += temp.brute_dam / 60
			if (temp.surgery_open_stage)
				blood_max += 0.6  //Yer stomach is cut open
		if(blood_max)
			drip(blood_max)

//Override for brain damage notifications
/datum/internal_organ/brain/set_organ_status()
	var/old_organ_status = organ_status
	if(damage > min_broken_damage)
		if(organ_status != ORGAN_BROKEN)
			organ_status = ORGAN_BROKEN
			owner.notification("AIN'T THAT A KICK IN THE HEAD?")
			return TRUE
		return FALSE
	if(damage > min_bruised_damage)
		if(organ_status != ORGAN_BRUISED)
			organ_status = ORGAN_BRUISED
			owner.notification("A throbbing pain pulses around your head.")
			return TRUE
		return FALSE
	if(organ_status != ORGAN_HEALTHY)
		organ_status = ORGAN_HEALTHY
		return TRUE
	owner.skills = owner.skills.modifyAllRatings(old_organ_status - organ_status)
	if(organ_status >= ORGAN_BRUISED)
		ADD_TRAIT(owner, TRAIT_DROOLING, BRAIN_TRAIT)
	else
		REMOVE_TRAIT(owner, TRAIT_DROOLING, BRAIN_TRAIT)
