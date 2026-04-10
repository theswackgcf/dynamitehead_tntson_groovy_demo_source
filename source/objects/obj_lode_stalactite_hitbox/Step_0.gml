{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		if(_parentobj != noone && instance_exists(_parentobj)){
			y = _parentobj.y+_parentobj._offset[1];
		}
		
		if(_destroy){
			_destroy_timer ++;
			if(_destroy_timer >= 3){
				instance_destroy();
			}
		}
	}
}