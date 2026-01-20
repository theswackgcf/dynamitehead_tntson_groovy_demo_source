function scr_gonext_update(type, bzone){
	if(type == "x"){
		var xpos_ = [
			(global._cameraX+global._camerasize[0])-200,
			global._cameraX+270,
			(global._cameraX+(global._camerasize[0]/2))-140
		];
		if(bzone){
			if(_side == "r"){
				_gonext_xpos = xpos_[0];
			}
			if(_side == "l"){
				_gonext_xpos = xpos_[1];
			}
			if(_type == "v"){
				_gonext_xpos = xpos_[2];
			}
		} else {
			if(_side == "r"){
				x = xpos_[0];
			}
			if(_side == "l"){
				x = xpos_[1];
			}
			if(_type == "v"){
				x = xpos_[2];
			}
		}
	} else if(type == "y"){
		var ypos_ = [
			global._cameraY+95,
			(global._cameraY+global._camerasize[1])-200,
			global._cameraY+270
		];
		if(bzone){
			if(_side == "u"){
				_gonext_inst._yTo = ypos_[0];
			}
			if(_side == "d"){
				_gonext_inst._yTo = ypos_[1];
			}
			if(_type == "h"){
				_gonext_inst._yTo = ypos_[2];
			}
		} else {
			if(_side == "u"){
				_yTo = ypos_[0];
			}
			if(_side == "d"){
				_yTo = ypos_[1];
			}
			if(_type == "h"){
				_yTo = ypos_[2];
			}
		}
	}
}