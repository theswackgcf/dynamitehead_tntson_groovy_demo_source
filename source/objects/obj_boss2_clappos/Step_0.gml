{
	if(global._debug){
		visible = global._showHitbox;
	}

	if(global._bossstart){
		x = _startx;
		
		var boss2bg = instance_nearest(x,y,obj_boss2_bg);
		var dh = instance_nearest(x,y,obj_dh_mask);
		if(boss2bg != noone && instance_exists(boss2bg)){
			if(x < boss2bg.x){
				_dir = DIR_L;
			} else {
				_dir = DIR_R;
			}
			if(dh != noone && instance_exists(dh)){
				if((dh.x < x && _dir == DIR_L) || (dh.x > x && _dir == DIR_R)){
					x = dh.x;
				}
			}
		}
	}
}