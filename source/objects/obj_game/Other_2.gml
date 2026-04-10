{
	randomise();
	
	global._prevcursorpos = [window_mouse_get_x(), window_mouse_get_y()];
	global._cursortimer = 0;
	global._inactivecursor = 0;
	
	global._htmlinit = false;

	global._showDebug = 1;
	global._showTexGroupDebug = false;
	global._showMemoryDebug = false;
	global._mpGridCount = 0;
	global._testloop_curmusic = 0;
	
	global._loadState = "start";
	
	global._swackygames = false;
	global._menututorial = false;
	global._menuminigame = false;
	global._backtomenu = false;
	
	global._dowindow = false;
	alarm_set(1,2);
	
	global._defvalues = ds_map_create();
	
	global._storeSliders = ds_map_create();
	
	global._masterVolume = 0.75;
	global._defvalues[? "Master"] = global._masterVolume;
	global._musVolume = 0.85;
	global._defvalues[? "Music"] = global._musVolume;
	global._sfxVolume = 1;
	if(global._buildver == HTML){
		global._sfxVolume = 0.7;
	}
	global._defvalues[? "Sound Effects"] = global._sfxVolume;
	global._voiceVolume = 1;
	global._defvalues[? "Voice"] = global._voiceVolume;
	
	global._unfocusedmute = false;
	global._defvalues[? "Unfocused Mute"] = global._unfocusedmute;
	
	//load audio settings
	global._masterVolume = scr_loadvalue("number", "Master", _settingsfile, global._defvalues[? "Master"], "Audio", true, false);
	global._musVolume = scr_loadvalue("number", "Music", _settingsfile, global._defvalues[? "Music"], "Audio", false, false);
	global._sfxVolume = scr_loadvalue("number", "Sound Effects", _settingsfile, global._defvalues[? "Sound Effects"], "Audio", false, false);
	global._voiceVolume = scr_loadvalue("number", "Voice", _settingsfile, global._defvalues[? "Voice"], "Audio", false, false);
	global._unfocusedmute = scr_loadvalue("bool", "Unfocused Mute", _settingsfile, global._defvalues[? "Unfocused Mute"], "Audio", false, true);
	
	global._storeSliders[? "Master"] = global._masterVolume;
	if(global._masterVolume == 0){
		global._storeSliders[? "Master"] = global._defvalues[? "Master"];
	}
	global._storeSliders[? "Music"] = global._musVolume;
	if(global._musVolume == 0){
		global._storeSliders[? "Music"] = global._defvalues[? "Music"];
	}
	global._storeSliders[? "Sound Effects"] = global._sfxVolume;
	if(global._sfxVolume == 0){
		global._storeSliders[? "Sound Effects"] = global._defvalues[? "Sound Effects"];
	}
	global._storeSliders[? "Voice"] = global._voiceVolume;
	if(global._voiceVolume == 0){
		global._storeSliders[? "Voice"] = global._defvalues[? "Voice"];
	}
	
	application_surface_draw_enable(false);
	
	global._full = false;
	global._borderless = false;
	global._scrtype = 0;
	global._defvalues[? "Fullscreen"] = global._scrtype;
	global._vsync = false;
	global._defvalues[? "V-Sync"] = global._vsync;
	global._all_aa = [0,2];
	if(display_aa == 2){
		global._all_aa = [0,2];
	} else if(display_aa == 6){
		global._all_aa = [0,2,4];
	} else if(display_aa == 12){
		global._all_aa = [0,4,8];
	} else if(display_aa == 14){
		global._all_aa = [0,2,4,8];
	}
	global._aa_filter = 1;
	global._defvalues[? "Anti-Aliasing"] = global._aa_filter;
	
	_setres = [
		[640,360],
		[896,504],
		[1024,576],
		[1152,648],
		[1280,720],
		[1600,900],
		[1920,1080],
		[2560,1440],
	];
	
	global._res = [
		[384,216],
	];
	for(var i = 0; i < array_length(_setres); i++){
		if(display_get_width() >= _setres[i][0] && display_get_height() >= _setres[i][1]){
			global._res[array_length(global._res)] = [_setres[i][0],_setres[i][1]];
		}
	}
	
	global._curres = min(5, array_length(global._res)-1);
	global._defvalues[? "Resolution"] = global._curres;
	global._colorblending = 1;
	global._defvalues[? "Color Blending"] = global._colorblending;
	global._texfilter = true;
	global._defvalues[? "Interpolation"] = global._texfilter;
	global._shakevals = [0,0.25,0.5,0.75,1,1.25,1.5,1.75];
	global._shakeval = 4;
	global._defvalues[? "Screenshake"] = global._shakeval;
	
	//load video settings
	global._scrtype = scr_loadvalue("number", "Fullscreen", _settingsfile, global._defvalues[? "Fullscreen"], "Video", true, false);
	global._vsync = scr_loadvalue("bool", "V-Sync", _settingsfile, global._defvalues[? "V-Sync"], "Video", false, false);
	global._aa_filter = scr_loadvalue("number", "Anti-Aliasing", _settingsfile, global._defvalues[? "Anti-Aliasing"], "Video", false, false);
	global._colorblending = scr_loadvalue("number", "Color Blending", _settingsfile, global._defvalues[? "Color Blending"], "Video", false, false);
	global._curres = scr_loadvalue("number", "Resolution", _settingsfile, global._defvalues[? "Resolution"], "Video", false, false);
	global._texfilter = scr_loadvalue("bool", "Interpolation", _settingsfile, global._defvalues[? "Interpolation"], "Video", false, false);
	global._shakeval = scr_loadvalue("number", "Screenshake", _settingsfile, global._defvalues[? "Screenshake"], "Video", false, true);
	
	switch(global._scrtype){
		case 0:
			global._full = false;
			global._borderless = false;
		break;
		case 1:
			global._full = true;
			global._borderless = false;
		break;
		case 2:
			global._full = true;
			global._borderless = true;
		break;
	}
	
	global._storeSliders[? "Fullscreen"] = global._scrtype;
	if(global._scrtype == 0){
		global._storeSliders[? "Fullscreen"] = global._defvalues[? "Fullscreen"];
	}
	global._storeSliders[? "Anti-Aliasing"] = global._aa_filter;
	if(global._aa_filter == 0){
		global._storeSliders[? "Anti-Aliasing"] = global._defvalues[? "Anti-Aliasing"];
	}
	global._storeSliders[? "Color Blending"] = global._colorblending;
	if(global._colorblending == 0){
		global._storeSliders[? "Color Blending"] = global._defvalues[? "Color Blending"];
	}
	global._storeSliders[? "Resolution"] = global._curres;
	if(global._curres == 0){
		global._storeSliders[? "Resolution"] = global._defvalues[? "Resolution"];
	}
	global._storeSliders[? "Screenshake"] = global._shakeval;
	if(global._shakeval == 0){
		global._storeSliders[? "Screenshake"] = global._defvalues[? "Screenshake"];
	}
	
	display_reset(0, global._vsync);
	gpu_set_texfilter(global._texfilter);
	
	global._input = [ds_map_create(),ds_map_create()];
	
	//game settings
	global._menumouse = true;
	global._defvalues[? "Mouse in Menu"] = global._menumouse;
	global._surflighting = true;
	global._defvalues[? "Surface Lighting"] = global._surflighting;
	global._skyshader = true;
	global._defvalues[? "Background Shaders"] = global._skyshader;
	global._kdeffect = true;
	global._defvalues[? "Knockdown effect"] = global._kdeffect;
	global._showtips = true;
	global._defvalues[? "Show Tips"] = global._showtips;
	global._freezevals = [0,0.25,0.5,0.75,1,1.25,1.5];
	global._freezeval = 4;
	global._defvalues[? "Freeze Frame Intensity"] = global._freezeval;
	global._birdmode = false;
	global._defvalues[? "Flying Robot"] = global._birdmode;
	
	//load game settings
	global._menumouse = scr_loadvalue("bool", "Mouse in Menu", _settingsfile, global._defvalues[? "Mouse in Menu"], "Game", true, false);
	global._surflighting = scr_loadvalue("bool", "Surface Lighting", _settingsfile, global._defvalues[? "Surface Lighting"], "Game", false, false);
	global._skyshader = scr_loadvalue("bool", "Background Shaders", _settingsfile, global._defvalues[? "Background Shaders"], "Game", false, false);
	global._kdeffect = scr_loadvalue("bool", "Knockdown effect", _settingsfile, global._defvalues[? "Knockdown effect"], "Game", false, false);
	global._showtips = scr_loadvalue("bool", "Show Tips", _settingsfile, global._defvalues[? "Show Tips"], "Game", false, false);
	global._freezeval = scr_loadvalue("number", "Freeze Frame Intensity", _settingsfile, global._defvalues[? "Freeze Frame Intensity"], "Game", false, false);
	global._birdmode = scr_loadvalue("bool", "Flying Robot", _settingsfile, global._defvalues[? "Flying Robot"], "Game", false, true);
	
	if(global._buildver == HTML){
		global._menumouse = false;
	}
	
	global._storeSliders[? "Freeze Frame Intensity"] = global._freezeval;
	if(global._freezeval == 0){
		global._storeSliders[? "Freeze Frame Intensity"] = global._defvalues[? "Freeze Frame Intensity"];
	}
	
	//keyboard
	global._definput = [ds_map_create(),ds_map_create()];
	
	global._input[0][? "left"] = vk_left;
	global._input[0][? "right"] = vk_right;
	global._input[0][? "up"] = vk_up;
	global._input[0][? "down"] = vk_down;
	global._input[0][? "jump"] = ord("Z");
	global._input[0][? "punch"] = ord("X");
	global._input[0][? "tnt"] = ord("C");
	global._input[0][? "grab"] = ord("S");
	global._input[0][? "crouch"] = vk_shift;
	global._input[0][? "dive"] = 17;
	global._input[0][? "shield"] = ord("A");
	global._input[0][? "taunt"] = ord("D");
	global._input[0][? "confirm"] = vk_enter;
	global._input[0][? "pause"] = vk_escape;
	global._input[0][? "menu_left"] = vk_left;
	global._input[0][? "menu_right"] = vk_right;
	global._input[0][? "menu_up"] = vk_up;
	global._input[0][? "menu_down"] = vk_down;
	global._input[0][? "menu_select"] = ord("Z");
	global._input[0][? "menu_back"] = ord("X");
	
	ds_map_copy(global._definput[0], global._input[0]);
	
	//controller
	global._input[1][? "left"] = "stick1_l";
	global._input[1][? "right"] = "stick1_r";
	global._input[1][? "up"] = "stick1_u";
	global._input[1][? "down"] = "stick1_d";
	global._input[1][? "jump"] = gp_face1;
	global._input[1][? "punch"] = gp_face3;
	global._input[1][? "tnt"] = gp_face4;
	global._input[1][? "grab"] = gp_face2;
	global._input[1][? "crouch"] = gp_shoulderlb;
	global._input[1][? "dive"] = gp_shoulderrb;
	global._input[1][? "shield"] = gp_shoulderl;
	global._input[1][? "taunt"] = gp_shoulderr;
	global._input[1][? "confirm"] = gp_start;
	global._input[1][? "pause"] = gp_select;
	global._input[1][? "menu_left"] = gp_padl;
	global._input[1][? "menu_right"] = gp_padr;
	global._input[1][? "menu_up"] = gp_padu;
	global._input[1][? "menu_down"] = gp_padd;
	global._input[1][? "menu_select"] = gp_face1;
	global._input[1][? "menu_back"] = gp_face2;
	
	ds_map_copy(global._definput[1], global._input[1]);
	
	global._sensitivity = 0.3;
	global._defvalues[? "Gamepad Deadzone"] = global._sensitivity;
	
	global._rumble = 1;
	global._defvalues[? "Rumble Intensity"] = global._rumble;
	
	//load controls
	ini_open(_settingsfile+".ini");
	
	dsmap_controls = [];
	
	for(var j = 0; j < array_length(global._input); j++){
		var inp;
		if(j == 0){
			inp = "key_";
		} else if(j == 1){
			inp = "gp_";
		}
		
		dsmap_controls = ds_map_keys_to_array(global._input[j]);
		for(var i = 0; i < array_length(dsmap_controls); i++){
			var type = typeof(global._input[j][? dsmap_controls[i]]);
			global._input[j][? dsmap_controls[i]] = scr_loadvalue(type, inp+dsmap_controls[i], _settingsfile, global._definput[j][? dsmap_controls[i]], "Controls", false, false);
		}
	}
	
	global._sensitivity = scr_loadvalue("number", "Gamepad Deadzone", _settingsfile, global._defvalues[? "Gamepad Deadzone"], "Controls", false, false);
	global._sensitivity = clamp(global._sensitivity, 0.05, 0.95);
	
	global._rumble = scr_loadvalue("number", "Rumble Intensity", _settingsfile, global._defvalues[? "Rumble Intensity"], "Controls", false, false);
	global._rumble = clamp(global._rumble, 0, 1);
	
	global._storeSliders[? "Gamepad Deadzone"] = global._sensitivity;
	if(global._sensitivity == 0){
		global._storeSliders[? "Gamepad Deadzone"] = global._defvalues[? "Gamepad Deadzone"];
	}
	global._storeSliders[? "Rumble Intensity"] = global._rumble;
	if(global._rumble == 0){
		global._storeSliders[? "Rumble Intensity"] = global._defvalues[? "Rumble Intensity"];
	}
	
	ini_close();
	
	//game info
	global._location = 1;
	global._locations = ["tOxIc TrEnCheS ","GrOoVy gRaVeYaRd "];
	
	global._metric = false;
	
	global._gametips = ds_map_create();
	//[trigger, show again];
	global._gametips[? "punch"] = [false,false];
	global._gametips[? "lowkick"] = [false,false];
	global._gametips[? "upper"] = [false,false];
	
	global._gametips[? "grab"] = [false,false];
	global._gametips[? "jumpback"] = [false,false];
	global._gametips[? "roll"] = [false,false];
	
	global._bossintro = false;
	global._bossphase_save = 0;
	global._bosswave_save = 0;
	
	//load game ini
	global._curmonyx = 15000;
	global._defvalues[? "Monyx"] = global._curmonyx;
	
	global._curmonyx = scr_loadvalue("number", "Monyx", _gamesavefile, global._defvalues[? "Monyx"], "", true, true);
	
	global._addmonyx = 0;
	global._minigame_monyx = 0;
	global._minigame_diff = 0;
	global._minigame = "";
	
	global._saveminigame = [0,0];
	
	//minigames stuff
	global._lode_testlayout = [];
	global._lode_testsigns = ds_map_create();
	global._lode_playmode = true;
	global._lode_testmode = false;
	global._lode_testmode_load = false;
	
	//font
	global._font = "";
	global._fontdata = ds_map_create();
	global._fontmap = ds_map_create();
	global._charset = ds_map_create();
	global._charset[? "test"] = "ABC123";
	global._charset[? "ascii"] = " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
	global._charset[? "letters_nums"] = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:.?!'";
	global._textheight = ds_map_create();
	global._halign = 0;
	global._valign = 0;
	global._textspacing = 0;
	global._textshaking = [0,0];
	global._textwave = [0,0];
	global._textwavetime = [0,0];
	global._usegametimer = false;
	global._fontInit = false;
	global._keybindW = 52;
	global._keybindH = 26;
	global._keyscale_nes = 0.32;
	
	global._acceptedFonts = [];
	
	scr_textrender_setfont("dh_font1", global._charset[? "ascii"]);
	scr_textrender_setfont("dh_font2", global._charset[? "ascii"]);
	scr_textrender_setfont("dh_font2_hue", global._charset[? "ascii"]);
	scr_textrender_setfont("dh_font2_big", global._charset[? "ascii"]);
	scr_textrender_setfont("dh_font3", " HP/0123456789");
	scr_textrender_setfont("dh_font4", global._charset[? "letters_nums"]);
	scr_textrender_setfont("dh_font4_big", global._charset[? "letters_nums"]);
	scr_textrender_setfont("dh_fontnes", global._charset[? "ascii"]+"±º¹²³");
	scr_textrender_setfont("dh_fontnes_lode", global._charset[? "ascii"]+"±º¹²³");
	scr_textrender_setfont("dh_fontcomic1", global._charset[? "ascii"]);
	scr_textrender_setfont("dh_fontmenu1", global._charset[? "letters_nums"]);
	scr_textrender_setfont("dh_fontmenu2", global._charset[? "letters_nums"]);
	
	global._fontSpacing = ds_map_create();
	global._fontSpacing[? "dh_font1"] = 1;
	global._fontSpacing[? "dh_font2"] = -2;
	global._fontSpacing[? "dh_font2_hue"] = -2;
	global._fontSpacing[? "dh_font2_big"] = -6;
	global._fontSpacing[? "dh_fontcomic1"] = 2;
	global._fontSpacing[? "dh_fontmenu1"] = -24;
	global._fontSpacing[? "dh_fontmenu2"] = -24;
	
	//set to default font
	global._defaultFont = "dh_font1";
	
	scr_textrender_switchfont(global._defaultFont);
	
	global._padfound = false;
	global._inptype = 0;
	global._padnum = 0;
	global._padtime = 0;
	global._padmsgtype = 0;
	
	global._playerX = 0;
	global._playerY = 0;
	global._playerDir = "r";
	global._deathZoom = 1;
	
	global._showHitbox = false;
	global._freeRoam = false;
	global._enableCamera = true;
	
	//musics
	global._saveMusPos = 0;
	global.mus_emitter = audio_emitter_create();
	global.music_bus = audio_bus_create();
	audio_emitter_bus(global.mus_emitter, global.music_bus);
	
	//CHECKPOINT!
	global._checkpoint = noone;
	global._checkPos = [0,0];
	
	global._knockouts = 0;
	
	global._moneypickups = {
		total: 3,
		prev: 0,
		cur: 0,
	};
	global._plusmoney = {
		prev: [],
		cur: [],
	};
	
	global._deletedStuffPrev = ds_map_create();
	global._deletedStuff = ds_map_create();
	global._checkps = ds_map_create();
	
	global._whack_help = false;
	global._lode_help = false;
	
	global._lode_deletedStuff = ds_map_create();
	global._lode_tutorial = false;
	global._lode_stage = 0;
	global._lode_curboss = 0;
	global._lode_lives = 0;
	global._lode_tnt = 0;
	global._lode_tnt_store = 0;
	global._lode_tntmax = 100;
	global._lode_score = 0;
	global._lode_score_store = 0;
	global._lode_spawnstuff = false;
	global._lode_loopback = false;
	global._lode_curloop = 0;
	global._lode_spd = 1;
	global._lode_muspitch = 1;
	
	global._lode_editor = false;
	
	global._died = false;
	
	global._seenvs = false;
	
	global._cursong = -1;
	global._looped = 0;
	global._curSongGain = 1;
	
	global._stageintro_theme = -1;
	global._stageintro_leit = -1;
	
	global._horse = false;
	global._speedruntimer = 0;
}