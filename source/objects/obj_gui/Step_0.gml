{
	if(!global._pause && !global._winscreen){
		//fading ui
		for(var i = 0; i < array_length(global._ui_stuff_alpha); i++){
			global._ui_stuff_alpha[i] = lerp(global._ui_stuff_alpha[i], global._ui_stuff_alphaTo[i], 0.15);
			global._ui_stuff_alphaMult[i] = lerp(global._ui_stuff_alphaMult[i], global._ui_stuff_alphaMultTo[i], 0.15);
			if(instance_exists(obj_dh_mask)){
				if(obj_dh_mask._idleguitimer < obj_dh_mask._idleguithreshold){
					global._fadeOutTimer[i] ++;
					if(global._fadeOutTimer[i] >= 180){
						global._ui_stuff_alphaTo[i] = 0;
						global._fadeOutTimer[i] = 180;
					}
				}
			}
		}
		global._ui_shieldMult = lerp(global._ui_shieldMult, global._ui_shieldMultTo, 0.24);
			
		var dh = instance_find(obj_dh_mask,0);
		if(dh != noone && instance_exists(dh)){
			if(dh._begin){
				if(!global._dialogue && check_keypress(global._input[global._inptype][? "confirm"], global._inptype )){
					with(obj_dh_display){
						_outline_alpto = 1;
						_outline_timer = _outline_maxtimer;
					}
					ui_all_fade(1);
				}
			}
		}
		
		if(global._tutorial){
			ui_all_fade(1);
			
			_hitstemp = 0;
			_hitsarraytemp = [];
		}
		
		//dh colliding with gui elements
		with(obj_dh_mask){
			if(scr_colliderect(0, (HEIGHT-220)-_height, 480, (HEIGHT)-_height, true)){
				global._ui_stuff_alphaMultTo[0] = 0.3;
			} else {
				global._ui_stuff_alphaMultTo[0] = 1;
			}
				
			if(scr_colliderect(WIDTH-520, (HEIGHT-170)-_height, WIDTH, (HEIGHT)-_height, true)){
				global._ui_stuff_alphaMultTo[1] = 0.3;
			} else {
				global._ui_stuff_alphaMultTo[1] = 1;
			}
				
			if(scr_colliderect(0, _height, 410, 320+_height, true)){
				global._ui_stuff_alphaMultTo[2] = 0.3;
			} else {
				global._ui_stuff_alphaMultTo[2] = 1;
			}
				
			if(scr_colliderect(0, _height, WIDTH, 320+_height, true)){
				global._ui_stuff_alphaMultTo[3] = 0.3;
			} else {
				global._ui_stuff_alphaMultTo[3] = 1;
			}
					
			//prompt
			if(scr_colliderect(0, _height, WIDTH, 340+_height, true)){
				global._prompt_desc_multTo = 0.3;
			} else {
				global._prompt_desc_multTo = 1;
			}
		}
		
		//enemies
		if(!global._tutorial){
			if(array_length(global._curenemy) == 1){
				//one enemy
				if(instance_exists(global._curenemy[0])){
					if(global._curenemy[0]._inactive){
						global._curenemy = [];
					}
				} else {
					global._curenemy = [];
				}
			} else if(array_length(global._curenemy) > 1){
				//two or three enemies
				for(var i = array_length(global._curenemy)-1; i >= 0; i--){
					if(instance_exists(global._curenemy[i])){
						if(global._curenemy[i]._inactive){
							array_delete(global._curenemy, i, 1);
						}
					} else {
						array_delete(global._curenemy, i, 1);
					}
				}
			}
		}
		
		//boss
		if(!global._pause){
			if(global._curboss != noone && instance_exists(global._curboss) && global._curboss._boss_active){
				_bossoffsetlerp = 16;
			} else {
				_bossoffsetlerp = -320;
			}
			_bossoffset[1] = lerp(_bossoffset[1], _bossoffsetlerp, 0.12);
		}
		
		if(!global._stageentrance){
			//tnt juice
			global._displayjuice = global._displayjuice + (global._tntjuice-global._displayjuice)*0.12;
			
			_firetimer ++;
			if(_firetimer % 8 == 0){
				_fireframe ++;
				if(_fireframe >= 3){
					_fireframe = 0;
				}
			}
		}
		
		//hits
		var maxhitval = 999;
		if(global._hits > maxhitval){
			global._hits = maxhitval;
		}
		if(array_length(global._hitsarray) > maxhitval){
			array_shift(global._hitsarray);
		}
		if(global._hitscd > 0){
			global._hitscd --;
		}
		
		if(global._hits > 0){
			if(_jump){
				_vspd += 0.6;
				_height += _vspd;
				if(_height > 0){
					_height = 0;
					_vspd = 0;
					_jump = false;
				}
			}
			global._hitmeter -= 0.25;
			if(global._hitmeter <= 0){
				ui_fade("tnt", 1);
				_flyaway = true;
				_flypos = [_hitoffset[0]+_hitnumoffset[0], _hitoffset[1]+_hitnumoffset[1]];
				_flyto = [_tntoffset[0]+120, _tntoffset[1]-10];
				_hitstemp = floor(global._hits);
				_hitsarraytemp = global._hitsarray;
				global._hitmeter = 0;
				global._hits = 0;
				global._hitsarray = [];
			}
		}
		
		//hit numbers approaching tnt juice meter
		if(_flyaway){
			_flypos[0] = _flypos[0] + (_flyto[0] - _flypos[0]) * 0.14;
			_flypos[1] = _flypos[1] + (_flyto[1] - _flypos[1]) * 0.14;
			if(diff(_flypos[0],_flyto[0]) < 8){
				for(var h = 0; h < array_length(_hitsarraytemp); h++){
					global._tntjuice += _hitsarraytemp[h]*0.86;
				}
				_hitsarraytemp = [];
				if(global._tntjuice > global._tntjuice_max){
					global._tntjuice = global._tntjuice_max;
				}
				_tntamp = 8;
				_flyaway = false;
			}
		}	
		
		//tnt meter shake
		if(_tntamp > 0){
			_tntamp --;
		} else if(_tntamp < 0){
			_tntamp = 0;
		}
		
		//dial-m tutorial popup
		if(_dialm_active){
			_dialm_timer ++;
			switch(_dialm_act){
				case 0:
					if(_dialm_pos > 0){
						_dialm_pos -= 66;
					} else {
						sfx_play(snd_perfect, 0.68);
						sfx_pitch(snd_perfect,1.35);
						_dialm_pos = 0;
						_dialm_timer = 0;
						_dialm_act = 1;
					}
				break;
				case 1:
					if(_dialm_timer >= 48){
						_dialm_timer = 0;
						_dialm_act = 2;
					}
				break;
				case 2:
					if(_dialm_pos < WIDTH){
						_dialm_pos += 80;
					} else {
						if(surface_exists(_dialm_surf)){
							surface_free(_dialm_surf);
						}
									
						_dialm_quote = -1;
						_dialm_active = false;
					}
				break;
			}
		} else {
			if(_dialm_quote == -1){
				_dialm_quote = irandom_range(0,array_length(_dialm_quotes)-1);
			}
			_dialm_pos = WIDTH;
			_dialm_timer = 0;
			_dialm_act = 0;
		}
		
		//spacing text
		if(_uitextshow){
			_uitexttime ++;
			switch(_uitextact){
				case 0:
					_uitextspacing = 500;
					_uitextact = 1;
				break;
				case 1:
					_uitextspacing -= 27;
					if(_uitextspacing <= 0){
						_uitextspacing  = 0;
					}
					if(_uitexttime >= 100){
						_uitexttime = 0;
						_uitextact = 2;
					}
				break;
				case 2:
					_uitextspacing += 36;
					if(_uitexttime >= 40){
						_uitextshow = false;
					}
				break;
			}
		} else {
			_uitextact = 0;
			_uitexttime = 0;
		}
	}
}