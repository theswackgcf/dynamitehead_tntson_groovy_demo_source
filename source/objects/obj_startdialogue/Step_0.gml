{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				instance_destroy();
			}
		}
		_checkdelete = true;
	}
	
	if(!global._pause && (_build == -1 || _build == global._buildver)){
		if(!global._freeRoam && !global._dialogue && place_meeting(x,y,obj_dh_mask)){
			scr_startdialogue(_dialogue, _dir, _starttimer, _stopmove, _act);
			global._deletedStuff[? self.id] = self.id;
			instance_destroy();
		}
	}
}