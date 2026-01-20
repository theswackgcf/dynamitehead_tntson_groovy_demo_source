function scr_player_movement(){
	if(_state == "slide" || _falling || _runroll){
		global._axisspd = [1,1];
	}
	
	if(scr_checkaxis("left", 0) || scr_checkaxis("right", 0)){
		totalspd[0] = (_spd[0]*global._axisspd[0])*_speed;
	} else {
		totalspd[0] = _spd[0]*_speed;
	}
	
	if(scr_checkaxis("up", 0) || scr_checkaxis("down", 0)){
		totalspd[1] = (_spd[1]*global._axisspd[1])*_speed;
	} else {
		totalspd[1] = _spd[1]*_speed;
	}
		
	_float[0] = frac(totalspd[0]);
	_float[1] = frac(totalspd[1]);
		
	var mult = 3;
		
	//x-move
	repeat(abs(totalspd[0])){
		var go_x = true;
		var slidespot = false;
		var slope = false;
		
		//x slopes
		if(place_meeting(x+sign(totalspd[0]), y, obj_slope)){
			var slope = instance_place(x+sign(totalspd[0]), y, obj_slope);
			if(totalspd[0] > 0){
				go_x = false;
				slope = true;
				if(_slide){
					mult = 0;
				}
				if(place_meeting(x+sign(totalspd[0]),y+sign(totalspd[1]), obj_collidedown)){
					mult = 0;
				}
				if(totalspd[1] < 0){
					mult = 0;
				}
				y += slope.image_yscale*abs(totalspd[0])*mult;
			}
		}
		
		//x solid collision
		if(place_meeting_array(x + sign(totalspd[0]), y, _collidesolid)){
			var inst = place_meeting_array(x+sign(totalspd[0]), y, _collidesolid, true, true);
			if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height < inst._height && (inst._collidewith == "all" || inst._collidewith == "player")){
				go_x = false;
			}
		}
		
		//x side collision
		if(place_meeting(x+sign(totalspd[0]), y, obj_collideleft)){
			var bb = instance_place(x+sign(totalspd[0]),y, obj_collideleft);
			if(instance_exists(bb) && totalspd[0] < 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_x = false;
			}
		}
		if(place_meeting(x+sign(totalspd[0]), y, obj_collideright)){
			var bb = instance_place(x+sign(totalspd[0]),y, obj_collideright);
			if(instance_exists(bb) && totalspd[0] > 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_x = false;
			}
		}
		if(place_meeting(x+sign(totalspd[0]), y, obj_collideleftup)){
			var bb = instance_place(x+sign(totalspd[0]),y, obj_collideleftup);
			if(instance_exists(bb) && totalspd[0] < 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_x = false;
			}
		}
		if(place_meeting(x+sign(totalspd[0]), y, obj_collideleftdown)){
			var bb = instance_place(x+sign(totalspd[0]),y, obj_collideleftdown);
			if(instance_exists(bb) && totalspd[0] < 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_x = false;
			}
		}
		
		if(place_meeting(x+sign(totalspd[0]), y, obj_colliderightup)){
			var bb = instance_place(x+sign(totalspd[0]),y, obj_colliderightup);
			if(instance_exists(bb) && totalspd[0] > 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_x = false;
			}
		}
		if(place_meeting(x+sign(totalspd[0]), y, obj_colliderightdown)){
			var bb = instance_place(x+sign(totalspd[0]),y, obj_colliderightdown);
			if(instance_exists(bb) && totalspd[0] > 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_x = false;
			}
		}
		//x border collision
		if(place_meeting(x+sign(totalspd[0]), y, obj_battleborder)){
			var bb = instance_place(x+sign(totalspd[0]),y,obj_battleborder);
			if(instance_exists(bb) && ((totalspd[0] < 0 && bb._side == "l") || (totalspd[0] > 0 && bb._side == "r")) && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_x = false;
			}
		}
		
		//special cases
		if(place_meeting(x + sign(totalspd[0]), y, obj_slidespot)){
			var inst = instance_place(x+sign(totalspd[0]), y, obj_slidespot);
			if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height < inst._height && !_slide && !_runroll && (inst._collidewith == "all" || inst._collidewith == "player")){
				slidespot = true;
				go_x = false;
			}
		}
		
		if(go_x){
			x += sign(totalspd[0]);
		} else {
			if(!slidespot){
				_walltouch[0] = 4;
			} else {
				_slidetouch = 4;
				_running = false;
				_runtimer = 0;
			}
			if(!slope){
				_spd[0] = 0;
				totalspd[0] = 0;
			} else {
				x += slope.image_xscale*mult;
				_spd[0] = mult;
				totalspd[0] = mult;
			}
			if(_slide && !_runroll){
				if(!place_meeting(x,y,obj_slidespot)){
					_slidespd = 0;
					_slide = false;
				}
			}
			break;
		}
	}
	
	//y-move
	repeat(abs(totalspd[1])){
		var go_y = true;
		var slope = false;
		
		//y slopes
		if(place_meeting(x, y+sign(totalspd[1]), obj_slope)){
			var slope = instance_place(x, y+sign(totalspd[1]), obj_slope);
			if(totalspd[1] < 0){
				go_y = false;
				slope = true;
				if(totalspd[0] > 0){
					mult = 0;
				}
				x -= slope.image_xscale*abs(totalspd[1])*mult;
			}
		}
		
		//y solid collision
		if(place_meeting_array(x, y + sign(totalspd[1]), _collidesolid)){
			var inst = place_meeting_array(x, y+sign(totalspd[1]), _collidesolid, true, true);
			if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height < inst._height && (inst._collidewith == "all" || inst._collidewith == "player")){
				go_y = false;
			}
		}
		//y side collision
		if(place_meeting(x, y+sign(totalspd[1]), obj_collidedown)){
			var bb = instance_place(x,y+sign(totalspd[1]), obj_collidedown);
			if(instance_exists(bb) && totalspd[1] > 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_y = false;
			}
		}
		if(place_meeting(x, y+sign(totalspd[1]), obj_collideup)){
			var bb = instance_place(x,y+sign(totalspd[1]), obj_collideup);
			if(instance_exists(bb) && totalspd[1] < 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_y = false;
			}
		}
		if(place_meeting(x, y+sign(totalspd[1]), obj_collideleftup)){
			var bb = instance_place(x,y+sign(totalspd[1]), obj_collideleftup);
			if(instance_exists(bb) && totalspd[1] < 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_y = false;
			}
		}
		if(place_meeting(x, y+sign(totalspd[1]), obj_collideleftdown)){
			var bb = instance_place(x,y+sign(totalspd[1]), obj_collideleftdown);
			if(instance_exists(bb) && totalspd[1] > 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_y = false;
			}
		}
		if(place_meeting(x, y+sign(totalspd[1]), obj_colliderightup)){
			var bb = instance_place(x,y+sign(totalspd[1]), obj_colliderightup);
			if(instance_exists(bb) && totalspd[1] < 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_y = false;
			}
		}
		if(place_meeting(x, y+sign(totalspd[1]), obj_colliderightdown)){
			var bb = instance_place(x,y+sign(totalspd[1]), obj_colliderightdown);
			if(instance_exists(bb) && totalspd[1] > 0 && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_y = false;
			}
		}
		//y border collision
		if(place_meeting(x, y+sign(totalspd[1]), obj_battleborder)){
			var bb = instance_place(x,y+sign(totalspd[1]),obj_battleborder);
			if(instance_exists(bb) && ((totalspd[1] < 0 && bb._side == "u") || (totalspd[1] > 0 && bb._side == "d")) && (bb._collidewith == "all" || bb._collidewith == "player")){
				go_y = false;
			}
		}
		
		//special cases
		if(place_meeting(x, y+sign(totalspd[1]), obj_slidespot)){
			var inst = instance_place(x, y+sign(totalspd[1]), obj_slidespot);
			if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height < inst._height && !_slide && !_runroll && (inst._collidewith == "all" || inst._collidewith == "player")){
				go_y = false;
			}
		}
		
		if(go_y){
			y += sign(totalspd[1]);
		} else {
			_walltouch[1] = 4;
			if(!slope){
				_spd[1] = 0;
				totalspd[1] = 0;
			} else {
				y -= slope.image_yscale*mult;
				_spd[1] = -mult;
				totalspd[1] = -mult;
			}
			break;
		}
	}
	
	for(var i = 0; i < 2; i++){
		if(_walltouch[i] > 0){
			_walltouch[i] --;
		} else if(_walltouch[i] < 0){
			_walltouch[i] = 0;
		}
	}
	
	if(_slidetouch > 0){
		_slidetouch --;
	}
	
	_diagspeed = sqrt( abs((_maxspd[0]*_maxspd[1])/2) );
}