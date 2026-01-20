{
	if(place_meeting(x,y,obj_dh_mask)){
		with(obj_dialogue){
			if(_show){
				//end dialogue
				image_index = 0;
				_curpg = array_length(_textarray);
				_diagstate = 3;
				_timer = 0;
				_diagend = true;
				sfx_play(snd_noise);
				_noise = 12;
				
				other._destroy = true;
			}
		}
	}
	if(_destroy){
		instance_destroy();
	}
}