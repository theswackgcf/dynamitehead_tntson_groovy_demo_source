{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		if(!global._lode_editor){
			//checker
			if(!_checkdelete){
				if(ds_map_exists(global._lode_deletedStuff, _id)){
					_trigger = true;
					_trigger_act = 2;
					
					global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]] = LTILE_AIR;
					if(_tilelayer == 0){
						global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]] = global._stage_layout_bg[_tilepos[0]][_tilepos[1]];
					}
					
					y = global._lode_deletedStuff[? _id].yy;
					_tilepos[0] = round(y/global._lode_tilesize);
					
					global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]] = LTILE_STAL;
					if(_tilelayer == 0){
						global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]] = global._stage_layout_bg[_tilepos[0]][_tilepos[1]];
					}
					
					_offset[1] = global._lode_deletedStuff[? _id]._offset;
				}
				
				_checkdelete = true;
			}
			
			if(!_trigger){
				var plr = instance_nearest(x,y,obj_lode_plr);
				if(instance_exists(plr)){
					//player is close by x
					if(diff_abs(x,plr.x) <= 96){
						_checker = true;
					}
				}
		
				if(_checker){
					if(_checkerobj == noone){
						_checkerobj = instance_create_depth(x,y,0,obj_lode_stalactite_checker);
						_checkerobj._parentobj = self;
					}
				}
			
				_trigger_act = 0;
				_trigger_timer = 0;
			} else {
				//fall off
				_trigger_timer += global._lode_spd;
				switch(_trigger_act){
					case 0:
						_offset[0] = sin(random(480))*3;
						if(_trigger_timer >= 20){
							_hitbox = instance_create_depth(x,y,0,obj_lode_stalactite_hitbox);
							_hitbox._parentobj = self;
							
							_offset[0] = 0;
							_offset[1] = diff_abs(y,_landy)*-1;
							
							global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]] = LTILE_AIR;
							
							y = _landy;
							_tilepos[0] = round(y/global._lode_tilesize);
							
							global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]] = LTILE_STAL;
							
							sfx_play_proximity(snd_lode_stalac_fall,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
							
							_trigger_act = 1;
							_trigger_timer = 0;
						}
					break;
					case 1:
						y = _landy;
						_offset[1] += 5*global._lode_spd;
						
						_falltimer ++;
						if(_falltimer >= random_range(4,6)){
							var p = instance_create_depth(x+(sprite_width*0.5)-2,y-2+_offset[1],0,obj_particle);
							p._type = "lode_break";
							p._lode_particle = true;
							p._move = true;
							p._xspd = random_range(-1,1);
							p._yspd = random_range(1,1.8);
							
							_falltimer = 0;
						}
						
						if(_offset[1] >= 0){
							_offset[1] = 0;
							
							if(_hitbox != noone && instance_exists(_hitbox)){
								_hitbox._destroy = true;
							}
							
							var p = instance_create_depth(x+(sprite_width*0.5)-2,y-6+sprite_height,0,obj_particle);
							p._type = "lode_land";
							p._lode_particle = true;
							
							global._lode_deletedStuff[? _id] = {
								yy: y,
								_offset: _offset[1],
							}
							
							sfx_stop(snd_lode_stalac_fall);
							sfx_play_proximity(snd_lode_stalac_land,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
							
							_shake_amp = 5;
							_trigger_act = 2;
							_trigger_timer = 0;
						}
					break;
					case 2:
						if(place_meeting(x,y+sprite_height,obj_lode_wallgone)){
							var wallgone = instance_place(x,y+sprite_height,obj_lode_wallgone);
							if(instance_exists(wallgone)){
								wallgone._timer = wallgone._max_timer;
							}
						}
						sprite_index = spr_lode_stalactite_ground;
						_offset[0] = sin(random(480))*_shake_amp;
						if(_shake_amp > 0){
							_shake_amp -= 0.6;
							if(_shake_amp < 0){
								_shake_amp = 0;
							}
						}
					break;
				}
			}
		}
		
		scr_lode_overtile();
		
		scr_lode_project(sprite_index,image_index,[x+_offset[0],y+_offset[1]],[image_xscale,image_yscale],_depth);
	} else {
		image_speed = 0;
	}
}