{
	if(!_shadowsinit){
		//shadows
		global._gameshadows[? self.id] = ds_map_create();
		global._gameshadows[? self.id][? "draw"] = false;
		global._gameshadows[? self.id][? "x"] = x;
		global._gameshadows[? self.id][? "y"] = y;
		global._gameshadows[? self.id][? "scalex"] = 0;
		global._gameshadows[? self.id][? "scaley"] = 0;
		
		_shadowsinit = true;
	}
	
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				if(place_meeting(x,y,obj_solid)){
					var sol = instance_place(x,y,obj_solid);
					if(instance_exists(sol) && sol._delete){
						instance_destroy(sol.id);
					}
				}
				
				ds_map_delete(global._gameshadows, self.id);
				instance_destroy();
			}
		}
		_checkdelete = true;
	}
	
	if(!global._pause){
		if(_shadowsinit){
			var shadowmult = clamp(0, 1-((_height)/570), 1);
			if(ds_map_exists(global._gameshadows, self.id)){
				global._gameshadows[? self.id][? "draw"] = true;
				global._gameshadows[? self.id][? "y"] = y+_offsety;
				global._gameshadows[? self.id][? "scalex"] = 0.4*shadowmult;
				global._gameshadows[? self.id][? "scaley"] = 0.4*shadowmult;
			}
		}
		
		image_speed = 1;
		
		if(_height <= _groundlevel){
			_timer ++;
			if(_timer % 3 < 1){
				_storepos = y;
			}
			
			if(y <> _storepos){
				_walktimer = 2;
			} else {
				_walktimer --;
			}
			
			//dodging
			if(!_dead){
				if(place_meeting(x,y,obj_punchhitbox)){
					var hbox = instance_place(x,y,obj_punchhitbox);
					if(instance_exists(hbox)){
						if(hbox._type == "crouch"){
							sfx_play(snd_finalko);
							sfx_play_choose(global._kdsounds);
							sfx_pitch(snd_finalko, 1.35);
								
							var p = instance_create_depth(x,y,depth, obj_particle);
							p._type = "hit_final";
							global._contrasthit = global._contrasthit_max;
								
							if(instance_exists(_dh)){
								(_dh._displayobj).image_index = 1;
								
								_death_inst = _dh;
							}
							
							global._hits += 1;
							global._hitmeter = 50;
								
							with(obj_tipbox){
								if(_prompt == "lowkick"){
									global._deletedStuff[? self.id] = self.id;
									instance_destroy();
								}
							}
					
							global._gametips[? "lowkick"][1] = true;
								
							if(place_meeting(x,y,obj_solid)){
								var sol = instance_place(x,y,obj_solid);
								if(instance_exists(sol) && sol._delete){
									instance_destroy(sol.id);
								}
							}
								
							var p = instance_create_depth(x-24,y-96,depth-16,obj_particle);
							p._type = "fx6";
								
							global._pad_vibrate = 20;
							ds_map_delete(global._gameshadows, self.id);
								
							_dead = true;
						} else {
							image_index = 0;
							_dodge = true;
						}
					
						instance_destroy(hbox.id);
					}
				}
				if(place_meeting(x-160,y,obj_dh_mask)){
					var dh = instance_place(x-160,y,obj_dh_mask);
					if(instance_exists(dh)){
						if(_grabcd <= 0 && !_dodge && dh._curdir == DIR_R && dh._anim == "grab"){
							image_index = 0;
							_dodge = true;
							_grabcd = 24;
						}
					}
				}
			}
			
			if(_grabcd > 0){
				_grabcd --;
			}
			
			if(!_dodge){
				if(_walktimer <= 0){
					sprite_index = spr_st2_bw_idle;
					_dirttimer = 0;
				} else {
					sprite_index = spr_st2_bw_walk;
					if(distance_to_point(global._cameraX+(WIDTH*0.5), global._cameraY+(HEIGHT*0.5)) <= HEIGHT){
						_dirttimer ++;
						if(_dirttimer >= 7){
							sfx_play_choose_proximity([snd_footstep1_dirt,snd_footstep2_dirt],0.45);
							_dirttimer = 0;
						}
					}
				}
			} else {
				sprite_index = spr_st2_bw_dodge;
				if(image_index >= image_number-1){
					_dodge = false;
				}
			}
			
			if(_dead){
				_dodge = false;
				sprite_index = spr_st2_bw_dead;
				
				_deathtimer ++;
				switch(_deathact){
					case 0:
						with(obj_camera){
							_ampX = 14;
							_ampY = 14;
						}
						
						depth = -HEIGHT;
				
						global._cameraZoom = 0.72;
						global._camZoomSpd = 0.06;
						
						if(_death_inst != noone && instance_exists(_death_inst)){
							_death_inst._freeze = 2;
						}
						
						if(_deathtimer >= 32){
							_deathact = 1;
							_deathtimer = 0;
						}
					break;
					case 1:
						global._cameraZoom = global._defCamZoom;
						global._camZoomSpd = 0.5;
						
						if(!_vanish){
							var p = instance_create_depth(x-96,y-96,-32,obj_particle);
							p._type = "vanish";
							sfx_play(snd_ghost);
							
							_vanish = true;
						}
						visible = false;
						
						if(_deathtimer >= 12){
							ds_map_delete(global._gameshadows, self.id);
							global._deletedStuff[? self.id] = 1;
							
							instance_destroy();
						}
					break;
				}
			}
		} else {
			sprite_index = spr_st2_bw_jump;
		}
		
		//follow dh
		_dh = instance_nearest(x,y,obj_dh_mask);
		if(instance_exists(_dh)){
			_height = _dh._height;
			_groundlevel = _dh._groundlevel;
			
			y = _dh.y;
		}
		
		mask_index = spr_st2_bw_mask;
	} else {
		image_speed = 0;
	}
}