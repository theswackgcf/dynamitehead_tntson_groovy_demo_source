{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		_show = false;
		if(_codename != ""){
			var spr = asset_get_index("spr_lode_"+_codename+"_ghost");
			if(sprite_exists(spr)){
				sprite_index = spr;
				_show = true;
			}
		}
		
		_sintimer ++;
		var sinval = sin(_sintimer/22)*27;
		if(x+sinval >= _startx){
			image_xscale = -1;
		} else {
			image_xscale = 1;
		}
		
		y -= 0.98;
		
		if(y <= -sprite_height){
			scr_lode_remove_project();
		}
		
		scr_lode_overtile();
		
		if(_project){
			scr_lode_project(sprite_index,image_index,[x+sinval,y],[image_xscale,image_yscale],_depth);
		} else {
			_deadtimer ++;
			if(_deadtimer >= 2){
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}