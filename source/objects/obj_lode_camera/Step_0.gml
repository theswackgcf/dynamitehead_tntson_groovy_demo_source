{
	if(!global._pause && !global._gameover_stopall){
		if(!global._lode_editor){
			if(instance_number(obj_lode_plr) > 0){
				var plr = instance_find(obj_lode_plr,0);
				if(instance_exists(plr)){
					x = plr.x;
					y = plr.y;
				}
			}
		} else {
			x += _xspd;
			y += _yspd;
		}
	}
}