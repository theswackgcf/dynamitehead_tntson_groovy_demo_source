{	
	if(!_shadowsinit){
		//shadows
		global._gameshadows[? _occupy_id] = ds_map_create();
		global._gameshadows[? _occupy_id][? "draw"] = false;
		global._gameshadows[? _occupy_id][? "x"] = x;
		global._gameshadows[? _occupy_id][? "y"] = y;
		global._gameshadows[? _occupy_id][? "scalex"] = 1;
		global._gameshadows[? _occupy_id][? "scaley"] = 1;
		
		_shadowsinit = true;
	}
	
	if(!global._pause){
		_scale = 1;
	
		_shadowoffset[0] = lerp(_shadowoffset[0], _shadowlerp[0], 0.06);
		_shadowoffset[1] = lerp(_shadowoffset[1], _shadowlerp[1], 0.06);
	
		image_xscale = _xscale * _scale;
		image_yscale = _yscale * _scale;
		_groundlevel = _parentobj._groundlevel;
		_height = _parentobj._height;
		if(_parentobj != noone){
			x = (_parentobj.x + _offset[0]) + _shakeOffset[0];
			y = (_parentobj.y + _offset[1]) + _shakeOffset[1];
		}
		if(_ampX == 0){
			_shakeOffset[0] = 0;
		}
		if(_ampY == 0){
			_shakeOffset[1] = 0;
		}
		if(_ampX > 0){
			_shakeOffset[0] = sin(random(480))*_ampX;
			_ampX --;
		} else if(_ampX < 0){
			_ampX = 0;
		}
		if(_ampY > 0){
			_shakeOffset[1] = cos(random(480))*_ampY;
			_ampY--;
		} else if(_ampY < 0){
			_ampY = 0;
		}
		
		_starttime ++;
		
		/*
		if(!_parentobj._begin){
			if(_starttime >= 30 && !_startsurf){
				var offset;
				if(_startdir == DIR_R){
					offset = global._cameraX - 128;
				} else if(_startdir == DIR_L){
					offset = global._cameraX + WIDTH + 128;
				}
				var surf = instance_create_depth(offset, floor(global._cameraY+110), depth+1, obj_surfboard);
				surf._yvel = -8;
				surf._curdir = _startdir;
				_startsurf = true;
			}
		}
		if(_starttime >= 90 && _startsurf && !_startsfx){
			sfx_play(snd_whoopsie);
			_startsfx = true;
		}
		if(_starttime >= 120 && _startsurf && !_startvoice){
			voice_play_choose([], global._dhvoices, 1);
			_startvoice = true;
		}
		if(_starttime >= 180){
			with(obj_music){
				_musicstart = true;
			}
		}
		
		*/
	}
}