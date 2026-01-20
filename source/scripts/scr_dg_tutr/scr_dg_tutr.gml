function scr_dg_tutr(act = 0){
	switch(act){
		case 0:
			//intro
			_textarray = [
				["What's up, Head? I was wondering if you'd ever show up, man.", "dialm", true],
				["C'mon, M. Let's just get this done.", "dh", true],
				["Got it!", "dialm", true],
			];
		break;
		case 1:
			//jabs
			_tips_active = "tutr_punch";
			_textarray = [
				["Let's start off easy 'n simple. Give this fridge here a couple of jabs.", "dialm", true]
			];
		break;
		case 2:
			//slide and crouch
			_textarray = [
				["Good stuff, man.", "dialm", true],
				["The way to this fridge is blocked.", "dialm", true],
				["I'm thinking sliding underneath should do the job.", "dialm", true],
			];
		break;
		case 3:
			//uppercuts
			_tips_active = "tutr_upper";
			_textarray = [
				["So this fridge just hanged itself.", "dialm", true],
				["Seems about right.", "dh", true],
				["Yo, Head! Do an uppercut!", "dialm", true],
			];
		break;
		case 4:
			//air attack
			_tips_active = "tutr_jump";
			_textarray = [
				["Things are real dangerous around here. Fridges riding on their motorcycles...", "dialm", true],
				["Let's teach 'em a lesson.", "dh", true],
			];
		break;
		case 5:
			//grab n throw
			_tips_active = "tutr_grab";
			_textarray = [
				["Doing real great, Head!", "dialm", true],
				["Now see this fridge here? The friendly look is almost deceiving!", "dialm", true],
				["Grab and throw it into this rock formation up ahead.", "dialm", true],
			];
		break;
		case 6:
			//shield
			_tips_active = "tutr_shield";
			_textarray = [
				["Sometimes a badhead won't go down no matter how you punch.", "dialm", true],
				["In a situation like this, shield away!", "dialm", true],
				["Don't shield for too long, though... The juice on that thing runs out fast!", "dialm", true],
			];
		break;
		case 7:
			//mashing
			_tips_active = "tutr_mash";
			_textarray = [
				["Who the hell put all these fridges here?", "dh", true],
				["Me.", "dialm", true],
				["Before you venture into Groovy Graveyard, you should know about /yTNT JUICE/w.", "dialm", true],
				["The more you punch badheads, the more /yTNT JUICE/w points you gain. Easy.", "dialm", true],
				["And once you have enough points, you can /rPUMMEL/w through badheads!", "dialm", true],
				["Give it a try.", "dialm", true],
			];
		break;
		case 8:
			//tnt quake
			_tips_active = "tutr_tnt";
			_textarray = [
				["Cool stuff, man.","dialm",true],
				["Now, once your /yTNT JUICE/w meter is full, you can perform /rTNT QUAKE/w!!","dialm",true],
				["Perfect for \"turning the tide\" in a sticky situation. Let's get it going!","dialm",true],
			];
		break;
		case 9:
			//finish main path
			_textarray = [
				["And that's the main moveset covered.","dialm",true],
				["Neat.","dh",true],
				["Give that fridge one last uppercut to finish the drill. OR...","dialm",true],
				["...push forward and give the /yADVANCED MOVESET/w a shot!","dialm",true],
				["What're we thinkin', Head?","dialm",true],
				["Hang on M, gimme a sec.","dh",true],
			];
		break;
		case 10:
			//run and roll
			_tips_active = "tutr_roll";
			_textarray = [
				["I see you're in for some advanced moves!","dialm",true],
				["Now, let's give runnin' and rollin' a try.","dialm",true],
				["Roll over those fridges ahead, go on!","dialm",true],
			];
		break;
		case 11:
			//slam
			_tips_active = "tutr_slam1";
			_textarray = [
				["Ever wanted to slam a fridge? Normal question.","dialm",true],
				["Uh... sure? I mean, who hasn't thought about it?","dh",true],
				["Great! Go ahead and grab one. This one's fun!","dialm",true],
			];
		break;
		case 12:
			//parry
			_tips_active = "tutr_parry";
			_textarray = [
				["Hey, remember that shield move from before?","dialm",true],
				["You can use it to /yPARRY/w stuff!","dialm",true],
				["Shield just before you're about to get hit, and you'll do it. Try it out.","dialm",true],
				["Parrying takes practice, so don't lose it if you don't get it on the first try.","dialm",true],
			];
		break;
		case 13:
			//combo
			_tips_active = "tutr_combo1";
			_textarray = [
				["Alright. Let's wrap this thing up!","dialm",true],
				["The last thing you'll learn today is /yCOMBOs/w!","dialm",true],
				["So there's this fridge here...","dialm",true],
				["Typical.","dh",true],
				["Slide into it to send it flying, punch it in the air and kick it into the screen!","dialm",true],
				["I think you've got this, Head.","dialm",true],
			];
		break;
		case 14:
			//finish
			_textarray = [
				["You're a KILLING MACHINE, dude!!","dialm",true],
				["Alright. That concludes your training. Go out there and make a mess.","dialm",true],
				["Okay, I'm off. Catch you later, M.","dh",true],
			];
		break;
	}
}