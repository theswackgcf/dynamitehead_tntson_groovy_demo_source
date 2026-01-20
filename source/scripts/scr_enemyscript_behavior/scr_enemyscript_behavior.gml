function scr_enemyscript_behavior(type){
	if(type == ""){
		if(!global._pause){
			_allsoundstimer ++;
			if(_allsoundstimer >= 180){
				scr_clearsounds();
				_allsoundstimer = 0;
			}
		}
		
		//drag enemy debug
		if(global._debug){
			if(scr_mousehover(bbox_left,bbox_top,bbox_right,bbox_bottom, false, 1) && mouse_check_button_pressed(mb_left)){
				_dragoffset = [x-mouse_x,y-mouse_y];
				_mousedrag = true;
			}
		}
		if(!mouse_check_button(mb_left)){
			_mousedrag = false;
		}
		if(_mousedrag){
			x = mouse_x+_dragoffset[0];
			y = mouse_y+_dragoffset[1];
		}
		
		if(_forceai <> -1){
			_ailevel = _forceai;
		}
		if(place_meeting(x,y,obj_aiblock)){
			var aiblock = instance_place(x,y,obj_aiblock);
			if(instance_exists(aiblock)){
				//set ai level
				_ailevel = aiblock._ailevel;
			}
		}
		
		if(ds_map_exists(global._sequenceLayers, _seqid) && layer_exists(global._sequenceLayers[? _seqid]) && layer_sequence_exists(global._sequenceLayers[? _seqid], _sequence)){
			layer_sequence_destroy(_sequence);
			layer_destroy(global._sequenceLayers[? _seqid]);
			ds_map_delete(global._sequenceLayers, _seqid);
			ds_map_delete(global._sequenceColors, _seqid);
		}
		
		_nohopobj = true;
		
		if(_sequence_hop_obj != noone && instance_exists(_sequence_hop_obj)){
			if(_sequence_hop_obj._walking){
				_displayobj.image_index = _sequence_hop_obj.image_index;
			}
			instance_destroy(_sequence_hop_obj.id);
		}
		
		if(distance_to_point(global._cameraX+(WIDTH*0.5),global._cameraY+(HEIGHT*0.5)) <= WIDTH*0.8){
			_inview = true;
		} else {
			_inview = false;
		}
		
		if(_freeze <= 0){
			if(_spdmult_timer > 0){
				_spdmult_timer --;
			} else {
				_spdmult = 1;
			}
		}
		
		if(!_death){
			//path grid area
			if(!_battlezone){
				if(bbox_left <= _pathgridarea[0] ||
				bbox_right >= _pathgridarea[2] ||
				bbox_top <= _pathgridarea[1] ||
				bbox_bottom >= _pathgridarea[3]
				){
					_pathgridarea = [x-_defarea[0],y-_defarea[1],_defarea[2],_defarea[3]];
					
					if(_pathgrid != 0){
						mp_grid_destroy(_pathgrid);
						global._mpGridCount--;
					}
					_pathgrid = mp_grid_create(_pathgridarea[0],_pathgridarea[1],_pathgridarea[2]/_pathgridsize[0],_pathgridarea[3]/_pathgridsize[1],_pathgridsize[0],_pathgridsize[1]);
					global._mpGridCount++;
			
					do_grid_collisions();
				}
			}
			
			//behavior
			if(_freeze <= 0){
				if(!_falling && !_grabfall && !_death){
					_spdmode = SPD_WALK;
				}
				if(_curstate != STATE_FALL){
					_behaviortype = "idle";
				}
				if(_curstate == STATE_WALK || _curstate == STATE_FOLLOW || _curstate == STATE_FALL){
					_behaviortype = "move";
				}
				if(_curstate == STATE_WALK){
					if(abs(_curspd[0]) <= 0.1 && abs(_curspd[1]) <= 0.1){
						_walktimer ++;
					}
				} else {
					_walktopos = [x,y];
					_walksuccess = false;
					_walktimer = 999;
				}
				if(_curstate == STATE_ATTACK){
					_behaviortype = "attack";
				} else {
					if(_forceattack <= 0 && _atktimer > 0){
						_atktimer --;
					}
				}
				
				if(_curstate != STATE_FOLLOW){
					_followgridtimer = 0;
					_badidletimer = 0;
				}
				
				if(_curstate == STATE_FOLLOW){
					_followgridtimer ++;
					if(_followgridtimer >= 30){
						do_grid_collisions();
						_followgridtimer = 0;
					}
				}
			
				if(_curstate == STATE_IDLE){
					clearpath();
					_standtimer ++;
					if(_standtimer >= scr_ailevel(20, random_range(32,96))){
						_curstate = STATE_WALK;
					}
				} else {
					_standtimer = 0;
				}
			
				//force attack state
				if(_curstate == STATE_IDLE || _behaviortype == "move"){
					_dh = instance_nearest(x,y,obj_dh_mask);
					if(_dh != noone && instance_exists(_dh)){
						if(!_dh._falling){
							if(distance_to_object(_dh) <= _walkdist[0] && (_available[0] || _available[1])){
								if(_total_ailevel >= 5 && _curstate != STATE_ATTACK){
									_atktimer = 99;
								}
								if(_forceattack == 0){
									scr_dh_pathpoint();
									if(path_exists(_path) && mp_grid_path(_pathgrid, _path, x, y, _pathpoint[0],_pathpoint[1], 1)){
										_forceattack = 40;
									}
								}
							}
						}
					}
				}
				
				//dodge roll
				if(_stuntimer <= 0 && !_falling && !_fall_ko && !_standup && _behaviortype == "move"){
					if(!_grabbed){
						_dh = instance_nearest(x,y,obj_dh_mask);
						if(_dh._runroll && _dh._anim == "runroll" && abs(_dh._spd[0]) >= 6 && distance_to_object(_dh) <= 96){
							if((_dh.x < x && _curdir == DIR_L) || (x < _dh.x && _curdir == DIR_R)){
								_fall_ko = true;
								_jump = true;
								_standup = true;
								_nocrouchatk = true;
								_height = _groundlevel + 1;
								_vspd = 12;
								_curspd = [0,0];
								clearpath();
							}
						}
					}
				}
				
				if(_forceattack > 0 && _interest > 0 && (_curstate == STATE_WALK || _curstate == STATE_IDLE)){
					if(!_grabbed){
						_dh = instance_nearest(x,y,obj_dh_mask);
						_interest = 60;
						if(_curstate != STATE_ATTACK){
							_curstate = STATE_FOLLOW;
						}
						
						check_occupy();
						
						if(_available[0] && !_available[1]){
							_walkto = [_dh.x-_dh._occupdist-_attackdist,_dh.y];
						}
						if(_available[1] && !_available[0]){
							_walkto = [_dh.x+_dh._occupdist+_attackdist,_dh.y];
						}
										
						if(_available[0] && x < _dh.x){
							_walkto = [_dh.x-_dh._occupdist-_attackdist,_dh.y];
						} else if(_available[1] && x > _dh.x){
							_walkto = [_dh.x+_dh._occupdist+_attackdist,_dh.y];
						}
						
						if(!_attack){
							_atktimer = 255;
						}
					}
					_forceattack --;
				}
			
				//block state
				if(_block){
					if(_height <= _groundlevel){
						_curstate = STATE_BLOCK;
					} else {
						_blocktimer = 0;
					}
				} else {
					if(_phaseend_act == 0 && _specialatk <= 0 && _height <= _groundlevel && _curstate == STATE_BLOCK){
						if(has_trait(TRAIT_BLOCKKO)){
							if(_dh_atk <= 0){
								var dh = instance_nearest(x,y,obj_dh_mask);
								if(instance_exists(dh) && ((_curdir == DIR_R && x < dh.x) || (_curdir == DIR_L && x > dh.x)) && dh._mashact == 0){
									_displayobj.image_index = 0;
									_setframe = false;
									_attack = true;
									_attacktype = "blockko";
									_blockko_fx = false;
									
									_afterim_active = 60;
								
									//create ko attack
									var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
									atk._frame = _atkdelay.blockko;
									atk._parentobj = self.id;
									atk._ptype = "enm";
									atk._type = "blockko_enm";
									atk._scale = [5.4, 3];
									atk._offset = [136,-100];
									if(array_length(_atkhitb.blockko) > 0){
										atk._scale = [_atkhitb.blockko[0][0],_atkhitb.blockko[0][1]];
										atk._offset = [_atkhitb.blockko[1][0],_atkhitb.blockko[1][1]];
									}
									atk._timer = 9;
									atk._height = 60;
									atk._damage = ATK_KO;
									
									sfx_play_choose_proximity(global._swishsounds[1]);
								}
							} else {
								_dh_atk = 0;
							}
						}
						_blocktimer = 0;
						_curstate = STATE_IDLE;
					}
				}
			
				//stop blocking
				if(_height > _groundlevel && _block){
					_blocktimer = 0;
				}
				if(_fall_ko){
					_blocktimer = 0;
				}
				if(_curstate != STATE_BLOCK){
					_blocktimer = 0;
				}
				if(_blocktimer <= 0 && _block){
					_block = false;
					_blockcount = 0;
				}
				
				if(_pointtime > 0){
					_pointtime --;
				}
				if(_pointtime <= 0){
					//default path point
					_pathpoint = [_walkto[0],_walkto[1]];
				}
			
				if(_backoff > 0){
					_backoff -= 1;
				}
			}
				
			//backing off
			var sndplay = asset_get_index("snd_tiptoe_"+_floortype);
			if(has_trait(TRAIT_BACKOFF) && _backoffsound){
				if(_anim == "back"){
					_backofftime ++;
					if(_backofftime >= 8){
						if(!sfx_isplaying(sndplay)){
							sfx_play_proximity(sndplay, 1, false);
							sfx_pitch(sndplay, random_range(0.8,1.25));
						}
					}
				} else {
					_backofftime = 0;
					sfx_stop(sndplay);
				}
			}
			
			if(instance_number(obj_boss2_mask) > 0){
				if(has_trait(TRAIT_BACKOFF)){
					remove_trait(TRAIT_BACKOFF);
				}
			}
		
			//stunned
			if(has_trait(TRAIT_STUN)){
				if(_grabdodge){
					_stun = false;
					_stuntimer = 0;
					_stunpunch = 0;
					_stunact = 0;
				}
				if(!_falling && !_fall_ko && !_standup){
					if(_stuntimer > 0){
						_slide = false;
						_slidespd = 0;
					
						clearpath();
						_curspd = [0,0];
						_curstate = STATE_IDLE;
					}
				}
				if(_fall_ko && !_standup){
					_stunact = 0;
					if(_curstate == STATE_JUMP){
						_stuntimer = 0;
						_stunact = 0;
						_stunpunch = 0;
						_stun = false;
					}
				}
			}
			
			if(_hurttimer == 0 && _dodgetimer == 0 && _behaviortype == "idle"){
				if(_stuntimer > 0){
					_stunanim = true;
				}
			}
			
			//grab store
			if(!_grabbed){
				_storebgrab = [x,y];
			}
			
			if(_height <= _groundlevel && _grabdodge){
				_grabdodge = false;
			}
			
			if(_curstate == STATE_JUMP){
				if(_successparry > 0){
					_curstate = STATE_IDLE;
				}
				_jumpingtimer = 0;
				_behaviortype = "hopping";
				clearpath();
			} else {
				if(!_falling && !_fall_ko){
					if(_dohop){
						_displayobj.image_index = 0;
						_behaviortype = "hopping";
						_hop_snd = false;
						_hop_arcstart = false;
						_hop_startpos = [x,y];
						_hop_time = 0;
						_hop_arc = 0;
						_curstate = STATE_JUMP;
						
						_dohop = false;
					} else {
						_hop_arc = 0;
					}
				}
				
				if(has_trait(TRAIT_HOP)){
					if(_mashed || _shockwave || _grabdodge || _successparry > 0){
						_jumpingtimer = 0;
					}
					if((_curstate == STATE_IDLE && _stuntimer == 0) || _behaviortype == "move"){
						if(_curstate != STATE_FALL && !_falling && !_fall_ko && !_grabbed){
							_jumpingtimer ++;
					
							//hop
							if(_jumpingtimer >= scr_ailevel(180,random_range(400, 700))){
								if(_stuntimer <= 0){
									scr_hopspot(HOP_RANDOM_DH);
								
									if(scr_enemyscript_calculatejump()){
										_dohop = true;
									} else {
										_jumpingtimer = 0;
									}
								} else {
									_jumpingtimer = 0;
								}
							}
						} else {
							_jumpingtimer = 0;
						}
					}
				}
			}
			
			if(_dohop && _successparry > 0){
				_dohop = false;
			}
			
			//sliding trait
			if(has_trait(TRAIT_SLIDE)){
				if(_mashed || _shockwave){
					_slidetimer = 0;
					_slideact = 0;
					_slide = false;
				}
				if(_curstate == STATE_IDLE || _behaviortype == "move"){
					if(!_slide){
						_slidetimer ++;
						if(_stuntimer > 0){
							_slidetimer = 0;
						}
					
						if(_slidetimer >= scr_ailevel(120, 280)){
							_dh = instance_nearest(x, y, obj_dh_mask);
							if(instance_exists(_dh)){
								var checkdist = _dh.x;
								if(!_falling){
									if(x < _dh.x){
										checkdist = _dh.x-_slidedist;
										_curdir = DIR_R;
									} else {
										checkdist = _dh.x+_slidedist;
										_curdir = DIR_L;
									}
								}
							
								if(diff_abs(x, checkdist) <= 64){
									//enemy is close to dh, slide
									doslide();
								} else if(diff_abs(x, checkdist) > 64 && diff_abs(x, checkdist) <= _noticedist){
									if(_stuntimer <= 0 && !_grabdodge){
										//hop to the spot and then slide
										scr_hopspot(HOP_SLIDE);
								
										if(scr_enemyscript_calculatejump()){
											_hopslide = true;
											_dohop = true;
										} else {
											_jumpingtimer = 0;
										}
									} else {
										_jumpingtimer = 0;
									}
								} else {
									_slidetimer = 0;
								}
							}
						}
					} else {
						_curstate = STATE_SLIDE;
					}
				}
			
				if(_falling || _fall_ko){
					_slide = false;
					if(_curstate == STATE_SLIDE){
						_curstate = STATE_WALK;
					}
				}
			}
			
			if(_slide){
				_slidetimer ++;
				_curspd = [0,0];
				clearpath();
				switch(_slideact){
					case 0:
						if(_slidetimer >= scr_ailevel(24,60)){
							_fixwall = true;
							_slideact = 1;
							_slidespd = _slidespd_max*_curdir;
							_slidedir = _curdir;
							_slidedecel = _slidedecel_max;
							
							var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
							atk._parentobj = self.id;
							atk._ptype = "enm";
							atk._scale = [4, 4];
							atk._offset = [180,-24];
							atk._timer = 120;
							atk._type = "slide_enm";
							atk._damage = ATK_KO;
							atk._persist = true;
							
							sfx_play_proximity(snd_slide);
						}
					break;
					case 1:
						if(_codename != "boss2"){
							_afterim_active = 3;
						}
						_fallxspd = _slidespd;
						if(_slidedir == DIR_R){
							_slidespd -= _slidedecel;
							if(_slidespd < 0){
								_slidespd = 0;
							}
						} else {
							_slidespd += _slidedecel;
							if(_slidespd > 0){
								_slidespd = 0;
							}
						}
						_slidedecel += 0.07;
						if(abs(_slidespd) <= 0.05){
							_displayobj.image_index = 0;
							_anim_tr_anim = "crouch_out";
							_anim_tr_init = false;
							_anim_transition = true;
								
							_slide = false;
							_slidetimer = 0;
							_slideact = 0;
							_slidespd = 0;
						}
					break;
				}
			} else {
				_slidespd = 0;
				if(_curstate == STATE_SLIDE){
					_curstate = STATE_WALK;
				}
			}
			
			//getting pissed off at taunts
			if(_dh_atk_taunt_inst != noone && instance_exists(_dh_atk_taunt_inst)){
				if(_dh_atk_taunt > 0){
					if(has_trait(TRAIT_PISSEDOFF)){
						if(variable_instance_exists(_dh_atk_taunt_inst, "_taunt") && variable_instance_exists(_dh_atk_taunt_inst, "_tauntloops")){
							if(_dh_atk_taunt_inst._taunt && _dh_atk_taunt_inst._tauntloops > 0){
								_pissedoff_int ++;
								if(_pissedoff_int > 2){
									_pissedoff_int = 2;
								}
								_pissedoff = 800;
								_dh_atk_taunt_inst = noone;
							}
						}
					}
				}
			}
			
			if(_pissedoff > 0){
				switch(_pissedoff_int){
					case 0:
						_ailevel_mult = 1.6;
					break;
					case 1:
						_ailevel_mult = 2;
					break;
					case 2:
						_ailevel_mult = 2.4;
					break;
				}
			} else {
				_pissedoff_int = -1;
				_ailevel_mult = 1;
			}
		} else {
			sfx_stop(asset_get_index("snd_tiptoe_"+_floortype));
		}
		
		if(!_falling && !_slide && !_freespd){
			_wallbonks = 0;
		}
		
		//avoiding dh during mash
		if(_phaseend_act == 0 && !_spin && _stuntimer <= 0 && !_mashed && (_curstate == STATE_IDLE || _curstate == STATE_WALK || _curstate == STATE_FOLLOW)){
			var dhavoid = instance_nearest(x, y, obj_dh_mask);
			if(dhavoid != noone && instance_exists(dhavoid)){
				if(_total_ailevel >= 3 && distance_to_object(dhavoid) >= 250 && distance_to_object(dhavoid) <= _panicdist && dhavoid._mashact > 0){
					/*if(dhavoid._mashobj == noone && distance_to_object(dhavoid) <= 200 && dhavoid._mashtime <= 35){
						var spot = [dhavoid.x,dhavoid.y];
						if(dhavoid._curdir == DIR_L){
							spot[0] = dhavoid.x+256;
						} else if(dhavoid._curdir == DIR_R){
							spot[0] = dhavoid.x-256;
						}
						scr_hopspot(spot[0],spot[1]);
						
						if(scr_enemyscript_calculatejump(0)){
							_dohop = true;
						}
					}*/
					_panictimer = 120;
				}
				if(_total_ailevel >= 5 && dhavoid._mashact == 0){
					_panictimer = 0;
				}
			}
		}
		
		//panic mode
		if(_panictimer > 0){
			if(_curstate == STATE_IDLE || _curstate == STATE_WALK){
				_curstate = STATE_FOLLOW;
			}
			var dhavoid = instance_nearest(x, y, obj_dh_mask);
			if(dhavoid != noone && instance_exists(dhavoid)){
				var mindist = 48;
				if(diff_abs(x,_panicspot[0]) < mindist && diff_abs(y,_panicspot[1]) < mindist){
					if(x < dhavoid.x){
						_jumptopos[0] = random_range(x-(WIDTH/2),x-512);
					} else {
						_jumptopos[0] = random_range(x+(WIDTH/2),x+512);
					}
					if(y < dhavoid.y){
						_jumptopos[1] = random_range(y-(HEIGHT/2),y-512);
					} else {
						_jumptopos[1] = random_range(y+(HEIGHT/2),y+512);
					}
					if(scr_enemyscript_calculatejump(0)){
						_panicspot[0] = _jumptopos[0];
						_panicspot[1] = _jumptopos[1];
						_jumptopos = [x,y];
					}
				}
			}
		} else {
			if(_spdmode == SPD_PANIC){
				_spdmode = SPD_WALK;
			}
		}
		
		//moving/following
		_drawifmoving --;
		if(_freespd || _falling || (_standup && _init_fallxspd <> 0) || (_slide && _slideact > 0) || _afterhop > 0){
			if(_freeze <= 0){
				clearpath();
				_curspd = [0,0];
				if(_fixwall){
					var dest = [x,y];
					var dh = instance_nearest(x, y, obj_dh_mask);
					if(dh != noone && instance_exists(dh)){
						if(dh.x <= x){
							dest[0] = dh.x + 16;
						} else {
							dest[0] = dh.x - 16;
						}
						if(place_meeting_array(bbox_right+16, y, _collide_solid) || place_meeting_array(bbox_right+16, y, _collide_other) || place_meeting(bbox_right+16, y, obj_battleborder)){
							dest[0] = dh.bbox_left;
						}
						if(dh.y <= y){
							dest[1] = dh.y + 16;
						} else {
							dest[1] = dh.y - 16;
						}
						if(place_meeting_array(x, bbox_top-16, _collide_solid)){
							dest[1] = dh.bbox_bottom;
						}
						if(place_meeting(x, bbox_top-16, obj_collideup)){
							dest[1] = dh.bbox_bottom;
						}
						if(place_meeting_array(x, bbox_top-16, [obj_battleborder])){
							var bb = place_meeting_array(x, bbox_top-16, [obj_battleborder], true, true);
							if(instance_exists(bb) && bb._side == "u"){
								dest[1] = dh.bbox_bottom;
							}
						}
						
						if(place_meeting_array(x, bbox_bottom+16, _collide_solid)){
							dest[1] = dh.bbox_top;
						}
						if(place_meeting(x, bbox_bottom+16, obj_collidedown)){
							dest[1] = dh.bbox_top;
						}
						if(place_meeting_array(x, bbox_bottom+16, [obj_battleborder])){
							var bb = place_meeting_array(x, bbox_bottom+16, [obj_battleborder], true, true);
							if(instance_exists(bb) && bb._side == "d"){
								dest[1] = dh.bbox_top;
							}
						}
						repeat(32){
							if(place_meeting_array(x, y, _collide_solid) || place_meeting_array(x, y, _collide_other) || place_meeting(x, y, obj_battleborder)){
								if(dest[0] < x){
									x -= 4;
								} else if(dest[0] >= x){
									x += 4;
								}
								if(dest[1] < y){
									y -= 4;
								} else if(dest[1] >= y){
									y += 4;
								}
							} else {
								_fixwall = false;
								break;
							}
						}
					}
					_fixwall = false;
				}
			}
			
			//spd movement
			if(_freeze <= 0){
				if(!_slide && !_freespd){
					_fallxspd = (_movespd[? _spdmode]+_fallxspd_offset)*_curdir;
				}
				if(_init_fallxspd <> 0){
					_fallxspd = _init_fallxspd;
				}
				_floatx = frac(_fallxspd);
				_floaty = frac(_fallyspd);
			} else {
				_fallxspd = 0;
				_floatx = 0;
				
				_fallyspd = 0;
				_floaty = 0;
			}
			_realspd[0] = _fallxspd;
			_realspd[1] = _fallyspd;
			
			if(_freespd){
				_fixwall = false;
			}
			
			function wallbonk() {
				if(_codename != "fridge"){
					if(_afterhop <= 0 && _curstate != STATE_JUMP && (_fallxspd <> 0 || _fallyspd <> 0)){
						_dh_atk = 0;
						if(_fallxspd <> 0){
							if(!_freespd){
								_tempdir *= -1;
								_curdir = _tempdir;
							} else {
								if(_boundwall.left > 0){
									_freedir = DIR_R;
								} else if(_boundwall.right > 0){
									_freedir = DIR_L;
								}
								_tempdir = _freedir;
								_curdir = _freedir;
							}
						}
						if(_fallyspd <> 0){
							if(!_freespd){
								_curdir_v *= -1;
							} else {
								if(_boundwall.up > 0){
									_freedir_v = DIR_D;
								} else if(_boundwall.down > 0){
									_freedir_v = DIR_U;
								}
							}
						}
						
						_wallbonks ++;
					
						if(_freespd){
							_walltouch = 0;
							_walltouch_y = 0;
						
							_boundwall.left = 0;
							_boundwall.right = 0;
							_boundwall.up = 0;
							_boundwall.down = 0;
						}
						
						var partc = instance_create_depth(_displayobj.x, _displayobj.y-96, 0, obj_particle);
						partc._type = "fx6";
				
						with(obj_camera){
							if(other._fallxspd <> 0){
								_ampX = 20;
							}
							if(other._fallyspd <> 0){
								_ampY = 20;
							}
						}
					
						sfx_play_choose_proximity([snd_wallslam,snd_wallslam2,snd_wallslam3]);
					}
				}
			}
			
			//x-move
			repeat(abs(_fallxspd)){
				var go_x = true;
				
				//x solid collision
				if(place_meeting_array(x + sign(_fallxspd), y, _collide_solid)){
					var inst = place_meeting_array(x+sign(_fallxspd), y, _collide_solid, true, true);
					if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height < inst._height && (inst._collidewith == "all" || inst._collidewith == "enemy")){
						go_x = false;
					}
				}
				//x border collision
				if(place_meeting_array(x+sign(_fallxspd), y, [obj_battleborder])){
					var bb = place_meeting_array(x+sign(_fallxspd),y,[obj_battleborder],true,true);
					if(instance_exists(bb) && ((_fallxspd < 0 && bb._side == "l") || (_fallxspd > 0 && bb._side == "r")) && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_x = false;
					}
				}
				//x side collision
				if(place_meeting(x+sign(_fallxspd), y, obj_collideleft)){
					var bb = instance_place(x+sign(_fallxspd),y, obj_collideleft);
					if(instance_exists(bb) && _fallxspd < 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_x = false;
					}
				}
				if(place_meeting(x+sign(_fallxspd), y, obj_collideright)){
					var bb = instance_place(x+sign(_fallxspd),y, obj_collideright);
					if(instance_exists(bb) && _fallxspd > 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_x = false;
					}
				}
				if(place_meeting(x+sign(_fallxspd), y, obj_collideleftup)){
					var bb = instance_place(x+sign(_fallxspd),y, obj_collideleftup);
					if(instance_exists(bb) && _fallxspd < 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_x = false;
					}
				}
				if(place_meeting(x+sign(_fallxspd), y, obj_collideleftdown)){
					var bb = instance_place(x+sign(_fallxspd),y, obj_collideleftdown);
					if(instance_exists(bb) && _fallxspd < 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_x = false;
					}
				}
				if(place_meeting(x+sign(_fallxspd), y, obj_colliderightup)){
					var bb = instance_place(x+sign(_fallxspd),y, obj_colliderightup);
					if(instance_exists(bb) && _fallxspd > 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_x = false;
					}
				}
				if(place_meeting(x+sign(_fallxspd), y, obj_colliderightdown)){
					var bb = instance_place(x+sign(_fallxspd),y, obj_colliderightdown);
					if(instance_exists(bb) && _fallxspd > 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_x = false;
					}
				}
				
				//special cases
				if(place_meeting(x + sign(_fallxspd), y, obj_slidespot)){
					var inst = instance_place(x+sign(_fallxspd), y, obj_slidespot);
					if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height < inst._height && (inst._collidewith == "all" || inst._collidewith == "enemy")){
						go_x = false;
					}
				}
				
				if(go_x){
					x += sign(_fallxspd); 
				} else {
					if(!_slide){
						if(_walltouch <= 0 && !_fixwall){
							wallbonk();
						}
					}
						
					if(!_fixwall){
						_walltouch = 4;
						if(_fallxspd > 0){
							_boundwall.right = 4;
						} else if(_fallxspd < 0){
							_boundwall.left = 4;
						}
						_fallxspd = 0;
						_floatx = 0;
					}
						
					if(_slideact >= 1){
						_slide = false;
						_slidetimer = 0;
						_slideact = 0;
					}
					break;
				}
			}
			
			//y-move
			repeat(abs(_fallyspd)){
				var go_y = true;
				
				//y solid collision
				if(place_meeting_array(x, y + sign(_fallyspd), _collide_solid)){
					var inst = place_meeting_array(x, y+sign(_fallyspd), _collide_solid, true, true);
					if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height < inst._height && (inst._collidewith == "all" || inst._collidewith == "enemy")){
						go_y = false;
					}
				}
				//y border collision
				if(place_meeting_array(x, y+sign(_fallyspd), [obj_battleborder])){
					var bb = place_meeting_array(x,y+sign(_fallyspd),[obj_battleborder],true,true);
					if(instance_exists(bb) && ((_fallyspd < 0 && bb._side == "u") || (_fallyspd > 0 && bb._side == "d")) && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_y = false;
					}
				}
				//y side collision
				if(place_meeting(x, y+sign(_fallyspd), obj_collideup)){
					var bb = instance_place(x,y+sign(_fallyspd), obj_collideup);
					if(instance_exists(bb) && _fallyspd < 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_y = false;
					}
				}
				if(place_meeting(x, y+sign(_fallyspd), obj_collidedown)){
					var bb = instance_place(x,y+sign(_fallyspd), obj_collidedown);
					if(instance_exists(bb) && _fallyspd > 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_y = false;
					}
				}
				if(place_meeting(x, y+sign(_fallyspd), obj_collideleftup)){
					var bb = instance_place(x,y+sign(_fallyspd), obj_collideleftup);
					if(instance_exists(bb) && _fallyspd < 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_y = false;
					}
				}
				if(place_meeting(x, y+sign(_fallyspd), obj_collideleftdown)){
					var bb = instance_place(x,y+sign(_fallyspd), obj_collideleftdown);
					if(instance_exists(bb) && _fallyspd > 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_y = false;
					}
				}
				if(place_meeting(x, y+sign(_fallyspd), obj_colliderightup)){
					var bb = instance_place(x,y+sign(_fallyspd), obj_colliderightup);
					if(instance_exists(bb) && _fallyspd < 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_y = false;
					}
				}
				if(place_meeting(x, y+sign(_fallyspd), obj_colliderightdown)){
					var bb = instance_place(x,y+sign(_fallyspd), obj_colliderightdown);
					if(instance_exists(bb) && _fallyspd > 0 && (bb._collidewith == "all" || bb._collidewith == "enemy")){
						go_y = false;
					}
				}
				
				//special cases
				if(place_meeting(x, y+sign(_fallyspd), obj_slidespot)){
					var inst = instance_place(x, y+sign(_fallyspd), obj_slidespot);
					if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height < inst._height && (inst._collidewith == "all" || inst._collidewith == "enemy")){
						go_y = false;
					}
				}
				
				if(go_y){
					y += sign(_fallyspd); 
				} else {
					if(!_slide){
						if(_walltouch_y <= 0 && !_fixwall){
							wallbonk();
						}
					}
						
					if(!_fixwall){
						_walltouch_y = 4;
						if(_fallyspd > 0){
							_boundwall.down = 4;
						} else if(_fallyspd < 0){
							_boundwall.up = 4;
						}
						_fallyspd = 0;
						_floaty = 0;
					}
						
					if(_slideact >= 1){
						_slide = false;
						_slidetimer = 0;
						_slideact = 0;
					}
					break;
				}
			}
			
			if(_walltouch > 0){
				_walltouch --;
			} else if(_walltouch < 0){
				_walltouch = 0;
			}
			
			if(_walltouch_y > 0){
				_walltouch_y --;
			} else if(_walltouch_y < 0){
				_walltouch_y = 0;
			}
			
			
			//bounding box wall
			if(_boundwall.left > 0){
				_boundwall.left --;
			}
			if(_boundwall.right > 0){
				_boundwall.right --;
			}
			if(_boundwall.up > 0){
				_boundwall.up --;
			}
			if(_boundwall.down > 0){
				_boundwall.down --;
			}
			
			if(!_freespd){
				_fallxspd = 0;
				_floatx = 0;
				
				_fallyspd = 0;
				_floaty = 0;
			}
			
			//wall stuck fix
			var colarray = [
				obj_solid,
				obj_collideleft,
				obj_collideright,
				obj_collideup,
				obj_collidedown,
				obj_collideleftup,
				obj_colliderightup,
				obj_collideleftdown,
				obj_colliderightdown,
			];
			/*if(_anim == "idle" && place_meeting_array(x, y, colarray, false, true) && _afterhop <= 0){
				_afterhop = 32;
				_fixwall = true;
			}*/
			
		} else {
			if(!_death){
				if(_behaviortype == "move" || _curstate == STATE_ATTACK || _curstate == STATE_IDLE){
					if(global._enmCollideCooldown <= 0){
						if(_crouchkicktime <= 0 && _hop_cooldownthing <= 0){
							var hopcd = 115;
							if(place_meeting_array(x, y, _collide_enemy)){
								var enemy = place_meeting_array(x, y, _collide_enemy, true, true);
								if(variable_instance_exists(enemy, "_hop_cooldownthing")){
									if(enemy.id != self.id && _do_walk_hop && !_grabbed && enemy._hop_cooldownthing <= 0 && !enemy._grabbed && !_falling && !enemy._falling && !_fall_ko && !enemy._fall_ko && (enemy._behaviortype == "move" || enemy._curstate == STATE_ATTACK || enemy._curstate == STATE_IDLE)){
										global._curEnmCollide = [self, enemy];
										global._enmCollideCooldown = 2;
										_hop_cooldownthing = hopcd;
										enemy._hop_cooldownthing = hopcd;
									}
								}
							}
							if(place_meeting(x+((sprite_width/2)*-_curdir),y+((sprite_height/2)*-_vdir),obj_battleborder)){
								if(_do_walk_hop && !_grabbed && !_falling && !_fall_ko){
									global._curEnmCollide = [self, self];
									global._enmCollideCooldown = 2;
									_hop_cooldownthing = hopcd;
								}
							}
						}
					}
				}
				
				//attacks
				if(!_standup && !_falling && !_fall_ko && !_grabbed && !_grabdodge && _docrouchkick){
					_crouchkicktime = _crouchkicktime_max;
					
					_displayobj.image_index = 0;
					_attack = true;
					_attacktype = "crouch";
					
					if(_playvoice.atk != -1){
						voice_play_overlap_proximity(_playvoice.atk, 1);
					}
					sfx_play_choose_proximity(global._swishsounds[0]);
					
					_docrouchkick = false;
				}
				
				switch(_behaviortype){
					case "move":
						//pathfinding movement
						if(!_attack && _hurttimer <= 0 && !_mashed && _spottimer <= 0 && _blocktimer <= 0){
							clearpath();
							_path = path_add();
							if(path_exists(_path) && mp_grid_path(_pathgrid, _path, x, y, _pathpoint[0],_pathpoint[1], 1)){
								_drawifmoving = 1;
								if(_freeze <= 0){
									var spd = _movespd[? _spdmode]*_spdmult;
									if(_total_ailevel >= 5 && _curstate == STATE_FOLLOW && _dh != noone && instance_exists(_dh)){
										if(_backofftime <= 0 && distance_to_object(_dh) <= _dhdist[0]*2 && _forceattack){
											spd = _movespd[? _spdmode]*_spdmult*1.6;
										}
									}
									path_start(_path, spd, path_action_stop, true);
								}
							}
						} else {
							_curspd = [0,0];
							clearpath();
							_path = path_add();
						}
					break;
					case "hopping":
						if(_blocktimer > 0 || _mashed || _successparry > 0 || _taunt > 0 || _shockwave > 0){
							_hop_arc = 0;
							_hop_arcstart = true;
							_afterhop = 8;
						} else {
							_block = false;
							_blocktimer = 0;
							
							_stun = false;
							_stuntimer = 0;
							_stunpunch = 0;
							_slide = false;
							
							if(_docrouchkick){
								_hop_arc = 0;
								_hop_arcstart = true;
								_afterhop = 8;
							}
				
							//"hop" to a position in an arc
							_curspd = [0,0];
							clearpath();
					
							if(!_hop_walk){
								_height = _groundlevel+2;
							}
							_fall_ko = false;
							_standup = false;
					
							//arc code
							
							if(_anim == "hop"){
								_afterim_active = 0;
							}
							
							if(!_hop_walk){
								//jump towards jump point
								_hop_time = clamp(_hop_time + _hop_spd, 0, 1);
								x = lerp(_hop_startpos[0], _jumptopos[0], _hop_time);
								_hop_base_y = lerp(_hop_startpos[1], _jumptopos[1], _hop_time);

								_prev_hop_arc = _hop_arc;
								_hop_arc = _hop_archeight * _hop_time * (_hop_time - 1);
							
								if(_hop_arc <= -8){
									_hop_arcstart = true;
								}
								y = _hop_base_y;
					
								if(_hop_quiet <= 0){
									if(_hop_arcstart){
										if(!_hop_snd){
											sfx_play_proximity(snd_jump);
											_hop_snd = true;
										}
									}
								}
							} else {
								//walk towards jump point
								if(x < _jumptopos[0]){
									x += _hop_walkspeed;
								} else if(x > _jumptopos[0]){
									x -= _hop_walkspeed;
								}
								
								if(y < _jumptopos[1]){
									y += _hop_walkspeed;
								} else if(y > _jumptopos[1]){
									y -= _hop_walkspeed;
								}
								
								//stop incase interrupted by player
								if(_hurttimer > 0 || _falling || _standup || _blocktimer > 0 || _dodgetimer > 0){
									_hop_arc = 0;
									_hop_arcstart = true;
									_fixwall = true;
									_afterhop = 8;
								}
							}
						}
						
						//finish arc
						if((!_hop_walk && _hop_arcstart && _hop_arc >= 0) || (_hop_walk && diff_abs(x,_jumptopos[0]) < _hop_walkspeed && diff_abs(y,_jumptopos[1]) < _hop_walkspeed)){
							_fixwall = true;
							_afterhop = 8;
							
							_hop_arc = 0;
							if(_total_ailevel <= 3){
								_curstate = STATE_IDLE;
							} else {
								_curstate = STATE_WALK;
							}
							if(_hop_quiet <= 0){
								if(!_attack){
									with(obj_camera){
										_ampY = 14;
									}
								} else {
									with(obj_camera){
										_ampY = 20;
									}
									for(var ii = 0; ii < 2; ii++){
										var p = instance_create_depth(x-42, y+32, depth, obj_particle);
										p._move = true;
										if(ii == 0){
											p._type = "run4";
											p._xspd = -14;
										} else if(ii == 1){
											p._type = "run5";
											p._xspd = 14;
										}
									}
									sfx_play_choose_proximity([snd_thud,snd_thud2,snd_thud3,snd_thud4]);
								}
								sfx_play_choose_proximity([asset_get_index("snd_land1_"+_floortype),asset_get_index("snd_land2_"+_floortype)]);
							}
							
							if(!_falling && _hopslide){
								_dh = instance_nearest(x, y, obj_dh_mask);
								if(instance_exists(_dh)){
									if(x < _dh.x){
										_curdir = DIR_R;
									} else {
										_curdir = DIR_L;
									}
								}
							
								doslide();
								
								_hopslide = false;
							}
						} else {
							_curstate = STATE_JUMP;
						}
					break;
				}
			}
		}
		
		if(!_death){
			if(_mashed){
				_stuntimer = 0;
				_stunpunch = 0;
				if(!_falling && !_fall_ko && !_standup){
					//enemy is being mashed
					_behaviortype = "idle";
					if(_mashedobj != noone && instance_exists(_mashedobj) && _mashedobj._mashact > 0){
						_displayobj._depthoffset = 128;
						x = lerp(x, _mashedobj.x+(230*_mashedobj._curdir), 0.12);
						_curdir = _mashedobj._curdir;
						y = lerp(y, _mashedobj.y, 0.12);
					}
					if(_hurttimer > 0){
						_dispoffset = [random_range(-10,10),random_range(-10,10)];
					} else {
						_dispoffset = [0,0];
					}
					_mashedtimer ++;
					if(_mashedtimer >= 320){
						_mashed = false;
					}
					if(_mashedobj != noone && instance_exists(_mashedobj)){
						if(_hurttimer <= 0){
							if(_mashedobj.x < x){
								_curdir = DIR_R;
							} else {
								_curdir = DIR_L;
							}
						}
						if(_mashedobj._mashact == 0){
							_mashed = false;
						}
					}
				} else {
					_mashed = false;
					_mashedobj = noone;
				}
			} else {
				_mashedtimer = 0;
				_displayobj._depthoffset = 0;
			}
		}
		
		_total_ailevel = _ailevel*_ailevel_mult;
		/*if(_ailevel <= 3){
			_total_ailevel = _ailevel+(_ailevel_mult*2);
		}*/
	}

	if(!_death){
		if(type == "walk"){
			if(!_falling && !_fall_ko && !_standup){
				//walk randomly
				if(_anim == "idle"){
					_badidletimer ++;
					if(_badidletimer >= scr_ailevel(4, random_range(15,36))){
						//reset state if enemy is idling for a bit
						_curstate = STATE_IDLE;
						_standtimer = 96;
						_walksuccess = false;
						_walktimer = 255;
						_badidletimer = 0;
					}
				} else {
					_badidletimer = 0;
				}
			
				if(path_exists(_path) && !scr_check_path_end(_path)){
					_interest = 0;
				}
			
				if(_panictimer <= 0){
					if(_interest <= 0){
						var sourcepos = [x,y];
						//dh found, walk around dh
				
						var care = true;
						if(_codename = "st2_enm3" && variable_instance_exists(self.id, "_gl_passive")){
							if(_gl_passive){
								care = false;
							}
						}
				
						var dh = instance_nearest(x,y,obj_dh_mask);
						if(instance_exists(dh) && distance_to_object(dh) >= _dhdist[0]){
							care = false;
						}
						if(care){
							if(instance_exists(dh)){
								if(path_exists(_path) && scr_check_path_end(_path)){
									_interest = 60;
									_curstate = STATE_FOLLOW;
						
									_pointtime = 8;
									sourcepos = [dh.x+_randoffset[0], dh.y+_randoffset[1]];
								}
							}
						}
						//otherwise walk around its own position
					
					
						//enemy reached the point
						if(diff_abs(_walktopos[0],x) <= 32 && diff_abs(_walktopos[1],y) <= 32 && _walktimer < 40){
							_walktimer = 40;
						}
					
						//reset walking point
						if(_walktimer >= scr_ailevel(45,random_range(90, 120))){
							if(!_walksuccess){
								_walktopos[0] = sourcepos[0]+random_range(-_walkdist[0],_walkdist[0]);
								_walktopos[1] = sourcepos[1]+random_range(-_walkdist[1],_walkdist[1]);
						
								var fakex = x;
								var fakey = y;
								var prevx = x;
								var prevy = y;
						
								//normalize distance, account for walls
								repeat(16){
									if(place_meeting_array(fakex, fakey, _collide_solid) || place_meeting(fakex, fakey, obj_battleborder)){
										fakex = prevx;
										fakey = prevy;
										break;
									} else {
										if(fakex > _walktopos[0]){
											prevx = fakex;
											fakex -= 12;
										} else if(fakex < _walktopos[0]){
											prevx = fakex;
											fakex += 12;
										}
										if(fakey > _walktopos[1]){
											prevy = fakey;
											fakey -= 12;
										} else if(fakey < _walktopos[1]){
											prevy = fakey;
											fakey += 12;
										}
									}
								}
						
								_walktopos[0] = fakex;
								_walktopos[1] = fakey;
						
								_pointtime = 8;
								if(diff_abs(_walktopos[0], x) <= 64 && diff_abs(_walktopos[1], y) <= 64){
									_walktopos[0] = x;
									_walktopos[1] = y;
									_walktimer = 120;
								} else {
									_pathpoint = [_walktopos[0], _walktopos[1]];
									_walksuccess = true;
								}
							} else {
								_walktimer = 0;
								_walkto = [_walktopos[0],_walktopos[1]];
								_walksuccess = false;
							}
						} else {
							//reset
							_walksuccess = false;
							_walktopos = [x,y]; 
						}
					} else {
						_dh = instance_nearest(x, y, obj_dh_mask);
						if(instance_exists(_dh)){
							if(path_exists(_path) && scr_check_path_end(_path)){
								if(_curstate != STATE_FOLLOW){
									scr_dh_pathpoint();
							
									_pointtime = 8;
									_interest = 70;
									_curstate = STATE_FOLLOW;
								}
							} else {
								_interest = 0;
							}
						} else {
							_interest = 0;
						}
					}
				} else {
					//panic away
					_walkto = [_panicspot[0],_panicspot[1]];
					_spdmode = SPD_PANIC;
				}
			}
		}
	}
	
	if(!_death){
		if(type == "follow"){
			if(_anim == "idle"){
				_badidletimer ++;
				if(_badidletimer >= scr_ailevel(4, random_range(15,36))){
					//reset state if enemy is idling for a bit
					_curstate = STATE_WALK;
					_interest = 0;
					_walktimer = 999;
					_badidletimer = 0;
				}
			} else {
				_badidletimer = 0;
			}
			
			//follow dh
			_dh = instance_nearest(x, y, obj_dh_mask);
			if(instance_exists(_dh)){
				var closedist = 280;
				var backoffdist = 96;
							
				check_occupy();
			
				if(!_falling && !_fall_ko && !_standup){
					if(path_exists(_path) && scr_check_path_end(_path)){
						_pathpoint = [_walkto[0],_walkto[1]];
						_pointtime = 8;
						_interest = 60;
						if(_panictimer <= 0){
							if(_available[0] || _available[1]){
								//check occupied spots, take one if free
								if(_available[0] && !_available[1]){
									_walkto = [_dh.x-_dh._occupdist-_attackdist,_dh.y];
								}
								if(_available[1] && !_available[0]){
									_walkto = [_dh.x+_dh._occupdist+_attackdist,_dh.y];
								}
										
								if(_available[0] && x < _dh.x){
									_walkto = [_dh.x-_dh._occupdist-_attackdist,_dh.y];
								} else if(_available[1] && x > _dh.x){
									_walkto = [_dh.x+_dh._occupdist+_attackdist,_dh.y];
								}
								
								//enemy is very close to occupied spot
								if(distance_to_object(_dh) < closedist && distance_to_object(_dh) > 48){
									if(has_trait(TRAIT_BACKOFF) && _total_ailevel >= 3){
										if(_stuntimer <= 0 && !_spin){
											//backing off, right
											if(x < _dh.x && _dh._curdir == DIR_L && _dh.totalspd[0] <= -(_dh._maxspd[0]-2)){
												_walkto = [x - backoffdist, y-diff_abs(y, _dh.y)];
												_spdmode = SPD_BACK;
												_backoff = 3;
											}
											if(_available[0] && x < _dh.x){
												_curdir = DIR_R;
											}
									
											//backing off, left
											if(x > _dh.x && _dh._curdir == DIR_R && _dh.totalspd[0] >= _dh._maxspd[0]-2){
												_walkto = [x + backoffdist, y-diff_abs(y, _dh.y)];
												_spdmode = SPD_BACK;
												_backoff = 3;
											}
											if(_available[1] && x >= _dh.x){
												_curdir = DIR_L;
											}
										}
									}
								}
								
								//attacking if almost at the spot
								if(!_block && _spdmode != 1){
									if(diff_abs(x, _walkto[0]) <= 64 && diff_abs(y, _walkto[1]) <= 64){
										if(_dh.x > x){
											_curdir = DIR_R;
										} else {
											_curdir = DIR_L;
										}
										if(_total_ailevel > 4){
											_atktimer = 999;
										}
										_interest = 30;
										_curstate = STATE_ATTACK;
									}
								}
							}
										
							if(!_available[0] && !_available[1]){
								if(distance_to_object(_dh) > HEIGHT){
									_interest = 0;
								} else {
									if(diff_abs(x, _walkto[0]) <= 64 && diff_abs(y, _walkto[1]) <= 64){
										_walkto = [_dh.x+(random_range(-_walkdist[0],_walkdist[0])*0.6),_dh.y+(random_range(-_walkdist[1],_walkdist[1])*0.6)];
									}
								}
							}
						} else {
							//panic away
							_walkto = [_panicspot[0],_panicspot[1]];
							_spdmode = SPD_PANIC;
						}
					} else {
						clearpath();
						_interest = 0;
					}
					
					if(distance_to_object(_dh) < _dhdist[0]){
						_interest = 30;
						_walktimer = 999;
					}
				}
					
				if(_path == 0){
					_interest = 0;
				}
			}
			if(_interest <= 0 && _forceattack <= 0){
				_state_cooldown = 24;
				_curstate = STATE_WALK;
			}
		}
	}
	
	if(!_death){
		if(type == "attack"){
			if(!_falling && !_fall_ko && !_standup){
				_atktimer ++;
				if(_attack){
					clearpath();
				} else {
					_badidletimer ++;
					if(_badidletimer >= 12){
						_curstate = STATE_WALK;
						_walktimer = 64;
						_badidletimer = 0;
					}
				}
				_dh = instance_nearest(x, y, obj_dh_mask);
				if(_dh != noone && instance_exists(_dh)){
					if(!_dh._falling && !_dh._dead){
						if(_dh._mashact == 0 && _dh._invframe <= 0 && _dh._hurtTimer <= 0){
							if(_atktimer >= scr_ailevel(8,42)){
								_curatktimer = _atktimer + 10;
								_atktimer = 0;
								//direction
								if(_dh.x < x){
									_curdir = DIR_L;
								} else {
									_curdir = DIR_R;
								}
							
								var pass = true;
								if(_codename == "boss2" && variable_instance_exists(self.id, "_ll_atk3_act")){
									if(_ll_atk2_attack || _ll_atk3_act > 0 || _ll_atk4_act > 0 || _ll_atk5_act > 0 || _ll_atk6_act > 0){
										pass = false;
									}
								}
								if(pass){
									if(!_dh._crouch && _attacktype != "blockko"){
										x += 8*_curdir;
						
										_curatk ++;
							
										_displayobj.image_index = 0;
										_attack = true;
										_attacktype = "idle";
						
										//exceptions
										if(has_trait(TRAIT_JABS)){
											//create enemy attack
								
											if(_specialatk <= 0 && _jabstop <= 0){
												var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
												atk._parentobj = self.id;
												atk._ptype = "enm";
												atk._scale = [4, 2.2];
												atk._offset = [136,-76];
												atk._timer = 9;
												if(_curatk > _meleeanims){
													
													atk._frame = _atkdelay.meleeko;
													atk._damage = ATK_KO;
													_curatk = 0;
												}
									
												sfx_play_choose_proximity(global._swishsounds[0]);
											}
										}
									} else {
										//crouch kick if dynamitehead is seen dodging attacks by crouching
										_curatk = 0;
										var requirecrouchai = 4;
										if(_codename == "boss2"){
											requirecrouchai = 0;
										}
										if(_total_ailevel >= requirecrouchai){
											if(has_trait(TRAIT_CROUCHKO)){
												if(distance_to_object(_dh) <= 320){
													if(_ckick_cd <= 0 && !_standup && !_hop_walk && !_grabbed && !_grabdodge){
														_fall_ko = true;
														_jump = true;
														_standup = true;
														_grabout = false;
														_fallabove = false;
														_height = _groundlevel+1;
														_vspd = 12;
														_nocrouchatk = false;
														_docrouchkick = true;	
														_ckick_cd = 180;
													}
												} else {
													_curstate = STATE_WALK;
												}
											} else {
												_curstate = STATE_WALK;
											}
										} else {
											_curstate = STATE_WALK;
										}
									}
								}
							}
						}
					}
				}
					
				//back into walking state if no punches were landed / dh too far away
				if(_interest == 0 && _forceattack <= 0){
					_walktimer = 0;
					_curstate = STATE_WALK;
				}
				if(_dh != noone && instance_exists(_dh)){
					if(distance_to_object(_dh) >= 240){
						_interest = 0;
						_curstate = STATE_WALK;
					}
				}
			}
		}
	}
	
	if(!_death){
		if(type == "battlezone"){
			//battlezone behavior
			if(_behaviortype == "move"){
				if(_battlezone && _bzstart > 0){
					if(_bzobj != noone && instance_exists(_bzobj)){
						_walkto = [_bzobj.x+_bzstart_offset[0],_bzobj.y+_bzstart_offset[1]];
					}
				}
			}
			if(_bzstart > 0){
				_bzstart --;
			}
			if(_bzstart <= 0 && !_initcol){
				do_grid_collisions();
				_initcol = true;
			}
		}
	
		if(type == "grab"){
			//being grabbed
			if(_grabbed){
				clearpath();
				_curstate = STATE_OTHER;
				_standup = false;
					
				if(_dh != noone && instance_exists(_dh)){
					if(_dh._grabtimer >= 1){
						var animval = -1;
						var dirval = 1;
						var offsety_ = 0;
						_slam = false;
						if(_dh._anim == "grab"){
							animval = 0;
						} else if(_dh._anim == "pick_idle"){
							animval = 1;
						} else if(_dh._anim == "pick_walk"){
							animval = 2;
						} else if(_dh._anim == "grab_fail"){
							animval = 3;
						} else if(_dh._anim == "slam"){
							_slam = true;
							animval = 4;
						} else if(_dh._anim == "grabdown"){
							animval = 5;
						}
						if(animval == 0){
							_grabstart = true;
						} else {
							if(_grabstart){
								_grabtr = true;
								_grabstart = false;
							}
						}
						if(!_falling && _grabstart){
							if(_dh.x > x){
								_curdir = DIR_R;
							} else {
								_curdir = DIR_L;
							}
						}
				
						if(_slam){
							_grabtr = false;
						}
				
						if(!_grabtr){
							_grabtr = 0;
							if(animval == 0){
								offsety_ = 72;
							}
							if(animval >= 1 && animval < 4){
								offsety_ = -200;
							}
						} else {
							offsety_ = _grabtr_offset;
							_grabtr_offset = lerp(_grabtr_offset, -200, 0.17);
							if(diff_abs(_grabtr_offset, -200) < 16){
								_grabtr = false;
							}
						}
						
						if(!_falling){
							dirval = _dh._curdir;
							if(animval != -1){
								var numframes = array_length(_dh._graboffset[animval]);
								var curframe = floor(min(_dh._displayobj.image_index,numframes-1));
								_graboffset[0] = _dh._graboffset[animval][curframe][0]*dirval;
								_graboffset[1] = _dh._graboffset[animval][curframe][1];
						
								_dh._graboffsetsimple[0] = _dh._graboffset[animval][curframe][0]*dirval;
								_dh._graboffsetsimple[1] = _dh._graboffset[animval][curframe][1];
						
								if(_slam){
									_displayobj.image_index = curframe;
								}
							}
							
							_grabDrawX = _dh.x+_graboffset[0];
							_grabDrawY = _dh.y+_graboffset[1]+offsety_;
							
							_curdir = _dh._curdir;
							
							if(_dh._grabtimer >= 3){
								_jumptopos = [_dh.x,_dh.y];
								x = _dh.x;
								y = _dh.y;
							}
						}
						
						if(!_slam){
							_grabresist ++;
							if(_grabresist_curtimer == 0){
								_grabresist_curtimer = max(1,_grabresist_timer+random_range(-60,60));
							}
							if(_grabresist >= scr_ailevel(22, _grabresist_curtimer)){
								//jump out when being grabbed for too long
								with(_dh){
									_spd = [0,0];
									_randhurt = 1;
									_push = true;
									_hurtTimer = 14;
									force_throw_enemy();
								}
								sfx_play_proximity(snd_jump);
								_jumpoff_snd = true;
								_interest = 0;
							}
						}
					} else {
						//"picked up" direction and position
						var groffset = 0;
						if(_dh.x > x){
							if(!_falling){
								_curdir = DIR_L;
							}
							groffset = 24;
						} else {
							if(!_falling){
								_curdir = DIR_R;
							}
							groffset = -24;
						}
						
						_grabDrawX = x+groffset;
						_grabDrawY = y+46;
					}
				}
			} else {
				_grabDrawX = x;
				_grabDrawY = y;
				_grabresist_curtimer = 0;
				_grabresist = 0;
				_slam = false;
				_graboffset = [0,0];
			}
		}
	}
}