{
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				if(global._deletedStuff[? self.id][0]){
					instance_destroy();
				} else {
					_trigger = global._deletedStuff[? self.id][1];
				}
			}
			_checkdelete = true;
		}
	}
	
	if(!global._pause){
		_cantrigger = true;
		if(_cantrigger){
			if(place_meeting(x,y,obj_dh_mask)){
				_cantrigger = false;
				if(!_trigger){
					//change walls state
					with(obj_st2_wall){
						if(_id == other._id && other._enmtouch <= 0){
							var numenm = instance_number_array(global._enemyArray);
							if(numenm == 0 || (numenm > 0 && !place_meeting_array(x,y,global._enemyArray, false, true))){
								_open = !_open;
								global._deletedStuff[? self.id] = _open;
							
								if(!_open){
									var dh = instance_nearest(x,y,obj_dh_mask);
									if(instance_exists(dh) && distance_to_object(dh) < _dhdist){
										sfx_play_proximity(snd_wall_down, 0.55);
									}
								
									//create solid object
									_solid = instance_create_depth(x-128,y-128,depth,obj_wallsolid);
									_solid.image_xscale = 4;
									_solid.image_yscale = 2;
								} else {
									var dh = instance_nearest(x,y,obj_dh_mask);
									if(instance_exists(dh) && distance_to_object(dh) < _dhdist){
										sfx_play_proximity(snd_wall_up, 0.55);
									}
						
									if(instance_exists(_solid)){
										instance_destroy(_solid.id);
									}
									_solid = noone;
								}
							
								_changing = true;
							} else {
								other._enmtouch = 2;
							}
						}
					}
					
					with(obj_st2_walltrigger){
						if(_id == other._id){
							_trigger = true;
							if(!_deleteontrigger){
								global._deletedStuff[? self.id] = [false, _trigger];
							}
						}
					}
					
					_trigger = true;
					if(!_deleteontrigger){
						global._deletedStuff[? self.id] = [false, _trigger];
					}
				}
			}
		}
		
		if(_enmtouch > 0){
			_trigger = false;
			_cantrigger = true;
			
			_enmtouch --;
		}
		
		if(_trigger){
			if(_deleteontrigger){
				global._deletedStuff[? self.id] = [true, self.id];
						
				instance_destroy();
			}
		}
		if(_cantrigger){
			_trigger = false;
		}
	}
}