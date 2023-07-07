//If a player chooses a backpack or satchel in character loadout, it overrides the job-specific one
//This can be a problematic, so just disabling the backpack choices doing anything
/datum/preferences/copy_to(mob/living/carbon/human/character, safety = FALSE)
	var/new_name
	if(random_name)
		new_name = character.species.random_name(gender)
	else
		new_name = character.species.prefs_name(src)

	if(!good_eyesight)
		ENABLE_BITFIELD(character.disabilities, NEARSIGHTED)

	character.real_name = new_name
	character.name = character.real_name

	character.flavor_text = flavor_text

	character.med_record = med_record
	character.sec_record = sec_record
	character.gen_record = gen_record
	character.exploit_record = exploit_record

	character.age = age
	character.gender = gender
	character.ethnicity = ethnicity

	character.r_eyes = r_eyes
	character.g_eyes = g_eyes
	character.b_eyes = b_eyes

	character.r_hair = r_hair
	character.g_hair = g_hair
	character.b_hair = b_hair

	character.r_grad = r_grad
	character.g_grad = g_grad
	character.b_grad = b_grad

	character.r_facial = r_facial
	character.g_facial = g_facial
	character.b_facial = b_facial

	character.h_style = h_style
	character.grad_style= grad_style
	character.f_style = f_style

	character.citizenship = citizenship
	character.religion = religion

	character.voice = tts_voice

	character.moth_wings = moth_wings
	character.underwear = underwear
	character.undershirt = undershirt

	/*if(backpack > BACK_NOTHING)
		var/obj/item/storage/backpack/new_backpack
		switch(backpack)
			if(BACK_BACKPACK)
				new_backpack = new /obj/item/storage/backpack/marine(character)
			if(BACK_SATCHEL)
				new_backpack = new /obj/item/storage/backpack/marine/satchel(character)
		character.equip_to_slot_or_del(new_backpack, SLOT_BACK)*/

	character.update_body()
	character.update_hair()
