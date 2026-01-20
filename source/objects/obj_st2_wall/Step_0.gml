{
	if(!global._pause){
		if(!_init){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					_open = global._deletedStuff[? self.id];
				}
			}
			
			if(_open){
				_wall_offs = _borders[0];
				_wall_alp = _alphas[0];
			} else {
				//create solid object
				_solid = instance_create_depth(x-128,y-128,depth,obj_solid);
				_solid.image_xscale = 4;
				_solid.image_yscale = 2;
				
				_wall_offs = _borders[1];
				_wall_alp = _alphas[1];
			}
			
			_init = true;
		} else {
			if(!_changing){
				_bounce = false;
				_wall_spd = 0;
			} else {
				//wall changes state
				_wall_offs += _wall_spd;
				if(_open){
					//wall opens
					_wall_alp -= 0.07;
					if(_wall_alp <= _alphas[0]){
						_wall_alp = _alphas[0];
					}
					if(!_bounce){
						_wall_spd -= 1.6;
						
						//wall overshoots
						if(_wall_offs <= _borders[0]-24){
							_wall_spd = 0;
							_bounce = true;
						}
					} else {
						_wall_spd += 3.2;
						
						//opening animation is finished
						if(_wall_offs >= _borders[0]){
							_wall_offs = _borders[0];
							_changing = false;
						}
					}
				} else {
					//wall closes
					_wall_alp += 0.07;
					if(_wall_alp >= _alphas[1]){
						_wall_alp = _alphas[1];
					}
					
					_wall_spd += 3;
					if(_wall_offs >= _borders[1]){
						if(!_bounce){
							var dh = instance_nearest(x,y,obj_dh_mask);
							if(instance_exists(dh) && distance_to_object(dh) < _dhdist){
								sfx_stop(snd_wall_down);
								sfx_play_proximity(snd_wall_close);
								
								with(obj_camera){
									_ampY = 28;
								}
							
								with(obj_dh_mask){
									if(_height == _groundlevel){
										_vspd = 16;
										_height += 4;
										_jump = true;
										_state = "shockwave";
										_shockwave = 50;
									}
								}
							
								//particles
								for(var i = 0; i < 2; i++){
									var offset = [-235, 140];
									var p = instance_create_depth(x+offset[i], y-12, depth, obj_particle);
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
							
							//wall bounces a bit
							_wall_offs = _borders[1]-4;
							_wall_spd = -20;
							_bounce = true;
						} else {
							//closing animation is finished
							_wall_offs = _borders[1];
							_changing = false;
						}
					}
				}
			}
		}
	}
}