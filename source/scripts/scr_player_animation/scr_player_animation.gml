function scr_player_animation(){
	if(_hurtTimer == 0){
		if(!_enemygrab){
			if(_spd[0] == 0 && _spd[1] == 0){
				if(_skidtimer <= 0){
					if(_state == "default" && !_jump && _begin){
						_anim_prev = _anim;
						_anim = "idle";
						if(_lowhp){
							_anim = "idle_lowhp";
						}
						if(_idleanim[0]){
							_anim = "idling1";
						} else if(_idleanim[1]){
							_anim = "idling2";
						}
						if(_idleanim[0] || _idleanim[1]){
							if(_lowhp){
								_idles = 0;
								_anim = "idling_lowhp";
							}
							if(_displayobj.image_index >= _displayobj.image_number-1){
								if(_idleanim[1]){
									_idles = 0;
								}
								_idletimer = 0;
								_idleanim = [false,false];
							}
						}
						if(_taunt){
							_anim = _taunt_type;
						}
					}
					if(_taunt && _taunt_type == "tauntmoney"){
						_anim = _taunt_type;
					}
				}
			} else {
				if(_state == "default"){
					if(!_running){
						_anim_prev = _anim;
						_anim = "walk";
					} else {
						if(_skidtimer > 0){
							_anim_prev = _anim;
							_anim = "skid";
						} else {
							_anim_prev = _anim;
							_anim = "run";
						}
					}
				}
			}
			
			if(_shield){
				_anim_prev = _anim;
				_anim = "block";
				if(_height > _groundlevel){
					_anim_prev = _anim;
					_anim = "block_air";
				}
			}
			if(_stunnedtimer > 0){
				_anim_prev = _anim;
				_anim = "stunned";
				if(_stunnedtimer < 15){
					_anim_prev = _anim;
					_anim = "shakeoff";
					if(!_dead && !_jumpback && !_shakeoff){
						_shakeoff = true;
						sfx_play(snd_headshake);
					}
				}
			}
		} else {
			if(_spd[0] == 0 && _spd[1] == 0){
				_anim_prev = _anim;
				_anim = "pick_idle";
			} else {
				_anim_prev = _anim;
				_anim = "pick_walk";
			}
			if(_slam){
				_anim_prev = _anim;
				_anim = "slam";
				if(_grabinst != noone && instance_exists(_grabinst)){
					_slamspd = clamp((_grabinst._ailevel/5)+(_slamcount*0.2),0.8,3.4);
				}
			}
		}
		if(_grabfail && _grabfailact > 0){
			_anim = "grab_fail";
		}
		if(!_shield){
			if(_height > _groundlevel && _jump){
				if(!_walking){
					if(_vspd > 0){
						_anim_prev = _anim;
						_anim = "jump_loop";
					} else {
						_anim_prev = _anim;
						_anim = "fall_loop";
					}
				} else {
					_anim_prev = _anim;
					_anim = "longjump";
				}
				if(_rolljump){
					_anim = "runroll";
				}
			}
		}
		
		if(_grab){
			_grabtimer += 1;
			_spd = [0,0];
						
			_anim_prev = _anim;
			if(!_grabdown){
				_anim = "grab";
			} else {
				_anim = "grabdown";
			}
						
			if(_displayobj.image_index >= _displayobj.image_number-1){
				_grabdown = false;
				_grab = false;
			}
		} else {
			if(_enemygrab){
				_grabtimer += 1;
			} else {
				_grabtimer = 0;
			}
		}
		if(_throw){
			_spd = [0,0];
						
			_anim_prev = _anim;
			_anim = "throw";
						
			if(_displayobj.image_index >= _displayobj.image_number-1){
				_throw = false;
			}
		}
		if(_nojump > 0){
			_anim_prev = _anim;
			_anim = "air_ground";
		}
		if(_state == "item"){
			if(_itemanim <> 2){
				_spd = [0,0];
			}
			if(_itemanim == 0){
				_anim_prev = _anim;
				_anim = "pickup";
				if(_moneypickup){
					_curdir = DIR_L;
				}
			}
			if(_itemanim == 1){
				_iteminst._trigger = true;
				_iteminst.visible = false;
				
				_anim_prev = _anim;
				_anim = "blowup";
				
				if(_displayobj.image_index >= 0 && !_sfx[? snd_tnt_pull]){
					sfx_play(snd_tnt_pull, 0.4);
					_sfx[? snd_tnt_pull] = true;
				}
				if(_displayobj.image_index >= 6 && !_sfx[? snd_tnt_push]){
					sfx_play(snd_tnt_push, 0.8);
					_sfx[? snd_tnt_push] = true;
				}
			}
			if(_displayobj.image_index >=_displayobj.image_number-1){
				if(_itemanim <> 2){
					if(_itemanim == 0 && !_moneypickup){
						var p = instance_create_depth(_iteminst.x, _iteminst.y-72, depth, obj_particle);
						p._color = _iteminst._color;
						p._type = "item";
									
						var sp = instance_create_depth(_iteminst.x, _iteminst.y-210, depth, obj_splash);
						sp.sprite_index = asset_get_index("spr_splash_item"+string(_iteminst._item));
									
						sfx_play(snd_item, 0.6);
						
						var num = instance_create_depth(x, y - 220, 0, obj_nums);
						switch(_iteminst._restore_type){
							case 0:
								//HP
								num._num = _lastpickuphprestore;
								num._plus = true;
							break;
							case 1:
								//TNT
								num._num = _iteminst._restore;
								num._plus = true;
								num._tnt = true;
							break;
						}
						
						global._deletedStuff[? _iteminst.id] = _iteminst.id;
						instance_destroy(_iteminst.id);
					}
					if(_itemanim == 1){
						var instance = _iteminst._itembox;
						if(instance._trigger == 0){
							instance._trigger = 1;
						}
					}
					_pickup = false;
					if(_moneypickup){
						_displayobj.image_index = 0;
						_curdir = DIR_L;
						_taunt = true;
						_taunt_type = "tauntmoney";
						_moneypickup = false;
						_moneypickup_inst._picked = true;
						
						_nodive_timer = 90;
						
						_state = "nomove";
					} else {
						_state = "default";
					}
				}
			}
		}
		if(_state == "shockwave"){
			_anim_prev = _anim;
			_anim = "shockwave";
						
			_pickup = false;
			if(_iteminst != noone && instance_exists(_iteminst) && !_iteminst.visible){
				_iteminst._trigger = false;
				_iteminst.visible = true;
			}
		}
		if(_state == "zapped"){
			_anim_prev = _anim;
			_anim = "zapped";
		}
	} else {
		//hurt
		if(_attack){
			_hurtTimer = 0;
		}
		_anim_prev = _anim;
		if(!global._tutorial){
			_anim = "hurt"+string(_randhurt);
		} else {
			_anim = "chew";
		}
	}
	
	if(_mashact == 1){
		_anim_prev = "mash1";
		_anim = "mash1";
	} else if(_mashact == 2){
		_anim_prev = "mash2";
		_anim = "mash2";
	}
	
	if(!_attack && _hurtTimer <= 0){
		if(_crouch){
			_anim_prev = _anim;
			_anim = "crouch";
			if(_slide){
				if(_spd[0] > 0){
					_curdir = DIR_R;
				} else if(_spd[0] < 0){
					_curdir = DIR_L;
				}
				_anim_prev = _anim;
				_anim = "runhit";
			}
			_hitobj._curscale = 1;
		}
		if(_runroll){
			_anim_prev = _anim;
			_anim = "runroll";
			if(_runroll_dive){
				_anim_prev = _anim;
				_anim = "dive";
				if(_shield){
					_anim_prev = _anim;
					_anim = "block_air";
				}
			}
		}
	}
	if(_falling){
		_anim_prev = _anim;
		_anim = "fall";
	}
	if(_dead){
		_anim_prev = _anim;
		_anim = "dead";
	}
	if(_jumpback && !_attack){
		_anim_prev = _anim;
		_anim = "standup";
	}
	if(_afterslam){
		_anim = "afterslam";
	}
	if(_state == "tnt"){
		_anim_prev = _anim;
		_anim = "tnt";
		
		_animloop[? "tnt"] = _displayobj.image_number-5;
	}
	
	if(_successparry > 0){
		_anim = "parry";
		_displayobj.image_index = _parryframe;
	}
				
	if(!_begin){
		with(_displayobj){
			_forcedepth = -6600;
		}
		_anim = "intro3";
	}
	
	_dispoffset = [0,0];
	if(_successparry > 0){
		_dispoffset = [random_range(-10,10),0];
	}
	
	if(_bigpunch_amp > 0){
		_bigpunch_amp--;
	} else {
		_bigpunch_amp = 0;
	}
	
	
	//animation loops
	if(_displayobj != noone && instance_exists(_displayobj)){
		if(_displayobj.image_index >= _displayobj.image_number-1){
			if(ds_map_exists(_animloop, _anim)){
				if(_taunt){
					_tauntloops ++;
					var tauntmax = 3;
					if(_taunt_type == "tauntdown"){
						tauntmax = 5;
					}
					if(_taunt_type == "tauntmoney"){
						tauntmax = 4;
					}
					if(_tauntloops >= tauntmax){
						if(_taunt_type == "tauntmoney"){
							if(_moneypickup_inst != noone && instance_exists(_moneypickup_inst)){
								var num = instance_create_depth(x, y - 220, 0, obj_nums);
								num._num = _moneypickup_inst._amount;
								global._moneypickups.cur += 1;
								array_push(global._plusmoney.cur,_moneypickup_inst._amount);
								num._plus = true;
								num._money = true;
								
								global._musFade = 1;
								
								sfx_play(snd_cash);
								voice_play_choose([snd_dh_voice_win1,snd_dh_voice_win2,snd_dh_voice_win3,snd_dh_voice_win4,snd_dh_voice_win5], global._dhvoices, 1);
								
								instance_destroy(_moneypickup_inst);
								_moneypickup_inst = false;
							}
							_state = "default";
						}
						_taunt = false;
					}
				}
				_displayobj.image_index = _animloop[? _anim];
			}
		}
	}
}