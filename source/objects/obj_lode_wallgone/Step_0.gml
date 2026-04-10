{
	if(global._debug){
		image_alpha = 0.4;
		visible = global._showHitbox;
	}
	
	if(!global._pause && !global._gameover_stopall){
		if(_project){
			if(place_meeting_array(x,y,global._lode_collide_enemy)){
				_max_timer = 220;
			}
			if(place_meeting(x,y,obj_lode_plr)){
				_max_timer = 280;
				var plr = instance_place(x,y,obj_lode_plr);
				if(instance_exists(plr)){
					if(plr._plstate == LODE_STATE_DIG){
						_subtimer = 0;
					} else {
						if(abs(plr._xspd) <= 1 && abs(plr._yspd) <= 1){
							_subtimer ++;
							if(_subtimer >= 240){
								_subtimer = 240;
							}
							_max_timer -= _subtimer;
						} else {
							_subtimer = 0;
						}
					}
				}
			}
			
			var canadd = true;
			if(place_meeting(x,y,obj_lode_crawler_v)){
				canadd = false;
			}
			if(canadd){
				_timer += global._lode_spd;
			}
			if(_timer >= _max_timer-60){
				_show = true;
				_alptimer += global._lode_spd;
				_alp = clamp(abs(sin(_alptimer/10)),0,1);
			} else {
				_show = false;
			}
			if(_timer >= _max_timer){
				_alp = lerp(_alp,1,0.12);
				if(_alp >= 0.95){
					_alp = 1;
					
					global._stage_layout[1][_tilepos[0]][_tilepos[1]] = LTILE_SOL;
					var wall = instance_create_depth(x,y,depth,obj_lode_wall);
					wall._tilepos = _tilepos;
					
					var p = instance_create_depth(x+(sprite_width*0.5)-3,y+(sprite_height*0.5)-3,0,obj_particle);
					p._lode_particle = true;
					p._type = "lode_block";
					
					sfx_play_proximity(snd_lode_block_pop,0.76,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
					
					_project = false;
				}
			}
			
			scr_lode_project(sprite_index,image_index,[x,y],[image_xscale,image_yscale],0,0,c_white,_alp);
		} else {
			_deadtimer ++;
			if(_deadtimer >= 2){
				scr_lode_remove_project();
				instance_destroy();
			}
		}
	}
}