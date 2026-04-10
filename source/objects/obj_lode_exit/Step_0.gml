{
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause && !global._gameover_stopall){
		image_speed = 1;
		
		if(!global._lode_editor){
			if(!_key_init && instance_number(obj_lode_key) > 0){
				_has_key = true;
				_key_init = true;
			}
			
			var maxval = global._lode_collect_max;
			if(global._lode_boss){
				maxval = global._lode_collect_cur;
			}
			
			if(global._lode_collect_cur >= maxval){
				if(!_open && !_stage_exit){
					if(!global._lode_boss){
						sfx_play(snd_lode_door_unlock);
					}
					
					if(!global._lode_spawnstuff){
						with(obj_lode_skulls){
							_show = true;
							_show_timer = 0;
						}
						with(obj_lode_oneup){
							_show = true;
							_show_timer = 0;
						}
						
						global._lode_spawnstuff = true;
					}
					
					with(obj_lode_bone_ladder){
						_show = true;
					}
					
					if(!_has_key){
						if(!global._lode_boss){
							with(obj_mg_lode){
								_exit_type = 0;
								_exit_trigger = true;
						
								_exit_spacing = 48;
								_exit_timer = 0;
								_exit_act = 0;
			
								_exit_bottomy = _disp_dim[1]+sprite_get_height(spr_lode_gui_bottom);
								_exit_bottomalp = 0;
							}
						}
					} else {
						if(_do_locked == 0){
							_do_locked = 1;
						}
					}
					
					_open = true;
					_change = true;
				}
				
				if(_do_locked == 1){
					_locked = true;
					_locked_img = 0;
									
					sfx_play_proximity(snd_lode_lock1,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
									
					with(obj_mg_lode){
						_exit_type = 1;
						_exit_trigger = true;
						
						_exit_spacing = 48;
						_exit_timer = 0;
						_exit_act = 0;
			
						_exit_bottomy = _disp_dim[1]+sprite_get_height(spr_lode_gui_bottom);
						_exit_bottomalp = 0;
					}
									
					with(obj_lode_key){
						var p = instance_create_depth(x,y-8,0,obj_particle);
						p._lode_particle = true;
						p._type = "lode_block";
										
						_show = true;
					}
					
					_do_locked = 2;
				}
				
				if(_stage_exit){
					_exit_timer --;
					if(_exit_timer <= 0 && _open){
						sfx_play(snd_lode_door_down);
						
						_open = false;
						_change = true;
					}
				}
			}
			
			//animation
			if(_change){
				_gate_offset += _gate_yspd;
				
				if(_open){
					_gate_yspd -= 0.22;
					if(_gate_offset <= -24){
						_gate_offset = -24;
						_change = false;
					}
				} else {
					_gate_yspd += 0.12;
					if(_gate_offset >= 0){
						with(obj_mg_lode){
							_scr_shake_y = 9;
							_tr_exit_act = 1;
						}
						
						sfx_play(snd_lode_door_close);
						
						_gate_offset = 0;
						_change = false;
					}
				}
			} else {
				_gate_yspd = 0;
			}
		}
		
		scr_lode_overtile();
		
		var project_array = [
			{
				spr: spr_lode_exit,
				ind: 0,
				pos: [x,y],
				scale: [image_xscale,image_yscale],
				depth_: -3,
				tilepos: [_tilepos[0],_tilepos[1]],
			},
			{
				spr: spr_lode_exit_gate,
				ind: 0,
				pos: [x,y+_gate_offset],
				scale: [image_xscale,image_yscale],
				depth_: -1,
				tilepos: [_tilepos[0],_tilepos[1]],
			},
		];
		if(_locked){
			array_push(project_array, {
				spr: _locked_spr,
				ind: _locked_img,
				pos: [x,y],
				scale: [image_xscale,image_yscale],
				depth_: 0,
				tilepos: [_tilepos[0],_tilepos[1]],
			});
			
			_locked_img += 0.165;
			var frameslen = sprite_get_info(spr_lode_exit_locked).num_subimages-1;
			if(_locked_img >= frameslen){
				_locked_img = frameslen;
			}
			if(_locked_img >= 6 && !_lock_snd){
				sfx_play_proximity(snd_lode_lock2,1,false,global._lode_camera_pos[0],global._lode_camera_pos[1]);
				_lock_snd = true;
			}
		}
		
		scr_lode_project_array(project_array);
	} else {
		image_speed = 0;
	}
}