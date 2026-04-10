{
	if(!global._pause){
		if(!_checkdelete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					if(place_meeting(x, y, obj_solid)){
						var inst = instance_place(x, y, obj_solid){
							instance_destroy(inst.id);
						}
					}
					killself();
				}
				_checkdelete = true;
			}
		}
		
		with(_displayobj){
			image_speed = 1;
		}
		
		if(_startTimer > 0){
			_startTimer --;
		}
		if(_startTimer <= 0){
			if(!_init){
				_collide_solid = global._solidArray;
				_collide_enemy = global._enemyArray;
		
				_init = true;
			} else {
				_curdir = DIR_L;
				if(!_fly){
					if(_hurttimer == 0){
						_anim = "idle";
					} else {
						_anim = "hurt"+string(_hurtanim);
					}
				} else {
					_anim = "death";
				}
	
				scr_enemyscript_animation("step");
				scr_enemyscript_dir();
				
				if(!_fly){
					if(_hp <= 0){
						if(_freeze <= 0){
							if(!_explode){
								with(obj_camera){
									_ampX = 24;
									_ampY = 24;
								}
								var p = instance_create_depth(x, y, depth+24, obj_particle);
								p._type = "explosion";
								sfx_play(snd_explosion);
								_explode = true;
							}
							
							if(place_meeting(x, y, obj_solid)){
								var inst = instance_place(x, y, obj_solid){
									instance_destroy(inst.id);
								}
							}
							_fly = true;
						}
					}
					
					x = _startpos[0];
					y = _startpos[1];
				} else {
					if(_freeze <= 0){
						_flytimer ++;
						if(_flytimer % 3 == 0){
							var p = instance_create_depth(x, y, depth+8, obj_particle);
							p._type = "vanish";
							p.image_index = round(random_range(0, sprite_get_info(spr_p_vanish).num_subimages-1));
						}
						
						x += 8;
						y -= 30;
						
						if(y <= -800){
							global._deletedStuff[? self.id] = self.id;
							with(obj_gui){
								_uitextshow = true;
								_uitext = "WAiT FOr IT";
							}
							killself();
						}
					}
				}
				
				if(_freeze <= 0){
					scr_enemyscript_other();
				}
			}
			
			scr_enemyscript_bottomscript();
		}
	} else {
		with(_displayobj){
			image_speed = 0;
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