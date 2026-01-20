///function scr_enemyscript_calculatejump([min_distance])
function scr_enemyscript_calculatejump(min_distance){
	var curpos = [x,y];
	var prevpos = [x,y];
	var cellsize = 20;
	if(min_distance == undefined){
		min_distance = cellsize*4;
	}
	
	repeat(WIDTH/cellsize){
		//move object to point by X accounting for solids
		prevpos[0] = curpos[0];
		var dir = 1;
		if(curpos[0] < _jumptopos[0]){
			curpos[0] += cellsize;
		} else if(curpos[0] > _jumptopos[0]){
			curpos[0] -= cellsize;
			dir = -1;
		}
					
		if(place_meeting_array(curpos[0]+(dir*cellsize),curpos[1], _collide_solid) || place_meeting_array(curpos[0]+(dir*cellsize),curpos[1], _collide_other)){
			curpos[0] = prevpos[0];
			_jumptopos[0] = curpos[0];
			break;
		} else {
			if(diff_abs(curpos[0], _jumptopos[0]) <= cellsize*2){
				//object reached point in loop
				break;
			}
		}
	}
	repeat(HEIGHT/cellsize){
		//move object to point by Y accounting for solids
		prevpos[1] = curpos[1];
		var dir = 1;
		if(curpos[1] < _jumptopos[1]){
			curpos[1] += cellsize;
		} else if(curpos[1] > _jumptopos[1]){
			curpos[1] -= cellsize;
			dir = -1;
		}
					
		if(place_meeting_array(curpos[0],curpos[1]+(dir*cellsize), _collide_solid) || place_meeting_array(curpos[0],curpos[1]+(dir*cellsize), _collide_other)){
			curpos[1] = prevpos[1];
			_jumptopos[1] = curpos[1];
			break;
		} else {
			if(diff_abs(curpos[1], _jumptopos[1]) <= cellsize*2){
				//object reached point in loop
				break;
			}
		}
	}
	if(diff_abs(curpos[0], _jumptopos[0]) <= cellsize*2 && diff_abs(curpos[1], _jumptopos[1]) <= cellsize*2){
		if(diff_abs(x, _jumptopos[0]) > min_distance || diff_abs(y, _jumptopos[1]) > min_distance){
			//object reached point & the point is not too close
			return true;
		} else {
			return false;
		}
	}
}