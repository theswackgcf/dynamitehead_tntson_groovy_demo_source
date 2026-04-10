{
	if(global._debug){
		if(global._showHitbox){
			visible = true;
			if(_collidewith == "player"){
				image_blend = c_green;
			}
			if(_collidewith == "enemy"){
				image_blend = c_red;
			}
		} else {
			visible = false;
		}
	}
	
	if(!_deletestart){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				instance_destroy();
			}
		}
		
		_deletestart = true;
	}
	
	if(_dialogue){
		if(global._dialogue){
			y = _starty;
		} else {
			y = -sprite_height;
		}
	}
}