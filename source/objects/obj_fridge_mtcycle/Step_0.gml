{
	if(!global._pause){
		image_speed = 1;
		
		x += _mt_spd;
		_mt_spd -= 1;
	
		_mt_exhausttime ++;
		if(_mt_exhausttime >= random_range(6,8)){
			var p = instance_create_depth(x+(-250*_curdir), y+56, depth+8, obj_particle);
			p._type = "exhaust"+string(choose(1,2,3));
			p._move = true;
			p._xspd = 9.2*_curdir;
			p._yspd = 0;
			p._angle = 0;
			p._curdir = _curdir;
			p._scale = random_range(1.2,1.62);
			p._forcedepth = depth+8;
			p._adddepth = 0;
							
			_mt_exhausttime = 0;
		}
		
		_timer ++;
		
		if(_timer >= 100){
			instance_destroy();
		}
	} else {
		image_speed = 0;
	}
}