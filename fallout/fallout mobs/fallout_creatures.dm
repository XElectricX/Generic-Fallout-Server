/mob/living/carbon/fallout/deathclaw
	name = "deathclaw"
	desc = "Apex predator of the wastes. Run."
	icon = 'fallout/fallout icons/fallout mobs/fallout_deathclaw.dmi'
	icon_state = "deathclaw"
	faction = "deathclaw"
	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	mob_size = MOB_SIZE_BIG
	melee_damage = 50
	maxHealth = 1000
	soft_armor = list(MELEE = 60, BULLET = 40, LASER = 30, ENERGY = 30, BOMB = 25, BIO = 10, FIRE = 10, ACID = 20)
	hard_armor = list(MELEE = 20, BULLET = 20, LASER = 10, ENERGY = 10, BOMB = 5, BIO = 0, FIRE = 0, ACID = 0)
	idle_sound = list('fallout/fallout sounds/fallout mob sounds/deathclaw_idle.ogg')
	aggro_sound = list(\
		'fallout/fallout sounds/fallout mob sounds/deathclaw_aggro1.ogg',\
		'fallout/fallout sounds/fallout mob sounds/deathclaw_aggro2.ogg')
	combat_sound = list('fallout/fallout sounds/fallout mob sounds/deathclaw_attacking.ogg')
	attack_sound = 'sound/weapons/bladeslice.ogg'
	death_sound = 'fallout/fallout sounds/fallout mob sounds/deathclaw_death.ogg'
	attacktext = "slashes"
	pixel_x = -16
	effect_offset_y = 68

/mob/living/carbon/fallout/radroach
	name = "radroach"
	desc = "Gonna need a bigger boot."
	icon_state = "radroach"
	faction = "radroach"
	allow_pass_flags = PASS_LOW_STRUCTURE|PASS_MOB
	mob_size = MOB_SIZE_SMALL
	melee_damage = 5
	maxHealth = 25
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 100, FIRE = 0, ACID = 30)
	idle_sound = list(\
		'fallout/fallout sounds/fallout mob sounds/radroach_idle1.ogg',\
		'fallout/fallout sounds/fallout mob sounds/radroach_idle2.ogg',\
		'fallout/fallout sounds/fallout mob sounds/radroach_idle3.ogg')
	aggro_sound = list('fallout/fallout sounds/fallout mob sounds/radroach_aggro.ogg')
	combat_sound = list('fallout/fallout sounds/fallout mob sounds/radroach_attacking.ogg')
	attack_sound = 'sound/weapons/bladeslice.ogg'
	death_sound = 'fallout/fallout sounds/fallout mob sounds/radroach_death.ogg'
	attacktext = "nips"
	attack_effect = ATTACK_EFFECT_PUNCH
	speak_emote = list("skitters")
	effect_offset_y = 20

/mob/living/carbon/fallout/molerat
	name = "molerat"
	desc = "Common subterranean rodent. Big incisors, quick diggers, and fast breeders."
	icon_state = "molerat"
	faction = "molerat"
	allow_pass_flags = PASS_LOW_STRUCTURE
	mob_size = MOB_SIZE_SMALL
	melee_damage = 10
	maxHealth = 40
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	idle_sound = list(\
		'fallout/fallout sounds/fallout mob sounds/molerat_idle1.ogg',\
		'fallout/fallout sounds/fallout mob sounds/molerat_idle2.ogg')
	aggro_sound = list(\
		'fallout/fallout sounds/fallout mob sounds/molerat_aggro1.ogg',\
		'fallout/fallout sounds/fallout mob sounds/molerat_aggro2.ogg')
	combat_sound = list('fallout/fallout sounds/fallout mob sounds/molerat_attacking.ogg')
	attack_sound = 'sound/weapons/bite.ogg'
	death_sound = 'fallout/fallout sounds/fallout mob sounds/molerat_death.ogg'
	attacktext = "bites"
	attack_effect = ATTACK_EFFECT_BITE
	speak_emote = list("chitters")
	effect_offset_y = 20

/mob/living/carbon/fallout/feral_dog
	name = "feral dog"
	desc = "No longer man's best friend."
	icon_state = "feraldog"
	faction = "dog"
	allow_pass_flags = PASS_LOW_STRUCTURE
	mob_size = MOB_SIZE_SMALL
	melee_damage = 15
	attack_speed = ATTACK_SPEED_FAST
	maxHealth = 50
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	idle_sound = list(\
		'fallout/fallout sounds/fallout mob sounds/dog_bark1.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_bark2.ogg')
	aggro_sound = list('fallout/fallout sounds/fallout mob sounds/dog_aggro.ogg')
	combat_sound = list(\
		'fallout/fallout sounds/fallout mob sounds/dog_charge1.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_charge2.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_charge3.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_charge4.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_charge5.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_charge6.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_charge7.ogg')
	attack_sound = 'sound/weapons/bite.ogg'
	death_sound = list(\
		'fallout/fallout sounds/fallout mob sounds/dog_death1.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_death2.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_death3.ogg',\
		'fallout/fallout sounds/fallout mob sounds/dog_death4.ogg')
	attacktext = "bites"
	attack_effect = ATTACK_EFFECT_BITE
	speak_emote = list("barks", "howls")
	effect_offset_y = 28

/mob/living/carbon/fallout/centaur
	name = "centaur"
	desc = "An abomination."
	icon_state = "centaur"
	faction = "mutant"
	move_resist = MOVE_FORCE_STRONG
	melee_damage = 15
	attack_speed = ATTACK_SPEED_SLOW
	maxHealth = 200
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 100, FIRE = 0, ACID = 100)
	idle_sound = list(\
		'fallout/fallout sounds/fallout mob sounds/centaur_idle1.ogg',\
		'fallout/fallout sounds/fallout mob sounds/centaur_idle2.ogg')
	aggro_sound = list('fallout/fallout sounds/fallout mob sounds/centaur_aggro.ogg')
	combat_sound = list('fallout/fallout sounds/fallout mob sounds/centaur_attacking.ogg')
	attack_sound = 'fallout/fallout sounds/fallout mob sounds/centaur_lash.ogg'
	death_sound = list('fallout/fallout sounds/fallout mob sounds/centaur_death.ogg')
	attacktext = "lashes at"
	attack_effect = "redslash2"
	speak_emote = list("gargles", "screeches", "moans")
	effect_offset_y = 28
