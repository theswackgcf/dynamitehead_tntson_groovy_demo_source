{
	if(!global._pause){
		if(instance_exists(_displayobj)){
			if(global._bigpunch > 0){
				_anim = "bigpunch";
				_displayobj.image_index = _bigpunch_frame;
				_displayobj.image_xscale = _displayobj._scale;
			}
			
			function drawSpr() {
				_displayobj.sprite_index = asset_get_index("spr_"+_codename+"_"+_anim);
			}
			
			if(_anim_transition){
				if(!_anim_tr_init){
					_displayobj.image_index = 0;
					
					if(_anim_prev == ""){
						drawSpr();
					}
					
					_anim_tr_init = true;					
				} else {
					drawSpr();
				}
			} else {
				drawSpr();
			}
			
		
			_displayobj.image_speed = _speed;
			if(_slam){
				_displayobj.image_speed = _slamspd;
			}
		}
		
		//input buffer
		if(_buffer_deletepress != ""){
			for(var i = 0 ; i < array_length(_input_keypress); i++){
				if(_input_keypress[i] == _buffer_deletepress){
					array_delete(_input_keypress, i, 1);
				}
			}
			_buffer_deletepress = "";
		}
		if(_buffer_deleterelease != ""){
			for(var i = 0 ; i < array_length(_input_keyrelease); i++){
				if(_input_keyrelease[i] == _buffer_deleterelease){
					array_delete(_input_keyrelease, i, 1);
				}
			}
			_buffer_deleterelease = "";
		}
	}
	
	if(global._finalhit > 0 && !global._finalhit_phase){
		if(_atk_timer > 0 && _anim == "idle" || _anim == "walk"){
			_anim = "melee_idle3";
		}
	}
	
	if(!global._pause){
		if(_state == "win"){
			_curdir = DIR_R;
			_spd = [0,0];
			_wintimer ++;
			if(_wintimer >= 80+_wintimeroffset){
				if(!_firstindex){
					_displayobj.image_index = 0;
					_firstindex = true;
				}
				if(!_winanim){
					_anim_prev = _anim;
					_anim = "win";
				} else {
					_anim_prev = _anim;
					_anim = "winloop";
				}
				if(_displayobj.image_index >= 5 && !_winvoice){
					voice_play_choose([snd_dh_voice_win1,snd_dh_voice_win2,snd_dh_voice_win3,snd_dh_voice_win4,snd_dh_voice_win5], global._dhvoices, 1);
					_winzoom = 2;
					_winvoice = true;
				}
				if(_displayobj.image_index >= 13 && !_star){
					instance_create_depth(x+48, y-76, _displayobj.depth+16, obj_stareffect);
					sfx_play(snd_star);
					_star = true;
				}
				if(_anim == "win" && _displayobj.image_index >= _displayobj.image_number-1){
					_winanim = true;
				}
				if(_displayobj.image_index >= 8){
					_displayobj._shadowlerp[0] = 46;
				}
				
				_winzoom = 1;
				
				if(_winvoice){
					global._camZoomSpd = 0.35;
					global._defCamZoom = _winzoom;
				}
			} else {
				_curdir = DIR_R;
				if(_jump){
					if(_vspd > 0){
						_anim_prev = _anim;
						_anim = "jump_loop";
					} else {
						_anim_prev = _anim;
						_anim = "fall_loop";
					}
				} else {
					if(instance_number(obj_boss_finalko) > 0){
						_attack = false;
						_attacktype = "";
						_anim = "finalko";
					} else {
						_anim = "idle";
					}
				}
			}
		}
	}
	
	if(_phasehit > 0){
		_displayobj.depth = -2000;
		if(_kickass_obj != noone && instance_exists(_kickass_obj)){
			_kickass_obj.image_xscale = 1;
			_kickass_obj.image_yscale = 1;
			_displayobj.image_xscale = _kickass_obj.image_xscale;
			_displayobj.image_yscale = _kickass_obj.image_yscale;
			
			with(_kickass_obj){
				visible = false;
			}
			
			_dispoffset = [0,0];
			_height = 0;
			_displayobj.x = _kickass_obj.x;
			_displayobj.y = _kickass_obj.y;
		}
	} else {
		if(_kickass_obj != noone && instance_exists(_kickass_obj)){
			with(_kickass_obj){
				visible = true;
			}
		}
	}
}