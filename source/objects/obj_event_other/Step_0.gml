{
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._pause){
		if(!_checkdelete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					instance_destroy();
				}
			}
			_checkdelete = true;
		}
		
		if(_event == "dive"){
			if(place_meeting(x, y, obj_dh_mask)){
				_dh = instance_place(x,y,obj_dh_mask);
				if(instance_exists(_dh)){
					if(_dh._curdir == DIR_R && _dh._runroll_dive){
						_dh._lowkick_dive = false;
						_dh._running = false;
						_dh._runtimer = 0;
						_dh._runroll_dive = false;
						_dh._runroll = true;
						_dh._rollspd = 20*_dh._curdir;
						_dh._forceroll = true;
					}
				}
			}
		}
	}
}