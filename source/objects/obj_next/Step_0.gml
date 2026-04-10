{
	if(!global._pause){
		image_speed = 1;
		
		if(_type == "h"){
			sprite_index = spr_next_horiz;
			mask_index = spr_next_horiz;
		} else if(_type == "v"){
			if(_side == "u"){
				_offset = [0,46];
				sprite_index = spr_next_up;
				mask_index = spr_next_up;
			} else if(_side == "d"){
				_offset = [0,-46];
				sprite_index = spr_next_down;
				mask_index = spr_next_down;
			}
		}
		if(_side == "r"){
			_offset = [-46,0];
			image_xscale = _scale;
		} else if(_side == "l"){
			_offset = [0,0];
			image_xscale = -_scale;
		} else {
			image_xscale = _scale;
		}
		image_yscale = _scale;
	
		if(_timer < _endtimer){
			scr_gonext_update("x", false);
			scr_gonext_update("y", false);
		}
	
		y = y + (_yTo - y) * 0.16;
		if(!_start){
			if(diff(y, _yTo) <= 12){
				sfx_play_choose(_sndarray);
				_start = true;
			}
		} else {
			_timer ++;
			if(!_inactive && _timer >= _endtimer){
				if(place_meeting(x,y,obj_dh_mask)){
					if(_parentobj != noone && instance_exists(_parentobj)){
						with(_parentobj){
							for(var i = 0; i < array_length(_borders); i++){
								instance_destroy(_borders[i])
							}
							_borders = [];
						}
						instance_destroy(_parentobj.id);
					}
					with(obj_camera){
						_mode = 0;
					}
					
					var offs_ = [-24,-12];
					if(_side == "u" || _side == "d"){
						offs_[0] = 0;
					}
					
					var p = instance_create_depth((x+_offset[0])+offs_[0],(y+_offset[1])+offs_[1], depth, obj_particle);
					p._type = "next_gone";
					
					sfx_play(snd_next_gone);
	
					var nextsndnum = 6;
	
					for(var i = 1; i < nextsndnum+1; i++){
						audio_stop_sound(asset_get_index("snd_gonext"+string(i)));
					}
					
					_inactive = true;
				}
			}
		}
		
		if(_inactive){
			var sndp = 0;
			for(var i = 0; i < array_length(_sndarray); i++){
				if(!sfx_isplaying(_sndarray[i])){
					sndp++;
				}
			}
			if(sndp >= array_length(_sndarray)){
				instance_destroy();
			}
			visible = false;
		}
	} else {
		image_speed = 0;
	}
}