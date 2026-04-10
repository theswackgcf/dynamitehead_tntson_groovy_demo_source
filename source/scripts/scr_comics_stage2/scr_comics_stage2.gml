function scr_comics_stage2(){
	global._location = 1;
	
	var comicname = "stage2";
	_comics[? comicname] = ds_map_create();
	_endsprite = spr_comics_stage2_endbg;

	// "" - appear instantly
	// "l" "r" "u" "d" - sides
	// "f" - front (scale from 2 to 1)
	// "b" - back (scale from 0 to 1)

	for(var i = 0; i < 14; i++){
		_comics[? comicname][? "page"+string(i+1)] = ds_map_create();
	}
	
	var defease = "out";
	var defduration = 18;
	var defalpha = 1;
	var defgain = 1;
	
	_comics[? comicname][? "page1"] = [
		["sprite", "page01"],
		[
			{
				slidefrom: "l",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_howling,defgain*0.5],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "u",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: -1,
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "d",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_hench_minehold,defgain],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page2"] = [
		["sprite", "page02"],
		[
			{
				slidefrom: "l",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_tapping, defgain],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "r",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_throw, defgain*0.8],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page3"] = [
		["sprite", "page03"],
		[
			{
				slidefrom: "f",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_chewing,defgain],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 32,
				sfx: [snd_comic2_hench_mine,defgain],
				delay: 35,
				plusdepth: 0,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page4"] = [
		["sprite", "page04"],
		[
			{
				slidefrom: "r",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: -1,
				delay: 0,
				plusdepth: 0,
				text_: [
					["Quit goofing around,\nYOU JERK OFFS!!",363,28,1],
					["Huh?!",107,474,1.4],
				],
			},
			{
				slidefrom: "r",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: -1,
				delay: 0,
				plusdepth: 0,
				text_: [
					["We've got\nimportant\nthings to do",667,33,1],
				],
			},
			{
				slidefrom: "d",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_lanklaugh,1],
				delay: 0,
				plusdepth: 0,
				text_: [
					["If all is according\nto the plan...",1100,390,1],
					["...That red headed\nfreak's about\nto show up",1097,567,1],
				],
			},
		]
	];
	
	_comics[? comicname][? "page5"] = [
		["sprite", "page05"],
		[
			{
				slidefrom: "l",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_hench_look,1],
				delay: 0,
				plusdepth: 0,
				text_: [
					["LOOK!",130,416,1.45],
				],
			},
			{
				slidefrom: "r",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_theman,defgain*0.6],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page6"] = [
		["sprite", "page06"],
		[
			{
				slidefrom: "u",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: -1,
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "l",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: -1,
				delay: 0,
				plusdepth: 0,
				text_: [
					["AHA! It's almost midnight!",388,642,1],
				],
			},
			{
				slidefrom: "r",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_scratchit, defgain],
				delay: 0,
				plusdepth: 2,
				text_: [
					["Let's shake this whole\nplace up...",954,22,0.92],
					["...with GROOVY TUNES!",1068,651,1],
				],
			},
		]
	];
	
	_comics[? comicname][? "page7"] = [
		["sprite", "page07"],
		[
			{
				slidefrom: "d",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_steps, defgain*0.77],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "u",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_yolo_dodge2,defgain*0.68],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page8"] = [
		["sprite", "page08"],
		[
			{
				slidefrom: "b",
				easetype: "out_elastic",
				slidedur: 30,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_badheads,defgain],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page9"] = [
		["sprite", "page09"],
		[
			{
				slidefrom: "l",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_lankshake,defgain],
				delay: 0,
				plusdepth: 0,
				text_: [
					["God damnit...\nI SHOULD'VE HIT THE GYM!",379,614,1],
				],
			},
			{
				slidefrom: "",
				easetype: defease,
				slidedur: 30,
				alpha: defalpha,
				shake: 28,
				sfx: [snd_comic2_lankcrash,defgain],
				delay: 0,
				plusdepth: 1,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page10"] = [
		["sprite", "page10"],
		[
			{
				slidefrom: "d",
				easetype: "out_elastic",
				slidedur: 32,
				alpha: 0,
				shake: 0,
				sfx: -1,
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page11"] = [
		["sprite", "page11"],
		[
			{
				slidefrom: "l",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: -1,
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "r",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_dhgrunt,defgain*0.95],
				delay: 0,
				plusdepth: 1,
				text_: [
					["That dude with headphones\n   looks just like me...",604,604,1],
				],
			},
		]
	];
	
	_comics[? comicname][? "page12"] = [
		["sprite", "page12"],
		[
			{
				slidefrom: "u",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_tv, defgain*0.9],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "d",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_cash, 0.7],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "u",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_boing,defgain*0.82],
				delay: 0,
				plusdepth: 2,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page13"] = [
		["sprite", "page13"],
		[
			{
				slidefrom: "r",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_comic2_dialscream,0.56],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
			{
				slidefrom: "l",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_addcash,defgain],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
		]
	];
	
	_comics[? comicname][? "page14"] = [
		["sprite", "page14"],
		[
			{
				slidefrom: "f",
				easetype: defease,
				slidedur: defduration,
				alpha: defalpha,
				shake: 0,
				sfx: [snd_checkp,defgain*0.8],
				delay: 0,
				plusdepth: 0,
				text_: -1,
			},
		]
	];
}