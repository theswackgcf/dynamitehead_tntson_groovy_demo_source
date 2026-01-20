function scr_hopspot(hoptype){	
	if(!is_array(hoptype)){
		var distx = _jumpingdist[0];
		var disty = _jumpingdist[1];
		if(round(random(2)) == 1){
			distx = -_jumpingdist[0];
		}
		if(round(random(2)) == 1){
			disty = -_jumpingdist[1];
		}
		
		switch(hoptype){
			case HOP_RANDOM:
				//get a random spot
				_jumptopos = [floor(x+(distx+random_range(-520,520))),floor(y+(disty+random_range(-520,520)))];
			break;
			case HOP_DH:
				//hop right on top of dynamitehead
				_dh = instance_nearest(x,y,obj_dh_mask);
				_dh._occupycenter = 120;
				_jumptopos = [_dh.x,_dh.y];
			break;
			case HOP_CLOSE_DH:
				//hop right on top of dynamitehead
				_dh = instance_nearest(x,y,obj_dh_mask);
				_dh._occupycenter = 120;
				_jumptopos = [_dh.x+random_range(-190,190),_dh.y+random_range(-190,190)];
			break;
			case HOP_RANDOM_DH:
				//get a random spot around dynamitehead
				_dh = instance_nearest(x,y,obj_dh_mask);
				_jumptopos = [floor(_dh.x+(distx+random_range(-120,120))),floor(_dh.y+(disty+random_range(-120,120)))];
			break;
			case HOP_BACK:
				var offsetx = 200*_curdir;
				_jumptopos = [x+offsetx,y];
				if(place_meeting_array(x+abs(offsetx), y, _collide_solid) || place_meeting_array(x+abs(offsetx), y, _collide_other)){
					_jumptopos = [x-abs(offsetx),y];
				} else if(place_meeting_array(x-abs(offsetx), y, _collide_solid) || place_meeting_array(x-abs(offsetx), y, _collide_other)){
					_jumptopos = [x+abs(offsetx),y];
				} else {
					_jumptopos = [x,y];
				}
			break;
			case HOP_SLIDE:
				_dh = instance_nearest(x,y,obj_dh_mask);
				if(x < _dh.x){
					_jumptopos = [_dh.x-_slidedist,_dh.y];
				} else {
					_jumptopos = [_dh.x+_slidedist,_dh.y];
				}
			break;
			case HOP_NEAR:
				//jump to a random spot around self
				_jumptopos = [floor(x+((distx*0.8)+random_range(-60,60))),floor(y+((disty*1.2)+random_range(-60,60)))];
			break;
		}
	} else {
		//jump to array position
		_jumptopos = [hoptype[0],hoptype[1]];
	}
}