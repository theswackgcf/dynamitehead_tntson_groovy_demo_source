{
	if(!global._pause){
		_timer ++;
		if(_timer % 2 == 0){
			var fade = instance_create_depth(x, y-_height, 0, obj_st1_fallfade);
			fade.image_index = image_index;
		}
		_height -= _yspd;
		if(_height <= _fallto){
			var p = instance_create_depth(x, y-72, 0, obj_particle);
			p._type = "st1fallabove";
			sfx_stop(snd_whistle);
			sfx_play(snd_stonebreak);
			instance_destroy();
		}
		if(place_meeting(x, y - 120, obj_punchhitbox)){
			var inst = instance_place(x, y - 120, obj_punchhitbox);
			if(instance_exists(inst) && inst._active){
				inst_active = false;
			
				var p = instance_create_depth(x, y-72, 0, obj_particle);
				p._type = "st1fallabove";
				sfx_play(snd_kd1);
				sfx_stop(snd_whistle);
				sfx_play(snd_stonebreak);
				instance_destroy();
			}
		}
	}
}