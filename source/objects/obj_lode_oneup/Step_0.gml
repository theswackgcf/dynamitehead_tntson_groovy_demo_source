{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;

		if(!global._lode_editor){
			if(global._lode_boss){
				if(!_boss_show){
					_show = true;
					_boss_show = true;
				}
			}
			if(_show){
				if(global._lode_boss){
					_show_timer = 60;
				}
				if(!_show_particle){
					var p = instance_create_depth(x-3,y-3,0,obj_particle);
					p._lode_particle = true;
					p._type = "lode_block";
					
					_show_particle = true;
				}
				
				_show_timer += global._lode_spd;
				
				if(_show_timer >= 30){
					_active = true;
				}
				if(_show_timer >= global._lode_skulltimer){
					var p = instance_create_depth(x-3,y-3,0,obj_particle);
					p._lode_particle = true;
					p._type = "lode_block";
					
					_active = false;
					_show = false;
				}
			}
		} else {
			_show = true;
		}
		
		scr_lode_overtile();
		
		if(_project){
			scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale]);
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