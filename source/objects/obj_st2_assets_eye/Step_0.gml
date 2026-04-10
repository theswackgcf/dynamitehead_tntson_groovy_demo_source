{
	if(!global._pause){
		var dh = instance_nearest(x,y,obj_dh_mask);
		if(instance_exists(dh)){
			var offset_x = 0;
			var offset_y = -8;
			
			var dist_x = dh.x - _middlepoint[0];
			var dist_y = dh.y - _middlepoint[1];
			
			var dist = sqrt(dist_x*dist_x + dist_y*dist_y);
			
			_curpoint = [dh.x,dh.y];
			
			var maxdist = _radius - sprite_width;
			
			var ang = arctan2(dist_y,dist_x);
			if(dist > maxdist){
				_curpoint[0] = _middlepoint[0]+cos(ang)*maxdist;
				_curpoint[1] = _middlepoint[1]+sin(ang)*maxdist;
			}
			
			x = _curpoint[0]+offset_x;
			y = _curpoint[1]+offset_y;
		}
	}
}