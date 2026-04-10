function scr_enemyscript_falling(){
	if(_stunlock_dodge && _height <= _groundlevel){
		sfx_play_choose_proximity([snd_thud,snd_thud2,snd_thud3,snd_thud4]);
		
		with(obj_camera){
			_ampY = 18;
		}
		
		_stunlock_dodge = false;
	}
	
	//falling
	if(_falling){
		_curstate = STATE_FALL;
		_pointtime = 0;
		_pathpoint = [_walkto[0],_walkto[1]];
		_attack = false;
		_hurttimer = 0;
		
		if(_tempdir != 0){
			_curdir = _tempdir;
		}
		
		clearpath();
		_curspd = [0,0];
		
		_blockcount = 0;
		
		if(_grabfall){
			_spdmode = SPD_GRABFALL;
		} else {
			_spdmode = SPD_FALL;
		}
				
		if(_falls < 2){
			_ko_done = true;
		}
		
		if(_downhurt > 0){
			_kickeddown = true;
		}
		
		_deathoffset = [0,0];
		
		_jumpingtimer = 0;
		
		if(has_trait(TRAIT_FALLSTUN) && (_anim == "fall" || _anim == "fall_stun")){
			if(!_stunanim){
				//set stun when knocked
				if(_stuntimer <= 0){
					_stun = true;
					_stunact = 0;
					_stuntimer = scr_ailevel(45, random_range(_stunrange[0],_stunrange[1]));
				}
			} else {
				//if knocked again, reset stun
				_stuntimer = 0;
				_stun = false;
				_stunact = 0;
			}	
		}
				
		//wall jam fix
		var yto = y;
		if(place_meeting_array(x, y-48, _collide_solid) || place_meeting_array(x, y-48, _collide_other)){
			yto = y+48;
		}
		if(place_meeting_array(x, y+48, _collide_solid) || place_meeting_array(x, y+48, _collide_other)){
			yto = y-48;
		}
					
		if(place_meeting(x,y,obj_tnt)){
			if(_height <= 64){
				var tnt = instance_place(x,y,obj_tnt);
				if(tnt != noone && instance_exists(tnt)){
					if(tnt.visible && !tnt._trigger){
						var partc = instance_create_depth(_displayobj.x, _displayobj.y-96, 0, obj_particle);
						partc._type = "fx6";
						
						sfx_play_proximity(snd_tnt_push, 0.7);
						tnt._trigger = true;
						tnt._trigger_enm = true;
						
						_vspd = 5.5;
						_freeze = global._freezeFrames.vshort_freeze;
						tnt._freeze = global._freezeFrames.vshort_freeze;
					}
				}
			}
		}
					
		_walkto = [x+(32*_curdir),yto];
		if(_height <= _groundlevel && _fallcd <= 0){
			if(!_death && _smackdown){
				//after-image
				var info = [
					[32, 1],
					[120, 0.8],
					[180, 0.7],
					[290, 0.6],
				];
				for(var i = 0; i < 4; i++){
					var im = instance_create_depth(x, y-info[i][0], depth+32, obj_enm_afterIM);
					im.sprite_index = asset_get_index("spr_"+string(_codename)+"_"+"fall");
					im.image_index = _displayobj.image_index;
					im.image_xscale = _displayobj.image_xscale;
					im.image_yscale = _displayobj.image_yscale;
					im._alpha = info[i][1];
				}
				
				_displayobj.image_index = 0;
				
				with(obj_camera){
					_ampY = 48;
				}
				
				sfx_play_proximity(snd_smackdown);
				sfx_pitch(snd_smackdown,random_range(1,1.16));
				if(_playvoice.smackdown != -1){
					voice_play_overlap_proximity(_playvoice.smackdown);
					sfx_pitch(_playvoice.smackdown,random_range(0.8,0.94));
				}
				_falls = 0;
				_smackdown = false;
			}
			
			if(_grabout){
				//dh gets punched while grabbing an enemy
								
				clearpath();
				_jump = false;
								
				_falling = false;
				_falls = 0;
				_fall_ko = false;
								
				_curstate = STATE_IDLE;
								
				_dodge = false;
				_standup = false;
								
				_grabout = false;
			} else {
				switch(_falls){
					//first bump
					case 0:
						with(obj_camera){
							_ampY = other._shakeamp;
						}
						var pos = 90;
						var partc = instance_create_depth((x-170)+pos, y, 0, obj_particle);
						partc._type = "fx5";
					
						sfx_play_choose_proximity([snd_thud,snd_thud2,snd_thud3,snd_thud4]);
					
						_vspd = 11;
						_jump = true;
						_height = _groundlevel + 8;
						_fallcd = 8;
						_falls ++;
								
						if(_grabfall){
							_kotype = "grabfall";
							_hplastframe = _hp;
							_hp -= 3;
							_grabfall = false;
						}
					break;
					//second bump
					case 1:
						clearpath();
						_jump = false;
						_falling = false;
						_falls = 0;
						if(!_fall_ko){
							_displayobj.image_index = 0;
						}
						_dmgfall = false;
						
						if(_stunlock_after <= 0){
							_fall_ko = true;
							_nocked ++;
						}
						_ko_cooldown = 0;
						_ko_fall = false;
					break;
				}
			}
		}
	}

	function do_stunlock() {
		with(obj_camera){
			_ampX = 18;
		}
			
		sfx_play(snd_stunlock_dodge);
			
		global._pad_vibrate = 10;
			
		_freeze = 32;
		if(_dh_atk_inst != noone && instance_exists(_dh_atk_inst)){
			_dh_atk_inst._freeze = 32;
		}
			
		var p = instance_create_depth(x-64, y-64, 0, obj_particle);
		p._type = "fx_parry";
			
		_stunlock_after = 45;
		_stunlock_pose = irandom_range(0,_stunlock_pose_max-1);
		_stunlock_timer = 0;
		_stunlock_hits = 0;
		_stunlock_dodge = true;
	}

	if(_slam && has_trait(TRAIT_STUNLOCK_DODGE)){
		if(_hp >= _maxhp*0.1 && !_stunlock_dodge && _stunlock_hits >= _stunlock_hits_max){
			if(_dh != noone && instance_exists(_dh)){
				with(_dh){
					force_throw_enemy();
				}
			}
			
			_falling = true;
			_grabfall = false;
			_height += 2;
			if(_height <= _groundlevel + 96){
				_vspd += 10;
			}
		}
	}
	
	if(_falling || _grabfall){
		if(!_fall_ko && !_standup){
			_kotimer = 0;
			_docrouchkick = false;
		}
		
		//dodge completely if stunlocked
		
		if(!_standup){
			_nocrouchatk = false;
		}
		
		if(_behaviortype != "hopping"){
			_jumptopos = [x,y];
		}
		_slidespd = 0;
		
		if(_stunlock_dodge){
			_falls = 1;
			_stunlock_after = 45;
		}
		
		if(has_trait(TRAIT_STUNLOCK_DODGE)){
			if(_phaseend_act == 0){
				if(_hp >= _maxhp*0.1 && !_stunlock_dodge && _stunlock_hits >= _stunlock_hits_max){
					_grabfall = false;
					_height += 2;
					if(_height <= _groundlevel + 96){
						_vspd += 10;
					}
				
					do_stunlock();
				}
			}
		}
	} else {
		if(has_trait(TRAIT_STUNLOCK_DODGE)){
			if(_hp >= _maxhp*0.1 && !_stunlock_dodge && _stunlock_hits >= _stunlock_hits_max){
				_falling = true;
			}
		}
	}
	if(!_falling || (_height >= _groundlevel && _ko_fall)){
		_ko_fall = false;
	}
	
	if(_fall_ko){
		//ko'd
		clearpath();
		_curstate = STATE_OTHER;
		_kotimer ++;
		
		_slidespd = 0;
		_slide = false;
		_fallxspd = 0;
		
		var komax = max(45*_standup_mult,scr_ailevel(8,32)*_standup_mult);
		if(_nocked >= 2){
			_nocked = 0;
			komax = 0;
		}
		if(!_death){
			if(_pissedoff > 0){
				_kotimer = komax;
			}
			if(_kickeddown){
				_kotimer = komax;
				_kickeddown = false;
			}
			if(!_standup && _kotimer >= komax && _height <= _groundlevel){
				_height = _groundlevel+2;
				_kotimer = 0;
				
				_jump = true;
				_vspd = random_range(5,14);
				
				_displayobj.image_index = 0;
				
				_nocked = 0;
				_standup = true;
			}
			if(_standup && _height < _groundlevel){
				//crouch kick attack after landing
				if(has_trait(TRAIT_CROUCHKO)){
					var dh = instance_nearest(x, y, obj_dh_mask);
					if(distance_to_object(dh) <= 320 && _codename != "boss2"){
						_standup = false;
						if(!_dodge){
							if(!_hop_walk && !_nocrouchatk && !_grabbed && !_grabdodge){
								_docrouchkick = true;
							}
						}
						_dodge = false;
					} else {
						_curstate = STATE_WALK;
					}
				} else {
					_curstate = STATE_IDLE;
				}
				
				if(_stuntimer > 0){
					_curdir *= -1;
				}
				if(!_stun){
					_stunanim = false;
				}
				
				_fall_ko = false;
				
				_dodge = false;
				_standup = false;
			}
		} else {
			_jump = true;
			_kotimer = 999;
			if(!_boss){
				if(_failsafedeath >= 250 || (_height <= _groundlevel && !_downkill)){
					//skull and bones
					if(_codename != "fridge"){
						var skull = instance_create_depth(_displayobj.x,_displayobj.y,_displayobj.depth,obj_enemyskull);
						skull._dispoffset[0] = _dispoffset[0];
						skull._dispoffset[1] = _dispoffset[1];
						skull._height = _height;
						skull._groundlevel = _groundlevel;
						skull._vspd = _vspd;
						skull._xscale = _displayobj._xscale;
						skull._codename = _codename;
						skull._maxcolors = _maxcolors;
						skull.image_index = _displayobj.image_index;
						skull.image_angle = _displayobj.image_angle;
				
						skull._difftype = _difftype;
						skull._mult_colorinArray = _mult_colorinArray;
						skull._mult_coloroutArray = _mult_coloroutArray;
						skull._mult_tolrArray = _mult_tolrArray;
						skull._mult_blendArray = _mult_blendArray;
				
						//ghost
						var dnm = instance_create_depth(x-32, y-56, -16, obj_deadenemy);
						dnm._codename = _codename;
				
						var ghostspr = asset_get_index("spr_deadenemy_"+dnm._codename);
						if(sprite_exists(ghostspr)){
							dnm.sprite_index = ghostspr;
						} else {
							var ghostspr = asset_get_index("spr_"+dnm._codename+"_idle");
							if(sprite_exists(ghostspr)){
								dnm.sprite_index = ghostspr;
							} else {
								dnm.sprite_index = spr_deadenemy_st2_enm1;
							}
						}
					}
				
					var p = instance_create_depth(x-42, y-42, 0, obj_particle);
					p._type = "vanish";
					global._deadid = self.id;
				
					if(_battlezone && !_confirmkill){
						global._enmorder ++;
						_confirmkill = true;
					}
				
					killself();
				}
			}
		}
	} else {
		if(_taunt <= 0){
			with(_displayobj){
				_forcedepth = 0;
			}
		}
		_kotimer = 0;
	}
}