{
	global._died = false;
	
	//values
	_allsounds = ds_map_create();
	
	_init = false;
	
	_menustate = "main";
	
	_changedinput = false;
	_inputinit = false;
	_changehold = 0;
	
	_creditsinfo = [];
	
	_creditsoffset = [];
	for(var i = 0; i < array_length(_creditsinfo); i++){
		array_push(_creditsoffset, WIDTH*i);
	}
	
	_creditscuroffset = 0;
	_creditsLerp = 0;
	
	_credits_arowoffs = 0;
	
	_creditsframe = 0;
	
	_curopt = [0,0];
	_prevopt = [0,0];
	
	_mouseactive = false;
	_mouseprev = [mouse_x,mouse_y];
	
	_menutimer = 0;
	
	_actiontimer = ds_map_create();
	
	_sndarray = [snd_menu1,snd_menu2,snd_menu3,snd_menu4,snd_menu5];
	
	_enter = false;
	_chosenmenu = "";
	_transition = false;
	
	//objects
	_logo = instance_create_depth(0, 0, 0, obj_menulogo);
	
	_dh = instance_create_depth(0, 0, 0, obj_menudh);
	_dh._menuobj = self;
	_wall = instance_create_depth(0, 0, 0, obj_menudh);
	_wall._wall = true;
	_wall._menuobj = self;
	_options = instance_create_depth(0, 0, 0, obj_options);
	_options._menuobj = self;
	
	_btninfo = [
		["play", 1010, 90, 200],
		["tutr", 929, 226, 278],
		["setting", 1049, 346, 270],
		["credits", 925, 475, 285],
		["quit", 1075, 584, 245],
	];
	
	if(global._buildver == HTML){
		array_delete(_btninfo, 4, 1);
	}
	
	_xpos = 0;
	_ypos = 0;
	_action = "";
	_on = false;
	
	for(var i = 0; i < array_length(_btninfo); i++){
		_btn = instance_create_depth(_btninfo[i][1], _btninfo[i][2], 0, obj_menubtn);
		_btn._tnt = false;
		_btn._btn = _btninfo[i][0];
		_btn._opt = i;
		_btn._menuobj = self;
		
		_tntobj = instance_create_depth(_btn.x-_btninfo[i][3], _btn.y+32, depth, obj_menubtn);
		_tntobj._menuobj = self;
		_tntobj._tnt = true;
		_tntobj._opt = i;
	}
	
	
	
	function checkmenus() {
		if(_curopt[0] == 1){
			with(obj_camera){
				_ampX = 120;
				_ampY = 120;
			}
			sfx_play(snd_OW);
		} else {
			with(obj_menubtn){
				if(_tnt){
					image_index = 0;
					sprite_index = spr_menu_tnt2;
				}
			}
			sfx_play(snd_tnt_pull);
			_enter = true;
			switch(_curopt[0]){
				case 0:
					//begin
					_chosenmenu = "play";
				break;
				case 1:
					//tutorial
					//_chosenmenu = "tutorial";
				break;
				case 2:
					//setting
					_chosenmenu = "setting";
				break;
				case 3:
					//credit
					_chosenmenu = "credits";
				break;
				case 4:
					//quit game
					_chosenmenu = "quit";
				break;
			}
		}
	}
}