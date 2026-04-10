{
	if(_plus){
		_addstr = "+";
		if(_money){
			_addstr = "$";
		}
		if(_tnt){
			_addstr = "F";
		}
		_color = global._guiNumColors[? "heal"];
		if(_money){
			_color = global._guiNumColors[? "money"];
		}
		if(_tnt){
			_color = global._guiNumColors[? "tnt"];
		}
	} else {
		_color = global._guiNumColors[? "dmg"];
	}
	_numstring = _addstr+string(round(_num));
	if(_nocked){
		_numstring = "N";
	}
	
	if(!global._pause){
		if(!_init){
			_randspd = [random_range(-3, 3), -8.8];
			for(var i = 0; i < string_length(_numstring); i++){
				_nummap[? i] = [
					string_char_at(_numstring, i+1),
					(x-((_charw*string_length(_numstring))/2))+(i*_charw), y, _randspd[0], _randspd[1]
				];
			}
			_init = true;
		} else {
			_timer ++;
			
			_shakeoff = [sin(random(480))*_amp,cos(random(480))*_amp];
			
			_amp -= 1;
			if(_amp < 3){
				_amp = 3;
			}
			
			if(_timer >= 40){
				for(var i = 0; i < string_length(_numstring); i++){
					_nummap[? i][4] += _grav
					_nummap[? i][1] += _nummap[? i][3];
					_nummap[? i][2] += _nummap[? i][4];
				}
				_yvel += _grav;
				_boxx += _nummap[? 0][3];
				_boxy += _nummap[? 0][4];
				/*if(_yvel >= 2){
					_drawback = false;
				}*/
			}
			
			if(_timer > 0 && !visible){
				visible = true;
			}
	
			image_yscale = lerp(image_yscale, 1.4, 0.15);
			image_xscale = lerp(image_xscale, 1.4, 0.15);
			
			if(!is_string(_num) && _num < 10){
				_addoffset = -16;
			}
			if(!is_string(_num) && _num > 999){
				_addoffset = 60;
			}
			
			//destroying
			if(_timer >= 320 || _boxy >= global._cameraY+HEIGHT+128){
				instance_destroy();
			}
		}
		
		if(global._finalhit > 0 && !global._finalhit_phase){
			instance_destroy();
		}
	} else {
		_shakeoff = [0,0];
	}
}