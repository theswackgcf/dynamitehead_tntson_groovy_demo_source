{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		_sintimer ++;
		
		var floatoffset_x = 0;
		var floatoffset_y = cos(_sintimer/22)*6;
		
		if(!global._lode_editor){
			if(_followobj != noone && instance_exists(_followobj)){
				var base_y = _followobj.y-(sprite_height*0.5);
				
				x = _followobj.x;
				y = base_y;
				
				var base_time = 24;
				var amp = 32;
				floatoffset_x = sin(_sintimer/base_time)*amp;
				floatoffset_y = (cos(_sintimer/base_time)*sin(_sintimer/base_time))*amp;
				
				if(round(floatoffset_x) <= -amp || round(floatoffset_x) >= amp){
					if(!_reset_depth){
						_depth_type = !_depth_type;
						_reset_depth = true;
						with(obj_mg_lode){
							_depthsort_timer = 99;
						}
					}
				} else {
					_reset_depth = false;
				}
				
				if(!_depth_type){
					_depth = 4;
				} else {
					_depth = 12;
				}
			}
			
			_sparklesoffset = [floatoffset_x,-8+(sprite_height*0.5)+floatoffset_y];
			
			if(_show){
				if(_sparkles == noone){
					_sparkles = instance_create_depth(x,y,0,obj_lode_follower_collect);
					_sparkles._parentobj = self;
					_sparkles._id = "collect"+string(x+y)+string(irandom(99999));
				}
			} else {
				if(_sparkles != noone && instance_exists(_sparkles)){
					instance_destroy(_sparkles.id);
					_sparkles = noone;
				}
			}
		}
		
		scr_lode_overtile();
		
		if(_project){
			_disppos = [x,y];
			scr_lode_project(sprite_index,image_index,[x+floatoffset_x,(y-8)+floatoffset_y],[image_xscale,image_yscale],_depth);
		} else {
			_deadtimer ++;
			if(_deadtimer >= 2){
				scr_lode_remove_project();
				global._stage_layout[0][_tilepos[0]][_tilepos[1]] = global._stage_layout_bg[_tilepos[0]][_tilepos[1]];
				
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}