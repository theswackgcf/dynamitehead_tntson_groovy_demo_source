{
	depth = 9995;
	
	if(!global._pause){
		_timer ++;
		x += 32;
		y -= 4;
			
		if(_timer % 4 == 0){
			var p = instance_create_depth(x, y, depth, obj_particle);
			p._type = "barrelfly";
			p._forcedepth = depth+1;
			p._move = false;
			p._xspd = -4;
		}
		
		image_angle = 25;
		
		if(_timer >= 180){
			instance_destroy();
		}
	}
}