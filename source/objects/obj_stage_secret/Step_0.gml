{
	depth = _forcedepth;
	
	visible = _visible;
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				if(place_meeting_array(x,y,global._solidArray,false,true)){
					var sol = place_meeting_array(x,y,global._solidArray,true,true);
					if(instance_exists(sol)){
						if(variable_instance_exists(sol,"_delete")){
							if(sol._delete){
								instance_destroy(sol.id);
							}
						}
					}
				}
				
				if(layer_exists(layer_get_id(_layer))){
					var l = layer_get_id(_layer);
					if(layer_exists(l)){
						layer_set_visible(l, false);
					}
				}
				
				instance_destroy();
			}
		}
		_checkdelete = true;
	}
	
	if(!global._pause){
		switch(_triggertype){
			case ST2_SECRET_TRIGGER_IDLE:
				//dh walks into the object and it disappears, revealing
				// a secret path
				if(place_meeting(x,y,obj_dh_mask)){
					_trigger = true;
				}
			break;
		}
		if(!_destroy && _trigger){
			with(obj_camera){
				_ampX = 24;
			}
			
			sfx_play_proximity(snd_secret);
		
			if(place_meeting_array(x,y,global._solidArray,false,true)){
				var sol = place_meeting_array(x,y,global._solidArray,true,true);
				if(instance_exists(sol)){
					if(variable_instance_exists(sol,"_delete")){
						if(sol._delete){
							instance_destroy(sol.id);
						}
					}
				}
			}
			
			//particles
			for(var i = 0; i < irandom_range(12,24); i++){
				var p = instance_create_depth(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),-1000,obj_particle);
				p._type = "face";
				p._frameend = false;
				p._move = true;
				p._xspd = choose(random_range(-4,-9),random_range(4,9));
				p._yspd = choose(random_range(-3,-5),random_range(3,5));
				p._alpha = true;
				p._alpha_spd = 0.008;
				p._color = make_color_rgb(190, 130, 237);
			}
			
			if(layer_exists(layer_get_id(_layer))){
				var l = layer_get_id(_layer);
				if(layer_exists(l)){
					layer_set_visible(l, false);
				}
			}
			
			global._deletedStuff[? self.id] = self.id;
			_destroy = true;
		}
		
		if(_destroy){
			if(!sfx_isplaying(snd_secret)){
				instance_destroy();
			}
		}
	}
}