function scr_enemyscript_inactive(){
	//despawn
	if(!_forcedeath){
		if(!_idiot && !_boss && !_spin && !_death){
			if(!_battlezone){
				if(!place_meeting(x,y,obj_enemyzone)){
					_inactive = true;
				} else {
					_inactive = false;
				}
			}
		}
	}
	
	if(_forcedeath || _death){
		_inactive = false;
	}
}