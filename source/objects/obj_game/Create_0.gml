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
	
	global._debug = false;
	global._buildver = WINDOWS;
	global._gxLoading = false;
	global._version = "MONYX FEVER v1.02";
	
	global._debugroom = false;
	global._debughidepause = false;
	
	global._doLoading = true;
	
	cursor_sprite = -1;
	global._inactivecursortime = 180;
	global._prevcursorpos = [window_mouse_get_x(), window_mouse_get_y()];
	global._forcecustorstop = 0;
	
	global._drawBlackScreen = 0;
	
	_settingsfile = "settings";
	_gamesavefile = "gamesave";
	
	_spacing = 0;
	
	_htmladjust = false;
	
	global.sfx_effect = "";
	global.sfx_bus = audio_bus_create();
	global.sfx_bus.effects[0] = undefined;
	
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
	
	global._gravmult = 0.9;
	
	global._state = "game";
	global._freezeFrames = {
		vshort_freeze: 0,
		short_freeze: 0,
		mid_freeze: 0,
		long_freeze: 0
	}
	
	global._easings = ds_map_create();
	
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
	#macro EFFECT_CONTRAST 2
	
	global._seteffect = 0;
	global._effect = 0;
	
	global._contrasthit = 0;
	global._contrasthit_max = 8;
	global._contrasthit_val = 1;
	
	global._defShadowSize = 0.5;
	
	global._bossmusic = false;
	
	global._dialogue = false;
	
	global._minigame_nopause = false;
	
	//debug
	global._bzmaker = false;
	global._bzone_enemies = [[]];
	
	//stage specific
	global._toxicshack = false;
	
	global._lightsout = false;
	global._switchlights = "";
	global._switchlights_act = 0;
	global._switchlights_sound = false;
	
	global._stopFog = 16;
	
	global._ringmaster = 0;
	
	global._deleteready = false;
	
	global._fgScrollSpd = -0.43;
	global._bgScrollSpd = [0.4,0.6];
	
	_layers_info = [["lv_parallaxfg",global._fgScrollSpd],["lv_parallaxbg1",global._bgScrollSpd[0]],["lv_parallaxbg2",global._bgScrollSpd[1]]];
	_store_layer_x = [0,0,0];
	
	global._easteregg_lank = false;
	global._easteregg_goblin = false;
	
	//binds
	global._binds = [27,112,113,114,115,116,117,118,119,120,121,122,123,145,19,192,49,50,51,52,53,54,55,56,57,48,189,187,[8,spr_keybinds_longer3,0],[9,spr_keybinds_longer1,0],81,87,69,82,84,89,85,73,79,80,219,221,220,[20,spr_keybinds_longer2,0],65,83,68,70,71,72,74,75,76,186,222,[13,spr_keybinds_enter,0],[16,spr_keybinds_longer2,1],90,88,67,86,66,78,77,188,190,191,[16,spr_keybinds_longer2,1],[vk_control,spr_keybinds_longer1,1],[162,spr_keybinds_longer1,1],[163,spr_keybinds_longer1,1],91,164,[32,spr_keybinds_space,0],38,[36,spr_keybinds_longer2,2],33,46,35,34,164,37,40,39,[45,spr_keybinds_longer3,1]];
	global._keystrings = [ "Escape","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","ScrLk","Pause","`","1","2","3","4","5","6","7","8","9","0","-","=","Backspace","Tab","Q","W","E","R","T","Y","U","I","O","P","[","]","\\","Caps Lock","A","S","D","F","G","H","J","K","L",";","'","Enter","Shift","Z","X","C","V","B","N","M",",",".","/","Shift","CTRL","CTRL","CTRL","Home","ALT","Space","Up","Home","Page Up","Delete","End","Page Down","ALT","Left","Down","Right","Insert"];
	global._gpbinds = [gp_face1,gp_face2,gp_face3,gp_face4,[gp_shoulderl,spr_padbinds_longer1,0],gp_shoulderlb,[gp_shoulderr,spr_padbinds_longer1,1],gp_shoulderrb,[gp_select,spr_padbinds_longer2,0],[gp_start,spr_padbinds_longer2,1],gp_stickl,gp_stickr,gp_padu,gp_padd,gp_padl,gp_padr,"stick1_u","stick1_d","stick1_l","stick1_r","stick2_u","stick2_d","stick2_l","stick2_r"];
	global._gpstrings = [ "A","B","X","Y","L","ZL","R","ZR","Select","Start","Left stick","Right stick","Pad-Up","Pad-Down","Pad-Left","Pad-Right","stick1_u","stick1_d","stick1_l","stick1_r","stick2_u","stick2_d","stick2_l","stick2_r" ];
	global._keyoffset = -20;
	
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
	
	global._maxai = 6;
	
	global._delayspawn = 0;
	global._delayspawntime = 0;
	
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
	
	global._bossstart = false;
	global._bossvalue = 0;
	
	global._fadeout = false;
	global._fadeout_alp = 0;
	global._winscreen = false;
	
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
	
	_gp_alp = 0;
	
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
	
	//arrays
	global._solidArray = [obj_solid, obj_itembox, obj_boxthing, obj_wallsolid, obj_matchsolid, obj_stage_secret_solid];
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
	
	_tutr_ocs = [
		"fella","gran","breadft",
		"glassesinblue","icie145","lafonteyn",
		"popkinsssussy","toki","yaysuu",
		"junga","gizmo","booger",
	];
	
	function hitjump(){
		_jump = true;
		_vspd = -4;
		_height = _vspd;
	}
}