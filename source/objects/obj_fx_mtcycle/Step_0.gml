{
	if(!_colorsinit){
		if(ds_map_exists(global._enemyColors, _codename)){
			if(_enmtype != -1){
				_rep = _enmtypes[_enmtype][0];
				makecolors("def",_rep,_codename);
			}
		}
		_colorsinit = true;
	}
	
	scr_orderspawn();
	if(global._enmorder >= _order || _canspawn >= 8){
		_delay --;
		if(_delay <= 0){
			if(!_init){
				if(!ds_map_exists(global._bzone_fx, self.id)){
					global._bzone_fx[? self.id] = 0;
				}
				
				if(_spawndir == "r"){
					_curdir = DIR_R;
				} else if(_spawndir == "l"){
					_curdir = DIR_L;
				}
		
				visible = false;
				if(_curdir == DIR_L){
					x = global._cameraX+(WIDTH*2);
				} else if(_curdir == DIR_R){
					x = global._cameraX-(WIDTH/1.5);
				}
		
				_xspd = 40*_curdir;
			
				_init = true;
			} else {
				visible = true;
			}
	
			y = global._cameraY+(HEIGHT*1.4);
	
			image_alpha = 0.38;
			image_xscale = 2.2*_curdir;
			image_yscale = 2.2;
			depth = -5010;
	
			if(!global._pause){
				if(_init){
					_timer ++;
				
					_sndtimer ++;
					if(_sndtimer >= 8){
						sfx_play_proximity(snd_mtcycle_loop, 0.36);
						_sndtimer = 0;
					}
				
					_yoffs = sin(_timer)*random_range(2,5);
			
					image_speed = 1;
		
					x += _xspd;
		
					if((_curdir == DIR_L && x <= global._cameraX-(WIDTH/1.5)) || (_curdir == DIR_R && x >= global._cameraX+(WIDTH*2))){
						sfx_stop(snd_mtcycle_loop);
						instance_destroy();
					}
				}
			} else {
				image_speed = 0;
			}
		}
	}
}