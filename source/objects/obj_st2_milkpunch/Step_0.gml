{
	if(!global._pause){
		if(global._blowup_kill > 0 || global._mashZoom){
			instance_destroy();
		}
		
		if(_fall){
			_height += 54;
			if(_height >= 0){
				_height = 0;
				_fall = false;
				
				sfx_play(snd_moneythud);
				
				//particles
				for(var i = 0; i < 2; i++){
					var offset = [-170, 80];
					var p = instance_create_depth(x+offset[i], y+6, depth, obj_particle);
					p._move = true;
					if(i == 0){
						p._type = "run4";
						p._xspd = -14;
					} else if(i == 1){
						p._type = "run5";
						p._xspd = 14;
					}
				}
			}
		}
	}
}