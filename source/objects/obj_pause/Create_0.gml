{
	_allsounds = ds_map_create();
	
	_prevOpt = 0;
	_curOpt = 0;
	
	_prevOpt2 = 0;
	_curOpt2 = 0;
	
	_confirmtitle = "";
	
	_pauseOpts = [
		["resume",""],
		["back to last surf", ""],
		["start over",""],
		["settings",""],
		["back to menu",""],
	];
	
	_curbutton = noone;
	_enter = false;
	_state = "main";
	_sndarray = [snd_menu1,snd_menu2,snd_menu3,snd_menu4,snd_menu5];
	
	_menutimer = 0;
	_actiontimer = ds_map_create();
	
	_muspos = 0;
	
	_yposoffset = 0;
	for(var i = 0; i < array_length(_pauseOpts); i++){
		_btn = instance_create_depth(0, 0, 0, obj_optbtn);
		_btn._pausebtn = true;
		_btn._xpos = floor(WIDTH/2)-WIDTH;
		_btn._ypos = 290 + _yposoffset;
		_btn._starty = _btn._ypos;
		_btn._maintextscale = 1.25;
		_yposoffset += 72;
		_btn._text = _pauseOpts[i][0];
		_btn._id = _pauseOpts[i][1];
		_btn._opt = i;
		_btn._optionsobj = self;
		_btn._state = "main";
		_btn._layer = 0;
	}
	
	for(var i = 0; i < 2; i++){
		_btn = instance_create_depth(0, 0, 0, obj_optbtn);
		_btn._pausebtn = true;
		if(i == 0){
			_btn._xpos = floor(WIDTH/2)-128;
			_btn._text = "YES";
		} else {
			_btn._xpos = floor(WIDTH/2)+128;
			_btn._text = "NO";
		}
		_btn._ypos = floor(HEIGHT/2);
		_btn._starty = _btn._ypos;
		_btn._id = "confirm";
		_btn._opt = i;
		_btn._optionsobj = self;
		_btn._state = "confirm";
	}
	
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
	
	function checkmenus() {
		if(_state == "main"){
			switch(_curOpt){
				case 0:
					_tntmenustate = "return";
				break;
				case 1:
					_tntmenustate = "restart_check";
				break;
				case 2:
					_tntmenustate = "restart_stage";
				break;
				case 3:
					_tntmenustate = "options";
				break;
				case 4:
					_tntmenustate = "end";
				break;
			}
		} else if(_state == "confirm"){
			if(_curOpt2 == 0){
				switch(_curOpt){
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
		_enter = true;
		global._tntmenuAct = 1;
		sfx_play(snd_tnt_pull);
	}
	
	_dosurfacestuff = true;
	
	_gui_size = [WIDTH,HEIGHT];
	_gui_surface = surface_create(_gui_size[0],_gui_size[1]);
	
	_resizegui_size = [1,1];
	_resizegui_surface = surface_create(_resizegui_size[0],_resizegui_size[1]);
}