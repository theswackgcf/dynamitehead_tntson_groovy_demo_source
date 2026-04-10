function scr_enemyscript_other(){
	//spawn fade
	if(_startFade){
		if(!_fadeInit){
			_fadeCol = [0,0,0];
			_fadeInit = true;
		}
		if(!_doFade){
			for(var i = 0; i < 3; i++){
				_fadeCol[i] = lerp(_fadeCol[i],_fadeTo[i], 0.04);
			}
			if(diff(_fadeCol[0],_fadeTo[0]) < 6){
				for(var i = 0; i < 3; i++){
					_fadeCol[i] = _fadeTo[i];
				}
				_doFade = true;
			}
		}
	} else {
		if(!_doFade){
			for(var i = 0; i < 3; i++){
				_fadeCol[i] = _fadeTo[i];
			}
			_doFade = true;
		}
	}
	
	if(_immunetimer > 0){
		_immunetimer --;
	}
	
	//combo hit
	if(_combohit_timer > 0){
		_combohit_timer --;
	} else {
		_combohit = 1;
	}
	
	//move in only one direction for a period of time
	if(_onlydir_timer > 0){
		_onlydir_timer --;
	} else {
		_onlydir = [false,false];
	}
	
	if(_behaviortype == "hopping" || _falling){
		_onlydir_timer = 0;
	}
	
	if(_onlydir[0]){
		var point = _startpos[1];
		if(_curstate == STATE_FOLLOW){
			var dh = instance_nearest(x,y,obj_dh_mask);
			if(instance_exists(dh)){
				point = dh.y;
			}
		}
		_pathpoint[1] = point;
		_walkto[1] = point;
		_walktopos[1] = point;
	}
	if(_onlydir[1]){
		var point = _startpos[0];
		if(_curstate == STATE_FOLLOW){
			var dh = instance_nearest(x,y,obj_dh_mask);
			if(instance_exists(dh)){
				point = dh.x;
			}
		}
		_pathpoint[0] = point;
		_walkto[0] = point;
		_walktopos[0] = point;
	}
	
	//fall from above
	if(_startTimer <= 0 && _fallabove){
		clearpath();
		_curspd = [0,0];
		if(_height <= _groundlevel){
			var info = [
				[64, 1],
				[128, 0.8],
				[192, 0.7],
				[256, 0.5],
			];
			for(var i = 0; i < 4; i++){
				var im = instance_create_depth(x, y-info[i][0], depth+32, obj_enm_afterIM);
				im.sprite_index = asset_get_index("spr_"+string(_codename)+"_"+"standup");
				im.image_index = _displayobj.image_index;
				im.image_xscale = _displayobj.image_xscale;
				im.image_yscale = _displayobj.image_yscale;
				im._alpha = info[i][1];
			}
		
			with(obj_camera){
				_ampY = 22;
			}
		
			//particles
			for(var i = 0; i < 2; i++){
				var p = instance_create_depth(x-42, y+32, depth, obj_particle);
				p._move = true;
				if(i == 0){
					p._type = "run4";
					p._xspd = -14;
				} else if(i == 1){
					p._type = "run5";
					p._xspd = 14;
				}
			}
		
			sfx_play_choose_proximity([snd_heavythud1,snd_heavythud2]);
		
			_height = _groundlevel;
			_jump = false;
			_standup = false;
			_fallabove = false;
		}
	}
	
	//fall float and parachute
	if(_fallfloat && (_height <= (_groundlevel+_fallfloat_offset) || (!_standup && (_falling || _fall_ko)))){
		remove_trait(TRAIT_SPOT);
		
		_height = _groundlevel;
		_dispoffset[0] = 0;
		
		if(_parachute){
			sfx_play_proximity(snd_parachute, 0.7);
			instance_create_depth(x,y-330,depth,obj_parachute);
		}
		
		sfx_play_choose_proximity([asset_get_index("snd_land1_"+_floortype),asset_get_index("snd_land2_"+_floortype)]);
		
		_fallfloat = false;
	}
	if(!_fallfloat){ 
		_parachute = false; 
		_shadowoffset[0] = 0;
	}
	
	//floor sounds
	if(place_meeting(x,y,obj_floor)){
		var _floor = instance_place(x,y,obj_floor);
		if(_floor != noone && instance_exists(_floor) && _floor._floortype != ""){
			_floortype = _floor._floortype;
		}
	} else {
		_floortype = _deffloortype;
	}
	
	if(_sequence_finished){
		if(_interest > 0){
			_interest --;
		} else if(_interest < 0){
			_interest = 0;
		}
	}
			
	if(_state_cooldown > 0){
		_state_cooldown --;
	} else if(_state_cooldown < 0){
		_state_cooldown = 0;
	}
				
	if(_hurttimer > 0){
		_hurttimer --;
					
		_attack = false;
					
		if(_curstate != STATE_OTHER){
			_curstate = STATE_OTHER;
		}
					
		clearpath();
	} else {
		_hurttimer = 0;
		if(_curstate == STATE_OTHER){
			_curstate = STATE_IDLE;
		}
	}
	
	if(_dodgetimer > 0){
		_dodgetimer --;
		
		_attack = false;
		
		if(_curstate != STATE_OTHER){
			_curstate = STATE_OTHER
		}
					
		clearpath();
	} else {
		_dodgetimer = 0;
		if(_curstate == STATE_OTHER){
			_curstate = STATE_IDLE;
		}
	}
	
	if(_dodge_trait[0]){
		with(_hitobj){
			if(place_meeting(x,y,obj_punchhitbox)){
				var hbox = instance_place(x,y,obj_punchhitbox);
				if(instance_exists(hbox)){
					if(hbox._ptype == "pl" && hbox._type == "crouch"){
						other._atkallowed = [ATK_NORM,ATK_KO];
						other._dodgezones = other._dodgezones_start;
						other._block_endzones = other._block_endzones_start;
						other._dodge_trait[1] = 0;
						other._immunetimer = 0;
						other._stunlock_dodge = false;
						other._curstate = STATE_IDLE;
						other._height = other._groundlevel;
						add_trait([TRAIT_HURT,TRAIT_DODGE,TRAIT_FALLSTUN],other);
					}
				}
			}
		}
		
		_afterim_active = 3;
		_dodge_trait[1] --;
		remove_trait([TRAIT_HURT,TRAIT_FALLSTUN,TRAIT_DODGE]);
		
		_curspd = [0,0];
		clearpath();
		
		if(_dodge_trait[1] <= 0){
			add_trait([TRAIT_HURT,TRAIT_DODGE,TRAIT_FALLSTUN]);
			_dodge_trait[0] = false;
		}
	}
	
	if(!_attack){
		_attackhb = false;
	}
	
	if(_jabstop > 0){
		_jabstop --;
	}
	
	if(!_grabbed && !_slam){
		if(_stuntimer > 0){
			if(!_falling && !_fall_ko && !_standup){
				_stuntimer --;
			}
		} else {
			if(_stun){
				if(_stunact == 0){
					_stunact = 1;
					_stuntimer = 50;
					if(_height <= _groundlevel && !_fall_ko && _hurttimer == 0){
						_stunanim = false;
						if(_playvoice.headshake != -1){
							sfx_play_proximity(_playvoice.headshake);
						}
					}
				} else if(_stunact > 0){
					_stunanim = false;
					_stun = false;
					_stunact = 0;
					_stuntimer = 0;
					_stunpunch = 0;
				}
			}
		}
	}
	
	if(_stunact > 0){
		if(_grabbed || _falling || _hurttimer > 0){
			_stun = false;
			_stunact = 0;
			_stuntimer = 0;
			_stunpunch = 0;
		}
	}
			
	if(_hurt_combotime > 0){
		_hurt_combotime --;
	} else {
		_hurt_combotime = 0;
		_hurts = 0;
	}
				
	if(_hitadd_time > 0){
		_hitadd_time --;
	} else {
		_hitadd = 0;
	}
				
	if(_fallcd > 0){
		_fallcd --;
	}
				
	if(_dh_atk > 0){
		_dh_atk --;
	}
	if(_dh_atk <= 0){
		_dh_atk_inst = noone;
	}
	
	if(_dh_atk_taunt > 0){
		_dh_atk_taunt --;
	}
	if(_dh_atk_taunt <= 0){
		_dh_atk_taunt_inst = noone;
	}
	
	if(_pissedoff > 0){
		_pissedoff_icontimer ++;
		_pissedoff --;
	} else {
		_pissedoff_icontimer = 0;
	}
	
	if(_curatktimer > 0){
		_curatktimer --;
	} else {
		_curatktimer = 0;
		_curatk = 0;
	}
				
	if(_taunt > 0){
		_taunt --;
	}
	
	if(_spottimer > 0){
		_spottimer --;
	}
	if(_spottimer <= 0){
		_spotwalk = false;
	}
	if(_fastwalk > 0){
		_fastwalk --;
	}
	
	if(_blocktimer > 0){
		_attack = false;
		_blocktimer --;
	}
	
	if(_blockfailcooldown > 0){
		_blockfailcooldown --;
	}
	
	if(_mashblock > 0){
		_mashblock --;
	}
	if(_blocktimer > 0 || _attack || _falling){
		_mashed = false;
	}
	if(_mashedobj != noone && instance_exists(_mashedobj)){
		if(_mashedobj._mashact == 0){
			_mashed = false;
			_mashedobj = noone;
		}
	}
	
	if(_blockko_timer > 0){
		_blockko_timer --;
	}
	
	if(_crouchkicktime > 0){
		_crouchkicktime --;
	}
	
	if(_grabattempt > 0){
		_grabattempt --;
	}
	
	if(_freeze <= 0){
		if(_ko_cooldown > 0){
			_ko_cooldown --;
		}
		
		if(_curstate != STATE_JUMP){
			if(_hop_quiet > 0){
				_hop_quiet --;
			}
		}
		
		if(_curstate == STATE_SLIDE){
			_taunt = 0;
		}
		
		if(!_falling && _slide_lookatdh > 0){
			if(_slidespd <> 0){
				_slide_lookatdh = 0;
			}
			var dh = instance_nearest(x,y,obj_dh_mask){
				if(dh.x < x){
					_curdir = DIR_L;
				} else if(dh.x > x){
					_curdir = DIR_R;
				}
			}
			_slide_lookatdh --;
		}
		
		if(_blockcd > 0){
			_blockcd --;
		}
		
		if(_panictimer > 0){
			_panictimer --;
		} else {
			_panicspot = [x,y];
		}
		
		if(_downhurt > 0){
			_downhurt --;
		}
		
		if(_stunlock_timer > 0){
			_stunlock_timer --;
		}
		if(!_falling && !_grabfall && !_fall_ko && !_standup && _stunlock_after > 0){
			_stunlock_after --;
		}
		
		if(_boss){
			if(_ease_kd_timer > 0){
				_ease_kd_timer --;
			} else {
				_ease_kd = 0;
			}
		}
		if(_specialatk > 0){
			_specialatk --;
		}
		if(_aftermash > 0){
			_aftermash --;
		}
	}
	
	if(_afterhop > 0){
		_hop_walk = false;
		_afterhop --;
	}
	
	if(_hop_cooldownthing > 0){
		_hop_cooldownthing --;
	}
	
	if(_dmgcoold > 0){
		if(!_falling){
			_dmgcoold --;
		}
	} else if(_dmgcoold < 0){
		_dmgcoold = 0;
	}
	
	if(_ckick_cd > 0){
		_ckick_cd --;
	}
	
	if(_scrcleartimer > 0){
		if(_scrclear){
			_freeze = 5;
			_shockwave = true;
		}
		_scrcleartimer --;
	} else {
		if(_scrclear){
			_shockwave = false;
			if(!_boss || (_boss && _phaseend_act == 0)){
				with(obj_camera){
					_ampX = 16;
					_ampY = 16;
				}
			
				global._pad_vibrate = 4;
			
				sfx_stop_array(global._kdsounds);
				sfx_play_choose(global._kdsounds);
				_curspd = [0,0];
				_jump = true;
				_falldir = choose(DIR_L,DIR_R);
				_fallxspd_offset = random_range(-3.2,3.2);
				_falling = true;
				_fixwall = true;
				_freeze = 35;
			}
			_scrclearend = true;
			
			_scrclear = false;
		}
	}
	
	if(_height <= _groundlevel){
		_init_fallxspd = 0;
	}
	
	if(_mashed && place_meeting_array(x,y,_collide_enemy)){
		var enm = place_meeting_array(x,y,_collide_enemy, true);
		if(instance_exists(enm) && variable_instance_exists(enm, "_mashed")){
			if(enm.id != self.id && enm._mashed){
				_mashed = false;
				_mashedobj = noone;
			}
		}
	}
	
	if(_shockwave){
		_fallxspd = 0;
		_fallyspd = 0;
		_curspd = [0,0];
		clearpath();
		_jumpingtimer = 0;
		_stuntimer = 0;
		_stunpunch = 0;
	}
	
	//after images
	if(_hurttimer <= 0 && !_falling && !_fall_ko && !_standup && !_grabbed){
		var animstop = ["idle","dodge","walk"];
		if(!array_contains(animstop,_anim)){
			if(_afterim_active > 0){
				_afterim_active --;
		
				_afterim_timer ++;
				if(_afterim_timer >= 12){
					var im = instance_create_depth(x, y+_height+_hop_arc, depth+32, obj_enm_afterIM);
					im.sprite_index = _displayobj.sprite_index;
					im.image_index = _displayobj.image_index;
					im.image_xscale = _displayobj.image_xscale;
					im.image_yscale = _displayobj.image_yscale;
					im.image_blend = c_purple;
					im._alpha = 0.7;
					im._decaytime = 0.02;
									
					_afterim_timer = 0;
				}
			} else {
				_afterim_timer = 999;
			}
		}
	}
				
	//hp
	_displayhp = _displayhp + (_hp - _displayhp) * 0.12;
}