{
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._pause){
		if(!_init){
			_enemyarray = global._enemyArray;
			
			_wallobj = instance_create_depth(x,y,depth,obj_dh_occupywall);
			_wallobj._parentobj = self.id;
			_wallobj._type = _type;
			
			_init = true;
		} else {
			_nocollide = 0;
			
			image_blend = c_white;
			if(place_meeting_array(x, y, _enemyarray)){
				image_blend = c_black;
			}
			
			//check enemy collision
			if(place_meeting_array(x, y, _enemyarray)){
				var enm = place_meeting_array(x, y, _enemyarray, true, true);
				if(instance_exists(enm) && place_meeting(x, y, enm) && variable_instance_exists(enm,"_curstate")){
					if((enm._curstate == STATE_ATTACK || enm._curstate == STATE_FOLLOW || enm._curstate == STATE_WALK) && !enm._grabbed){
						_curenemyid = enm._occupy_id;
						_occupytimer ++;
					}
				}
			} else {
				//doesn't collide with enemies
				_curenemyid = -1;
				if(_nocollide == 0){
					_nocollide = 1;
				}
			}
			
			//check wall collision
			with(_wallobj){
				if(_init){
					if(place_meeting_array(x, y, _solidarray)){
						other._curenemyid = -2;
						other._occupytimer ++;
					} else {
						//doesn't collide with solids
						if(other._nocollide == 1){
							other._nocollide = 2;
						}
					}
				}
			}
			
			//doesn't collide both, reset timer
			if(_nocollide >= 2){
				_occupytimer = 0;
			}
		}
	}
	if(_parentobj != noone){
		var dist = _parentobj._occupdist;
		if(_type == "l"){
			_offset = -dist;
		} else if(_type == "r"){
			_offset =  dist;
		}
		x = _parentobj.x + _offset;
		y = _parentobj.y;
	}
}