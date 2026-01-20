{
	if(!_checktrig){
		if(ds_map_exists(global._checkps, self.id)){
			_triggered = true;
		}
		_checktrig = true;
	}
	
	if(_triggered){
		sprite_index = spr_checkp_on;
		_offsety = -150+_sineoffset;
	} else {
		sprite_index = spr_checkp_off;
		_offsety = 0;
	}
	if(!global._pause){
		if(_triggered){
			if(_scale <= 1.1){
				_timer ++;
				_sineoffset = sin(_timer/20)*72;
				
				if(_timer >= 60 && !_fadeback){
					global._musFade = 1;
					
					_fadeback = true;
				}
			}
			
			if(sfx_isplaying(snd_checkp)){
				var curp = audio_sound_get_track_position(_allsounds[? snd_checkp]);
				if(curp >= 1.16 && !_checkword){
					instance_create_depth(x, y - 240, 0, obj_gui_checkpoint);
					
					_checkword = true;
				}
			}
		}
		
		if(_checkanim){
			global._musFade = 0.35;
			
			_scale = 2.05;
			_checkanim = false;
		}
		
		_scale = lerp(_scale, 1, 0.17);
		
		image_xscale = _scale;
		image_yscale = _scale;
		
		image_speed = 1;
	} else {
		image_speed = 0;
	}
}