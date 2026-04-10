{
	global._died = false;
	
	//values
	_allsounds = ds_map_create();
	_actiontimer = ds_map_create();
	
	_displaymenu = true;
	
	_init = false;
	
	_doinput = false;
	_mainmenuoffset_start = 3700;
	_mainmenuoffset = _mainmenuoffset_start;
	
	_mainmenuoffset_spd = 0;
	
	_starttimer = 0;
	
	_anykey_alp = 1;
	_anykey_act = 0;
	_anykey_timer = 0;
	_anykey_snd = false;
	_anykey_scale = 1;
	
	_introact = 0;
	_introtimer = 0;
	_lerppos = 500;
	
	_inp_cd = 0;
	
	_skip_intro_on_start = false;
	_stageselect_start = false;
	_minigamescreen_start = false;
	
	_menustate = "main";
	_option = 0;
	_prevoption = _option;
	_optionhovered = false;
	
	_bgrot = [0,0,0,0,0];
	_bgspd = [0,0.035,0.022,0.018,0.012];
	
	_dhsprite = spr_groovymenu_dh;
	_dhindex = 0;
	_dhspd = 0.25;
	
	_songplaying = false;
	_bpm = 90;
	
	_failsafe_timer = 0;
	_beatcount_start = 2;
	_beatcount = _beatcount_start;
	_beat = false;
	
	_enter = false
	_enterinit = false;
	_enteract = 0;
	_entertimer = 0;
	_enterscale = [1,1];
	_enterangle = 0;
	_enteroffset = [0,0];
	_enteramp = 0;
	
	_enterpos = 0;
	
	_begin = false;
	_begintimer = 0;
	_savemuspos = 0;
	
	_sqr_size = 0;
	
	_lerpedoption = _option;
	
	_mouseactive = false;
	_mouseprev = [mouse_x,mouse_y];
	
	//[name, dispname, xoffset]
	_btninfo = [
		["play", "BEGIN", 0],
		["setting", "OPTIONS", 40],
		["extra", "EXTRAS", 40],
		["credits", "CREDITS", 40],
		["patreon", "PATREON", 40],
		["quit", "QUIT.", -8],
	];
	_curoption = "";
	
	//[name, dispname]
	_extras_btns = [
		["manual", "Manual"],
		["minigames", "Mini-games"],
		["return", "Back"],
	];
	
	var yposoffset = 0;
	_defstartpos = 296;
	_defposoffset = 96;
	
	_show = false;
	_state = _menustate;
	_curopt = [0];
	_prevopt[0] = 0;
	_offsetYLerp = 0;
	_getinput = false;
	
	_mouselect = 0;
	
	for(var j = 0; j < array_length(_extras_btns); j++){
		_btn = instance_create_depth(0, 0, 0, obj_optbtn);
		_btn._xpos = floor(WIDTH/2);
		_btn._ypos = _defstartpos + yposoffset;
		_btn._starty = _btn._ypos;
		yposoffset += _defposoffset;
		_btn._text = _extras_btns[j][1];
		_btn._id = _extras_btns[j][0];
		_btn._opt = j;
		_btn._optionsobj = self;
		_btn._state = "extra";
		_btn._layer = 0;
		_btn._menubtn = true;
	}
	
	for(var i = 0; i < 2; i++){
		_btn = instance_create_depth(0, 0, 0, obj_optbtn);
		if(i == 0){
			_btn._xpos = floor(WIDTH/2)-136;
			_btn._text = "YES";
			_btn._id = "quit_yes";
		} else {
			_btn._xpos = floor(WIDTH/2)+136;
			_btn._text = "NO";
			_btn._id = "quit_no";
		}
		_btn._ypos = floor(HEIGHT/2)+24;
		_btn._starty = _btn._ypos;
		_btn._opt = i;
		_btn._optionsobj = self;
		_btn._state = "quit";
		_btn._layer = 0;
		_btn._menubtn = true;
	}
	
	_sndarray = [snd_menu1,snd_menu2,snd_menu3,snd_menu4,snd_menu5];
	
	_tntscalemult = 0;
	_tntframe = 0;
	
	_options = instance_create_depth(0, 0, 0, obj_options);
	_options._menuobj = self;
	
	_xpos = 0;
	_ypos = 0;
	_action = "";
	_on = false;
	
	_menutimer = 0;
	
	_menubtn_surface = surface_create(WIDTH, HEIGHT);
	
	_inputinit = false;
	_changedinput = false;
	_changehold = 0;
	
	_manual_imgs = [];
	_manual_dim = [840, 724];
	_manual_page = 0;
	_manual_page_prev = 0;
	
	_manual_offset = 0;
	_manual_spd = 0;
	_manual_jumpspd = -10;
	
	_curmonyx = global._curmonyx;
	_addmonyx = 0;
	_addmonyx_once = false;
	
	_minigame_frame = 0;
	var wrapw = 520;
	_minigame_desc = [
		[scr_wordwrap("Those pesky Badheads are popping out ALL over the place! Time to show 'em a lesson in WHACKIN'! Be careful, though... The more Badheads you whack, the quicker they pop out!\nYou think you can handle this?", wrapw, "\n", false),0,"whack"],
		[scr_wordwrap("Find yourself traversing the Groovy Graveyard as Dial-M. Dodge the sneaky Badheads on your way. Find all the scattered Monyx, and bring 'em back to the EXIT GATE! Think you can handle Dial Runner?", wrapw, "\n", false),1,"lode"],
	];
	_minigame_monyx = [
		[4000, 380], //price, difficulty adjust variable
		[5500, 410],
	];
	_minigame_desc_loop = [];
	_minigame_monyx_loop = [];
	
	_minigame_cur = 1;
	_minigame_prev = _minigame_cur;
	_minigame_offset_to = -_minigame_cur*WIDTH;
	_minigame_offset = _minigame_offset_to;
	_setminigameoffset = false;
	
	_monyx_screen = false;
	_curminigame = 0;
	_curprice = 0;
	_curfactor = 0;
	_curdiff = 1;
	_pricediff = 0;
	_subprice = 0;
	
	_minigame_curname = "";
	
	_monyxshake = 0;
	_monyx_col = [255,255,255];
	_monyx_colto = [255,255,255];
	_diffshake = 0;
	_start_on = false;
	
	_priceshake = 0;
	
	_minigame_begin = false;
	_minigame_begintimer = 0;
	_minigame_beginshow = false;
	
	_minigame_submonyx = false;
	_minigame_tr = false;
	
	_quitmessages = [
		"Leaving... ALREADY?!",
		"Are you really leaving us?",
		"Go ahead. Leave.",
		"Go on. Do it. I don't care.",
		"Chickening out already?",
		"Quit? (Don't)",
		"DON'T LEAVE ME HERE!!!",
		"Press Yes to /rDie.",
		"Press No to be Spared!"
	];
	
	_quitmessage = 0;
	
	function drawbtn(xx, yy, text, col, i, subtext) {
		if(_option == i){
			var spr = asset_get_index("spr_menu_icon_"+_curoption);
			if(sprite_exists(spr)){
				draw_sprite_ext(spr, _tntframe / 3, xx + (sprite_get_width(spr) / 2) + 155 + _btninfo[i][2], yy + 16 + _mainmenuoffset, 1 + (sin(global._timer / 5) / 2 * _tntscalemult), 1 + (cos(global._timer / 5) / 2 * _tntscalemult), 0, c_white, 1);
			}
		}
					
		scr_textrender_type(xx, yy + _mainmenuoffset, text, false, col, 1, 0.86, 0.86);

		scr_textrender_wave_x(2, 5);
		scr_textrender_wave_y(2, 5);
		scr_textrender_shake(0, 0);
		scr_textrender_switchfont("dh_font1");
		scr_textrender_type(xx+24, yy + _mainmenuoffset+80, subtext, true, col, 1, 1, 1);

		scr_textrender_wave_x(0, 0);
		scr_textrender_wave_y(0, 0);
		scr_textrender_shake(0, 0);
	}
	
	_tntmenustate = "";
	_tntenter = false;
	
	function checkmenus() {
		switch(_state){
			case "extra":
				if(_curbutton != noone && _curbutton._on && _mouselect <= 0){
					sfx_play(snd_tnt_pull);
					
					_tntmenustate = _curbutton._id;
					
					_manual_page = 0;
					_manual_page_prev = _manual_page;
							
					_manual_offset = 0;
					_manual_spd = 0;
					
					_minigame_cur = 1;
					_minigame_prev = _minigame_cur;
					
					_minigame_offset_to = -_minigame_cur*WIDTH;
					_minigame_offset = _minigame_offset_to;
					
					global._tntmenuAct = 1;
					_tntenter = true;
				}
			break;
			case "quit":
				if(_curbutton != noone && _curbutton._on && _mouselect <= 0){
					switch(_curbutton._id){
						case "quit_yes":
							//quit the game
							audio_stop_all();
							sfx_play(snd_finalko);
							sfx_play_choose([snd_scream1,snd_scream2,snd_scream3,snd_scream4,snd_scream5,snd_scream6]);
							room_goto(r_quit);
						break;
						case "quit_no":
							//back
							sfx_stop_array(_sndarray);
							sfx_play_choose(_sndarray);
				
							_menustate = "main";
						break;
					}
				}
			break;
		}
	}
	
	_creditsoption = 0;
	_prevcreditsoption = _creditsoption;
	
	var creditsSpr = spr_credits_devs;
	var chance = irandom(1000);
	if(chance == 536){
		creditsSpr = spr_credits_devs_heroin;
	}
	
	_creditsinfo = [
		//swackygcf
		//9301000006000000000000000000000000000040020000000B00000001000000100000007370725F656E6D315F737061776E6572000000000000000000000000000000000000000000C08D400000000000000000004072400000000000000000000000C0010000000E0000004C65616420646576656C6F706572010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E74657201000000060000006D6964646C65000000000000000000000840020000000B00000001000000100000007370725F656E6D315F737061776E6572000000000000000000000000000000000000000000B08D40000000000000000000B076400000000000000000000008C001000000120000004368617261637465722064657369676E6572010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E74657201000000060000006D6964646C6500000000000000000000F03F020000000B00000001000000110000007370725F637265646974735F6C6F676F73000000000000000000000000000000000000000000B08B4000000000000000000000694000000000000000000000F0BF0100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000001440020000000B00000001000000100000007370725F656E6D315F737061776E657200000000000000000000E03F000000000000000000D88D40000000000000000000B07F400000000000000000000014C001000000310000004D757369633A2F6E47616D65204F7665722F6E53746167652073656C6563742F6E4E6F6D696F27732072696E67746F6E65010000000800000064685F666F6E743100000000000000000000F43F00000000000000000000F43F010000000600000063656E7465720100000003000000746F70000000000000000000001040020000000B00000001000000100000007370725F656E6D315F737061776E6572000000000000000000000000000000000000000000E88D40000000000000000000707B400000000000000000000010C00100000009000000416E696D6174696F6E010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E74657201000000060000006D6964646C65000000000000000000000000020000000B00000001000000100000007370725F637265646974735F646576730000000000000000000000000000000000000000000010C00000000000000000000000C00000000000000000000000000100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70
		[
			{
				pos: [0,0],
				_type: "spr",
				sprite: creditsSpr,
				ind: 0,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [886,200],
				_type: "spr",
				sprite: spr_credits_logos,
				ind: 0,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [952,292],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Lead developer",
				font: "dh_font1",
				scale: 1.32,
				align: ["center","middle"],
			},
			{
				pos: [950,363],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Character designer",
				font: "dh_font1",
				scale: 1.32,
				align: ["center","middle"],
			},
			{
				pos: [957,439],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Animation",
				font: "dh_font1",
				scale: 1.32,
				align: ["center","middle"],
			},
			{
				pos: [955,500],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Music:/nMain menu/nGame Over/nStage select/nNomio's ringtone",
				font: "dh_font1",
				scale: 1,
				align: ["center","top"],
			},
		],
		//onsku
		//9301000006000000000000000000000000000040020000000B00000001000000100000007370725F656E6D315F737061776E657200000000000000000000E03F000000000000000000B88D40000000000000000000E071400000000000000000000000C0010000002B0000004164646974696F6E616C2070726F6772616D6D696E672C2F6E64657369676E202620616E696D6174696F6E010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E7465720100000003000000746F70000000000000000000000840020000000B00000001000000100000007370725F656E6D315F737061776E6572000000000000000000000000000000000000000000108F40000000000000000000E07B400000000000000000000008C0010000000C000000536F756E642064657369676E010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E74657201000000060000006D6964646C6500000000000000000000F03F020000000B00000001000000110000007370725F637265646974735F6C6F676F7300000000000000000000F03F000000000000000000888A4000000000000000000060684000000000000000000000F0BF0100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000001440020000000B00000001000000100000007370725F656E6D315F737061776E657200000000000000000000E03F000000000000000000F08A40000000000000000000B083400000000000000000000014C001000000120000005368616465722070726F6772616D6D696E67010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E74657201000000060000006D6964646C65000000000000000000001040020000000B00000001000000100000007370725F656E6D315F737061776E657200000000000000000000E03F000000000000000000788D40000000000000000000C080400000000000000000000010C001000000110000005175616C697479206173737572616E6365010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E74657201000000060000006D6964646C65000000000000000000000000020000000B00000001000000100000007370725F637265646974735F6465767300000000000000000000F03F00000000000000000000000000000000000000000000F0BF0000000000000000000000000100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70
		[
			{
				pos: [0,0],
				_type: "spr",
				sprite: creditsSpr,
				ind: 1,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [849,195],
				_type: "spr",
				sprite: spr_credits_logos,
				ind: 1,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [951,286],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Additional programming,/ndesign & animation",
				font: "dh_font1",
				scale: 1.3,
				align: ["center","top"],
			},
			{
				pos: [994,446],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Sound design",
				font: "dh_font1",
				scale: 1.3,
				align: ["center","middle"],
			},
			{
				pos: [943,536],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Quality assurance",
				font: "dh_font1",
				scale: 1.3,
				align: ["center","middle"],
			},
			{
				pos: [862,630],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Shader programming",
				font: "dh_font1",
				scale: 1.3,
				align: ["center","middle"],
			},
		],
		//jarektek
		//9301000004000000000000000000000000000040020000000B00000001000000100000007370725F656E6D315F737061776E6572000000000000000000000000000000000000000000A08B400000000000000000005076400000000000000000000000C0010000000E0000004D7573696320636F6D706F736572010000000800000064685F666F6E7431000000009A9999999999F53F000000009A9999999999F53F010000000600000063656E74657201000000060000006D6964646C65000000000000000000000840020000000B00000001000000100000007370725F656E6D315F737061776E6572000000000000000000000000000000000000000000908B40000000000000000000807C400000000000000000000008C0010000000C000000536F756E642064657369676E010000000800000064685F666F6E7431000000009A9999999999F53F000000009A9999999999F53F010000000600000063656E74657201000000060000006D6964646C6500000000000000000000F03F020000000B00000001000000110000007370725F637265646974735F6C6F676F73000000000000000000000040000000000000000000988B4000000000000000000000684000000000000000000000F0BF0100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000000000020000000B00000001000000100000007370725F637265646974735F6465767300000000000000000000004000000000000000000000000000000000000000000000F0BF0000000000000000000000000100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70
		[
			{
				pos: [0,0],
				_type: "spr",
				sprite: creditsSpr,
				ind: 2,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [883,192],
				_type: "spr",
				sprite: spr_credits_logos,
				ind: 2,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [884,357],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Music composer",
				font: "dh_font1",
				scale: 1.35,
				align: ["center","middle"],
			},
			{
				pos: [882,456],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Sound design",
				font: "dh_font1",
				scale: 1.35,
				align: ["center","middle"],
			},
		],
		//voice acting
		//9301000006000000000000000000000000000040020000000B00000001000000100000007370725F656E6D315F737061776E657200000000000000000000E03F000000000000000000288440000000000000000000607A400000000000000000000000C0010000001A0000006A61737065722E6E796D616E202D204C616E6B79204C61727279010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E7465720100000003000000746F70000000000000000000000840020000000B00000001000000100000007370725F656E6D315F737061776E65720000000000000000000000000000000000000000001884400000000000000000000081400000000000000000000008C0010000000F0000006F6E736B75202D2048656E63686965010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E7465720100000003000000746F7000000000000000000000F03F020000000B00000001000000100000007370725F656E6D315F737061776E657200000000000000000000E03F000000000000000000188440000000000000000000F0724000000000000000000000F0BF0100000025000000737761636B79474346202D2044796E616D69746548656164202620596F6C6F2D426F6E6573010000000800000064685F666F6E743100000000CDCCCCCCCCCCF43F00000000CDCCCCCCCCCCF43F010000000600000063656E7465720100000003000000746F70000000000000000000001440020000000B00000001000000110000007370725F637265646974735F766F69636500000000000000000000F03F0000000000000000008C9140000000000000000000F8804000000000000000000000F0BF0100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000001040020000000B00000001000000110000007370725F637265646974735F766F696365000000000000000000000000000000000000000000C06540000000000000000000C066400000000000000000000000000100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000000000020000000B00000001000000110000007370725F637265646974735F6F74686572000000000000000000000000000000000000000000E88440000000000000000000E064400000000000000000000000000100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70
		[
			{
				pos: [669,167],
				_type: "spr",
				sprite: spr_credits_other,
				ind: 0,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [174,182],
				_type: "spr",
				sprite: spr_credits_voice,
				ind: 0,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [1123,543],
				_type: "spr",
				sprite: spr_credits_voice,
				ind: 1,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [643,303],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "swackyGCF - DynamiteHead & Yolo-Bones",
				font: "dh_font1",
				scale: 1.3,
				align: ["center","top"],
			},
			{
				pos: [645,422],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "Jas - Lanky Larry",
				font: "dh_font1",
				scale: 1.3,
				align: ["center","top"],
			},
			{
				pos: [643,544],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "onsku - Henchie",
				font: "dh_font1",
				scale: 1.3,
				align: ["center","top"],
			},
		],
		//tutorial ocs
		//9301000004000000000000000000000000000040020000000B00000001000000110000007370725F6F635F66656C6C615F77616C6B000000000000000000000000000000000000000000C066400000000000000000001076400000000000000000000000C00100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000000840020000000B00000001000000100000007370725F6F635F6772616E5F69646C650000000000000000000000000000000000000000000C9140000000000000000000B074400000000000000000000008C00100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F7000000000000000000000F03F020000000B00000001000000100000007370725F656E6D315F737061776E6572000000000000000000000000000000000000000000A88340000000000000000000B07A4000000000000000000000F0BF0100000052000000427265616446542020476C6173736573496E426C75652F6E69636965313435202020206C61666F6E7465796E2F6E706F706B696E7373737573737920202020746F6B6963685F6B6120202020594159535555010000000800000064685F666F6E7431000000009A9999999999F13F000000009A9999999999F13F010000000600000063656E7465720100000003000000746F70000000000000000000000000020000000B00000001000000110000007370725F637265646974735F6F746865720000000000000000000008400000000000000000008085400000000000000000006065400000000000000000000000000100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70
		[
			{
				pos: [688,171],
				_type: "spr",
				sprite: spr_credits_other,
				ind: 3,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [182,353],
				_type: "spr",
				sprite: spr_oc_fella_walk_menu,
				ind: 0,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [1091,331],
				_type: "spr",
				sprite: spr_oc_gran_idle_menu,
				ind: 0,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [629,427],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "breadft  GlassesInBlue/nicie145    8owls/npopkinsssussy    Toki    YAYSUU/nGuyTheMind    PoponTheBozo    JarekTEK",
				font: "dh_font1",
				scale: 1.1,
				align: ["center","top"],
			},
		],
		//beta testers
		//930100000200000000000000000000000000F03F020000000B00000001000000100000007370725F656E6D315F737061776E657200000000000000000000E03F000000000000000000388440000000000000000000F0724000000000000000000000F0BF010000004A000000476C6173736573496E426C75652F6E6B656E69706F6E657A682F6E5377656C6C4F6365616E2F6E6A61737065722E6E796D616E2F6E616E6F6E6361727230742F6E72616D73687469636B010000000800000064685F666F6E743100000000000000000000F43F00000000000000000000F43F010000000600000063656E7465720100000003000000746F70000000000000000000000000020000000B00000001000000110000007370725F637265646974735F6F7468657200000000000000000000F03F0000000000000000009884400000000000000000002065400000000000000000000000000100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70
		[
			{
				pos: [659,169],
				_type: "spr",
				sprite: spr_credits_other,
				ind: 1,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [647,303],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "GlassesInBlue    KeniPonezh/n   SwellOcean       Jas    /n    breadft        Toki    /nmemer.online     anoncarr0t/nramshtick",
				font: "dh_font1",
				scale: 1.25,
				align: ["center","top"],
			},
		],
		//special thanks
		//930100000200000000000000000000000000F03F020000000B00000001000000100000007370725F656E6D315F737061776E657200000000000000000000E03F00000000000000000020844000000000000000000040744000000000000000000000F0BF010000003300000072616D73687469636B2F6E467574757265436F704C47462F6E737761636B7967616D657320646973636F726420736572766572010000000800000064685F666F6E743100000000000000000000F43F00000000000000000000F43F010000000600000063656E7465720100000003000000746F70000000000000000000000000020000000B00000001000000110000007370725F637265646974735F6F746865720000000000000000000000400000000000000000004084400000000000000000004068400000000000000000000000000100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70
		[
			{
				pos: [648,194],
				_type: "spr",
				sprite: spr_credits_other,
				ind: 2,
				_text: "",
				font: "dh_font1",
				scale: 1,
				align: ["center","middle"],
			},
			{
				pos: [644,324],
				_type: "text",
				sprite: -1,
				ind: 0,
				_text: "ramshtick/nFutureCopLGF/nnavyneurons (rest in peace)/nswackygames discord server",
				font: "dh_font1",
				scale: 1.25,
				align: ["center","top"],
			},
		],
	];
	
	_creditsoffset = [];
	for(var i = 0; i < array_length(_creditsinfo); i++){
		array_push(_creditsoffset, WIDTH*i);
	}
	
	_creditscuroffset = 0;
	_creditsLerp = 0;
	
	_creditsframe = 0;
}