datum/preferences
	//The mob should have a gender you want before running this proc. Will run fine without H
	proc/random_character(gender_override)
		if(gender_override)
			gender = gender_override
		else
			gender = pick(MALE,FEMALE)
		underwear = random_underwear(gender)
		undershirt = random_undershirt(gender)
		socks = random_socks(gender)
		skin_tone = random_skin_tone()
		hair_style = random_hair_style(gender)
		facial_hair_style = random_facial_hair_style(gender)
		hair_color = random_short_color()
		facial_hair_color = hair_color
		eye_color = random_eye_color()
		backbag = 2
		age = rand(AGE_MIN,AGE_MAX)

	proc/update_preview_icon()		//seriously. This is horrendous.
		del(preview_icon_front)
		del(preview_icon_side)
		var/icon/preview_icon = null

		var/g = "m"
		if(gender == FEMALE)	g = "f"

		preview_icon = new /icon('icons/mob/human.dmi', "[skin_tone]_[g]_s")

		var/datum/sprite_accessory/S
		if(underwear)
			S = underwear_all[underwear]
			if(S)
				preview_icon.Blend(new /icon(S.icon, "[S.icon_state]_s"), ICON_OVERLAY)

		if(undershirt)
			S = undershirt_list[undershirt]
			if(S)
				preview_icon.Blend(new /icon(S.icon, "[S.icon_state]_s"), ICON_OVERLAY)

		if(socks)
			S = socks_list[socks]
			if(S)
				preview_icon.Blend(new /icon(S.icon, "[S.icon_state]_s"), ICON_OVERLAY)

		var/icon/eyes_s = new/icon("icon" = 'icons/mob/human_face.dmi', "icon_state" = "eyes_s")
		eyes_s.Blend("#[eye_color]", ICON_MULTIPLY)

		S = hair_styles_list[hair_style]
		if(S)
			var/icon/hair_s = new/icon("icon" = S.icon, "icon_state" = "[S.icon_state]_s")
			hair_s.Blend("#[hair_color]", ICON_MULTIPLY)
			eyes_s.Blend(hair_s, ICON_OVERLAY)

		S = facial_hair_styles_list[facial_hair_style]
		if(S)
			var/icon/facial_s = new/icon("icon" = S.icon, "icon_state" = "[S.icon_state]_s")
			facial_s.Blend("#[facial_hair_color]", ICON_MULTIPLY)
			eyes_s.Blend(facial_s, ICON_OVERLAY)

		var/icon/clothes_s = null
		if(job_civilian_low & ASSISTANT)//This gives the preview icon clothes depending on which job(if any) is set to 'high'
			clothes_s = new /icon('icons/mob/uniform.dmi', "grey_s")
			clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
			if(backbag == 2)
				clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
			else if(backbag == 3)
				clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)

		else if(job_civilian_high)//I hate how this looks, but there's no reason to go through this switch if it's empty
			switch(job_civilian_high)
				if(HOP)
					clothes_s = new /icon('icons/mob/uniform.dmi', "hop_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "hopcap"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(BARTENDER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "ba_suit_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "armor"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(BOTANIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "hydroponics_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "ggloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "apron"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-hyd"), ICON_OVERLAY)
				if(CHEF)
					clothes_s = new /icon('icons/mob/uniform.dmi', "chef_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "chef"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(JANITOR)
					clothes_s = new /icon('icons/mob/uniform.dmi', "janitor_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(LIBRARIAN)
					clothes_s = new /icon('icons/mob/uniform.dmi', "red_suit_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(QUARTERMASTER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "qm_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "fingerless"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/eyes.dmi', "sun"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_righthand.dmi', "clipboard"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(CARGOTECH)
					clothes_s = new /icon('icons/mob/uniform.dmi', "cargotech_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "fingerless"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(MINER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "miner_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "fingerless"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "engiepack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-eng"), ICON_OVERLAY)
				if(LAWYER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "inq_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "jackboots"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "inqaltcape"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "ig"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "inqhat"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/back.dmi', "inq"), ICON_OVERLAY)
				if(CHAPLAIN)
					clothes_s = new /icon('icons/mob/uniform.dmi', "chapblack_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(CELEBRITY)
					clothes_s = new /icon('icons/mob/uniform.dmi', "red_suit_s")
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "celeb"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "tourist"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "spliffoff"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
				if(MIME)
					clothes_s = new /icon('icons/mob/uniform.dmi', "mime_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "lgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "beret"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "suspenders"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "solitaire"), ICON_OVERLAY) //Little foreshadowing...
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "mimepack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)

		else if(job_medsci_high)
			switch(job_medsci_high)
				if(RD)
					clothes_s = new /icon('icons/mob/uniform.dmi', "director_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "LIOX"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-tox"), ICON_OVERLAY)
				if(SCIENTIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "science_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "warmboots"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-tox"), ICON_OVERLAY)
				if(CHEMIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "chemistrywhite_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "plaguedoctor2"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "medicalpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-chem"), ICON_OVERLAY)
				if(CMO)
					clothes_s = new /icon('icons/mob/uniform.dmi', "cmo_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "medicusmask"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "hospitaller"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "medicalpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-med"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_lefthand.dmi', "firstaid"), ICON_UNDERLAY)
				if(DOCTOR)
					clothes_s = new /icon('icons/mob/uniform.dmi', "medical_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_lefthand.dmi', "firstaid"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "medicusmask"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "plaguedoctor2"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "medicalpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-med"), ICON_OVERLAY)
				if(GENETICIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "geneticswhite_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "labcoat_gen_open"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "medicalpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-gen"), ICON_OVERLAY)
				if(VIROLOGIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "virologywhite_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "white"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "sterile"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "bio_virology"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "medicalpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-vir"), ICON_OVERLAY)
				if(ROBOTICIST)
					clothes_s = new /icon('icons/mob/uniform.dmi', "robotics_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_righthand.dmi', "toolbox_blue"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "rig-engineering"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-robo"), ICON_OVERLAY)

		else if(job_engsec_high)
			switch(job_engsec_high)
				if(CAPTAIN)
					clothes_s = new /icon('icons/mob/uniform.dmi', "captain_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "captain"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/eyes.dmi', "sun"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "lccoat"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "captainpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-cap"), ICON_OVERLAY)
				if(HOS)
					clothes_s = new /icon('icons/mob/uniform.dmi', "hosred_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "jackboots"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "hoscap"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "hos"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "securitypack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-sec"), ICON_OVERLAY)
				if(WARDEN)
					clothes_s = new /icon('icons/mob/uniform.dmi', "warden_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "jackboots"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "policehelm"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "warden_jacket"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "securitypack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-sec"), ICON_OVERLAY)
				if(DETECTIVE)
					clothes_s = new /icon('icons/mob/uniform.dmi', "detective_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_lefthand.dmi', "gun"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "cigaron"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "hoscap"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "hos"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-norm"), ICON_OVERLAY)
				if(OFFICER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "imperial_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "jackboots"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/items_righthand.dmi', "lasgunb"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "imperialhelmet"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "imperialarmor"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/back.dmi', "impbag"), ICON_OVERLAY)
				if(CHIEF)
					clothes_s = new /icon('icons/mob/uniform.dmi', "chief_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "brown"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/belt.dmi', "utility"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/mask.dmi', "gas_alt"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "rig0-white"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "rig-white"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "engiepack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-eng"), ICON_OVERLAY)
				if(ENGINEER)
					clothes_s = new /icon('icons/mob/uniform.dmi', "engine_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "orange"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/belt.dmi', "utility"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/head.dmi', "rig0_engineering"), ICON_OVERLAY)
					clothes_s.Blend(new /icon('icons/mob/suit.dmi', "rig-engineering"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "engiepack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-eng"), ICON_OVERLAY)
				if(ATMOSTECH)
					clothes_s = new /icon('icons/mob/uniform.dmi', "atmos_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/hands.dmi', "bgloves"), ICON_UNDERLAY)
					clothes_s.Blend(new /icon('icons/mob/belt.dmi', "utility"), ICON_OVERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "engiepack"), ICON_OVERLAY)
					if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel-eng"), ICON_OVERLAY)
				if(AI)//Gives AI and borgs assistant-wear, so they can still customize their character
					clothes_s = new /icon('icons/mob/uniform.dmi', "grey_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)
				if(CYBORG)
					clothes_s = new /icon('icons/mob/uniform.dmi', "grey_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)
				if(UGOOSE)
					clothes_s = new /icon('icons/mob/uniform.dmi', "grey_s")
					clothes_s.Blend(new /icon('icons/mob/feet.dmi', "black"), ICON_UNDERLAY)
					if(backbag == 2)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "backpack"), ICON_OVERLAY)
					else if(backbag == 3)
						clothes_s.Blend(new /icon('icons/mob/back.dmi', "satchel"), ICON_OVERLAY)


		preview_icon.Blend(eyes_s, ICON_OVERLAY)
		if(clothes_s)
			preview_icon.Blend(clothes_s, ICON_OVERLAY)
		preview_icon_front = new(preview_icon, dir = SOUTH)
		preview_icon_side = new(preview_icon, dir = WEST)

		del(preview_icon)
		del(eyes_s)
		del(clothes_s)