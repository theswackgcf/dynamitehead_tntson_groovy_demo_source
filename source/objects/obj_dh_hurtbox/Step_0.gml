{
	//might need to rewrite this
	
	if(!global._pause){
		if(_parentobj != noone){
			x = _parentobj.x + _offset[0];
			y = (_parentobj.y + _offset[1]) - _parentobj._height;
			
			_curdir = _parentobj._curdir;
		}
		image_yscale = _scales[_curscale];
	
		//damage
		if(_parentobj._begin && !_parentobj._dead && !_parentobj._falling && !_parentobj._blowup && !(_parentobj._state == "item" && !instance_exists(_parentobj._grabid)) && !_parentobj._jumpback && _parentobj._mashact == 0 && _parentobj._hurtTimer == 0 && _parentobj._invframe <= 0 && !_once){
			if(place_meeting(x, y, obj_punchhitbox)){
				var hurtbox = instance_place(x, y, obj_punchhitbox);
				
				if(hurtbox._delay > 0) return;
				if(hurtbox._shielded) return;
				if(_parentobj._mashact > 0) return;
				
				_parentobj._hurtbox = instance_place(x, y, obj_punchhitbox);
				if(hurtbox && hurtbox._active && instance_exists(hurtbox._parentobj) && (hurtbox._ptype == "enm" || hurtbox._ptype == "all") && hurtbox._parentobj != _parentobj.id && diff((hurtbox._parentobj).y, _parentobj.y) <= hurtbox._diffabs[0] && diff_abs(hurtbox._height, _parentobj._height) <= hurtbox._diffabs[1]){
					var enemyobj = hurtbox._parentobj;
					if(variable_instance_exists(enemyobj,"_falling") && variable_instance_exists(enemyobj,"_fall_ko")){
						if(enemyobj._hurttimer > 0 || enemyobj._falling || enemyobj._fall_ko) return;
					}
					//check blind zone
					if(hurtbox._damage == ATK_KO || (hurtbox._damage != ATK_KO && (hurtbox._curdir == DIR_L && _parentobj.x < enemyobj.x-64) || (hurtbox._curdir == DIR_R && _parentobj.x > enemyobj.x+64))){
						//exceptions
						if(hurtbox._type == "air_enm" && _parentobj._attack && _parentobj._attacktype == "upper") return;
						if(hurtbox._damage == ATK_NORM && _parentobj._slide) return;
						
						if(instance_exists(enemyobj)){
							enemyobj._interest += scr_ailevel(10, 50, enemyobj);
							if(enemyobj._interest >= 90){
								enemyobj._interest = 90;
							}
						}
					
						if(hurtbox._damage != ATK_KO){
							if(!_parentobj._falling){
								_parentobj._push = true;
							}
						} else {
							if(enemyobj._attack && enemyobj._attacktype == "blockko"){
								enemyobj._block = false;
								enemyobj._blocktimer = 0;
								enemyobj._attack = false;
								enemyobj._attacktype = "";
							}
						}
					
						if(!_parentobj._shield){
							if(_parentobj._stunnedtimer > 0){
								_parentobj._stunnedtimer -= _parentobj._minstun;
								if(_parentobj._stunnedtimer <= _parentobj._minstun){
									if(_parentobj._state == "nomove"){
										_parentobj._state = "default";
									}
									_parentobj._stunnedtimer = 0;
								}
							}
							
							if(_parentobj._parrytimer <= 0){
								var p = instance_create_depth(_parentobj.x, _parentobj.y, 0, obj_particle);
								if(hurtbox._type != "air"){
									p._type = "fx"+string(choose(1,2));
								} else {
									p._type = "fx"+string(choose(3,4));
								}
								p._damage = hurtbox._damage;
							}
							
							_parentobj._spd = [0,0];
							_parentobj._damage ++;
							_parentobj._damageTimer = scr_ailevel(30, 50, enemyobj);
							_parentobj._noAtkTimer = 30;
				
							with(obj_game){
								ui_fade("dh", 1);
							}
						
							var p = instance_create_depth(_parentobj.x, _parentobj.y, 0, obj_particle);
							if(hurtbox._bothdir){
								if(p.x < enemyobj.x){
									p._curdir = DIR_L;
								} else {
									p._curdir = DIR_R;
								}
							} else {
								p._curdir = hurtbox._curdir;
							}
				
							if(hurtbox._damage == ATK_KO || _parentobj._combo >= _parentobj._combomax){
								if(enemyobj._attacktype == "upper" && _parentobj._crouch) return;
								fall(enemyobj, _parentobj, hurtbox);
						
								_parentobj._koenemy = enemyobj;
						
								if(enemyobj._behaviortype != "spinning"){
									if(has_trait(TRAIT_KO, enemyobj)){
										enemyobj._did_ko = 1;
										(enemyobj._displayobj).image_index = enemyobj._koframe;
									}
									
									enemyobj._nockatk = 1;
								}
						
								if(_parentobj._runroll){
									_parentobj._state = "default";
									_parentobj._runroll = false;
									_parentobj._curdir *= -1;
								}
						
								if(enemyobj._behaviortype != "spinning"){
									enemyobj._forceattack = 0;
									enemyobj._interest = 0;
									enemyobj._dh = noone;
									enemyobj._state = STATE_WALK;
								}
						
								_parentobj._hp -= 6+hurtbox._add_damage;
								_parentobj._dmgcoold = 0;
						
								_parentobj._occupied = [noone, noone];
					
								if(enemyobj._behaviortype != "spinning"){
									if(enemyobj._boss){
										enemyobj._ease_kd ++;
										enemyobj._ease_kd_timer = enemyobj._ease_kd_max;
									}
								}
					
								sfx_stop_array(global._punchsounds[0]);
								sfx_play_choose(global._kdsounds);
						
								if(global._kdeffect){
									global._kohit = 12;
								}
							}
				
							if(_parentobj._damage != ATK_KO){
								if(_parentobj._state == "roll") return;
								if(_parentobj._slide) return;
							
								if(hurtbox._combo){
									_parentobj._combotimer = 60;
									_parentobj._combo ++;
								}
							
								_parentobj._randhurt = clamp(floor(random_range(1,4)), 1, 3);
								_parentobj._hurtTimer = 14;
								_parentobj._hp -= 3+hurtbox._add_damage;
								_parentobj._dmgcoold = 0;
								hurtbox._success = true;
					
								sfx_play_choose(global._punchsounds[0]);
							}
							if(_parentobj._damage == ATK_KO || _parentobj._combo >= _parentobj._combomax){
								fall(enemyobj, _parentobj, hurtbox);
					
								if(_parentobj._runroll){
									_parentobj._state = "default";
									_parentobj._runroll = false;
									_parentobj._curdir *= -1;
								}
								_parentobj._koenemy = enemyobj;

								if(enemyobj._behaviortype != "spinning"){
									if(has_trait(TRAIT_KO, enemyobj)){
										enemyobj._curatk = 0;
										enemyobj._did_ko = 1;
										(enemyobj._displayobj).image_index = 0;
									}
									enemyobj._interest = 0;
									enemyobj._dh = noone;
									enemyobj._state = STATE_WALK;
									
									enemyobj._nockatk = 1;
								}
						
								_parentobj._hp -= 10+hurtbox._add_damage;
								_parentobj._dmgcoold = 0;
							
								_parentobj._curdir = hurtbox._curdir;
					
								if(enemyobj._behaviortype != "spinning"){
									if(enemyobj._boss){
										enemyobj._ease_kd ++;
										enemyobj._ease_kd_timer = enemyobj._ease_kd_max;
									}
								}
					
								sfx_stop_array(global._punchsounds[0]);
								sfx_play_choose(global._kdsounds);
						
								_parentobj._occupied = [noone, noone];
						
								if(global._kdeffect){
									global._kohit = 12;
								}
							}
						} else {
							if(hurtbox._canparry){
								if(_parentobj._parrytimer > 0){
									//successfull parry
									_parentobj._shieldpower = 1;
									_parentobj._parrytimer = 0;
									_parentobj._successparry = 32;
									_parentobj._parryzoom = 1.6;
									_parentobj._parryframe = irandom(_parentobj._parryframe_max-1);
									_parentobj._shield = false;
								
									_parentobj._parryenmx = enemyobj.x;
								
									enemyobj._attack = false;
									enemyobj._attacktype = "";
									enemyobj._successparry = 140;
									enemyobj._freeze = 140;
									enemyobj._parryframe = irandom(enemyobj._mashhurt_max-1);
									
									var p = instance_create_depth(_parentobj.x-64, _parentobj.y-64, 0, obj_particle);
									p._type = "fx_parry";
								
									with(obj_camera){
										_ampX = 25;
									}
								
									sfx_stop(snd_parry);
									sfx_play(snd_parry);
									global._pad_vibrate = 8;
								}
							}
							
							if(!hurtbox._canparry || (hurtbox._canparry && _parentobj._parrytimer <= 0)){
								if(_parentobj._shieldpower > 0.3){
									//shield protection
									_parentobj._shieldpower -= enemyobj._breakpower;
									hurtbox._shielded = true;
									
									_parentobj._freeze = global._freezeFrames.mid_freeze;
									enemyobj._freeze = global._freezeFrames.mid_freeze;
								
									sfx_play_choose([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
									
									global._pad_vibrate = 4;
								} else {
									//shield breaks
									_parentobj._shieldpower = 0;
									_parentobj._shield = false;
									_parentobj._state = "default";
								
									fall(enemyobj, _parentobj, hurtbox);
					
									_parentobj._koenemy = enemyobj;

									if(enemyobj._behaviortype != "spinning"){
										if(has_trait(TRAIT_KO, enemyobj)){
											enemyobj._curatk = 0;
											enemyobj._did_ko = 1;
											(enemyobj._displayobj).image_index = 0;
										}
										enemyobj._interest = 0;
										enemyobj._dh = noone;
										enemyobj._state = STATE_WALK;
										
										enemyobj._nockatk = 1;
									}
						
									_parentobj._hp -= 10+hurtbox._add_damage;
									_parentobj._dmgcoold = 0;
							
									_parentobj._curdir = hurtbox._curdir;
					
									if(enemyobj._behaviortype != "spinning"){
										if(enemyobj._boss){
											enemyobj._ease_kd ++;
											enemyobj._ease_kd_timer = enemyobj._ease_kd_max;
										}
									}
					
									sfx_stop_array(global._punchsounds[0]);
									sfx_play_choose(global._kdsounds);
								
									sfx_play(snd_fireend);
						
									_parentobj._occupied = [noone, noone];
						
									if(global._kdeffect){
										global._kohit = 12;
									}
								
									_parentobj._stunnedtimer = 180;
								}
							}
						}
					}
				}
			
				hurtbox._active = false;
			
				_once = true;
			}
			
			if(place_meeting(x, y, obj_projectile)){
				var hurtbox = instance_place(x, y, obj_projectile);
				
				if(instance_exists(hurtbox) && diff(hurtbox.y, _parentobj.y) <= hurtbox._heightdiff[0] && diff_abs(hurtbox._height, _parentobj._height) <= hurtbox._heightdiff[1]){
					if(!hurtbox._active) return;
					if(hurtbox._shielded) return;
					if(_parentobj._mashact > 0) return;
					if(hurtbox._candodge.roll && _parentobj._state == "roll") return;
					if(hurtbox._candodge.down && (_parentobj._crouch || _parentobj._slide)) return;
					if(hurtbox._candodge.atk && _parentobj._attack) return;
					if(hurtbox._bike && _parentobj._attack && _parentobj._attacktype == "air") return;
					
					if(_parentobj._freeze <= 0 && hurtbox._freeze <= 0){
						if(!_parentobj._falling){
							_parentobj._push = true;
						}
						
						if(!_parentobj._shield){
							if(_parentobj._stunnedtimer > 0){
								_parentobj._stunnedtimer -= _parentobj._minstun;
								if(_parentobj._stunnedtimer <= _parentobj._minstun){
									if(_parentobj._state == "nomove"){
										_parentobj._state = "default";
									}
									_parentobj._stunnedtimer = 0;
								}
							}		
							
							if(hurtbox._damage == ATK_NORM){
								if(_parentobj._slide) return;
								if(!hurtbox._food){
									if(_parentobj._parrytimer <= 0 || !hurtbox._canparry){
										var p = instance_create_depth(_parentobj.x, _parentobj.y, 0, obj_particle);
										p._type = "fx"+string(choose(1,2));
										p._damage = hurtbox._damage;
									}
								
									_parentobj._spd = [0,0];
									_parentobj._damage ++;
									_parentobj._damageTimer = 40;
									_parentobj._noAtkTimer = 30;
								
									_parentobj._curdir = hurtbox._curdir;
									_parentobj._randhurt = clamp(floor(random_range(1,4)), 1, 3);
									_parentobj._hurtTimer = 14;
									_parentobj._hp -= 3+hurtbox._add_damage;
									_parentobj._dmgcoold = 0;
								
									global._pad_vibrate = 2;
								
									sfx_play_choose(global._punchsounds[0]);
								} else {
									//mm food
									_parentobj._spd = [0,0];
									_parentobj._curdir = hurtbox._curdir;
									_parentobj._hurtTimer = 14;
									_parentobj._dmgcoold = 0;
									if(instance_exists(_parentobj._displayobj)){
										(_parentobj._displayobj).image_index = 0;
									}
									with(hurtbox){
										instance_destroy();
									}
									sfx_play(snd_item);
								}
							} else if(hurtbox._damage == ATK_KO){
								if(_parentobj._parrytimer <= 0 || !hurtbox._canparry){
									var p = instance_create_depth(_parentobj.x, _parentobj.y, 0, obj_particle);
									p._type = "fx"+string(choose(1,2));
									p._damage = hurtbox._damage;
								}
								
								fall(hurtbox, _parentobj, hurtbox);
						
								_parentobj._hp -= 8+hurtbox._add_damage;
								_parentobj._dmgcoold = 0;
							
								_parentobj._curdir = hurtbox._curdir;
					
								sfx_stop_array(global._punchsounds[0]);
								sfx_play_choose(global._kdsounds);
						
								_parentobj._occupied = [noone, noone];
						
								if(global._kdeffect){
									global._kohit = 12;
								}
								
								global._pad_vibrate = 6;
							}
							
							_parentobj._attack = false;
							_parentobj._attacktype = "";
							
							with(obj_game){
								ui_fade("dh", 1);
							}
						
							with(obj_camera){
								_ampX = 12;
							}
					
							if(instance_exists(hurtbox)){
								_parentobj._freeze = global._freezeFrames.mid_freeze;
								hurtbox._freeze = global._freezeFrames.mid_freeze;
							}
						} else {
							if(instance_exists(hurtbox)){
								if(hurtbox._canparry){
									if(_parentobj._parrytimer > 0){
										//successfull parry
										_parentobj._shieldpower = 1;
										_parentobj._parrytimer = 0;
										_parentobj._parryzoom = 1.6;
										_parentobj._successparry = 32;
										_parentobj._parryframe = irandom(_parentobj._parryframe_max-1);
										_parentobj._shield = false;
								
										_parentobj._parryenmx = hurtbox.x;
								
										with(hurtbox){
											dead();
										}
								
										var p = instance_create_depth(_parentobj.x-64, _parentobj.y-64, 0, obj_particle);
										p._type = "fx_parry";
								
										with(obj_camera){
											_ampX = 15;
										}
								
										sfx_stop(snd_parry);
										sfx_play(snd_parry);
										global._pad_vibrate = 8;
									}
								}
							}
							if(instance_exists(hurtbox)){
								if(!hurtbox._canparry || (hurtbox._canparry && _parentobj._parrytimer <= 0)){
									if(_parentobj._shieldpower > 0.3){
										_parentobj._freeze = global._freezeFrames.mid_freeze;
								
										_parentobj._shieldpower -= hurtbox._breakpower;
										hurtbox._shielded = true;
								
										if(hurtbox._killedbyshield){
											with(hurtbox){
												dead();
											}
										}
								
										sfx_play_choose([snd_punchfail1,snd_punchfail2,snd_punchfail3]);
									
										global._pad_vibrate = 4;
									} else {
										//shield breaks
										_parentobj._shieldpower = 0;
										_parentobj._shield = false;
										_parentobj._state = "default";
								
										fall(hurtbox, _parentobj, hurtbox);
						
										_parentobj._hp -= 10+hurtbox._add_damage;
										_parentobj._dmgcoold = 0;
							
										_parentobj._curdir = hurtbox._curdir;
					
										sfx_stop_array(global._punchsounds[0]);
										sfx_play_choose(global._kdsounds);
								
										sfx_play(snd_fireend);
						
										_parentobj._occupied = [noone, noone];
						
										if(global._kdeffect){
											global._kohit = 12;
										}
								
										if(hurtbox._killedbyshield){
											with(hurtbox){
												dead();
											}
										}
								
										_parentobj._stunnedtimer = _parentobj._maxstun;
									}
								}
							}							
						}
					}
				}
			}
		
			/*(place_meeting(x, y, obj_st1_fallabove)){
				var inst = instance_place(x, y, obj_st1_fallabove);
				if(_parentobj._mashact == 0 && _parentobj._state != "item" && diff(inst.y-inst._height, _parentobj.y) <= 42){
					with(obj_game){
						ui_fade("dh", 1);
					}
				
					_parentobj._hurtbox = inst;
					_parentobj._spd = [0,0];
					_parentobj._damage ++;
					_parentobj._damageTimer = 40;
					_parentobj._randhurt = floor(random_range(1,4));
					_parentobj._push = true;
					_parentobj._hurtTimer = 14;
					_parentobj._hp -= 3+hurtbox._add_damage;
					_parentobj._dmgcoold = 0;
					
					sfx_play_choose(global._punchsounds[0]);
					with(inst){
						sfx_stop(snd_whistle);
						sfx_play(snd_stonebreak);
						var p = instance_create_depth(x, y-72, 0, obj_particle);
						p._type = "st1fallabove";
						instance_destroy();
					}
				}
			}*/
			
			if(place_meeting(x, y, obj_boss1_shockwave_front)){
				var inst = instance_place(x, y, obj_boss1_shockwave_front);
				if(inst._alp > 0.5 && _parentobj._mashact == 0 && _parentobj._state != "zapped" && !(_parentobj._state == "item" && !instance_exists(_parentobj._grabid)) && _parentobj._height <= 0){
					_parentobj._state = "zapped";
					_parentobj._zaptime = 45;
					sfx_play(snd_zapped);
					with(obj_game){
						ui_fade("dh", 1);
					}
					
					with(_parentobj){
						if(_grabid != noone && instance_exists(_grabid)){
							var inst = instance_create_depth(x, y, depth-1, asset_get_index("obj_"+_grabid._codename+"_mask"));
							instance_destroy(_grabid.id);
							inst._height += 4;
							inst._vspd = 10;
							inst._dead = true;
							inst._jumpback = true;
							inst._jump = true;
							inst._hp = _storegrabhp;
							inst._displayhp = _storegrabhp;
							inst._grabfall = true;
							(inst._displayobj).visible = true;
							(inst._displayobj).sprite_index = asset_get_index("spr_"+string(inst._codename)+"_standup");
							inst._diddamage = _store_diddamage;
							inst._gotdamaged = _store_gotdamaged;
							_state = "default";
						}
					}
				}
			}
		}
		
		if(_parentobj != noone && instance_exists(_parentobj)){
			//damage numbers
			if(global._finalhit <= 0 && _parentobj._hp < _parentobj._hplastframe && (_parentobj._height <= _parentobj._groundlevel || _parentobj._falling) && _parentobj._dmgcoold <= 0){
				if(!global._tutorial){
					var dmgnums = instance_create_depth(x, y-((_parentobj.sprite_height * 2)+150), 0, obj_nums);
				    dmgnums._num = max(1,floor(_parentobj._hplastframe - _parentobj._hp));
					_parentobj._hplastframe = _parentobj._hp;
					_parentobj._dmgcoold = 2;
				}
			}
		}
	}
	
	if(global._debug){
		if(global._showHitbox){
			visible = true;
		} else {
			visible = false;
		}
	}
}