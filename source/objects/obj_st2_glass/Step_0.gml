{
	if(!_init){
		if(_showbottom){
			instance_create_depth(x,y+233,3001,obj_st2_floorlightcast);
		}
		
		_shatter = instance_create_depth(x,y,2999,obj_st2_glass_shatter);
		_shatter._type = _type;
		
		_init = true;
	}
	
	visible = true;
	if(global._finalhit > 0 && !global._finalhit_phase){
		visible = false;
	}
	
	if(!global._pause){
		if(distance_to_point(global._cameraX+(WIDTH*0.5),global._cameraY+(HEIGHT*0.5)) <= WIDTH*2){
			_inview = true;
		} else {
			_inview = false;
		}
		
		if(_inview){
			if(place_meeting(x,y,obj_seq_enmhop)){
				var enmhop = instance_place(x,y,obj_seq_enmhop);
				if(!_broke && enmhop._timer < 3 && enmhop._glass){
					sfx_play_proximity(snd_glassbreak);
					sfx_pitch(snd_glassbreak, random_range(0.72, 1.35));
				
					with(obj_camera){
						_ampX = 24;
					}
				
					_shatter._active = true;
				
					for(var i = 0; i < random_range(7,10); i++){
						var p = instance_create_depth(x-random_range(-120,120),y-random_range(-120,120),depth-16,obj_particle);
						p._type = "glass";
						p._move = true;
						p._frameend = false;
						p._xspd = choose(random_range(-8,-5),random_range(5,8));
						p._yspd = random_range(-12,-17);
						p._do_grav = true;
						p._grav_val = 0.96;
						p._rotate = true;
						p._rotate_spd = random_range(12,28);
					}
				
					_broke = true;
				}
			}
		
			if(!_broke){
				var sprite = asset_get_index("spr_st2_glass"+string(_type));
				if(sprite_exists(sprite)){
					sprite_index = sprite;
				} else {
					sprite_index = spr_st2_glass1;
				}
			} else {
				var sprite = asset_get_index("spr_st2_glass_shattered"+string(_type));
				if(sprite_exists(sprite)){
					sprite_index = sprite;
				} else {
					sprite_index = spr_st2_glass_shattered1;
				}
			}
		}
	}
}