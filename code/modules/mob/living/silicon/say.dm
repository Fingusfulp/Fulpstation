/mob/living/silicon/say(var/message)
	return ..(message, "R")

/mob/living/proc/robot_talk(var/message)
	log_say("[key_name(src)] : [message]")
	var/desig = "Default Cyborg" //ezmode for taters
	if(istype(src, /mob/living/silicon))
		var/mob/living/silicon/S = src
		desig = trim_left(S.designation + " " + S.job)
	var/message_a = say_quote(message)
	var/rendered = "<i><span class='game say'>Robotic Talk, <span class='name'>[name]</span> <span class='message'>[message_a]</span></span></i>"

	for (var/mob/living/S in living_mob_list)
		if(S.binarycheck() || S.stat == DEAD)
			if(istype(S , /mob/living/silicon/ai))
				var/renderedAI = "<i><span class='game say'>Robotic Talk, <a href='byond://?src=\ref[S];track2=\ref[S];track=\ref[src]'><span class='name'>[name] ([desig])</span></a> <span class='message'>[message_a]</span></span></i>"
				S << renderedAI
			else
				S << rendered

/mob/living/silicon/binarycheck()
	return 1

/mob/living/silicon/lingcheck()
	return 0 //Borged or AI'd lings can't speak on the ling channel.

/mob/living/silicon/radio(message, message_mode)
	. = ..()
	if(. != 2)
		return .

	if(message_mode == "robot")
		if (radio)
			radio.talk_into(src, message)
		return 1

	else if(message_mode in radiochannels)
		if(radio)
			radio.talk_into(src, message, message_mode)
			return 1

	return 2

/mob/living/silicon/get_message_mode(message)
	if(..() == "headset")
		return "robot"
