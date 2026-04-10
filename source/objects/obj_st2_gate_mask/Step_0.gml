{
	if(!global._debug){
		visible = false;
	} else {
		visible = global._showHitbox;
	}
	
	if(!_checkdelete){
		if(global._deleteready){
			if(ds_map_exists(global._deletedStuff, self.id)){
				var gate = instance_create_depth(_displayobj.x+_g_offsets[0][0],_displayobj.y+_g_offsets[0][1],_displayobj.depth,obj_st2_gate_open);
				gate.sprite_index = spr_st2_gate_open_1;
				var gate2 = instance_create_depth(_displayobj.x+_g_offsets[1][0],_displayobj.y+_g_offsets[1][1],_displayobj.depth,obj_st2_gate_open);
				gate2.sprite_index = spr_st2_gate_open_2;
				
				killself();
			}
			_checkdelete = true;
		}
	}
	
	scr_sequence_pause();
	
	if(!global._pause){
		if(!_init){
			scr_enemyscript_init("step");
		} else {
			_dispoffset[1] = -72;
			_startTimer --;
			if(!_idiot && _startTimer <= 0){
				if(_hurttimer > 0){
					_hurttimer --;
				}
				scr_enemyscript_behavior("");
				if(_freeze <= 0){
					_movetimer ++;
			
					scr_enemyscript_animation("step");
					
					if(!_death){
						_anim_prev = _anim;
						_anim = "idle";
					}
					
					scr_enemyscript_other();
				} else {
					_curstate = STATE_OTHER;
					clearpath();
				}
			}
			
			if(_hurttimer > 0){
				with(obj_st2_rain){
					_thundertimer = 0;
				}
				
				with(obj_tipbox){
					if(_prompt == "punch"){
						global._deletedStuff[? self.id] = self.id;
						instance_destroy();
					}
				}
				global._gametips[? "punch"][1] = true;
			}

			//opened
			if(_hp <= 2){
				if(!_opened){
					sfx_play_choose(global._kdsounds);
					sfx_play(snd_finalko)
					
					var p = instance_create_depth(x,y,depth, obj_particle);
					p._type = "hit_final";
					global._contrasthit = global._contrasthit_max;
					
					with(obj_camera){
						_ampX = 35;
					}
					
					with(obj_st2_bw_sleep){
						_freeze = global._freezeFrames.long_freeze;
						_trigger = true;
					}
					
					_opened = true;
				}
			}
			
			if(_freeze > 0){
				_freeze -= 1;
			}
			
			if(_freeze <= 0){
				if(_opened){
					if(!_death){
						var gate = instance_create_depth(_displayobj.x+_g_offsets[0][0],_displayobj.y+_g_offsets[0][1],_displayobj.depth,obj_st2_gate_open);
						gate._freeze = _freeze;
						gate.sprite_index = spr_st2_gate_open_1;
						var gate2 = instance_create_depth(_displayobj.x+_g_offsets[1][0],_displayobj.y+_g_offsets[1][1],_displayobj.depth,obj_st2_gate_open);
						gate2._freeze = _freeze;
						gate2.sprite_index = spr_st2_gate_open_2;
						
						with(obj_st2_gate_delsolids){
							_trigger = true;
						}
						
						global._pad_vibrate = 12;
						
						global._deletedStuff[? self.id] = self.id;
						
						with(obj_st2_rain){
							_thundertimer = 9999;
						}
						with(obj_bg){
							_lv2_tint = c_white;
						}
						
						sfx_play(snd_gate_open);
						
						killself();
					}
				}
			}
		}
		
		/*(_displayobj){
			if(instance_number(obj_stageentrance) > 0){
				_forcedepth = 9980;
			} else {
				_forcedepth = 0;
			}
		}*/
	} else {
		clearpath();
		with(_displayobj){
			image_speed = 0;
		}
	}
}