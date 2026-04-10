{
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!global._pause && !global._gameover_stopall){
		if(!_setpos){
			if(place_meeting(x+global._lode_tilesize,y,obj_lode_rope)){
				x = _startx+(global._lode_tilesize*0.5);
				_setpos = true;
			} else if(place_meeting(x-global._lode_tilesize,y,obj_lode_rope)){
				x = _startx-(global._lode_tilesize*0.5);
				_setpos = true;
			}
		} else {
			if(!place_meeting(x+global._lode_tilesize,y,obj_lode_rope) && !place_meeting(x-global._lode_tilesize,y,obj_lode_rope)){
				x = _startx;
				_setpos = false;
			}
		}
		
		scr_lode_overtile();
		
		scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale]);
	}
}