function scr_player_other(){
	//sfx
	if(_sfx[? snd_tnt_pull] && _anim != "blowup"){
		_sfx[? snd_tnt_pull] = false;
	}
	if(_sfx[? snd_tnt_push] && _anim != "blowup"){
		_sfx[? snd_tnt_push] = false;
	}
	
	//combo cooldown
	if(_onecombocd > 0){
		_onecombocd --;
	} else if(_onecombocd < 0){
		_onecombocd = 0;
	}
		
	//freezing effect
	if(_freeze > 0){
		_speed = 0;
		_freeze -= 1;
	} else if(_freeze < 0){
		_freeze = 0;
	}
	if(_freeze == 0 && _speed == 0){
		_speed = 1;
	}
	
	if(_force_freeze > 0){
		_freeze = _force_freeze;
		_force_freeze --;
	}
	
	if(_stopwalk > 0){
		_stopwalk --;
	} else {
		_stopwalk = 0;
	}
			
	if(_hp <= 10){
		//low on hp
		_lowhp = true;
	} else {
		_lowhp = false;
	}
	
	if(_dmgcoold > 0){
		if(!_falling){
			_dmgcoold --;
		}
	} else if(_dmgcoold < 0){
		_dmgcoold = 0;
	}
		
	//push when hit
	if(_push){
		if(_hurtbox != noone){
			if(instance_exists(_hurtbox)){
				if(!_falling){
					_curdir = -_hurtbox._curdir
					
					if(_hurtbox._curdir == DIR_R){
						if(!place_meeting_array(x + 12, y, global._solidArray) && !place_meeting(x + 12, y, obj_battleborder)){
							x += 8;
						}
					} else if(_hurtbox._curdir == DIR_L){
						if(!place_meeting_array(x - 12, y, global._solidArray) && !place_meeting(x - 12, y, obj_battleborder)){
							x -= 8;
						}
					}
				}
			} else {
				_curdir = choose(DIR_L,DIR_R);
				_curdir_prev = _curdir;
				if(_curdir == DIR_L){
					if(!place_meeting_array(x + 12, y, global._solidArray) && !place_meeting(x + 12, y, obj_battleborder)){
						x += 8;
					}
				} else if(_curdir == DIR_R){
					if(!place_meeting_array(x - 12, y, global._solidArray) && !place_meeting(x - 12, y, obj_battleborder)){
						x -= 8;
					}
				}
			}
		}
		_hurtbox = noone;
		_push = false;
	}
		
	if(_damageTimer > 0){
		_damageTimer --;
	} else if(_damageTimer < 0){
		_damageTimer = 0;
	}
			
	if(_noAtkTimer > 0){
		_noAtkTimer --;
	} else if(_noAtkTimer < 0){
		_noAtkTimer = 0;
	}
		
	if(_damageTimer == 0){
		_damage = 0;
	}

	if(_hurtTimer > 0){
		_stopwalk = 3;
		
		_finalcombo = false;
		_hurtTimer -= _speed;
	} else if(_hurtTimer < 0){
		_hurtTimer = 0;
	}
			
	if(_hittimer > 0){
		_hittimer --;
	} else {
		_hittimer = 0;
		_hits = 0;
	}
	
	if(_combotimer > 0){
		_combotimer --;
	} else {
		_combo = 0;
	}
	
	if(_occupycenter > 0){
		_occupycenter --;
	}
	
	if(_hurtTimer < 2 && _hp <= 0){
		//dieing
		global._deathZoom = global._defCamZoom;
		if(global._cursong != -1){
			global._saveMusPos = audio_sound_get_track_position(global._cursong);
		}
		mus_stop();
		global._knockouts ++;
		room_goto(r_dead);
	}
	
	if(!_falling && _hurtTimer == 0){
		_hitobj._once = false;
	}

	//one combo
	if(_ocombotimer > 0){
		_ocombotimer -= _speed;
	} else if(_ocombotimer < 0){
		_ocombotimer = 0;
	}
	if(_ocombotimer == 0){
		_onecombo = 0;
	}
	
	//detect walking for long jump
	if((_state == "default" || _state == "jump") && !_falling){
		if(_height <= _groundlevel){
			if(_spd[0] == 0){
				_walking = false;
			} else {
				_walking = true;
			}
		}
	} else {
		_walking = false;
	}

	var runsound = asset_get_index("snd_run_"+_floortype);

	//looping sounds & particles
	if(_skidtimer <= 0){
		_skidsound = false;
	}
	if(_mashact == 0){
		if(sfx_isplaying(snd_mashbg)){
			sfx_stop(snd_mashbg);
		}
	}
	if(_state == "default" && !_attack && !_falling){
		if(_running){
			_runroll_dive_timer = 0;
			_runroll_dive = false;
			_runroll_slide = false;
			_height = _groundlevel;
			
			if(_skidtimer > 0){
				if(!audio_is_playing(snd_skid)){
					if(!_skidsound){
						_skidsound = true;
						sfx_play(snd_skid);
					}
				}
				sfx_stop(runsound);
			} else {
				if((abs(_spd[0]) >= _maxspd[0]/4 || abs(_spd[1]) >= _maxspd[1]/4)){
					if(!sfx_isplaying(runsound)){
						sfx_play(runsound);
						sfx_pitch(runsound, random_range(0.7, 1.22));
					}
					_runparticle ++;
					if(_runparticle % 8 == 2){
						var pos = -70;
						var curpos = pos*_curdir;
						var p = instance_create_depth((x-100)+curpos, y+60, 0, obj_particle);
						if(_runparticle % 8 == 7){
							p = instance_create_depth((x-100)+curpos, y+25, 0, obj_particle);
						}
						p._type = "run"+string(round(random_range(4,5)));
						p._move = true;
						var vel = 10;
						var curvel = vel*-_curdir;
						p._xspd = curvel;
						p._yspd = 0;
					}
					if(_runparticle % 6 == 3){
						var pos = -70
						var curpos = pos*_curdir;
						var p = instance_create_depth((x-100)+curpos, y+30, 0, obj_particle);
						p._type = "run"+string(round(random_range(1,3)));
						p._move = true;
						var vel = 9;
						var curvel = vel*_curdir;
						p._xspd = curvel;
						p._yspd = random_range(-5,5);
					}
					
					_afterrun_timer = 45;
				}
				sfx_stop(snd_skid);
			}
		} else {
			_runparticle = 0;
			_skidparticle = 0;
			sfx_stop(runsound);
			sfx_stop(snd_skid);
		}
	} else {
		_runparticle = 0;
		_skidparticle = 0;
		sfx_stop(runsound);
		sfx_stop(snd_skid);
	}
	
	if(_nodive_timer > 0 && _state != "nomove"){
		_nodive_timer --;
	}
	
	if(_shield){
		if(!audio_is_playing(snd_shieldaura)){
			sfx_play(snd_shieldaura);
		}
	} else {
		sfx_stop(snd_shieldaura);
	}
	
	if(_freeze > 0){
		sfx_stop(runsound);
		sfx_stop(snd_skid);
		sfx_stop(snd_shieldaura);
	}

	//max speed
	_maxspd = [_initspeed,_initspeed];
	if(_running && !_runroll){
		if((keyhold("left") || keyhold("right")) && !(keyhold("left") && keyhold("right"))){
			_runtimer = 8;
		}
		if((keyhold("up") || keyhold("down")) && !(keyhold("up") && keyhold("down"))){
			_runtimer = 8;
		}
		
		if(_spd[1] <= 3 && _curdir_prev != _curdir){
			//skids
			_skidtimer = 12;
			_curdir_prev = _curdir;
		}
			
		_maxspd = [17,17];
	}
	if(_state == "item"){
		_maxspd[0] *= _grabweight;
		_maxspd[1] *= _grabweight;
	}
	
	//grab stuff
	if(_grabhold_enemy_timer > 0){
		_grabhold_enemy_timer --;
	} else {
		_grabhold_downfail = false;
		if(_grabhold_enemy != noone){
			_grabhold_enemy = noone;
		}
	}
	
	if(_grabhold_other_timer > 0){
		_grabhold_other_timer --;
	} else {
		if(_grabhold_other != noone){
			_grabhold_other = noone;
		}
	}

	if(_runtimer > 0){
		_rundist ++;
		_runtimer --;
	} else if(_runtimer < 0){
		_rundist = 0;
		_runtimer = 0;
	}
	if(_skidtimer > 0){
		_skidtimer --;
	} else if(_skidtimer < 0){
		_skidtimer = 0;
	}
	if(_runtimer == 0){
		_skidtimer = 0;
		_runkeys = [];
		_runs = 0;
	}
	if(_spd[1] >= 3){
		_skidtimer = 0;
	}
		
	//shockwave
	if(_state == "shockwave"){
		_shockwave --;
		_spd[0] = clamp(_spd[0],-4,4);
		_spd[1] = clamp(_spd[1],-4,4);
		if(_shockwave <= 0){
			_state = "default";
		}
		_displayobj._ampY = 12;
	}
			
	//zapped
	if(_state == "zapped"){
		_zaptime --;
		if(_zaptime % 5 == 0){
			_hp -= 1;
			with(obj_gui){
				ui_fade("dh", 1);
			}
		}
		_spd = [0,0];
		if(_zaptime <= 0){
			_invframe = _invmax;
			_state = "default";
		}
	}
			
	if(_state == "nomove"){
		_spd = [0,0];
	}

	if(_fastcrouch > 0){
		_anim_prev = _anim;
		_anim = "crouch";
		_height = _groundlevel
		_fastcrouch --;
	}
	if(_state != "default" && _state != "crouch"){
		_fastcrouch = 0;
	}
	if(_spd[0] <> 0 || _spd[1] <> 0 || !keyhold("crouch") || _attack){
		_fastcrouch = 0;
	}
	
	if(_crouch){
		_crouchtimer ++;
	} else {
		_crouchtimer = 0;
	}
		
	if(_doWin){
		_crouch = false;
		_slide = false;
		_state = "win";
	}
			
	//idling
	if(_doWin){
		_idletimer = 0;
	}
	if((_anim == "idle" || _anim == "idle_lowhp") && !_stopspd && !_doWin){
		_idletimer ++;
		if(_idletimer >= random_range(180, 320)){
			_displayobj.image_index = 0;
			if(_idles < round(random_range(3,4))){
				//regular idle
				_idleanim[0] = true;
			} else {
				//voice idle
				_idleanim[1] = true;
				voice_play_choose([snd_dh_voice_idle1,snd_dh_voice_idle2,snd_dh_voice_idle3,snd_dh_voice_idle4,snd_dh_voice_idle5,snd_dh_voice_idle6],global._dhvoices,1);
			}
			_idles ++
		}
	} else {
		_idletimer = 0;
	}
	if(_anim != "idle" && _anim != "idle_lowhp" && _anim != "idling1" && _anim != "idling2" && _anim != "idling_lowhp"){
		_idletimer = 0;
		_idles = 0;
		_idleanim = [false,false];
	}
	
	if(_state != "item" && instance_exists(_grabid) && (_grabid._parentobj).id == self.id){
		throw_enemy();
	}
	
	//taunts
	if(!_taunt){
		_tauntloops = 0;
		_sfx[? snd_money2] = false;
	} else {
		_idletimer = 0;
	}
	var tauntanims = ["taunt","tauntside","tauntup","tauntdown","tauntmoney"];
	var total_t = 0;
	for(var t = 0; t < array_length(tauntanims); t++){
		if(_taunt && _anim != tauntanims[t]){
			total_t ++;
		}
	}
	if(_taunt_type != "tauntmoney"){
		if(total_t >= array_length(tauntanims)){
			_taunt = false;
			total_t = 0;
		}
	}
	if(_taunt_type == "tauntmoney"){
		_state = "nomove";
		_curdir = DIR_R;
		_spd = [0,0];
		
		if(_taunt && !_anim_transition && _displayobj.image_index >= 1 && !_sfx[? snd_money2]){
			sfx_stop(snd_money1);
			sfx_play(snd_money2);
						
			_sfx[? snd_money2] = true;
		}
	}
	if(_spd[0] <> 0 || _spd[1] <> 0 || _state != "default" || _doWin){
		if(_taunt_type != "tauntmoney"){
			_taunt = false;
		}
	}
	
	//invinciblity frames
	if(_invframe > 0){
		_invframe --;
		_invalpha = clamp(sin(_invframe/2.5)*1.7,0,1)
	} else {
		_invalpha = lerp(_invalpha, 1, 0.5);
	}
	
	if(!_slam){
		_slamcount = 0;
		_slambonks = 0;
		for(var i = 0; i < array_length(_slamsounds); i++){
			if(_slamsounds[i][3]){
				_slamsounds[i][3] = false;
			}
		}
	}
		
	if(_freeze <= 0){
		if(_shieldpower > 1){
			_shieldpower = 1;
		} else if(_shieldpower < 0){
			_shieldpower = 0;
		}
		
		if(!_shield && _shieldcd > 0){
			_shieldcd -= _speed;
		}
		
		//shield meter ui
		if(_shieldpower < 1){
			global._ui_shieldMultTo = 1;
			with(obj_gui){
				ui_fade("dh",1);
			}
		} else {
			global._ui_shieldMultTo = 0;
		}
		
		if(!_dead && !_falling && !_jumpback && _height <= _groundlevel && _stunnedtimer > 0){
			_stunnedtimer -= _speed;
		}
		
		if(_parrytimer > 0){
			_parrytimer -= _speed;
		}
		
		if(_parryzoom > global._defCamZoom){
			_parryzoom -= 0.07;
		} else {
			_parryzoom = global._defCamZoom;
		}
		
		if(_successparry > 0){
			global._cameraZoom = _parryzoom;
			if(_parryenmx <> -999){
				if(x > _parryenmx){
					_curdir = DIR_L;
				} else {
					_curdir = DIR_R;
				}
			}
			_stopspd = true;
			_spd = [0,0];
			_state = "nomove";
			_successparry -= _speed;
		} else {
			_parry_timer --;
			if(_parry_timer <= 0){
				_parry_mult = 1;
			}
			
			_parry_hpheal = false;
			
			_parryenmx = -999;
			if(!_taunt && _state == "nomove"){
				_state = "default";
			}
		}
		
		if(_parry_mult < 0){
			_parry_mult = 0;
		}
		
		if(_downattack > 0){
			_downattack --;
		}
	}
	
	if(_noslidecd > 0){
		_noslidecd --;
	}
	
	if(_slide_cooldown > 0){
		_slide_cooldown --;
	}
	
	if(_jump_enmhit && (_anim == "melee_jump" || _rolljump)){
		_roll_bounceoff = 15;
	}
	
	if(_roll_bounceoff > 0){
		_roll_bounceoff --;
	}
		
	if(global._bigpunch > 0){
		x = lerp(x, _punch_lerpx, 0.22);
		_spd = [0,0];
		_vspd = 0;
		_state = "bigpunch";
		global._bigpunch --;
	} else {
		_bigpunch_amp = 0;
		if(_state == "bigpunch"){
			_state = "default";
		}
	}
	
	//prompts
	if(!global._tutorial){
		if(_enemygrab && !global._gametips[? "grab"][1]){
			global._prompt_desc_show = global._help_prompt_time;
			global._prompt_desc_type = "grab";
			global._gametips[? "grab"][0] = true;
		}
		if((!_enemygrab || _slam) && global._gametips[? "grab"][0]){
			global._gametips[? "grab"][1] = true;
		}
	
		if(_dead && _stunnedtimer <= 0 && !global._gametips[? "jumpback"][1]){
			global._prompt_desc_show = global._help_prompt_time;
			global._prompt_desc_type = "jumpback";
			global._gametips[? "jumpback"][0] = true;
		}
		if(_jumpback && global._gametips[? "jumpback"][0] && keyhold("jump")){
			global._gametips[? "jumpback"][1] = true;
		}
	
		if(_runroll && !global._gametips[? "roll"][1]){
			global._prompt_desc_show = global._help_prompt_time;
			global._prompt_desc_type = "roll";
			global._gametips[? "roll"][0] = true;
		}
		if(((_runroll && keypress("jump")) || _runroll_dive) && global._gametips[? "roll"][0]){
			global._gametips[? "roll"][1] = true;
		}
	}
}