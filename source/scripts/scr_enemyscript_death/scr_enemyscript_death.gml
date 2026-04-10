function scr_enemyscript_death(){
	//despawn
	if(!_idiot && !_boss && !_spin){
		if(_battlezone){
			if(!_parachute && !_falling && !place_meeting(x,y,obj_battlezone)){
				if(!_confirmkill){
					global._enmorder ++;
					_confirmkill = true;
				}
				killself();
			}
		}
	}
	
	//dying
	if(_death){
		_failsafedeath ++;
		if(_height <= _groundlevel){
			_fall_ko = true;
			_nocked ++;
		}
		if(_height > _groundlevel+32){
			_grabfall = true;
		} else {
			_grabfall = false;
		}
		if(_grabbed || _grabstart){
			_dh = noone;				
			_grabstart = false;
			_grabbed = false;
		}
	}
	
	if(!_boss && _hp <= 2){
		if(!_death){
			if(_downhurt > 0){
				_downkill = true;
			}
			
			_show_hits = true;
			
			with(obj_camera){
				_ampX = 24;
				_ampY = 24;
			}
			_hp = 0;
			
			do_grid_collisions();
					
			//freeze frames
			if(_dh_atk > 0){
				sfx_stop_array(global._kdsounds);
				sfx_play_choose(global._kdsounds);
				_freeze = global._freezeFrames.long_freeze;
			}
			
			//fall
			if(!_downkill){
				if(!_falling && !_fall_ko){
					_falling = true;
					_fixwall = true;
					_jump = true;
					_height = _groundlevel + 1;
					_falls = 0;
				} else {
					if(!_fall_ko){
						_falling = true;
						if(!place_meeting(x,y,obj_dh_mask)){
							_fixwall = true;
						}
					}
				}
				
				//offset if death offset x/y is not 0
				if(_deathoffset[0] <> 0 || _deathoffset[1] <> 0){
					_curdir = sign(_deathoffset[0]);
					if(_curdir == 0){ _curdir = DIR_R };
					x += _deathoffset[0];
					y += _deathoffset[1];
					_displayobj.x = x+_displayobj._offset[0];
					_displayobj.y = y+_displayobj._offset[1];
					_deathoffset = [0,0];
				}
				
				if(_codename != "fridge"){
					if(global._buildver != HTML){
						for(var i = 0; i < round(random_range(3,5)); i++){
							var bone = instance_create_depth(_displayobj.x+random_range(-56,56),_displayobj.y+random_range(-100,12),_displayobj.depth,obj_enemybone);
							bone._codename = _codename;
							var bonesprite = asset_get_index("spr_enemybones_"+bone._codename);
							var bonesprite_alt = bonesprite;
							if(_enmtype != -1){
								bone._enmtype_disp = string(_enmtype);
								bonesprite_alt = asset_get_index("spr_enemybones_"+bone._codename+"_"+bone._enmtype_disp);
							}
							if(sprite_exists(bonesprite)){
								bone.sprite_index = bonesprite;
								if(_enmtype != -1 && sprite_exists(bonesprite_alt)){
									bone.sprite_index = bonesprite_alt;
								}
								_boneframe = irandom_range(0,sprite_get_info(bone.sprite_index).num_subimages-1);
								bone.image_index = bone._boneframe;
							}
							bone._xspd = random_range(8*_curdir, 12);
							bone._vspd = random_range(12,19);
							bone._groundlevel = _groundlevel;
							bone._height = _groundlevel + 3;
							bone._freeze = _freeze;
						}
					}
				}
				
				_vspd = 18;
				
				if(instance_exists(_displayobj)){
					var p = instance_create_depth(_displayobj.x-32,_displayobj.y-46,_displayobj.depth-1,obj_particle);
					p._type = "vanish";
				}
				
				_voiceinit = true;
			
				_death = true;
			} else {
				sfx_stop_array(global._kdsounds);
				sfx_play_choose(global._kdsounds);
				sfx_play(snd_finalko);
				
				global._hits += 1;
				global._hitmeter = 50;
				
				var p = instance_create_depth(x,y,depth, obj_particle);
				p._type = "hit_final";
				global._contrasthit = global._contrasthit_max;
				
				with(obj_camera){
					_ampX = 24;
					_ampY = 24;
				}
				
				if(_dh_atk > 0){
					if(_dh_atk_inst != noone && instance_exists(_dh_atk_inst)){
						_dh_atk_inst._freeze = 40*global._freezevals[global._freezeval];
					}
				}
				
				global._pad_vibrate = 16;
				
				_freeze = 40*global._freezevals[global._freezeval];
				_death = true;
			}
		} else {
			if(!_downkill){
				if(_despawndeath){
					if(x-global._cameraX < WIDTH/2){
						_curdir = DIR_L;
					} else {
						_curdir = DIR_R;
					}
				}
				if(instance_exists(_displayobj)){
					if(_despawndeath && _height <= _groundlevel){
						var p = instance_create_depth(_displayobj.x,_displayobj.y-12,_displayobj.depth-1,obj_particle);
						p._type = "vanish";
						killself();
					}
				}
				if(_anim == "skull" && !array_contains(global._skullrecolor, _codename)){
					_recolorstop = true;
				}
				_mashed = false;
			
				_pointtime = 0;
				_pathpoint = [_walkto[0],_walkto[1]];
			
				_dispoffset[1] = -32;
			
				if(_freeze == 0){
					if(_height > _groundlevel && !_grabbed){
						if(instance_exists(_displayobj)){
							_displayobj.image_angle += 5*(-_curdir);
						}
						if(x == xprevious){
							_nomovetime ++;
						}
						if(_nomovetime >= 6){
							_slidepoints = 0;
						}
					} else {
						_walkto[0] = x+(_slidepoints*_curdir);
						x += _slidepoints*_curdir;
						if(_slidepoints > 0){
							_slidepoints --;
						}
					}
				}
			} else {
				if(_freeze <= 0){
					var p = instance_create_depth(_displayobj.x,_displayobj.y-12,_displayobj.depth-1,obj_particle);
					p._type = "vanish";
				
					var f = instance_create_depth(_displayobj.x, _displayobj.y-24, -5001, obj_enm_finalko);
					f.sprite_index = asset_get_index("spr_"+_codename+"_finalko");
					f._codename = _codename;
					f._enmtype = _enmtype;
					f._battlezone = _battlezone;
					f._docolors = _docolors;
					f._maxcolors = _maxcolors;
	
					f._mult_colorinArray = _mult_colorinArray;
					f._mult_coloroutArray = _mult_coloroutArray;
					f._mult_tolrArray = _mult_tolrArray;
					f._mult_blendArray = _mult_blendArray;
					
					f._confirmkill = _confirmkill;
					
					if(x < ((WIDTH/2)-global._cameraX)+320){
						f._spd[0] = -7;
					} else {
						f._spd[0] = 7;
					}
					f._spd[1] = -12;
					
					sfx_pitch(snd_finalko, random_range(0.76,1.24));
			
					if(_playvoice.flyout != -1){
						f._playvoice = _playvoice.flyout;
					} else {
						if(_playvoice.death != -1){
							f._playvoice = _playvoice.death;
						}
					}
					
					var countkill = true;
					if(variable_instance_exists(self.id, "_hn_ring_fake")){
						if(_hn_ring_fake){
							countkill = false;
						}
					}
					if(variable_instance_exists(self.id, "_lankspawned")){
						if(_lankspawned){
							countkill = false;
						}
					}
					
					if(countkill){
						global._kills ++;
					}
				
					killself();
				}
			}
		}
	}
	
	//boss deaths
	if(_boss){
		if(global._finalhit <= 0 && !global._finalhit_phase && _finalhit){
			if(!_flyout){
				var f = instance_create_depth(global._cameraX+(WIDTH/2)-210, global._cameraY+(HEIGHT/2)+120, -5001, obj_boss_finalko);
				f._codename = _codename;
				if(_playvoice.death != -1){
					f._voiceclip = _playvoice.death;
				}
				f._spd[0] = 7;
				f._spd[1] = -18;
				
				_hp = 0;
				_boss_active = false;
				
				_flyout = true;
				_death = true;
			}
		}
	}
	
	//voice clip
	if(_voiceinit){
		if(_voicetimer > 0){
			_voicetimer --;
		} else {
			if(!_voiceonce){
				sfx_stop_array(global._kdsounds);
				sfx_play_choose(global._kdsounds);
				sfx_play(snd_finalko);
				
				global._hits += 1;
				global._hitmeter = 50;
				
				with(obj_camera){
					_ampX = 24;
					_ampY = 24;
				}
				
				var p = instance_create_depth(x,y,depth, obj_particle);
				p._type = "hit_final";
				global._contrasthit = global._contrasthit_max;
				
				sfx_pitch(snd_finalko, random_range(0.76,1.24));
				if(_playvoice.death != -1){
					voice_play_overlap_proximity(_playvoice.death);
					sfx_pitch(_playvoice.death, random_range(0.9,1.3));
				}
				
				global._pad_vibrate = 5;
				
				_voiceonce = true;
			}
		}
	}
}