{
	#macro PAUSE_RESUME 0
	#macro PAUSE_SURF 1
	#macro PAUSE_RSTART 2
	#macro PAUSE_OPT 3
	#macro PAUSE_QUIT 4
	
	depth = -10999;
	
	global._pause_prevent_restart = false;
	
	_allsounds = ds_map_create();
	
	_init_timer = 0;
	
	_prevOpt = 0;
	_curOpt = 0;
	
	_prevOpt2 = 0;
	_curOpt2 = 0;
	
	_confirmtitle = "";
	_confirmbtn = "";
	
	_pausetitles = {
		resume: "resume",
		restart_surf: "back to last surf",
		restart: "start over",
		settings: "settings",
		menu: "back to menu",
		skip: "skip all",
		restart_whack: "restart minigame",
		restart_lode: "restart level",
	};
	
	_pauseOpts = [
		[_pausetitles.resume,"id_resume",0,PAUSE_RESUME],
		[_pausetitles.restart_surf, "id_restart_surf",1,PAUSE_SURF],
		[_pausetitles.restart,"id_restart",2,PAUSE_RSTART],
		[_pausetitles.settings,"id_settings",3,PAUSE_OPT],
		[_pausetitles.menu,"id_menu",4,PAUSE_QUIT],
	];
	
	_state_init = false;
	
	_curbutton = noone;
	_enter = false;
	_state = "main";
	_sndarray = [snd_menu1,snd_menu2,snd_menu3,snd_menu4,snd_menu5];
	
	_menutimer = 0;
	_actiontimer = ds_map_create();
	
	_muspos = 0;
	
	_yposoffset = 0;
	
	
	_optionsobj = instance_create_depth(0, 0, 0, obj_options);
	_optionsobj._pause = true;
	
	_pauseLetters = ds_map_create();
	_pauseLetters[? 0] = [spr_pause_p, 0, 0, random(512)]; //sprite frame spd timer
	_pauseLetters[? 1] = [spr_pause_a, 0, 0, random(512)];
	_pauseLetters[? 2] = [spr_pause_u, 0, 0, random(512)];
	_pauseLetters[? 3] = [spr_pause_s, 0, 0, random(512)];
	_pauseLetters[? 4] = [spr_pause_e, 0, 0, random(512)];
	
	_combinedWidth = sprite_get_width(spr_pause_p)+sprite_get_width(spr_pause_a)+sprite_get_width(spr_pause_u)+sprite_get_width(spr_pause_s)+sprite_get_width(spr_pause_e);

	_pauseTimer = 0;
	
	_tntmenustate = "";
	
	_xoffset = 0;
	
	_picspos = 0;
	
	_backcooldown = 0;
	
	_curmonyx = 0;
	_totalmonyx = 0;
	
	_canpause = true;
	
	function checkmenus() {
		var enter = true;
		if(_state == "main"){
			switch(_pauseOpts[_curOpt][2]){
				case 0:
					_tntmenustate = "return";
				break;
				case 1:
					_tntmenustate = "restart_check";
				break;
				case 2:
					if(global._state == "minigame" && global._minigame == "lode" && global._pause_prevent_restart){
						enter = false;
						
						with(obj_camera){
							_ampX = 10;
							_ampY = 10;
						}
						sfx_play_choose([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
					} else {
						_tntmenustate = "restart_stage";
					}
				break;
				case 3:
					_tntmenustate = "options";
				break;
				case 4:
					_tntmenustate = "end";
				break;
				
				case 5:
					_tntmenustate = "skip_all";
				break;
			}
		} else if(_state == "confirm"){
			if(_curOpt2 == 0){
				switch(_pauseOpts[_curOpt][2]){
					case 1:
						_tntmenustate = "confirm_check";
					break;
					case 2:
						_tntmenustate = "confirm_restart";
					break;
					case 4:
						_tntmenustate = "confirm_menu";
					break;
				}
			} else {
				_tntmenustate = "confirm_no";
			}
		}
		if(enter){
			_enter = true;
			global._tntmenuAct = 1;
			sfx_play(snd_tnt_pull);
		}
	}
}