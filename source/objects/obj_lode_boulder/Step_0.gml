{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		if(!global._lode_editor){
			if(!_checkdelete){
				if(ds_map_exists(global._lode_deletedStuff, _id)){
					x = global._lode_deletedStuff[? _id].xx;
					y = global._lode_deletedStuff[? _id].yy;
					_tilepos = global._lode_deletedStuff[? _id]._tilepos;
					if(global._lode_deletedStuff[? _id].delete_){
						_project = false;
					}
				}
				_checkdelete = true;
			}
			
			if(_freeze <= 0){
				//player interaction
				if(_forceboulder <= 0){
					if(_groundtimer > 0){
						var doparticle = false;
						if(place_meeting(x-1,y,obj_lode_plr)){
							var plr = instance_place(x-1,y,obj_lode_plr);
							if(instance_exists(plr) && plr._holdR && diff_abs(plr.y-sprite_height,y-4)<=_movespd){
								if(!place_meeting_array(x+4,y,global._lode_collide_solid) && !place_meeting(x+4,y,obj_lode_plr)){
									plr._pushtimer = 4;
									_xspd = plr._movespd;
									_plrxspd = _xspd;
								
									doparticle = true;
								}
							}
						} else if(place_meeting(x+1,y,obj_lode_plr)){
							var plr = instance_place(x+1,y,obj_lode_plr);
							if(instance_exists(plr) && plr._holdL && diff_abs(plr.y-sprite_height,y-4)<=_movespd){
								if(!place_meeting_array(x-4,y,global._lode_collide_solid) && !place_meeting(x-4,y,obj_lode_plr)){
									plr._pushtimer = 4;
									_xspd = -plr._movespd;
									_plrxspd = -_xspd;
								
									doparticle = true;
								}
							}
						} else {
							if(_plrxspd != 0){
								_plrxspd = 0;
								_xspd = 0;
							}
						}
					
						if(doparticle){
							if(_project){
								global._lode_deletedStuff[? _id] = {
									xx: x,
									yy: y,
									_tilepos: _tilepos,
									delete_: false,
								}
							}
						
							_particle_timer += global._lode_spd;
							if(_particle_timer >= random_range(9,14)){
								var p = instance_create_depth(x+(sprite_width*0.5),y+sprite_height-5,0,obj_particle);
								p._lode_particle = true;
								p._type = "lode_break";
								p._move = true;
								p._xspd = -(_xspd*random_range(1,1.23));
							
								_particle_timer = 0;
							}
						}
					} else {
						_xspd = 0;
					}
				}
				if(_tilelayer != -1){
					if(_groundtimer > 0){
						var poscheck = [_tilepos[1],_tilepos[0]];
					
						var tiles = [LTILE_SOL,LTILE_ENMCOL,LTILE_BOL,LTILE_PLR,LTILE_LDR];
					
						var checkers = [-1,1];
						if(_forceboulder <= 0){
							for(var i = 0; i < 2; i++){
								poscheck = [_tilepos[0]+1,_tilepos[1]+checkers[i]];
								var cancheck = true;
								if(poscheck[0] < 0 || poscheck[1] < 0){
									cancheck = false;
								}
								if(poscheck[0] >= array_length(global._stage_layout[_tilelayer])){
									cancheck = false;
								} else {
									if(poscheck[0] >= 0 && poscheck[1] >= array_length(global._stage_layout[_tilelayer][poscheck[0]])){
										cancheck = false;
									}
								}
					
								if(cancheck){
									if(global._stage_layout[_tilelayer][poscheck[0]][poscheck[1]] == LTILE_AIR){
										if(!array_contains(tiles,global._stage_layout[_tilelayer][poscheck[0]-1][poscheck[1]])){
											if(!array_contains(tiles,global._stage_layout[_tilelayer][poscheck[0]][poscheck[1]])){
												_forceboulder = 16;
												_bouldspd = _movespd*checkers[i];
												_cantdig = 30;
											}
										}
									}
								}	
							}
						}
					} else {
						_forceboulder = 0;
						_bouldspd = 0;
					}
				}
			
				if(_forceboulder > 0){
					_xspd = _bouldspd;
					_forceboulder --;
				}
				if(_cantdig > 0){
					_cantdig --;
				}
		
				_fallspd = max(1,_movespd*1.25);
				_yspd = _fallspd;
		
				//collision and movement
				_frac_x = frac(_xspd*global._lode_spd);
				_frac_y = frac(_yspd*global._lode_spd);
		
				//x speed
				var amntx = _xspd*global._lode_spd;
				if(_xspd > 0){
					amntx = floor(_xspd*global._lode_spd);
				} else {
					amntx = ceil(_xspd*global._lode_spd);
				}
				
				repeat(abs(amntx)){
					_go_x = true;
					var pixel = sign(_xspd*global._lode_spd);
			
					checkcol(pixel, COL_X);
			
					if(_go_x){
						x += pixel;
					} else {
						_xspd = 0;
					}
				}
		
				//x fraction
				if(_frac_x <> 0){
					_go_x = true;
					var pixel = _frac_x;
			
					checkcol(pixel, COL_X);
			
					if(_go_x){
						x += pixel;
					} else {
						_xspd = 0;
					}
				}
		
				//y speed
				var amnty = _yspd*global._lode_spd;
				if(_yspd > 0){
					amnty = floor(_yspd*global._lode_spd);
				} else {
					amnty = ceil(_yspd*global._lode_spd);
				}
				repeat(abs(amnty)){
					_go_y = true;
					var pixel = sign(_yspd*global._lode_spd);
			
					checkcol(pixel, COL_Y);
			
					if(_go_y){
						y += pixel;
					} else {
						if(_yspd > 0){
							_groundtimer = 2;
						}
						_yspd = 0;
					}
				}
		
				//y fraction
				if(_frac_y <> 0){
					_go_y = true;
					var pixel = _frac_y;
			
					checkcol(pixel, COL_Y);
			
					if(_go_y){
						y += pixel;
					} else {
						if(_yspd > 0){
							_groundtimer = 2;
						}
						_yspd = 0;
					}
				}
		
				//other
				if(_groundtimer > 0){
					_groundtimer -= 1;
					
					if(!_ground_particle){
						var p = instance_create_depth(x+(sprite_width*0.5)-2,y-1+sprite_height,0,obj_particle);
						p._type = "lode_land";
						p._lode_particle = true;
					
						sfx_play_proximity(snd_lode_land,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
					
						_ground_particle = true;
					}
				} else {
					_ground_particle = false;
				}
		
				_frac_x = 0;
				_frac_y = 0;
			
				_prevpos[1] = _tilepos[1];
				_prevpos[0] = _tilepos[0];
				_tilepos[1] = round(x/global._lode_tilesize);
				_tilepos[0] = round(y/global._lode_tilesize);
		
				//update map
				if(_tilelayer != -1){
					_tilelayer = 1;
				
					if((_tilepos[0] >= 0 && _tilepos[1] >= 0) && (_tilepos[0] <= array_length(global._stage_layout[0])-1 && _tilepos[1] <= array_length(global._stage_layout[0][0])-1)){
						if((_prevpos[0] >= 0 && _prevpos[1] >= 0) && (_prevpos[0] <= array_length(global._stage_layout[0])-1 && _prevpos[1] <= array_length(global._stage_layout[0][0])-1)){
							if(_prevpos[0] != _tilepos[0] || _prevpos[1] != _tilepos[1]){
								var allowtiles = [LTILE_AIR];
								if(array_contains(allowtiles,global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]])){
									global._stage_layout[_tilelayer][_prevpos[0]][_prevpos[1]] = LTILE_AIR;
									if(_tilelayer == 0){
										global._stage_layout[_tilelayer][_prevpos[0]][_prevpos[1]] = global._stage_layout_bg[_prevpos[0]][_prevpos[1]];
									}
									global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]] = LTILE_BOL;
								}
					
								_prevpos[1] = _tilepos[1];
								_prevpos[0] = _tilepos[0];
							}
						}
					}
				} else {
					_tilelayer = 1;
				}
			
				//collectable interaction
				if(_collect_cd <= 0 && !_collectable && place_meeting(x,y,obj_lode_collect)){
					var collect = instance_place(x,y,obj_lode_collect);
					if(instance_exists(collect) && collect._checkdelete && collect._project){
						if(global._stage_layout[0][collect._tilepos[0]][collect._tilepos[1]] == LTILE_COL){
							global._stage_layout[0][collect._tilepos[0]][collect._tilepos[1]] = LTILE_AIR;
						}
						if(global._stage_layout[1][collect._tilepos[0]][collect._tilepos[1]] == LTILE_COL){
							global._stage_layout[1][collect._tilepos[0]][collect._tilepos[1]] = LTILE_AIR;
						}
				
						_collectable = true;
						_collectable_id = collect._id;
				
						sfx_play_proximity(snd_lode_monyx,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
				
						instance_destroy(collect.id);
					}
				}
			
				if(_collect_cd > 0){
					_collect_cd --;
				}
			
				image_blend = c_white;
				if(_collectable){
					if(_sparkles == noone){
						_sparkles = instance_create_depth(x,y,0,obj_lode_follower_collect);
						_sparkles._id = "collect"+string(x+y)+string(irandom(99999));
						_sparkles._parentobj = self;
					}
					image_blend = global._lode_collectblend;
				} else {
					if(_sparkles != noone && instance_exists(_sparkles)){
						instance_destroy(_sparkles);
						_sparkles = noone;
					}
				}
			} else {
				_freeze --;
			}
		}
		
		scr_lode_overtile();
		
		_disppos = [x,y];
		
		if(_project){
			scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale],0,0,image_blend);
		} else {
			_deadtimer ++;
			if(_deadtimer >= 2){
				scr_lode_remove_project();
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}