{
	if(!global._pause){
		with(_displayobj){
			image_speed = 1;
		}
		
		if(_startTimer > 0){
			_startTimer --;
		}
		if(_startTimer <= 0){
			//despawning
			scr_enemy_despawning();
			
			scr_enemy_move();
	
			if(_land == 0){
				if(_vspd < -3){
					_anim = "3";
				} else if(_vspd > 3){
					_anim = "1";
				} else {
					_anim = "2";
				}
			} else {
				_anim = "land";
			}
	
			if(instance_exists(_displayobj)){
				scr_enemy_animation();
			
				if(_land == 0){
					_landtime ++;
					_spd[0] = _startspd[0];
					_spd[1] = _startspd[1];
					if(_spd[0] > 0){
						_dir = "r";
					} else if(_spd[0] <= 0){
						_dir = "l";
					}
					if(_landtime >= 10 && _height == _groundlevel){
						sfx_play(snd_slime);
						sfx_pitch(snd_slime, random_range(0.8, 1.2));
						_displayobj.image_index = 0;
						_jump = false;
						_land = 1;
					}
				} else if(_land == 1){
					_landtime = 0;
					_spd = [0,0];
					if(_displayobj.image_index >= _displayobj.image_number-1){
						_jump = true;
						_height += 8;
						_vspd = 20;
						_land = 0;
					}
				}
			}
		
			if(_punchbox == noone){
				_punchbox = instance_create_depth(x,y,-1,obj_en_punchhitbox);
				_punchbox._parentobj = self.id;
				_punchbox._scale = [4,4];
				_punchbox._timer = 999;
				_punchbox._damage = 3;
			} else {
				if(!instance_exists(_punchbox)){
					var p = instance_create_depth(x, y-_height, 0, obj_particle);
					p._type = "barf_splash";
					killself();
				}
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