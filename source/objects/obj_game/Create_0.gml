{
	#macro HTML_W 848
	#macro HTML_H 477
	
	#macro WIDTH 1280
	#macro HEIGHT 720
	
	#macro WINDOWS 0
	#macro HTML 1
	
	#macro DIR_L -1
	#macro DIR_R 1
	#macro DIR_U -1
	#macro DIR_D 1
	
	#macro ITEM_CORN 1
	#macro ITEM_TOMATO 2
	#macro ITEM_CHOCO 3
	
	#macro NG_ACHV_COMPLETE "Groove It"
	#macro NG_ACHV_HELLYEAH "I GOTTA GET WICKED!"
	#macro NG_ACHV_ALLKILLS "Dead Badheads Everywhere"

	global._debug = false;
	global._buildver = HTML;
	global._gxLoading = false;
	global._version = "v1.02";
	
	global._debugroom = false;
	global._debughidepause = false;
	
	_dbg_mapcount = 0;
	_dbg_layercount = 0;
	
	global._doLoading = true;
	
	cursor_sprite = -1;
	global._inactivecursortime = 180;
	global._prevcursorpos = [window_mouse_get_x(), window_mouse_get_y()];
	global._forcecustorstop = 0;
	
	global._drawBlackScreen = 0;
	
	_settingsfile = "settings";
	
	_spacing = 0;
	
	_htmladjust = false;
	
	global.sfx_effect = "";
	
	global._borderless_cdown = 0;
	
	global._guisizeX = 1;
	global._guisizeY = 1;
	
	global._setdisp = false;
	
	_allsounds = ds_map_create();
	_init = false;
	global._timer = 0;
	global._gametimer = 0;
	
	global._tutorial = false;
	
	global._rapidtimer = 5;
	
	global._menubuttontimer = 0;
	global._menubuttonsin = 0;
	
	global._tntbordertimer = 0;
	global._tntmenuframe = 0;
	global._tntmenuAct = 0;
	
	global._pauseSoundGains = ds_map_create();
	
	global._pause = false;
	global._pausebackcooldown = 0;
	global._pauseoptions = false;
	global._pauseReturn = false;
	
	global._state = "game";
	global._freezeFrames = {
		vshort_freeze: 0,
		short_freeze: 0,
		mid_freeze: 0,
		long_freeze: 0
	}
	
	global._easings = ds_map_create();
	
	global._scale = 0.607;
	global._appsurfScale = 1.645;
	
	global._stageentrance = true;
	
	global._addSpacing = 0;
	
	global._occupyCharset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=";
	
	global._view = 0;
	global._adjustSurface = false;
	global._camera = 0;
	
	global._screenSideOffset = 270;
	global._screenOffsetX = 0;
	global._screenOffsetY = 0;
	
	#macro EFFECT_SEPIA 1
	
	global._seteffect = 0;
	global._effect = 0;
	
	global._defShadowSize = 0.5;
	
	global._bossmusic = false;
	
	global._dialogue = false;
	
	//stage specific
	global._toxicshack = false;
	
	global._lightsout = false;
	global._switchlights = "";
	global._switchlights_act = 0;
	global._switchlights_sound = false;
	
	global._stopFog = 16;
	
	global._deleteready = false;
	
	global._fgScrollSpd = -0.43;
	global._bgScrollSpd = [0.4,0.6];
	_fglayerx = [];
	_bglayerx = [];
	_bgfg_timer = 0;
	
	global._easteregg_lank = false;
	global._easteregg_goblin = false;
	
	//binds
	global._binds = [27,112,113,114,115,116,117,118,119,120,121,122,123,145,19,192,49,50,51,52,53,54,55,56,57,48,189,187,[8,spr_keybinds_longer3,0],[9,spr_keybinds_longer1,0],81,87,69,82,84,89,85,73,79,80,219,221,220,[20,spr_keybinds_longer2,0],65,83,68,70,71,72,74,75,76,186,222,[13,spr_keybinds_enter,0],[16,spr_keybinds_longer2,1],90,88,67,86,66,78,77,188,190,191,[16,spr_keybinds_longer2,1],[vk_control,spr_keybinds_longer1,1],[162,spr_keybinds_longer1,1],[163,spr_keybinds_longer1,1],91,164,[32,spr_keybinds_space,0],38,[36,spr_keybinds_longer2,2],33,46,35,34,164,37,40,39,[45,spr_keybinds_longer3,1]];
	global._keystrings = [ "Escape","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","ScrLk","Pause","`","1","2","3","4","5","6","7","8","9","0","-","=","Backspace","Tab","Q","W","E","R","T","Y","U","I","O","P","[","]","\\","Caps Lock","A","S","D","F","G","H","J","K","L",";","'","Enter","Shift","Z","X","C","V","B","N","M",",",".","/","Shift","CTRL","CTRL","CTRL","Home","ALT","Space","Up","Home","Page Up","Delete","End","Page Down","ALT","Left","Down","Right","Insert"];
	global._gpbinds = [gp_face1,gp_face2,gp_face3,gp_face4,[gp_shoulderl,spr_padbinds_longer1,0],gp_shoulderlb,[gp_shoulderr,spr_padbinds_longer1,1],gp_shoulderrb,[gp_select,spr_padbinds_longer2,0],[gp_start,spr_padbinds_longer2,1],gp_stickl,gp_stickr,gp_padu,gp_padd,gp_padl,gp_padr,"stick1_u","stick1_d","stick1_l","stick1_r","stick2_u","stick2_d","stick2_l","stick2_r"];
	global._gpstrings = [ "A","B","X","Y","L","ZL","R","ZR","Select","Start","Left stick","Right stick","Pad-Up","Pad-Down","Pad-Left","Pad-Right","stick1_u","stick1_d","stick1_l","stick1_r","stick2_u","stick2_d","stick2_l","stick2_r" ];
	global._keyoffset = -20;
	
	global._ui_stuff_alpha = [1,1,1,1]; //dh tnt enemy boss
	global._ui_stuff_alphaTo = [];
	global._ui_stuff_alphaMult = [];
	global._ui_stuff_alphaMultTo = [];
	global._fadeOutTimer = [];
	for(var i = 0; i < array_length(global._ui_stuff_alpha); i++){
		global._ui_stuff_alphaTo[i] = global._ui_stuff_alpha[i];
		global._ui_stuff_alphaMult[i] = global._ui_stuff_alpha[i];
		global._ui_stuff_alphaMultTo[i] = global._ui_stuff_alpha[i];
		global._fadeOutTimer[i] = 0;
	}
	
	global._ui_shieldMult = 0;
	global._ui_shieldMultTo = 0;
	
	function ui_all_fade(num){
		for(var i = 0; i < array_length(global._ui_stuff_alphaTo); i++){
			global._fadeOutTimer[i] = 0;
			global._ui_stuff_alphaTo[i] = num;
		}
	}
	
	function ui_fade(uiname, num){
		var uinum = 0;
		switch(uiname){
			case "dh":
				uinum = 0;
			break;
			case "tnt":
				uinum = 1;
			break;
			case "enemy":
				uinum = 2;
			break;
			case "boss":
				uinum = 3;
			break;
		}
		global._ui_stuff_alphaTo[uinum] = num;
		global._fadeOutTimer[uinum] = 0;
	}
	
	global._mashZoom = false;
	global._mashZoomTimer = 0;
	global._mashZoomMode = 0;
	global._mashinst = noone;
	
	global._tntZoom = false;
	global._tntZoomTimer = 0;
	global._tntZoomState = 0;
	
	global._rewards = [5000,10000];
	global._badnums = [-200,-300];
	global._reward = 0;
	
	global._stagebadheads = [0,128];
	
	global._maxai = 6;
	
	global._delayspawn = 0;
	global._delayspawntime = 0;
	
	u_position = shader_get_uniform(shd_hue, "u_Position"); // control shader
	_hue = 0;
	
	_guioffset = [39,42];
	_hpoffset = [5, HEIGHT-123];
	_tntoffset = [WIDTH-407,HEIGHT-66];
	_hitoffset = [32,(WIDTH/2)-320];
	_hitnumoffset = [22,38];
	_bossoffsetlerp = -320;
	_bossoffset = [24,_bossoffsetlerp];
	
	_firetimer = 0;
	_fireframe = 0;
	
	global._maxcolors = ds_map_create();
	global._maxcolors[? "dh"] = 4;
	
	global._maxcolors[? "enm1"] = 4;
	global._maxcolors[? "enm2"] = 5;
	global._maxcolors[? "enm3"] = 4;
	
	global._maxcolors[? "st2_enm1"] = 5;
	global._maxcolors[? "st2_enm2"] = 4;
	global._maxcolors[? "st2_enm3"] = 4;
	
	global._curenemy = [];
	global._portraits = ds_map_create();
	global._portraits[? "badhead"] = 0;
	global._portraits[? "blombo"] = 0;
	global._portraits[? "enm1"] = 1;
	global._portraits[? "enm2"] = 2;
	global._portraits[? "enm3"] = 3;
	global._portraits[? "st1_barrel"] = 4;
	global._portraits[? "st2_enm1"] = 5;
	global._portraits[? "st2_enm2"] = 6;
	global._portraits[? "st2_enm3"] = 7;
	
	global._curboss = noone;
	global._bossinfo = ds_map_create();
	//global._bossinfo[? "giant fridge lol"] = 0;
	//global._bossinfo[? "boss1"] = 1;
	global._bossinfo[? "boss2"] = spr_gui_boss2;
	
	global._help_prompt_time = 3;
	
	global._deadid = 0;
	_dh = noone;
	
	global._tntjuice = 0;
	global._displayjuice = global._tntjuice;
	global._tntjuice_store = global._tntjuice;
	global._tntjuice_max = 100;
	global._tntjuice_mash = 30;
	_tntamp = 0;
	
	global._hits = 0;
	global._hitsarray = [];
	global._hitscd = 0;
	global._hitmeter = 50;
	_jump = false;
	_vspd = 0;
	_height = 0;
	_flyaway = false;
	_flypos = [0,0];
	_flyto = [0,0];
	_hitstemp = 0;
	_hitsarraytemp = [];
	_holdc = 0; 
	
	_dialm_active = false;
	_dialm_pos = WIDTH;
	_dialm_timer = 0;
	_dialm_act = 0;
	_dialm_quote = -1;
	_dialm_quotes = [
		"AWESOME!",
		"THAT'S THE\nSTUFF!",
		"MY MAN!",
		"OH YEAH!",
		"SICK AS HELL!",
		"DUUUUDE!!!",
		"ROCKIN'!",
		"COOL!",
		"RADICAL!!",
		"WICKED!",
		"NOW WE'RE\nTALKIN'!"
	];
	_dialm_surfsize = [1000,380];
	_dialm_surf = surface_create(_dialm_surfsize[0],_dialm_surfsize[1]);
	
	global._prompt_desc_show = 0;
	global._prompt_desc_type = "";
	
	global._prompt_desc_mult = 1;
	global._prompt_desc_multTo = global._prompt_desc_mult;
	
	_prompt_desc_text = "";
	_prompt_desc_text_prev = "";
	_prompt_desc_ready = false;
	
	_prompt_desc_offpos = -164;
	_prompt_desc_pos = [_prompt_desc_offpos,_prompt_desc_offpos];
	_prompt_desc_posto = [_prompt_desc_pos[0],_prompt_desc_pos[1]];
	
	global._bossstart = false;
	global._bossvalue = 0;
	
	global._fadeout = false;
	global._fadeout_alp = 0;
	global._winscreen = false;
	_winact = 0;
	_wintime = 0;
	_textsize = [0,0,0];
	_textactive = [false,false,false];
	_kotimer = 0;
	_tempKO = 0;
	_koHeight = 0;
	_koSpd = 0;
	_badnumb = ds_map_create();
	
	_winpitchtimer = 0;
	_pitchmod = 0;
	_pitchmodlerp = 0;
	
	_minispawn = false;
	_curspawn = 1;
	
	_dhwinobj = noone;
	_bgwinobj = noone;
	_alphato = 0;
	_textspacing = [0, 0];
	
	_hellyeah = false;
	_spawnletter = [0,0,0,0,0,0,0,0];
	_letrpos = [
		[779,132],
		[890,140],
		[967,144],
		[1078,151],
		[732,318],
		[861,337],
		[972,325],
		[1100,329]
	];
	_curletter = 0;
	_lettertime = 0;
	
	_addcash_randcur = 0;
	
	_addcash_total = 0;
	
	_addcash_rand = [
		{
			xpos: WIDTH+250,
			xspd: -7,
			yspd: -24,
			scalespd: 0.026,
		},
		{
			xpos: WIDTH+300,
			xspd: -8,
			yspd: -23,
			scalespd: 0.025,
		},
		{
			xpos: WIDTH-500,
			xspd: 1,
			yspd: -24,
			scalespd: 0.027,
		}
	];
	
	_addcash_draw = false;
	_addcash_pos = [0,0];
	_addcash_spd = [0,0];
	_addcash_scale = 1;
	
	_addcash_amnt = 0;
	
	_addcash_spdmult = 1;
	
	_addcash_amp = 0;
	
	global._vsscreen = 0;
	_vs_snd = false;
	_vstimer = 0;
	_pos1 = [-WIDTH,-WIDTH];
	_pos2 = [WIDTH,WIDTH];
	_amp1 = 4;
	_amp2 = 4;
	_pos3 = [-HEIGHT,-HEIGHT];
	_pos4 = [HEIGHT,HEIGHT];
	_size5 = 0;
	_curcolor = c_black;
	_textspd = [0,0];
	_textpos1 = -WIDTH;
	_textpos2 = WIDTH;
	_texts = "WARNING! WARNING! BOSS BATTLE! PREPARE FOR A BRAWL! COME ON! GET ON IT! TIME FOR A BOSS BATTLE! WARNING! WARNING! COME ON! GET ON IT! IT'S BATTLE TIME!";
	_expframe = 0;
	_exptime = 0;
	
	//vs screen lighting
	_defcolors = [hex_to_rgb("#ffd52f"),hex_to_rgb("#ffd52f")] //[dark part, bright part]
	if(global._buildver == HTML){
		_defcolors = [hex_to_rgb("#98432f"),hex_to_rgb("#98432f")] //[dark part, bright part]
	}
	
	_uitextshow = false;
	_uitext = "";
	_uitextact = 0;
	_uitexttime = 0;
	_uitextspacing = 0;
	
	global._hitinst = noone;
	global._finalhit = 0;
	global._finalhit_init = false;
	global._finalhit_phase = false;
	
	global._lightstop = false;
	
	global._menuColorNo = make_color_rgb(70, 7, 112);
	global._menuColorYes = make_color_rgb(255, 255, 255);
	
	global._menuSineAmp = 7;
	global._menuSineSpd = 9;
	
	global._guiNumColors = ds_map_create();
	global._guiNumColors[? "hit"] = make_color_rgb(255, 153, 0);
	global._guiNumColors[? "dmg"] = make_color_rgb(255, 25, 83);
	global._guiNumColors[? "heal"] = make_color_rgb(219, 255, 41);
	global._guiNumColors[? "money"] = make_color_rgb(232, 90, 2);
	global._guiNumColors[? "tnt"] = make_color_rgb(255, 153, 0);
	
	_dhx = -WIDTH;
	_winy = -HEIGHT;
	_thingsx = [WIDTH,WIDTH,WIDTH];
	
	_dhslide = _dhx;
	_winslide = _winy;
	_thingsslide = [WIDTH,WIDTH,WIDTH];
	
	_confirmexit = false;
	_exit_enddemo = false;
	
	_curOpt = 0;
	
	_losertext = "LOSER! WHAT A LOSER... LOSER! WHAT A LOSER... LOSER! WHAT A LOSER... LOSER! WHAT A LOSER... WHAT A LOSER... LOSER! WHAT A LOSER... WHAT A LOSER... LOSER! WHAT A LOSER... ";	_drawloser = 0;
	_drawloserPos = [0,WIDTH];
	_loseralpha = 0;
	
	_loseOpt = 0;
	_loseOpts = ["TRY AGAIN?","GIVE IT UP..."];
	
	_retry = false;
	_retrymenu = false;
	_retrytimer = 0;
	
	global._flashbang = 0;
	_flashalp = 1;
	
	global._progress = 0;
	
	global._bigpunch = 0;
	
	global._battlezone = false;
	global._battleobj = noone;
	global._battlezonerange = 210;
	global._bzactive = false;
	global._enmorder = 0;
	global._bzone_fx = ds_map_create();
	
	global._dhmashing = false;
	
	global._proximityoffset = [256,-480];
	if(global._buildver == HTML){
		global._proximityoffset = [700,-480];
	}
	global._panmultiply = 35;
	
	_exitinit = false;
	_exitimer = 0;
	_quit = false;
	
	//arrays
	global._solidArray = [obj_solid, obj_itembox, obj_boxthing];
	global._solidOtherArray = [
		obj_battleborder,
		obj_collideleft,
		obj_collideright,
		obj_collideup,
		obj_collidedown,
		obj_collideleftup,
		obj_collideleftdown,
		obj_colliderightup,
		obj_colliderightdown
	];
	global._enemyArray = [
		obj_moneypickup_mask,
		obj_st2_gostlikbag_mask,
		obj_badhead_mask,
		obj_fridge_mask,
		obj_enm1_n_mask,
		obj_enm2_n_mask,
		obj_enm3_n_mask,
		obj_boss0_mask,
		obj_boss1_mask,
		obj_boss_finalko,
		obj_enm_finalko,
		obj_fridge_mask,
		obj_st2_enm1_mask,
		obj_st2_enm2_mask,
		obj_st2_enm3_mask,
		obj_st2_enm2_mtcycle_mask,
		obj_boss2_mask,
	];
	global._hurtboxArray = [
		obj_badhead_hurtbox,
		obj_enm1_n_hurtbox,
		obj_enm2_n_hurtbox,
		obj_enm3_n_hurtbox,
		obj_boss0_hurtbox,
		obj_boss1_hurtbox,
		obj_fridge_hurtbox,
		obj_st2_enm1_hurtbox,
		obj_st2_enm2_hurtbox,
		obj_st2_enm3_hurtbox,
		obj_boss2_hurtbox,
	];
	
	global._testsndgain = 0.5;
	
	//voices
	global._testvoices = [
		snd_dh_ko,
	];
	
	global._dhvoices = [
		snd_dh_voice_eugh1,
		snd_dh_voice_eugh2,
		snd_dh_voice_eugh3,
		snd_dh_voice_idle1,
		snd_dh_voice_idle2,
		snd_dh_voice_idle3,
		snd_dh_voice_idle4,
		snd_dh_voice_idle5,
		snd_dh_voice_idle6,
		snd_dh_voice_ko1,
		snd_dh_voice_ko2,
		snd_dh_voice_ko3,
		snd_dh_voice_ko4,
		snd_dh_voice_ko5,
		snd_dh_voice_ko6,
		snd_dh_voice_ko7,
		snd_dh_voice_ko8,
		snd_dh_voice_ko9,
		snd_dh_voice_ko10,
		snd_dh_voice_ready1,
		snd_dh_voice_ready2,
		snd_dh_voice_ready3,
		snd_dh_voice_ready4,
		snd_dh_voice_ready5,
		snd_dh_voice_ready6,
		snd_dh_voice_ready7,
		snd_dh_voice_laugh1,
		snd_dh_voice_laugh2,
		snd_dh_voice_win1,
		snd_dh_voice_win2,
		snd_dh_voice_win3,
		snd_dh_voice_win4,
		snd_dh_voice_win5,
		snd_dh_voice_chuckle1,
		snd_dh_voice_chuckle2,
		snd_dh_voice_chuckle3,
		snd_dh_voice_grunt1,
		snd_dh_voice_grunt2,
		snd_dh_voice_grunt3,
		snd_dh_voice_grunt4,
	];
	
	global._bossvoices = [
		snd_boss1_growl,
		snd_boss1_tnt,
		snd_boss1_ko,
		
		snd_lanky_hurry,
		snd_lanky_grunt1,
		snd_lanky_grunt2,
		snd_lanky_grunt3,
		snd_lanky_grunt4,
		snd_lanky_grunt5,
		snd_lanky_intro1,
		snd_lanky_intro2,
		snd_lanky_intro3,
		snd_lanky_intro4,
		snd_lanky_intro5,
		snd_lanky_intro6,
		snd_lanky_lights1,
		snd_lanky_lights2,
		snd_lanky_lights3,
		snd_lanky_lights4,
		snd_lanky_lights5,
		snd_lanky_phasehit1,
		snd_lanky_phasehit2,
		snd_lanky_phasehit3,
		snd_lanky_phasehit4,
		snd_lanky_tnthit1,
		snd_lanky_tnthit2,
		snd_lanky_tnthit3,
		snd_lanky_tnthit4,
		snd_lanky_seethe1,
		snd_lanky_seethe2,
		snd_lanky_spotlight1,
		snd_lanky_spotlight2,
		snd_lanky_spotlight3,
		snd_lanky_spotlight4,
		snd_lanky_spotlight5,
		snd_lanky_dizzy,
		snd_lanky_screamspin,
		snd_lanky_defeated,
	];
	
	global._allvoices = ds_map_create();
	
	for(var i = 0; i < array_length(global._testvoices); i++){
		global._allvoices[? global._testvoices[i]] = 1;
	}
	for(var i = 0; i < array_length(global._dhvoices); i++){
		global._allvoices[? global._dhvoices[i]] = 1;
	}
	
	//sound effects
	global._swishsounds = [
		[snd_swish1,snd_swish2,snd_swish3,snd_swish4,snd_swish5,
		snd_swish6,snd_swish7],
		[snd_swishup1,snd_swishup2,snd_swishup3],
		[snd_swishdown1,snd_swishdown2,snd_swishdown3]
	];
	global._punchsounds = [
		[snd_punch1,snd_punch2,snd_punch3,snd_punch4,
		snd_punch5,snd_punch6,snd_punch7,snd_punch8,snd_punch9],
		[snd_punch4,snd_punch5,snd_punch6,snd_punch7]
	];
	global._kdsounds = [
		snd_kd1,snd_kd2,snd_kd3,snd_kd4,snd_kd5
	];
	
	global._bzenemies = [
		{
			maskname: "badhead",
			codename: "",
			dispname: "Enemy template",
			masksprite: "",
			disp: "",
			obj: false,
			alts: false,
		},
		{
			maskname: "enm1_n",
			codename: "enm1",
			dispname: "Sourosaur",
			masksprite: "spr_enm1_mask",
			disp: "spr_enm1_idle",
			obj: false,
			alts: true,
		},
		{
			maskname: "enm2_n",
			codename: "enm2",
			dispname: "Musclethug",
			masksprite: "spr_enm2_mask",
			disp: "spr_enm2_idle",
			obj: false,
			alts: true,
		},
		{
			maskname: "enm3_n",
			codename: "enm3",
			dispname: "Bagdiot",
			masksprite: "spr_enm3_mask",
			disp: "spr_enm3_idle",
			obj: false,
			alts: true,
		},
		{
			maskname: "st2_enm1",
			codename: "",
			dispname: "Henchie",
			masksprite: "",
			disp: "",
			obj: false,
			alts: true,
		},
		{
			maskname: "st2_enm2",
			codename: "",
			dispname: "Yolo-Bones",
			masksprite: "",
			disp: "",
			obj: false,
			alts: true,
		},
		{
			maskname: "st2_enm2_mtcycle",
			codename: "st2_enm2",
			dispname: "Yolo-Bike",
			masksprite: "spr_st2_enm2_mtcycle1",
			disp: "spr_st2_enm2_mtcycle1",
			obj: true,
			alts: true,
		},
		{
			maskname: "st2_enm3",
			codename: "",
			dispname: "Gostlik",
			masksprite: "",
			disp: "",
			obj: false,
			alts: true,
		},
		{
			maskname: "boss2",
			codename: "",
			dispname: "Lanky Larry",
			masksprite: "",
			disp: "",
			obj: false,
			alts: false,
		},
		{
			maskname: "moneypickup",
			codename: "",
			dispname: "Money Pickup",
			masksprite: "spr_moneypickup",
			disp: ["spr_moneypickup",3],
			obj: true,
			alts: false,
		},
		{
			maskname: "st2_gostlikbag",
			codename: "",
			dispname: "Gostlik Bag",
			masksprite: "spr_st2_gostlikbag",
			disp: "spr_st2_gostlikbag",
			obj: true,
			alts: false,
		},
		{
			maskname: "fridge",
			codename: "",
			dispname: "Fridge",
			masksprite: "",
			disp: "",
			obj: false,
			alts: false,
		},
	];
	
	global._bzmaker = false;
	global._bzone_enemies = [[]];
	_bztimer = 0;
	_bzmousepos = [0,0];
	_bz_mousestart = [0,0];
	_bzone_enm = noone;
	_hover_enm = noone;
	_last_enm = noone;
	_hovertimer = 0;
	_bzpopup = false;
	_popupopt = -1;
	
	_tutr_ocs = [
		"fella","gran","breadft",
		"glassesinblue","icie145","lafonteyn",
		"popkinsssussy","toki","yaysuu",
	];
	
	function hitjump(){
		_jump = true;
		_vspd = -4;
		_height = _vspd;
	}
	
	_dosurfacestuff = true;
	
	_gui_size = [WIDTH,HEIGHT];
	_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
	
	_resizegui_size = [1,1];
	_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
	
	global._totalobjs = 0;
}