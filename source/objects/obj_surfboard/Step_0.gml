{
	image_speed = 0;
	image_xscale = 1.4;
	image_yscale = 1.4;
	if(!global._pause){
		if(_curdir == DIR_R){
			_xvel = 35;
			image_angle -= 60;
			
			if(x >= global._cameraX + WIDTH + 640){
				instance_destroy();
			}
		} else if(_curdir == DIR_L){
			_xvel = -35;
			image_angle += 60;
			
			if(x <= global._cameraX - 640){
				instance_destroy();
			}
		}
		x += _xvel;
		y += _yvel;
		_yvel += 0.5;
		
		_timer ++;
		if(_timer % 12 == 0){
			sfx_play(snd_swish1, 0.4);
		}
	}
}