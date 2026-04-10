{
	if(!global._pause){
		if(!_checkdelete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					instance_destroy();
				}
			}
			_checkdelete = true;
		}
		
		if(_freeze <= 0){
			if(!_trigger){
				if(place_meeting(x-48,y,obj_dh_mask)){
					var dh = instance_place(x-48,y,obj_dh_mask);
					if(instance_exists(dh) && dh._runroll && !dh._runroll_dive){
						if(place_meeting(x,y,obj_solid)){
							var sol = instance_place(x,y,obj_solid);
							if(instance_exists(sol) && sol._delete){
								global._deletedStuff[? sol.id] = 1;
								instance_destroy(sol.id);
							}
						}
					}
				}
								
				if(place_meeting(x,y,obj_dh_mask)){
					var dh = instance_place(x,y,obj_dh_mask);
					if(instance_exists(dh) && dh._runroll && !dh._runroll_dive){
						with(obj_tipbox){
							if(_prompt == "dive"){
								global._deletedStuff[? self.id] = 1;
								instance_destroy();
							}
						}
						with(obj_event_other){
							if(_event == "dive"){
								global._deletedStuff[? self.id] = 1;
								instance_destroy();
							}
						}
						
						_dh = dh;
						with(obj_camera){
							_ampX = 38;
						}
						var p = instance_create_depth(dh.x-48,dh.y-48,-16, obj_particle);
						p._type = "fx6";
										
						sfx_play_choose([snd_kd1,snd_kd2,snd_kd3,snd_kd4,snd_kd5]);
						
						var p = instance_create_depth(x-128,y-320,depth,obj_particle);
						p._type = "vanish";
						
						var p = instance_create_depth(x-128,y-240,depth,obj_particle);
						p._type = "rocks";
						
						dh._freeze = 6*global._freezevals[global._freezeval];
						_freeze = 6*global._freezevals[global._freezeval];
						_trigger = true;
					}
				}
			} else {
				sfx_play_proximity(snd_rock_break);
				if(_man){
					sfx_play_proximity(snd_scream4);
					if(_dh != noone && instance_exists(_dh)){
						_dh._runroll = false;
						_dh._runroll_dive = false;
						if(_dh._height <= _dh._groundlevel){
							_dh._crouch = true;
							_dh._slide = true;
							_dh._slidespd = 9*_dh._curdir;
							_dh._runroll_slide = true;
						}
						_dh._preservespd = 24*_dh._curdir;
						_dh._forceroll = false;
					}
				} else {
					if(_dh != noone && instance_exists(_dh)){
						_dh._lowkick_dive = false;
						_dh._runroll = true;
						_dh._runroll_dive = false;
						_dh._runroll_slide = false;
						_dh._rollspd = 20*_dh._curdir;
						_dh._forceroll = true;
					}
				}
				
				global._deletedStuff[? self.id] = 1;
				instance_destroy();
			}
		} else {
			_freeze --;
		}
	}
}