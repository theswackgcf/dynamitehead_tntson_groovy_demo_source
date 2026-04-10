{
	if(!global._pause){
		image_speed = 1;
		
		if(!_checkdelete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					instance_destroy();
				}
			}
			_checkdelete = true;
		}
		
		if(distance_to_point(global._cameraX+(WIDTH*0.5),global._cameraY+(HEIGHT*0.5)) <= WIDTH*2.1){
			_inview = true;
			if(!ds_map_exists(global._deletedStuff, self.id)){
				global._deletedStuff[? self.id] = self.id;
			}
		} else {
			_inview = false;
		}
		
		if(_inview){
			x -= 2;
			
			if(!_death && place_meeting(x,y,obj_event_other)){
				var ev = instance_place(x,y,obj_event_other);
				if(instance_exists(ev) && ev._event == "henchdie"){
					_death = true;
				}
			}
			if(_death){
				y += 2;
				if(y >= _starty+160){
					if(!_destroy){
						if(!global._battlezone){
							sfx_play_proximity(snd_scream1, 0.45);
							sfx_pitch(snd_scream1, 0.45);
						}
						_destroy = true;
					}
				}
			} else {
				y = _starty+sin(x/18)*8;
			}
			
			if(_destroy){
				if(!sfx_isplaying(snd_scream1)){
					if(_allsounds != -1){
						if(ds_map_exists(_allsounds, "emitter")){
							audio_emitter_free(_allsounds[? "emitter"]);
						}
						
						ds_map_destroy(_allsounds);
						_allsounds = -1;
					}
					instance_destroy();
				}
			}
		}
	} else {
		image_speed = 0;
	}
}