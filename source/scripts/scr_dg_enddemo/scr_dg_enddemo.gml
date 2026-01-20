function scr_dg_enddemo(act = 0){
	switch(act){
		//tv intro
		case 0:
			_textarray = [
				["Lame-ass TV.","dh",true],
				["JUST WORK ALREADY!","dh",true],
			];
		break;
		case 1:
			_textarray = [
				["Finally...","dh",true],
				["Took you long enough.","dialm",true],
			];
		break;
		
		//hellish havoc tape
		case 2:
			_textarray = [
				["Yello!", "nomio", true],
				["You've reached Nomio's domain. Heehee!!", "nomio", true],
				["Anything botherin' ya? Commited a felony? Thinking of endin' your life?", "nomio", true],
			];
		break;
		case 3:
			_textarray = [
				["Hello.", "???", true],
				["...I'm looking... For someone very important to me.", "???", true],
				["What? In hell?", "nomio", true],
				["That's tough, man.", "nomio", true],
				["Perhaps, you may even know them.", "???", true],
			];
		break;
		case 4:
			_textarray = [
				["I don't have time for your riddles, old man.", "nomio", true],
				["Spill the beans!", "nomio", true],
				["Does the name... \"DynamiteHead\" mean anything to you?", "???", true],
			];
		break;
		case 5:
			_textarray = [
				["Alright, big boss. I'm hearin' ya.", "nomio", false],
			];
		break;
	}
}