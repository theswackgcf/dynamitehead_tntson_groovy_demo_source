{
	_xscale = global._scale*_dir;
	_yscale = global._scale;
	image_xscale = _xscale;
	image_yscale = _yscale;
	
	if(!_colorsinit){
		if(ds_map_exists(global._enemyColors, _codename)){
			if(_enmtype != -1){
				_rep = _enmtypes[_enmtype][0];
			}
			
			_docolors = false;
			if(global._lightsout){
				_docolors = true;
			}
			
			makecolors("def",_rep,_codename);
		}
		_colorsinit = true;
	}
	
	if(!global._pause){
		_timer ++;
		
		//spawn fade
		if(_startFade){
			if(!_fadeInit){
				_fadeCol = [0,0,0];
				_fadeInit = true;
			}
			if(!_doFade){
				for(var i = 0; i < 3; i++){
					_fadeCol[i] = lerp(_fadeCol[i],_fadeTo[i], 0.04);
				}
				if(diff(_fadeCol[0],_fadeTo[0]) < 6){
					for(var i = 0; i < 3; i++){
						_fadeCol[i] = _fadeTo[i];
					}
					_doFade = true;
				}
			}
		} else {
			if(!_doFade){
				for(var i = 0; i < 3; i++){
					_fadeCol[i] = _fadeTo[i];
				}
				_doFade = true;
			}
		}
		
		if(_parentobj != noone && !instance_exists(_parentobj)){
			instance_destroy();
		}
		
		if(_parentobj != noone && instance_exists(_parentobj)){
			with(_parentobj){
				layer_sequence_pause(_sequence);
			}
		}
		
		image_speed = 1;
		depth = _depth;
		
		if(!_walking){
			//arc code
			_hop_time = clamp(_hop_time + _seqhop_spd, 0, 1);
			x = lerp(_hop_startpos[0], _jumptopos[0], _hop_time);
			_hop_base_y = lerp(_hop_startpos[1], _jumptopos[1], _hop_time);

			_hop_arc = _seqhop_archeight * _hop_time * (_hop_time - 1);
			if(_hop_arc <= -8){
				_hop_arcstart = true;
			}
						
			y = _hop_base_y+_hop_arc;
		} else {
			//move to position
			_hop_time = clamp(_hop_time + _seqhop_spd, 0, 1);
			x = lerp(_hop_startpos[0], _jumptopos[0], _hop_time);
			y = lerp(_hop_startpos[1], _jumptopos[1], _hop_time);
		}
	} else {
		image_speed = 0;
	}
}