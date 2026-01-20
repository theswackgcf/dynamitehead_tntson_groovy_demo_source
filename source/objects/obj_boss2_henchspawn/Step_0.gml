{
	visible = false;
	if(global._debug){
		visible = global._showHitbox
	}
	
	if(!global._pause){
		if(place_meeting(x,y,obj_battleborder)){
			_collideborder = 4;
		}
		if(_collideborder > 0){
			_collideborder --;
		}
		
		var lank = instance_nearest(x,y,obj_boss2_mask);
		if(instance_exists(lank)){
			x = lank.x;
			y = lank.y;
		}
	}
}