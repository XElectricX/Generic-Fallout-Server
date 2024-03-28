//Refer to life.dm for caller

/mob/living/carbon/human/handle_status_effects()
	. = ..()


	//The analgesic effect wears off slowly
	analgesic = max(0, analgesic - 1)

	return TRUE

/mob/living/carbon/human/finish_aura_cycle()

	set_mobility_aura(received_auras[AURA_HUMAN_MOVE] || 0)
	protection_aura = received_auras[AURA_HUMAN_HOLD] || 0
	set_marksman_aura_aura(received_auras[AURA_HUMAN_FOCUS] || 0)
	if(received_auras.Find(AURA_HUMAN_PESTILENCE))
		pestilence_aura = TRUE
		var/obj/effect/abstract/particle_holder/pestilence = new(src, /particles/pestilence_aura)
		//addtimer(VARSET_CALLBACK(pestilence.particles, count, 0), 5)
		QDEL_IN(pestilence, 2 SECONDS)	//Aura subsystem fires every 2 seconds
	else
		pestilence_aura = FALSE

	//Natural recovery; enhanced by hold/protection aura.
	if(protection_aura)
		var/aura_recovery_multiplier = 0.5 + 0.5 * protection_aura //Protection aura adds +50% recovery rate per point of leadership; +100% for an SL +200% for a CO/XO
		dizzy(- 3 * aura_recovery_multiplier)
		jitter(- 3 * aura_recovery_multiplier)
	hud_set_order()

	..()


/mob/living/carbon/human/proc/set_mobility_aura(new_aura)
	if(mobility_aura == new_aura)
		return
	mobility_aura = new_aura
	if(mobility_aura)
		add_movespeed_modifier(MOVESPEED_ID_MOBILITY_AURA, TRUE, 0, NONE, TRUE, -(0.1 + 0.1 * mobility_aura))
		return
	remove_movespeed_modifier(MOVESPEED_ID_MOBILITY_AURA)

///Updates the marksman aura if it is actually changing
/mob/living/carbon/human/proc/set_marksman_aura_aura(new_aura)
	if(marksman_aura == new_aura)
		return
	marksman_aura = new_aura
	SEND_SIGNAL(src, COMSIG_HUMAN_MARKSMAN_AURA_CHANGED, marksman_aura)

/particles/pestilence_aura
	icon = 'icons/effects/particles/generic_particles.dmi'
	icon_state = "x"
	width = 100
	height = 100
	count = 1000
	spawning = 4
	lifespan = 9
	fade = 10
	grow = 0.2
	velocity = list(0, 0)
	position = generator(GEN_CIRCLE, 10, 10, NORMAL_RAND)
	drift = generator(GEN_VECTOR, list(0, -0.15), list(0, 0.15))
	gravity = list(0, 0.4)
	scale = generator(GEN_VECTOR, list(0.3, 0.3), list(0.9,0.9), NORMAL_RAND)
	rotation = 0
	spin = generator(GEN_NUM, 10, 20)
	color = "#7DCC00"
