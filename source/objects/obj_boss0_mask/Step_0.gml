{
	if(!global._pause){
		with(_displayobj){
			image_speed = 1;
		}
		
		if(!global._bossstart){
			mus_fade(0, 500, true);
		
			global._bossstart = true;
		}
	
		if(_startTimer > 0){
			_startTimer --;
		}
	
		if(_startTimer <= 0){
			if(!_init){
				_collidesolid = global._solidArray;
				_collideenemy = global._enemyArray;
				_collidehurtbox = global._hurtboxArray;
		
				_init = true;
			} else {
				scr_enemy_move();
			
				_plobj = instance_nearest(x, y, obj_dh_mask);
			
				if(!_grabfall){
					if(!_begin){
						if(_beginact == 0){
							_beginoffset = -512+global._cameraY;
							_beginact = 1;
							sfx_play(snd_whistle);
						}
						if(_beginact == 1){
							_beginoffset += 50;
							if(_beginoffset >= y){
								_beginoffset = y;
								_beginact = 2;
								_displayobj.image_index = 0;
								with(obj_camera){
									_ampY = 40;
								}
								sfx_stop(snd_whistle);
								sfx_play(snd_slam);
							}
						}
						if(_beginact == 2){
							_begintime ++;
							if(_displayobj.image_index >= _displayobj.image_number-1){
								_displayobj.image_index = _displayobj.image_number-1;
							}
							if(_begintime >= 10){
								_begin = true;
							}
						}
					}
				} else {
					_begin = true;
				}
			
				if(_begin){
					global._curboss = self;
				}
			
				//animation
				if(!_begin){
					if(_beginact < 2){
						_anim = "appear1";
					}
					if(_beginact == 2){
						_anim = "appear2";
					}
				} else {
					_anim = "idle";
				}
				scr_enemy_animation();
			
				if(_hurtTimer > 0){
					_shakeX = 6;
					_shakeY = 6;
				}
				if(_shakeX > 0){
					_shakeX --;
				} else if(_shakeX < 0){
					_shakeX = 0;
				}
				if(_shakeY > 0){
					_shakeY --;
				} else if(_shakeY < 0){
					_shakeY = 0;
				}
			
				scr_enemy_other();
				scr_enemy_falling();
			}
		}
	} else {
		with(_displayobj){
			image_speed = 0;
		}
	}
	
	if(global._debug){
		if(global._showHitbox){
			visible = true;
		} else {
			visible = false;
		}
	}
}