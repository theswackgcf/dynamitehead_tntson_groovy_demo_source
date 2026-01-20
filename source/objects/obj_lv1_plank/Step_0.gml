{
	image_speed = 0;
	if(!global._pause){
		if(_createtype == 0){
			if(!_fell){
				_height -= _spd[1];
			}
			if(_height < 0){
				if(!_bump){
					_angle = 0;
					_height = 12;
					_spd[1] = -20;
					_bump = true;
				} else {
					_fell = true;
				}
			}
			if(!_fell){
				_scalemult = 1;
				_spd[1] += 2.5;
				if(!_bump){
					_angle += _spd[0] * 3;
				} else {
					_angle += _rot2;
				}
		
				if(_spd[0] >= 0){
					_xscale = 1;
				} else {
					_xscale = -1;
				}
			} else {
				_scalemult = 1.2;
				_sort = false;
				depth = 9000;
				_forcedepth = 9000;
				_height = 0;
				_spd[1] = 0;
				_spd[0] = lerp(_spd[0],0,0.08);
				_angle = 0;
				_fell = true;
			}
			x += _spd[0];
		} else {
			_height = 0;
			_fell = true;
			_spd = [0,0];
			if(!_setscale){
				_xscale = choose(-1, 1);
				_setscale = true;
			}
		}
		
		if(!_fell){
			//sprite_index = spr_lv1_planks1;
		} else {
			//sprite_index = spr_lv1_planks2;
		}
		image_index = _type;
	}
}