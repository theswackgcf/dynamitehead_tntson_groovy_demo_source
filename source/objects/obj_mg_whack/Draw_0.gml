{
	if(_init){
		//draw bg
		draw_set_color(c_black);
		draw_rectangle(0, 0, WIDTH, HEIGHT, false);
		draw_set_color(c_white);
		
		draw_sprite(spr_whack_bg_sky, floor(_skyframe), 0, _tnt_offset);
		
		if(_thunder_alp > 0){
			draw_set_alpha(lerp(0,_thunder_alp,1));
			draw_rectangle(0, 0, WIDTH, HEIGHT, false);
			draw_set_alpha(1);
		}
		
		draw_sprite(spr_whack_bg, 0, 0, _tnt_offset);
		
		//draw scores
		var dispframe = 0;
		if(_bonus_scoremult > 0){
			dispframe = 1;
			if(!(_bonus_scoremult >= 0.14 && _bonus_scoremult <= 0.94)){
				if((_bonus_scoremult*100)%0.7 < 0.3){
					dispframe = 1;
				} else {
					dispframe = 0;
				}
			}
		}
		
		var dispcol = c_white;
		if(_bonus_scoremult > 0){
			 dispcol = _bonuscol;
		}
		
		draw_sprite(spr_whack_disp1, dispframe, 0, _tnt_offset);
		draw_sprite(spr_whack_disp2, 0, 0, _tnt_offset);
		if(_score_multiplier > 1){
			scr_textrender_type(370, 50, "x"+string(_score_multiplier), true, dispcol);
		}
		
		drawscore(_score_string, 48, 60+_tnt_offset, false, dispcol);
		drawscore(_monyx_string, WIDTH-96, 60+_tnt_offset, true);
		
		//draw the spots
		var offset = [0,60+_tnt_offset];
	
		var draw = [0,0];
	
		var spotsize = [320,126];
		var spacing = [-24,42];
		var scale = [0.8,0.9,1];
			
		draw[1] = floor(HEIGHT/2)-((array_length(_spots)-1)*((spotsize[1]+spacing[1])*0.5));
		
		//second pass
		for(var yy = 0; yy < array_length(_spots); yy++){
			draw[0] = floor(WIDTH/2)-((array_length(_spots[yy])-1)*(((spotsize[0]+spacing[0])*scale[yy])*0.5));
			for(var xx = 0; xx < array_length(_spots[yy]); xx++){
				if(_spots[yy][xx]){
					var maxdepth = 3;
					for(var dep = 0; dep < maxdepth; dep++){
						var drawspot = [offset[0]+draw[0],offset[1]+draw[1]];
					
						var flames_offset = -72;
						var flames_size = 0.62;
						if(_flames_rows[yy][0] == -1){
							_flames_rows[yy] = [drawspot[1]-(spotsize[1]*flames_size)+flames_offset,drawspot[1]+(spotsize[1]*flames_size)+flames_offset,drawspot[1]];
						}
					
						if(global._debug && global._showHitbox){
							draw_set_color(c_purple);
							draw_set_alpha(0.45);
							for(var dbg = 0; dbg < array_length(_flames_rows); dbg++){
								if(dbg == yy){
									draw_rectangle(0,_flames_rows[dbg][0],WIDTH,_flames_rows[dbg][1],false);
								}
							}
							draw_set_color(c_white);
							draw_set_alpha(1);
						}
					
						//draw bg
						var curframe = 0;
						if(_inptype == WHACK_INPUT_KEY){
							if(_curspot[0] == xx && _curspot[1] == yy){
								curframe = 1;
								_curspot_coords = [drawspot[0], drawspot[1]-64];
							}
						}
						draw_sprite_ext(spr_whack_spotbg, curframe, drawspot[0], drawspot[1], _spots_scale[yy][xx][0]*scale[yy], _spots_scale[yy][xx][1]*scale[yy], 0, c_white, 1);
				
						var curent = string(xx)+" "+string(yy);
				
						//update flames
						if(ds_map_size(_flames) > 0){
							var dskeys = ds_map_keys_to_array(_flames);
							for(var i = 0; i < array_length(dskeys); i++){
								if(ds_map_exists(_flames, dskeys[i])){
									var curflame = _flames[? dskeys[i]];
									if(curflame.row == yy){
										if(!curflame.tnt || (curflame.tnt && _enemystate[? curent].exists && diff_abs(curflame.posx, _enemystate[? curent].posx) <= 32)){
											draw_sprite_ext(spr_whack_fire, floor(_fireframe%3), curflame.posx, curflame.posy, curflame.scalex+(sin(curflame.timer/3)*0.12), curflame.scaley+(cos(curflame.timer/3)*0.12), 0, c_white, 1);
										}
									}
								}
							}
						}
					
						//set hitbox
						if(!_enemystate[? curent].setbbox){
							var bbox_offset = [0,-125];
						
							_enemystate[? curent].bbox[0] = (drawspot[0]-(_enemystate[? curent].width*0.5))+bbox_offset[0];
							_enemystate[? curent].bbox[1] = (drawspot[1]-(_enemystate[? curent].height*0.5))+bbox_offset[1];
							_enemystate[? curent].bbox[2] = (drawspot[0]+(_enemystate[? curent].width*0.5))+bbox_offset[0];
							_enemystate[? curent].bbox[3] = (drawspot[1]+(_enemystate[? curent].height*0.5))+bbox_offset[1];
								
							_enemystate[? curent].setbbox = true;
						}
					
						//draw entity
						if(_enemystate[? curent].exists){
							if(_enemystate[? curent].posx == -1 && _enemystate[? curent].posy == -1){
								_enemystate[? curent].posx = drawspot[0];
								_enemystate[? curent].posy = drawspot[1];
							}
						
							if(_enemystate[? curent].spr != -1 && sprite_exists(_enemystate[? curent].spr)){
								if(global._debug && global._showHitbox){
									draw_set_color(c_red);
									draw_rectangle(_enemystate[? curent].bbox[0],_enemystate[? curent].bbox[1],_enemystate[? curent].bbox[2],_enemystate[? curent].bbox[3],false);
									draw_set_color(c_white);
								}
						
								//outline
								var entoffset = [_enemystate[? curent].offset[0],_enemystate[? curent].offset[1]];
							
								if(_enemystate[? curent].on && (_enemystate[? curent].act == WHACK_ACT_APPEAR || _enemystate[? curent].act == WHACK_ACT_PRESENT)){
									scr_draw_outline(_enemystate[? curent].spr, floor(_enemystate[? curent].img), drawspot[0]+entoffset[0], drawspot[1]+entoffset[1], _enemystate[? curent].scale[0]*scale[yy], _enemystate[? curent].scale[1]*scale[yy], 0, c_white, 1, [255, 194, 25]);
								}
							
								draw_sprite_ext(_enemystate[? curent].spr, _enemystate[? curent].img, drawspot[0]+entoffset[0], drawspot[1]+entoffset[1], _enemystate[? curent].scale[0]*scale[yy], _enemystate[? curent].scale[1]*scale[yy], 0, c_white, 1);
								
								if(!_firstbonked && _enemystate[? curent].act == WHACK_ACT_PRESENT){
									draw_sprite_ext(spr_whack_bubble, 0, drawspot[0]+entoffset[0], drawspot[1]+entoffset[1], _enemystate[? curent].scale[0]*scale[yy], _enemystate[? curent].scale[1]*scale[yy], 0, c_white, 1);
								}
								
								//hp
								if((_enemystate[? curent].act == WHACK_ACT_PRESENT || _enemystate[? curent].act == WHACK_ACT_BONKED) && (_enemystate[? curent].boss || _enemystate[? curent].hp > 1)){
									var offshp = -320;
									draw_sprite_ext(spr_whack_enmhp, 0, drawspot[0]+entoffset[0], drawspot[1]+entoffset[1]+offshp, 1, 1, 0, c_black, 1);
									draw_sprite_part_ext(spr_whack_enmhp, 0, 0, 0, sprite_get_width(spr_whack_enmhp)*(_enemystate[? curent].hp/_enemystate[? curent].maxhp), sprite_get_height(spr_whack_enmhp), drawspot[0]+entoffset[0]-sprite_get_xoffset(spr_whack_enmhp), drawspot[1]+entoffset[1]+offshp-sprite_get_yoffset(spr_whack_enmhp), 1, 1, _enemystate[? curent].hpcol, 1);
								}
							}
						}
					
						//draw fg
						gpu_set_texfilter(false);
						draw_sprite_ext(spr_whack_spotfg, curframe, drawspot[0], drawspot[1], _spots_scale[yy][xx][0]*scale[yy], _spots_scale[yy][xx][1]*scale[yy], 0, c_white, 1);	
						gpu_set_texfilter(global._texfilter);
					
						//show particle
						if(_spots_particle[yy][xx] == 1){
							sfx_play(snd_whack_spot);
							var p = instance_create_depth(drawspot[0],drawspot[1],-32, obj_particle);
							p._type = "whack_spot";
							_spots_particle[yy][xx] = 2;
						}	
					}
				}
				draw[0] += (spotsize[0]+spacing[0])*scale[yy];
			}
					
			draw[1] += spotsize[1]+spacing[1];
		}
		
		if(_flames_rows[1][2] != -1){
			_flames_init = true;
		}
		
		//hurt effect
		if(_hurt_alp > 0){
			draw_set_alpha(_hurt_alp);
			draw_sprite(spr_whack_hurt, 0,0,0);
			draw_set_alpha(1);
		}
		
		//draw ui
		
		draw_sprite_ext(spr_whack_ui_bar2, 0, 12+_hp_ui_offs[0], 640+_hp_ui_offs[1], 1,1, 0, #271d36, 1);
		draw_sprite_part_ext(spr_whack_ui_bar2, 0, 0, 0, sprite_get_width(spr_whack_ui_bar2)*(_hp_display/_hp_max), sprite_get_height(spr_whack_ui_bar2), 12+_hp_ui_offs[0], 640+_hp_ui_offs[1], 1, 1, #f5112c, 1);
		
		var hpcol = c_white;
		if(_bonus_damageless > 0){
			hpcol = _bonuscol;
			draw_sprite_part_ext(spr_whack_ui_bar2, 0, 0, 0, sprite_get_width(spr_whack_ui_bar2), sprite_get_height(spr_whack_ui_bar2)*(_bonus_damageless/1), 12+_hp_ui_offs[0], 640+_hp_ui_offs[1]+(sprite_get_height(spr_whack_ui_bar2)*(1-(_bonus_damageless/1))), 1, 1, _bonuscol, 1);
		}
		
		draw_sprite_ext(spr_whack_ui_bar1, 0, 7+_hp_ui_offs[0], 637+_hp_ui_offs[1], 1,1, 0, c_white, 1);
		
		scr_textrender_switchfont("dh_font1");
		scr_textrender_type(12+_hp_ui_offs[0], 588+_hp_ui_offs[1], "HP: "+string(round(_hp_display))+"/"+string(_hp_max), true, hpcol, 1, 1.3, 1.3);
		
		if(!_tnt_active){
			if(_juice >= _juice_atk){
				var iconpos = [700+_juice_ui_offs[0], 657+_juice_ui_offs[1]];
				if(_inptype == WHACK_INPUT_MOUSE){
					draw_sprite(spr_whack_ui_mouse, 1, iconpos[0], iconpos[1]);
				} else if(_inptype == WHACK_INPUT_KEY){
					scr_textrender_halign("center");
					scr_textrender_valign("middle");
					scr_textrender_type(iconpos[0], iconpos[1], "keycode@TNTkeycode");
					scr_textrender_halign("left");
					scr_textrender_valign("top");
				}
			}
			if(_juice >= _juice_max){
				draw_sprite_ext(spr_whack_hold, floor(_holdc), 700+_juice_ui_offs[0], 700+_juice_ui_offs[1], 1, 1, 0, c_white, 1);
				if(_holdc <= 0){
					scr_textrender_halign("center");
					scr_textrender_type(700+_juice_ui_offs[0], 690+_juice_ui_offs[1], "HOLD", false, c_white, 1, 0.55,0.55);
					scr_textrender_halign("left");
				}
			}
		}
		
		var juiceval = _juice_display;
		if(_tnt_active){
			juiceval = _tnt_active_juice;
		}
		draw_sprite_ext(spr_whack_ui_bar2, 0, 751+_juice_ui_offs[0], 640+_juice_ui_offs[1], 1,1, 0, #271d36, 1);
		draw_sprite_part_ext(spr_whack_ui_bar2, 0, 0, 0, sprite_get_width(spr_whack_ui_bar2)*(juiceval/_juice_max), sprite_get_height(spr_whack_ui_bar2), 751+_juice_ui_offs[0], 640+_juice_ui_offs[1], 1, 1, #ffb81f, 1);
		draw_sprite_ext(spr_whack_ui_bar1, 0, 745+_juice_ui_offs[0], 637+_juice_ui_offs[1], 1,1, 0, c_white, 1);
		
		scr_textrender_halign("right");
		var col = c_white;
		if(_juice >= _juice_max){
			if(!global._pause && !global._gameover_stopall){
				scr_textrender_shake(3,3);
			}
			col = c_orange;
		}
		scr_textrender_type(1272+_juice_ui_offs[0], 588+_juice_ui_offs[1], string(round(juiceval))+"/"+string(_juice_max)+" :TNT JUICE", true, col, 1, 1.3, 1.3);
		scr_textrender_halign("left");
		scr_textrender_switchfont(global._defaultFont);
		
		scr_textrender_shake(0,0);
		
		minigame_lose_draw(WIDTH,HEIGHT,spr_whack_loser,_monyx,2);
	}
	
	//how to whack
	
	//9301000006000000000000000000000000000040020000000B00000001000000140000007370725F776861636B5F686F77746F5F68616E64000000000000000000000000000000000000000000588F4000000000000000000090754000000000000000000000F03F0100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000000840020000000B00000001000000140000007370725F776861636B5F686F77746F5F68616E6400000000000000000000000000000000000000000000704000000000000000000090754000000000000000000000F03F0100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F7000000000000000000000F03F020000000B00000001000000130000007370725F776861636B5F686F77746F5F626732000000000000000000000000000000000000000000388440000000000000000000005B400000000000000000000000400100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000001440020000000B00000001000000140000007370725F776861636B5F686F77746F5F68656C70000000000000000000000000000000000000000000788340000000000000000000B075400000000000000000000000000100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000001040020000000B00000001000000150000007370725F776861636B5F686F77746F5F636C6F7365000000000000000000000000000000000000000000006F40000000000000000000405F4000000000000000000000F03F0100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70000000000000000000000000020000000B00000001000000130000007370725F776861636B5F686F77746F5F6267310000000000000000000000000000000000000000000084400000000000000000008076400000000000000000000008400100000000000000010000000000000000000000000000000000F03F00000000000000000000F03F01000000040000006C6566740100000003000000746F70
	if(_howto){
		if(surface_exists(_howto_surface)){
			surface_set_target(_howto_surface);
			
			draw_clear_alpha(c_black, 0);
			
			var mainpos = [floor(WIDTH/2),floor(HEIGHT/2)];
			
			draw_sprite(spr_whack_howto_bg1, 0, mainpos[0], mainpos[1]);
			draw_sprite(spr_whack_howto_bg2, 0, mainpos[0]+7, mainpos[1]-252);
			
			var handrightframe = 0;
			var handleftframe = 0;
			
			var handrightpos = [mainpos[0]+363, mainpos[1]-15];
			var handleftpos = [mainpos[0]-363, mainpos[1]-15];
			
			var handrightoffset = 76;
			var handleftoffset = -76;
			
			var hsize = [220, 140];
			
			var closeframe = 0;
			
			var closepos = [mainpos[0]-392, mainpos[1]-235];
			var csize = [124, 124];
			
			//mouse hover
			if(!global._pause && _howto_intro && !_howto_out && _inptype == WHACK_INPUT_MOUSE){
				if(scr_mousehover(
					(handrightpos[0]+handrightoffset)-(hsize[0]*0.5),
					handrightpos[1]-(hsize[1]*0.5),
					(handrightpos[0]+handrightoffset)+(hsize[0]*0.5),
					handrightpos[1]+(hsize[1]*0.5)
				)){
					if(_howto_showright){
						handrightframe = 1;
						_handright_on = 2;
					}
				} else if(scr_mousehover(
					(handleftpos[0]+handleftoffset)-(hsize[0]*0.5),
					handleftpos[1]-(hsize[1]*0.5),
					(handleftpos[0]+handleftoffset)+(hsize[0]*0.5),
					handleftpos[1]+(hsize[1]*0.5)
				)){
					if(_howto_showleft){
						handleftframe = 1;
						_handleft_on = 2;
					}
				} else if(scr_mousehover(
					closepos[0]-(csize[0]*0.5),
					closepos[1]-(csize[1]*0.5),
					closepos[0]+(csize[0]*0.5),
					closepos[1]+(csize[1]*0.5)
				)){
					if(_howto_showclose){
						closeframe = 1;
						_closebtn_on = 2;
					}
				}
			}
			scr_textrender_valign("middle");
			
			if(_inptype == WHACK_INPUT_MOUSE){
				if(_howto_showright){
					draw_sprite_ext(spr_whack_howto_hand, handrightframe, handrightpos[0], handrightpos[1], 1, 1, 0, c_white, 1);
				}
				if(_howto_showleft){
					draw_sprite_ext(spr_whack_howto_hand, handleftframe, handleftpos[0], handleftpos[1], -1, 1, 0, c_white, 1);
				}
			} else if(_inptype == WHACK_INPUT_KEY){
				var scale = 1.32;
				if(_howto_showright){
					scr_textrender_halign("center");
					scr_textrender_type(handrightpos[0], handrightpos[1], "keycode@RIGHTkeycode", true, c_white, 1, scale, scale);
				}
				if(_howto_showleft){
					scr_textrender_halign("right");
					scr_textrender_type(handleftpos[0], handleftpos[1], "keycode@LEFTkeycode", true, c_white, 1, scale, scale);
				}
			}

			if(_howto_showclose){
				if(_inptype == WHACK_INPUT_MOUSE){
					draw_sprite(spr_whack_howto_close, closeframe, closepos[0], closepos[1]);
				} else if(_inptype == WHACK_INPUT_KEY){
					var scale = 1.24;
					scr_textrender_halign("center");
					scr_textrender_type(closepos[0], closepos[1], "keycode@CONFIRMkeycode", true, c_white, 1, scale, scale);
					scr_textrender_type(closepos[0], closepos[1]+48, "CLOSE", true, c_white, 1, 0.65, 0.65);
				}
			}
			
			draw_sprite(spr_whack_howto_help, _howto_page, mainpos[0]-17, mainpos[1]-13);
			
			scr_textrender_halign("center");
			
			//text
			if(_howto_page == 0){
				var uipos = [mainpos[0]+300, mainpos[1]+170];
				if(_inptype == WHACK_INPUT_MOUSE){
					scr_textrender_halign("right");
					scr_textrender_type(uipos[0]-64, uipos[1], "Whack:", true, c_white, 1, 1.28, 1.28);
					scr_textrender_halign("center");
					draw_sprite(spr_whack_ui_mouse, 0, uipos[0], uipos[1]);
				} else if(_inptype == WHACK_INPUT_KEY){
					scr_textrender_halign("right");
					scr_textrender_type(uipos[0], uipos[1], "Whack: keycode@PUNCHkeycode", true, c_white, 1, 1.28, 1.28);
					scr_textrender_halign("center");
				}
			}
			if(_howto_page <= array_length(_howto_text)-1){
				if(array_length(_howto_text[_howto_page]) > 0){
					for(var t = 0; t < array_length(_howto_text[_howto_page]); t++){
						var curt = _howto_text[_howto_page][t];
						scr_textrender_type(mainpos[0]+curt[1][0], mainpos[1]+curt[1][1], curt[0], true, c_white, 1, curt[2], curt[2]);
					}
				}
			}
			
			scr_textrender_halign("left");
			scr_textrender_valign("top");
			
			surface_reset_target();
			
			draw_set_alpha(_howto_alpha);
			draw_set_color(c_black);
			draw_rectangle(0, 0, WIDTH, HEIGHT, false);
			draw_set_color(c_white);
			draw_set_alpha(1);
			
			if(_howto_timer >= _howto_startval){
				draw_surface_ext(_howto_surface, (WIDTH*0.5)*(1-_howto_scale), ((HEIGHT*0.5)*(1-_howto_scale))+_howto_offs, _howto_scale, _howto_scale, 0, c_white, 1);
			}
		} else {
			_howto_surface = surface_create(WIDTH, HEIGHT);
		}
	}
	
	if(!global._pause){
		if(_inptype == WHACK_INPUT_MOUSE){
			draw_sprite(spr_whack_cursor, ceil(_cursorframe), mouse_x, mouse_y);
		}
	}
}