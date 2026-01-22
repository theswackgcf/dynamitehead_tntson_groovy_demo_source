function scr_draw_gui(){
	if(global._state == "game"){
		if(global._flashbang > 0){
			if(!global._pause){
				if(global._flashbang <= 30){
					_flashalp -= 0.08;
				}
				global._flashbang --;
			}
			draw_set_alpha(_flashalp);
			draw_rectangle(-global._screenSideOffset, -global._screenSideOffset, WIDTH+global._screenSideOffset, HEIGHT+global._screenSideOffset, false);
			draw_set_alpha(1);
		}
		
		if(!global._winscreen && global._vsscreen == 0){
			//fading ui
			if(!global._pause){
				for(var i = 0; i < array_length(global._ui_stuff_alpha); i++){
					global._ui_stuff_alpha[i] = lerp(global._ui_stuff_alpha[i], global._ui_stuff_alphaTo[i], 0.15);
					global._ui_stuff_alphaMult[i] = lerp(global._ui_stuff_alphaMult[i], global._ui_stuff_alphaMultTo[i], 0.15);
					if(instance_exists(obj_dh_mask)){
						if(obj_dh_mask._idleguitimer < obj_dh_mask._idleguithreshold){
							global._fadeOutTimer[i] ++;
							if(global._fadeOutTimer[i] >= 180){
								global._ui_stuff_alphaTo[i] = 0;
								global._fadeOutTimer[i] = 180;
							}
						}
					}
				}
				global._ui_shieldMult = lerp(global._ui_shieldMult, global._ui_shieldMultTo, 0.24);
			
				var dh = instance_find(obj_dh_mask,0);
				if(dh != noone && instance_exists(dh)){
					if(dh._begin){
						if( check_keypress(global._input[global._inptype][? "confirm"], global._inptype )){
							ui_all_fade(1);
						}
					}
				}
			}
			
			if(global._tutorial){
				ui_all_fade(1);
			}
			
			//dh colliding with gui elements
			with(obj_dh_mask){
				if(scr_colliderect(0, (HEIGHT-220)-_height, 480, (HEIGHT)-_height, true)){
					global._ui_stuff_alphaMultTo[0] = 0.3;
				} else {
					global._ui_stuff_alphaMultTo[0] = 1;
				}
				
				if(scr_colliderect(WIDTH-520, (HEIGHT-170)-_height, WIDTH, (HEIGHT)-_height, true)){
					global._ui_stuff_alphaMultTo[1] = 0.3;
				} else {
					global._ui_stuff_alphaMultTo[1] = 1;
				}
				
				if(scr_colliderect(0, _height, 410, 320+_height, true)){
					global._ui_stuff_alphaMultTo[2] = 0.3;
				} else {
					global._ui_stuff_alphaMultTo[2] = 1;
				}
				
				if(scr_colliderect(0, _height, WIDTH, 320+_height, true)){
					global._ui_stuff_alphaMultTo[3] = 0.3;
				} else {
					global._ui_stuff_alphaMultTo[3] = 1;
				}
					
				//prompt
				if(scr_colliderect(0, _height, WIDTH, 340+_height, true)){
					global._prompt_desc_multTo = 0.3;
				} else {
					global._prompt_desc_multTo = 1;
				}
			}
			
			_hue = 5;
		
			if(!global._stageentrance){
				//dynamitehead hp bar
				_dh = instance_find(obj_dh_mask, 0);
				if(instance_exists(_dh)){
					var hpoff = [100,46];
					var alp = global._ui_stuff_alpha[0] * global._ui_stuff_alphaMult[0];
					draw_set_alpha(alp);
					draw_sprite(spr_gui_dhfire, 0, _hpoffset[0]+9, _hpoffset[1]-45);
					draw_sprite(spr_gui_dhborder, 1, _hpoffset[0], _hpoffset[1]);
					draw_sprite_part_ext(spr_gui_dhhp, 0, 0, 0, (_dh._displayhp/_dh._maxhp)*sprite_get_width(spr_gui_dhhp), sprite_get_height(spr_gui_dhhp), _hpoffset[0]+hpoff[0], _hpoffset[1]+hpoff[1], 1, 1, #E11A1A, alp);
					draw_sprite(spr_gui_dhborder, 0, _hpoffset[0], _hpoffset[1]);
					var lowhp = 0;
					if(_dh._hp <= 10){
						lowhp = 1;
					}
					draw_sprite(spr_gui_dhportrait, lowhp, _hpoffset[0]-17, _hpoffset[1]-63);
					scr_textrender_switchfont("dh_font2");
					scr_textrender_type(_hpoffset[0]+114, _hpoffset[1]+8, "DYNAMITEHEAD", true, #FFFFFF, alp);
					scr_textrender_switchfont("dh_font3");
					scr_textrender_type(_hpoffset[0]+381, _hpoffset[1]+46, "HP\n"+string(clamp(ceil(_dh._displayhp), 0, _dh._maxhp))+"/"+string(ceil(_dh._maxhp)), true, #FFFFFF, alp);
					scr_textrender_switchfont(global._defaultFont);
					var alp2 = global._ui_stuff_alpha[0] * global._ui_stuff_alphaMult[0] * global._ui_shieldMult;
					//shield bar
					draw_set_alpha(alp2);
					var shieldpos = [102, 573];
					var shieldbaroffs = [4, 5];
					draw_sprite_ext(spr_gui_shieldbar, 0, shieldpos[0]+shieldbaroffs[0], shieldpos[1]+shieldbaroffs[1], 1, 1, 0, c_black, alp2);
					draw_sprite_part_ext(spr_gui_shieldbar, 0, 0, 0, (_dh._shieldpower/1)*sprite_get_width(spr_gui_shieldbar), sprite_get_height(spr_gui_shieldbar), shieldpos[0]+shieldbaroffs[0], shieldpos[1]+shieldbaroffs[1], 1, 1, #FFFFFF, alp2);
					draw_sprite(spr_gui_shield, 0, shieldpos[0], shieldpos[1]);
					draw_set_alpha(1);
				}
			}
			
			function drawEnemyHp(xpos,ypos,xsize,ysize,pos){
				var guioff = [xpos,ypos];
				var hpoff = [88,2];
				var alp = global._ui_stuff_alpha[2] * global._ui_stuff_alphaMult[2];
				
				var curEnm = global._curenemy[pos];
				var enmtype = curEnm._enmtype+1;
				
				draw_sprite_ext(spr_gui_enemyborder, 1, guioff[0], guioff[1], xsize, ysize, 0, #FFFFFF, alp);
				draw_sprite_part_ext(spr_gui_enemyhp, 0, 0, 0, (global._curenemy[pos]._displayhp/global._curenemy[pos]._maxhp)*(sprite_get_width(spr_gui_enemyhp)), sprite_get_height(spr_gui_enemyhp), guioff[0]+(hpoff[0]*xsize), guioff[1]+(hpoff[1]*ysize), xsize, ysize, global._curenemy[pos]._hpcolor[enmtype], alp);
				draw_sprite_ext(spr_gui_enemyborder, 0, guioff[0], guioff[1], xsize, ysize, 0, #FFFFFF, alp);
				
				function drawPortrait(guioff, pos, xsize, ysize, alp) {
					var sp = spr_gui_enemyportraits;
					var curEnm = global._curenemy[pos];
					if(curEnm._hp <= 5){
						sp = spr_gui_enemyportraits_lowhp;
					}
					draw_sprite_ext(sp, global._portraits[? global._curenemy[pos]._codename], (guioff[0]-(42*xsize))+(116*xsize), (guioff[1]-(42*ysize))+(126*ysize), xsize, ysize, 0, #FFFFFF, alp);
					if(curEnm._pissedoff > 0){
						var spd = 0;
						switch(curEnm._pissedoff_int){
							case 0:
								spd = 0.2;
							break;
							case 1:
								spd = 0.35;
							break;
							case 2:
								spd = 0.5;
							break;
						}
						shader_reset();
						draw_sprite_ext(spr_p_angryicon, (curEnm._pissedoff_icontimer*spd)%6, (guioff[0]-(42*xsize))+(135*xsize), (guioff[1]-(42*ysize))+(32*ysize), xsize*0.35, ysize*0.35, 0, #FFFFFF, alp);
					}
				}
				
				if(curEnm._colorsinit){
					if(curEnm._difftype){
						//draw recolored version
						var _shdr = asset_get_index("shd_replace_col");
						if(global._buildver == HTML){
							_shdr = asset_get_index("shd_replace_col"+string(curEnm._maxcolors));
						}
							
						shader_set(_shdr);
				
						shader_set_uniform_i(shader_get_uniform(_shdr, "maxcolors"), curEnm._maxcolors);
						shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorIn"), curEnm._mult_colorinArray);
						shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorOut"), curEnm._mult_coloroutArray);
						shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorTolerance"), curEnm._mult_tolrArray);
						shader_set_uniform_f_array(shader_get_uniform(_shdr, "blend"), curEnm._mult_blendArray);
				
						drawPortrait(guioff, pos, xsize, ysize, alp);
			
						shader_reset();
					} else {
						//draw default version
						drawPortrait(guioff, pos, xsize, ysize, alp);
					}
				}
				
				scr_textrender_switchfont("dh_font2");
				var addsize = (1 - xsize)/3;
				var enmnamestr = global._curenemy[pos]._name;
				if(global._curenemy[pos]._nameoverwrite != ""){
					enmnamestr = global._curenemy[pos]._nameoverwrite;
				}
				scr_textrender_type(guioff[0]+(82*xsize), guioff[1]+(57*ysize), string_upper(enmnamestr), true, #FFFFFF, alp, xsize+addsize, ysize+addsize);
				if(xsize >= 0.5 && ysize >= 0.5){
					scr_textrender_switchfont("dh_font3");
					scr_textrender_type(guioff[0]+(289*xsize), guioff[1]+(1*ysize), "HP\n"+string(clamp(floor(global._curenemy[pos]._displayhp), 0, global._curenemy[pos]._maxhp))+"/"+string(floor(global._curenemy[pos]._maxhp)), true, #FFFFFF, alp, xsize, ysize);
				}
				scr_textrender_switchfont(global._defaultFont);
			}
		
			var hpoff_array = [
				[[39,42]], //top
				[[39,42],[135, 140]], //top bottom
				[[39,42],[30, 140],[215, 140]], //top bottom-left bottom-right
			];
				
			var bossreal = false;
			if(global._curboss != noone && instance_exists(global._curboss) && global._curboss._boss_active){
				bossreal = true;
			}
				
			if(bossreal){
				hpoff_array = [
					[[30,42]], //one
					[[30,42],[215, 42]], //two
					[[30,42],[215, 42],[400, 42]], //three
				];
			}
		
			var miniscale = 0.45;
			var hpbossoffs = 102;
		
			if(!global._tutorial){
				//enemy hp bar
				if(array_length(global._curenemy) == 1){
					//one enemy
					var hpscale = 1;
					var addoffs = 0;
					if(bossreal){
						hpscale = miniscale;
						addoffs = hpbossoffs;
					}
					if(instance_exists(global._curenemy[0])){
						drawEnemyHp(hpoff_array[0][0][0],hpoff_array[0][0][1]+addoffs,hpscale,hpscale,0);
						if(global._curenemy[0]._inactive){
							global._curenemy = [];
						}
					} else {
						global._curenemy = [];
					}
				} else if(array_length(global._curenemy) > 1){
					//two or three enemies
					var curind = array_length(global._curenemy)-1;
					for(var i = array_length(global._curenemy)-1; i >= 0; i--){
						var hpscale = 1;
						var addoffs = 0;
						if(i > 0){
							hpscale = miniscale;
						}
						if(bossreal){
							hpscale = miniscale;
							addoffs = hpbossoffs;
						}
						if(instance_exists(global._curenemy[i])){
							drawEnemyHp(hpoff_array[curind][i][0],hpoff_array[curind][i][1]+addoffs,hpscale,hpscale,i);
							if(global._curenemy[i]._inactive){
								array_delete(global._curenemy, i, 1);
							}
						} else {
							array_delete(global._curenemy, i, 1);
						}
					}
				}
			}
	
			//boss hp bar
			if(!global._pause){
				if(global._curboss != noone && instance_exists(global._curboss) && global._curboss._boss_active){
					_bossoffsetlerp = 16;
				} else {
					_bossoffsetlerp = -320;
				}
				_bossoffset[1] = lerp(_bossoffset[1], _bossoffsetlerp, 0.12);
			}
				
			if(global._curboss != noone && instance_exists(global._curboss)){
				var alp = global._ui_stuff_alpha[3] * global._ui_stuff_alphaMult[3];
				var scale_y = 0.85;
				draw_sprite_ext(spr_gui_bosshp1, 0, _bossoffset[0], _bossoffset[1], 1, scale_y, 0, c_white, alp);
				draw_sprite_part_ext(spr_gui_bosshp2, 0, 0, 0, (global._curboss._displayhp/global._curboss._maxhp)*sprite_get_width(spr_gui_bosshp2), sprite_get_height(spr_gui_bosshp2), _bossoffset[0], _bossoffset[1]+4, 1, scale_y, global._curboss._hpcolor[0], alp);
				draw_sprite_ext(spr_gui_bossbar, 0, _bossoffset[0]-5, _bossoffset[1]-5, 1, scale_y, 0, c_white, alp);
				draw_sprite_ext(global._bossinfo[? global._curboss._codename], global._curboss._phase, _bossoffset[0]+1228, _bossoffset[1]+(123*scale_y), 1, 1, 0, #FFFFFF, alp);
					
				var curBoss = global._curboss;
				if(curBoss._pissedoff > 0){
					var spd = 0;
					switch(curBoss._pissedoff_int){
						case 0:
							spd = 0.2;
						break;
						case 1:
							spd = 0.35;
						break;
						case 2:
							spd = 0.5;
						break;
					}
					draw_sprite_ext(spr_p_angryicon, (curBoss._pissedoff_icontimer*spd)%6, WIDTH-48, _bossoffset[1]+16, 0.35, 0.35, 0, #FFFFFF, alp);
				}
						
				scr_textrender_switchfont("dh_font2");
				scr_textrender_type(_bossoffset[0], _bossoffset[1]+(96*scale_y), string_upper(global._curboss._name), true, #FFFFFF, alp);
				scr_textrender_switchfont("dh_font3");
				scr_textrender_type(_bossoffset[0], _bossoffset[1]-10, "HP "+string(clamp(floor(global._curboss._displayhp), 0, global._curboss._maxhp))+"/"+string(floor(global._curboss._maxhp)), true, #FFFFFF, alp);
				scr_textrender_switchfont(global._defaultFont);
			}
	
			if(!global._stageentrance){
				//tnt juice
				global._displayjuice = global._displayjuice + (global._tntjuice-global._displayjuice)*0.12;
	
				var hpoff = [-6,-26];
				var offset = cos(random(480))*_tntamp;
				if(global._pause){
					offset = 0;
				}
			
				var alp = global._ui_stuff_alpha[1] * global._ui_stuff_alphaMult[1];
				draw_set_alpha(alp);
				draw_sprite(spr_gui_tntborder, 0, _tntoffset[0], _tntoffset[1]+offset);
			
				if(!global._pause){
					_firetimer ++;
					if(_firetimer % 8 == 0){
						_fireframe ++;
						if(_fireframe >= 3){
							_fireframe = 0;
						}
					}
				}
			
				if(global._tntjuice >= 5 || global._dhmashing){
					draw_sprite_part_ext(spr_gui_tntfire, _fireframe, 0, 0, ((global._displayjuice-5)/100)*sprite_get_width(spr_gui_tntfire), sprite_get_height(spr_gui_tntfire), _tntoffset[0]+hpoff[0], _tntoffset[1]+hpoff[1]+offset, 1, 1, #FFFFFF, alp);
					draw_sprite_ext(spr_gui_tntfire_end, _fireframe, _tntoffset[0]+hpoff[0]+(((global._displayjuice-5)/100)*sprite_get_width(spr_gui_tntfire))-32, _tntoffset[1]+hpoff[1]+offset+12, 1, 1, 0, #FFFFFF, alp);
				}
				var active = 0;
				var tntframe = 0;
				var hold = false;
				if(global._tntjuice >= global._tntjuice_mash){
					active = 1;
				}
				if(global._tntjuice >= global._tntjuice_max){
					hold = true;
					tntframe = 1;
					ui_fade("tnt", 1);
				}
				draw_sprite(spr_gui_tntjuice, tntframe, _tntoffset[0]+245, (_tntoffset[1]-111)+offset);
			
				if(active == 1){
					var sinval_ = random(320);
					if(global._pause){
						sinval_ = 0;
					}
					scr_textrender_type(_tntoffset[0]-68, ((_tntoffset[1]-8)+(sin(sinval_)*(_holdc*1.5)))+offset, "keycode@TNTkeycode", true, #FFFFFF, alp);
					if(hold){
						draw_sprite_ext(spr_gui_hold, floor(_holdc), _tntoffset[0]-39, _tntoffset[1]+43+offset, 1, 1, 0, #FFFFFF, alp);
						if(_holdc <= 0){
							scr_textrender_halign("center");
							scr_textrender_type(_tntoffset[0]-39, _tntoffset[1]+35+offset, "HOLD", false, c_white, alp, 0.55,0.55);
							scr_textrender_halign("left");
						}
					}
				}
			
				scr_textrender_halign("right");
				scr_textrender_switchfont("dh_font2");
				var tntname = "TNT JUICE";
				var shakecof = 0;
				if(global._tntjuice >= global._tntjuice_max){
					tntname = "TNT-QUAKE";
					shakecof = 5;
				}
				if(global._pause){
					shakecof = 0;
				}
				scr_textrender_shake(shakecof);
				scr_textrender_type(_tntoffset[0]+110+scr_textrender_width("TNT JUICE"), (_tntoffset[1]-34)+offset, tntname, true, #FFFFFF, alp);
				scr_textrender_shake(0);
				scr_textrender_switchfont("dh_font3");
				scr_textrender_type((_tntoffset[0]-28)+scr_textrender_width("100/100"), (_tntoffset[1]-26)+offset, string(clamp(round(global._displayjuice), 0, 100))+"/100", true, #FFFFFF, alp);
				scr_textrender_switchfont(global._defaultFont);
				scr_textrender_halign("left");
				draw_set_alpha(1);
			}
			
			_hue = 0;
	
			//hits
			var maxhitval = 999;
			if(global._hits > maxhitval){
				global._hits = maxhitval;
			}
			if(array_length(global._hitsarray) > maxhitval){
				array_shift(global._hitsarray);
			}
			if(global._hitscd > 0){
				global._hitscd --;
			}
			if(global._hits > 0){
				var strhits = string(floor(global._hits));
				for(var i = 0; i < string_length(strhits); i++){
					draw_sprite_ext(spr_gui_nums, real(string_char_at(strhits, i+1)), _hitoffset[0]+(i*42)+_hitnumoffset[0], _hitoffset[1]+_height+_hitnumoffset[1], 1, 1, 0, global._guiNumColors[? "hit"], 1);
				}
				var pos = 0;
				var frame = 0;
				if(global._hits < 2){
					frame = 0;
				} else {
					frame = 1;
				}
				pos = string_length(strhits)-1;
				draw_sprite(spr_gui_hits, frame, _hitoffset[0]+50+(pos*50), _hitoffset[1]+32);
				var hpoff = [10,76];
				draw_sprite_part_ext(spr_gui_hitmeter, 0, 0, 0, sprite_get_width(spr_gui_hitmeter), sprite_get_height(spr_gui_hitmeter), (_hitoffset[0]+hpoff[0])-7, _hitoffset[1]+hpoff[1], 1, 1, #000000, 1);
				draw_sprite_part_ext(spr_gui_hitmeter, 0, 0, 0, (global._hitmeter/50)*sprite_get_width(spr_gui_hitmeter), sprite_get_height(spr_gui_hitmeter), (_hitoffset[0]+hpoff[0])-7, _hitoffset[1]+hpoff[1], 1, 1, #FFFFFF, 1);
				draw_sprite(spr_gui_hitborder, 0, _hitoffset[0]+hpoff[0]-10, _hitoffset[1]+hpoff[1]-3);
				if(array_length(global._hitsarray) > 0){
					var lastval = global._hitsarray[array_length(global._hitsarray)-1];
					if(lastval > 1){
						scr_textrender_halign("right");
						scr_textrender_switchfont("dh_font1");
						scr_textrender_type((_hitoffset[0]+hpoff[0]-10)+138, (_hitoffset[1]+hpoff[1]-3)+20, "x"+string(lastval), true, #FF9900, 1, 0.9,0.9);
						scr_textrender_switchfont(global._defaultFont);
						scr_textrender_halign("left");
					}
				}
				if(!global._pause){
					if(_jump){
						_vspd += 0.6;
						_height += _vspd;
						if(_height > 0){
							_height = 0;
							_vspd = 0;
							_jump = false;
						}
					}
					global._hitmeter -= 0.4;
					if(global._hitmeter <= 0){
						ui_fade("tnt", 1);
						_flyaway = true;
						_flypos = [_hitoffset[0]+_hitnumoffset[0], _hitoffset[1]+_hitnumoffset[1]];
						_flyto = [_tntoffset[0]+120, _tntoffset[1]-10];
						_hitstemp = floor(global._hits);
						_hitsarraytemp = global._hitsarray;
						global._hitmeter = 0;
						global._hits = 0;
						global._hitsarray = [];
					}
				}
			}
			
			if(global._tutorial){
				_hitstemp = 0;
				_hitsarraytemp = [];
			}
			
			if(_flyaway){
				var strhits = string(floor(_hitstemp));
				for(var i = 0; i < string_length(strhits); i++){
					draw_sprite_ext(spr_gui_nums, real(string_char_at(strhits, i+1)), _flypos[0]+(i*42), _flypos[1]+_height, 1, 1, 0, global._guiNumColors[? "hit"], 1);
				}
				var pos = 0;
				var frame = 0;
				if(_hitstemp < 2){
					frame = 0;
				} else {
					frame = 1;
				}
				pos = string_length(strhits)-1;
				draw_sprite(spr_gui_hits, frame, _flypos[0]+22+(pos*50), _flypos[1]);
				if(!global._pause){
					_flypos[0] = _flypos[0] + (_flyto[0] - _flypos[0]) * 0.14;
					_flypos[1] = _flypos[1] + (_flyto[1] - _flypos[1]) * 0.14;
					if(diff(_flypos[0],_flyto[0]) < 8){
						for(var h = 0; h < array_length(_hitsarraytemp); h++){
							global._tntjuice += _hitsarraytemp[h]*1.65;
						}
						_hitsarraytemp = [];
						if(global._tntjuice > global._tntjuice_max){
							global._tntjuice = global._tntjuice_max;
						}
						_tntamp = 8;
						_flyaway = false;
					}
				}
			}
			if(!global._pause){
				if(_tntamp > 0){
					_tntamp --;
				} else if(_tntamp < 0){
					_tntamp = 0;
				}
			}
				
			//dial-m tutorial popup
			if(_dialm_active){
				if(!global._pause){
					_dialm_timer ++;
					switch(_dialm_act){
						case 0:
							if(_dialm_pos > 0){
								_dialm_pos -= 66;
							} else {
								sfx_play(snd_perfect, 0.68);
								sfx_pitch(snd_perfect,1.35);
								_dialm_pos = 0;
								_dialm_timer = 0;
								_dialm_act = 1;
							}
						break;
						case 1:
							if(_dialm_timer >= 48){
								_dialm_timer = 0;
								_dialm_act = 2;
							}
						break;
						case 2:
							if(_dialm_pos < WIDTH){
								_dialm_pos += 80;
							} else {
								if(surface_exists(_dialm_surf)){
									surface_free(_dialm_surf);
								}
									
								_dialm_quote = -1;
								_dialm_active = false;
							}
						break;
					}
				}
					
				draw_sprite_ext(spr_gui_dialm,0,_dialm_pos, 0, 1, 1, 0, c_white, 1);
				if(surface_exists(_dialm_surf)){
					if(_dialm_quote != -1){
						surface_set_target(_dialm_surf);
						
						draw_clear_alpha(c_black, 0);
						
						scr_textrender_switchfont("dh_font1");
						scr_textrender_halign("center");
						scr_textrender_valign("middle");
						scr_textrender_type(_dialm_surfsize[0]/2,_dialm_surfsize[1]/2,_dialm_quotes[_dialm_quote], true, c_white, 1, 1.4, 1.4);
						scr_textrender_halign("left");
						scr_textrender_valign("top");
						scr_textrender_switchfont(global._defaultFont);
						
						surface_reset_target();
							
						draw_surface_ext(_dialm_surf,WIDTH-_dialm_surfsize[0]+_dialm_pos,HEIGHT-_dialm_surfsize[1], 1, 1, 10, c_white, 1);
					}
				} else {
					_dialm_surf = surface_create(_dialm_surfsize[0],_dialm_surfsize[1]);
				}
			} else {
				if(_dialm_quote == -1){
					_dialm_quote = irandom_range(0,array_length(_dialm_quotes)-1);
				}
				_dialm_pos = WIDTH;
				_dialm_timer = 0;
				_dialm_act = 0;
			}
		}
			
		//prompt position
		if(global._prompt_desc_show > 0){
			_prompt_desc_posto = [0,0];
				
			if(diff_abs(_prompt_desc_pos[1],_prompt_desc_posto[1]) <= 12){
				_prompt_desc_ready = true;
			}
				
			global._prompt_desc_show --;
		} else {
			_prompt_desc_ready = false;
			_prompt_desc_posto = [_prompt_desc_offpos,_prompt_desc_offpos];
				
			if(diff_abs(_prompt_desc_pos[1],_prompt_desc_posto[1]) <= 12){
				_prompt_desc_text = "";
				_prompt_desc_text_prev = _prompt_desc_text;
			}
		}
			
		var prompt_scale = 0.8;
		var toffset = 32;
			
		//prompt text
		switch(global._prompt_desc_type){
			case "punch":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Hold keycode@PUNCHkeycode - Punch the gate";
				toffset = 48;
				prompt_scale = 1.1;
			break;
			case "slide":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Press keycode@SLIDEkeycode - Slide";
				toffset = 48;
				prompt_scale = 1.1;
			break;
			case "upper":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "keycode@UPkeycode + keycode@PUNCHkeycode - Uppercut";
				toffset = 48;
				prompt_scale = 1.1;
			break;
				
			case "grab":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "keycode@GRABkeycode - Throw enemy\nkeycode@PUNCHkeycode (Hold keycode@LEFTkeycode or keycode@RIGHTkeycode) - Slam";
			break;
			case "jumpback":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "keycode@JUMPkeycode - Jump";
				prompt_scale = 0.9;
				toffset = 48;
			break;
			case "roll":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "keycode@JUMPkeycode - Jump\nkeycode@PUNCHkeycode - Dive";
				prompt_scale = 0.9;
			break;
				
			//tutorial
			case "tutr_punch":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Hold keycode@PUNCHkeycode - Punch";
				prompt_scale = 1;
				toffset = 48;
			break;
			case "tutr_slide":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Press keycode@SLIDEkeycode - Slide";
				prompt_scale = 1;
				toffset = 48;
			break;
			case "tutr_crouch":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "keycode@CROUCHkeycode + Press keycode@PUNCHkeycode - Low kick";
				prompt_scale = 1;
				toffset = 48;
			break;
			case "tutr_upper":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "keycode@UPkeycode + Press keycode@PUNCHkeycode - Uppercut";
				prompt_scale = 0.9;
				toffset = 42;
			break;
			case "tutr_jump":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Hold keycode@JUMPkeycode & press keycode@PUNCHkeycode - Smackdown";
				prompt_scale = 0.9;
				toffset = 42;
			break;
			case "tutr_grab":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Press keycode@GRABkeycode - Grab\nPress keycode@GRABkeycode again - Throw";
				prompt_scale = 0.85;
				toffset = 36;
			break;
			case "tutr_shield":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Hold keycode@SHIELDkeycode - Flame shield";
				prompt_scale = 1;
				toffset = 48;
			break;
			case "tutr_mash":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Press keycode@TNTkeycode - TNT Pummel";
				prompt_scale = 1;
				toffset = 48;
			break;
			case "tutr_mash2":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Press keycode@PUNCHkeycode - PIERCE THROUGH!";
				prompt_scale = 1;
				toffset = 48;
			break;
			case "tutr_tnt":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Hold keycode@TNTkeycode - TNT Quake";
				prompt_scale = 1;
				toffset = 48;
			break;
				
			case "tutr_roll":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Double tap keycode@RIGHTkeycode - Run\nkeycode@PUNCHkeycode (while running) - Roll";
				prompt_scale = 0.85;
				toffset = 36;
			break;
			case "tutr_slam1":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Press keycode@GRABkeycode - Grab";
				prompt_scale = 1;
				toffset = 48;
			break;
			case "tutr_slam2":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Hold keycode@PUNCHkeycode (when grabbing)\n& hold keycode@LEFTkeycode or keycode@RIGHTkeycode - Start slamming";
				prompt_scale = 0.9;
				toffset = 36;
			break;
			case "tutr_parry":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Press keycode@SHIELDkeycode - Parry";
				prompt_scale = 1;
				toffset = 48;
			break;
			case "tutr_combo1":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Press keycode@SLIDEkeycode - Slide into fridge";
				prompt_scale = 0.95;
				toffset = 48;
			break;
			case "tutr_combo2":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Hold keycode@JUMPkeycode & press keycode@PUNCHkeycode - Smackdown";
				prompt_scale = 0.9;
				toffset = 42;
			break;
			case "tutr_combo3":
				_prompt_desc_text_prev = _prompt_desc_text;
				_prompt_desc_text = "Hold keycode@PUNCHkeycode - Send fridge offscreen";
				prompt_scale = 0.95;
				toffset = 48;
			break;
		}
			
		//set position when new text appears
		if(_prompt_desc_ready && _prompt_desc_text_prev <> _prompt_desc_text){
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_posto = [_prompt_desc_offpos/1.5,_prompt_desc_offpos/1.5];
		}
			
		var lerpval = [0.2,0.12];
			
		for(var d = 0; d < 2; d++){
			if(!global._pause){
				_prompt_desc_pos[d] = lerp(_prompt_desc_pos[d],_prompt_desc_posto[d],lerpval[d]);
			}
		}
		if(!global._pause){
			global._prompt_desc_mult = lerp(global._prompt_desc_mult, global._prompt_desc_multTo, 0.15);
		}
			
		if(global._showtips || global._tutorial){
			draw_sprite_ext(spr_gui_prompt, 0, 0, _prompt_desc_pos[0],1,1,0,c_white,global._prompt_desc_mult*0.45);
			scr_textrender_halign("center");
			scr_textrender_wave_y(2, 9, true);
			scr_textrender_type(floor(WIDTH/2),_prompt_desc_pos[1]+toffset,_prompt_desc_text, false, c_white, global._prompt_desc_mult, prompt_scale,prompt_scale);
			scr_textrender_wave_y(0, 0, true);
			scr_textrender_halign("left");
		}
		
		//spacing text
		if(_uitextshow){
			if(!global._pause){
				_uitexttime ++;
				switch(_uitextact){
					case 0:
						_uitextspacing = 500;
						_uitextact = 1;
					break;
					case 1:
						_uitextspacing -= 27;
						if(_uitextspacing <= 0){
							_uitextspacing  = 0;
						}
						if(_uitexttime >= 100){
							_uitexttime = 0;
							_uitextact = 2;
						}
					break;
					case 2:
						_uitextspacing += 36;
						if(_uitexttime >= 40){
							_uitextshow = false;
						}
					break;
				}
			}
			global._addSpacing = _uitextspacing;
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			scr_textrender_switchfont("dh_font4");
			
			if(!global._pause){
				scr_textrender_shake(5);
			}
			scr_textrender_type(floor(WIDTH/2), floor(HEIGHT/2)-32, _uitext, true);
			scr_textrender_shake(0);
			
			scr_textrender_halign("left");
			scr_textrender_valign("top");
			scr_textrender_switchfont("dh_font2");
			global._addSpacing = 0;
		} else {
			_uitextact = 0;
			_uitexttime = 0;
		}
		
		//vs screen
		if(global._vsscreen > 0){
			with(obj_dh_mask){
				_idletimer = 0;
				_idleanim = [false,false];
				_idles = 0;
				
				if(_jump){
					_anim = "jump_loop";
				} else {
					_anim = "idle";
				}
				_state = "nomove";
			}
			
			if(!global._pause){
				if(global._seenvs){
					//skip vs screen if shown a second time
					ui_fade("boss", 1);
					with(obj_boss1_mask){
						_begin = true;
					}
					with(obj_dh_mask){
						_state = "default";
					}
					global._vsscreen = 0;
				}
				
				_vstimer ++;
				_pos1[0] = lerp(_pos1[0], _pos1[1], 0.4);
				_pos2[0] = lerp(_pos2[0], _pos2[1], 0.4);
				_pos3[0] = lerp(_pos3[0], _pos3[1], 0.14);
				_pos4[0] = lerp(_pos4[0], _pos4[1], 0.14);
				
				switch(global._vsscreen){
					case 1:
						if(!_vs_snd){
							sfx_play(snd_vs);
							_vs_snd = true;
						}
						_textspd = [-9,9];
						with(obj_lighting){
							_colorTo[0] = other._defcolors[0];
							_colorTo[1] = other._defcolors[1];
							_draw = true;
						}
						_curcolor = c_black;
						_pos1[1] = 0;
						_pos2[1] = 0;
						if(_vstimer >= 10){
							_vstimer = 0;
							global._vsscreen = 2;
						}
					break;
					case 2:
						_curcolor = c_white;
						if(_vstimer >= 20){
							_vstimer = 0;
							global._vsscreen = 3;
						}
					break;
					case 3:
						_size5 += 0.3;
						if(_size5 >= 1){
							_size5 = 1;
						}
						_pos3[1] = 0;
						_pos4[1] = 0;
					
						if(_vstimer >= 90){
							sfx_play(snd_explosion2);
							_vstimer = 0;
							global._vsscreen = 4;
							with(obj_lighting){
								_colorTo[0] = [0,0,0];
								_colorTo[1] = [0,0,0];
							}
						}
					break;
					case 4:
						_exptime ++;
						if(_exptime % 4 == 3){
							_expframe += 1;
							if(_expframe >= 5){
								ui_fade("boss", 1);
								with(obj_boss1_mask){
									_begin = true;
								}
								with(obj_dh_mask){
									_state = "default";
								}
								global._seenvs = true;
								global._vsscreen = 0;
							}
						}
					break;
				}
			}
			
			if(_expframe < 3){
				draw_set_color(#000000);
				draw_rectangle(_pos2[0], 24, _pos2[0]+WIDTH, 48, false);
				draw_rectangle(_pos1[0], HEIGHT-76, _pos1[0]+WIDTH, HEIGHT-76, false);
				draw_set_color(#FFFFFF);
				if(!global._pause){
					if(global._vsscreen >= 2){
						_textpos2 += _textspd[0];
						_textpos1 += _textspd[1];
						if(_textpos2 < 0){
							_textpos2 = WIDTH*3.5;
						}
						if(_textpos1 > WIDTH){
							_textpos1 = -WIDTH*2.5;
						}
					}
				}
				scr_textrender_switchfont("dh_font2");
				scr_textrender_halign("right");
				scr_textrender_type(_textpos2, 24, _texts, false, #993400);
				scr_textrender_halign("left");
				scr_textrender_type(_textpos1,  HEIGHT-76, _texts, false, #993400);
				scr_textrender_switchfont(global._defaultFont);
			
				var shakeVal = random(480);
				if(global._pause){
					shakeVal = 0;
				}
			
				draw_sprite_ext(spr_vs_dh, 0, _pos1[0]+(sin(shakeVal)*_amp1), cos(shakeVal)*_amp1, 1.2, 1.2, 0, _curcolor, 1);
				draw_sprite_ext(spr_vs_boss, 0, _pos2[0]+(sin(shakeVal)*_amp2), cos(shakeVal)*_amp2, 1.2, 1.2, 0, _curcolor, 1);
			
				draw_sprite(spr_vs_logo_dh, 0, 0, _pos3[0]);
				draw_sprite(spr_vs_logo_boss, 0, 0, _pos4[0]);
				
				draw_sprite_ext(spr_vs, 0, WIDTH/2, HEIGHT/2, _size5, _size5, 0, #FFFFFF, 1);
			}
		
			if(global._vsscreen >= 4){
				draw_sprite(spr_p_explosion_screen, _expframe, WIDTH/2, HEIGHT/2);
			}
		}
		
		if(global._winscreen){
			_addcash_spdmult = 2.2+((global._moneypickups.cur-1)*0.6);
				
			if(_addcash_amp > 0){
				_addcash_amp --;
			} else {
				_addcash_amp = 0;
			}
				
			if(global._knockouts <= 0){
				_hellyeah = true;
			}
			
			/*if(!_minispawn){
				var mini_gridsize = 128;
				for(var i = 0; i < floor(WIDTH/mini_gridsize+1); i++){
					var mini = instance_create_depth(0, 0, 0, obj_minidh);
					mini._xpos = -WIDTH+(i*mini_gridsize);
					mini._ypos = 32;
					mini._sp = _curspawn;
					mini._xvel = 4;
					_curspawn ++;
					if(_curspawn >= 4){
						_curspawn = 1;
					}
				}
				_curspawn = 1;
				for(var i = 0; i < floor(WIDTH/mini_gridsize+1); i++){
					var mini = instance_create_depth(0, 0, 0, obj_minidh);
					mini._xpos = WIDTH+(i*mini_gridsize);
					mini._ypos = (HEIGHT-128)-32;
					mini._sp = _curspawn;
					mini._xvel = -4;
					_curspawn ++;
					if(_curspawn >= 4){
						_curspawn = 1;
					}
				}
				_minispawn = true;
			}*/
			
			//slide things onto screen
			var spd = 0.15;
			_dhx = _dhx + (_dhslide-_dhx)*spd;
			_dhwinobj._posx = _dhx;
			_winy = _winy + (_winslide-_winy)*spd;
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			if(!_hellyeah){
				if(global._buildver == WINDOWS){
					scr_textrender_switchfont("dh_font4_big");
					scr_textrender_type(850, _winy, "YoU DiD IT");
				} else if(global._buildver == HTML){
					scr_textrender_switchfont("dh_font4");
					scr_textrender_type(850, _winy, "YoU DiD IT", false, c_white, 1, 1.98, 1.98);
				}
			}
			
			_bgwinobj._alpha = lerp(_bgwinobj._alpha, _alphato, 0.16);
			
			_wintime ++;
			
			if(!_hellyeah){
				switch(_winact){
					case 0:
						if(_wintime >= 0){
							_alphato = 0.7;
							_dhslide = 0;
							_winact ++;
						}
					break;
					case 1:
						if(_wintime >= 30){
							_winslide = 130;
							_bgwinobj._drawspot = true;
							_winact = 5;
						}
					break;
					case 5:
						if(_wintime >= 120){
							sfx_play(snd_cash);
							_textspacing[0] = 30;
							_textactive[0] = true;
							_textsize[0] = 2;
							_winact ++;
						}
					break;
					case 6:
						if(_wintime >= 200){
							//count extra cash
							if(!_addcash_draw){
								if(_addcash_total < global._moneypickups.cur){
									_addcash_randcur = irandom_range(0,array_length(_addcash_rand)-1);
		
									_addcash_draw = true;
									_addcash_scale = 3;
									_addcash_pos = [_addcash_rand[_addcash_randcur].xpos,HEIGHT+240];
									_addcash_spd = [_addcash_rand[_addcash_randcur].xspd,_addcash_rand[_addcash_randcur].yspd];
								
									_addcash_amnt = global._plusmoney.cur[_addcash_total];
										
									sfx_play_choose([snd_swish1,snd_swish2,snd_swish3]);
								} else {
									_wintime = 0;
									_textactive[1] = true;
									_textsize[1] = 2;
									_textspacing[1] = 30;
									_winact ++;
								}
							}
						}
					break;
					case 7:
						if(_wintime >= 40){
							_winact = 8;
						}
					break;
					case 9:
						if(_wintime >= 60){
							_confirmexit = true;
							_winact ++;
						}
					break;
				}
				
				if(_winact >= 6){
					if(_textspacing[0] > 0){
						_textspacing[0] -= 3;
					}
					if(_textspacing[0] <= 0){
						_textspacing[0] = 0;
					}
					for(var i = 0; i < array_length(_textsize); i++){
						if(_textactive[i]){
							if(_textsize[i] > 1){
								_textsize[i] -= 0.25;
							}
							if(_textsize[i] < 1){
								_textsize[i] = 1;
							}
						}
					}
						
					scr_textrender_switchfont("dh_font2_big");
					global._addSpacing = _textspacing[0];
					scr_textrender_type(floor(WIDTH/2)+224, 280, "Great job. Here's your", false, #FFCC00);
						
					var str = string(floor(global._reward));
						
					var doloffsetx = 0;
					if(string_length(str) >= 5){
						for(var i = 0; i < string_length(str)-4; i++){
							doloffsetx -= sprite_get_width(spr_gui_dollarnum)*0.5;
						}
					}
						
					draw_sprite_ext(spr_gui_dollar, 0, (floor(WIDTH/2)-27)+doloffsetx+(sin(random(480))*_addcash_amp), 432+(sin(random(480))*_addcash_amp), _textsize[0]*1.2, _textsize[0]*1.2, 0, #FFFFFF, 1);
						
					var offset = [(floor(WIDTH/2)+106)+doloffsetx, 430];
					for(var i = 0; i < string_length(str)+1; i++){
						if(i > 0){
							draw_sprite_ext(spr_gui_dollarnum, real(string_char_at(str, i)), offset[0]+(i*86)+(sin(random(480))*_addcash_amp), offset[1]+(sin(random(480))*_addcash_amp), _textsize[0], _textsize[0], 0, #FFFFFF, 1);
						} else {
							draw_sprite_ext(spr_gui_dollarnum, 10, offset[0]+(i*86)+(sin(random(480))*_addcash_amp), offset[1]+(sin(random(480))*_addcash_amp), _textsize[0], _textsize[0], 0, #FFFFFF, 1);
						}
					}
				}
					
				var floornum = 560;
				if(_winact >= 7){
					if(_textspacing[1] > 0){
						_textspacing[1] -= 3;
					}
					if(_textspacing[1] <= 0){
						_textspacing[1] = 0;
					}
					global._addSpacing = _textspacing[1];
					if(global._knockouts > 0){
						var drawspace = "";
						if(_tempKO >= 10){
								drawspace = " ";
						}
						var noun = "times";
						if(_tempKO == 1){
							noun = "time";
						}
						scr_textrender_type(floor(WIDTH/2)+205, floornum, "...But you got /r'NOCKED    /w"+drawspace+noun, false, #FFCC00, 1, 0.8,0.8);
						var drawKO = string(_tempKO)+" ";
						var drawoffset = -16;
						if(_tempKO >= 10){
							drawKO = "9+";
							drawoffset = -30;
						}
						scr_textrender_type(floor(WIDTH/2)+205+drawoffset, floornum+_koHeight, "/i...But you got /r'NOCKED   /i"+drawKO+"/i"+noun, false, #FFCC00, 1, 0.8,0.8);
							
						//mess up music
						if(global._cursong != -1){
							_winpitchtimer --;
							if(_winpitchtimer <= 0){
								_pitchmod = clamp(clamp(_tempKO, 0, 10)*0.07, 0.2, 1.8);
								_pitchmodlerp = lerp(_pitchmodlerp,_pitchmod, 0.04);
								mus_pitch(random_range(1-_pitchmodlerp,1+_pitchmodlerp));
								_winpitchtimer = 90;
							}
						}
					} else {
						draw_sprite_ext(spr_guiwintext, 2, floor(WIDTH/2)+180, floornum, _textsize[1], _textsize[1], 0, #FFFFFF, 1);
					}
				}
			
				global._addSpacing = 0;
			
				if(_winact == 8){
					_kotimer ++;
					if(_kotimer % 12 == 0){
						global._reward += global._badnums[global._location];
						sfx_play_choose(global._kdsounds);
						if(!ds_map_exists(_badnumb, _tempKO)){
							_badnumb[? _tempKO] = [floor(WIDTH/2)+430, 390, 1, string(global._badnums[global._location]), #FF1317];
						}
							
						global._pad_vibrate = 2;
					
						with(obj_windh){
							image_index = 0;
							_state = "hurt";
							_hurtanim = round(random_range(1,3));
							_punches ++;
						}
					
						_koHeight = 0;
						_koSpd = -7;
						_tempKO += 1;
						if(_tempKO >= global._knockouts || _tempKO >= 10){
							with(obj_windh){
								_ranking = true;
							}
							_wintime = 0;
							_winact = 9;
						}
					}
				}
				/*if(_winact >= 9){
					if(global._knockouts > 0){
						scr_textrender_switchfont("dh_font2");
						scr_textrender_type(floor(WIDTH/2)+180, 346, "< "+string(global._rewards[0]), false, #FFCC00);
					}
				}*/
			} else {
				//HELL YEAH!!!
				switch(_winact){
					case 0:
						if(_wintime >= 0){
							_alphato = 0.7;
							_dhslide = 0;
							_winact ++;
						}
					break;
					case 1:
						if(_wintime >= 30){
							_bgwinobj._drawspot = true;
							_winact ++;
						}
					break;
					case 2:
						if(_wintime >= 40){
							sfx_play(snd_charge);
							_dhwinobj.image_index = 0;
							_dhwinobj._state = "hellyeah1";
							_winact ++;
						}
					break;
					case 3:
						_lettertime ++;
						if(_lettertime % 10 == 0){
							if(_curletter < array_length(_spawnletter)){
								if(_spawnletter[_curletter] == 0){
									var letr = instance_create_depth(0, 0, 0, obj_winhellyeah);
									letr.image_index = _curletter;
									letr._xpos = _letrpos[_curletter][0]-64;
									letr._ypos = _letrpos[_curletter][1];
									_spawnletter[_curletter] = 1;
								}
							} else {
								_wintime = 0;
								_winact ++;
							}
							_curletter ++;
						}
					break;
					case 4:
						if(_wintime >= 30){
							sfx_play(snd_explosion2);
							with(obj_camera){
								_ampX = 20;
								_ampY = 20;
							}
								
							global._pad_vibrate = 16;
								
							_bgwinobj._drawspot = false;
							_bgwinobj._drawfire = true;
							_dhwinobj.image_index = 0;
							_dhwinobj._state = "hellyeah2";
							_dhwinobj._hellyeahexp = 1;
							
							_wintime = 0;
							_winact ++;
						}
					break;
					case 5:
						if(_wintime >= 25){
							sfx_play(snd_perfect);
							_wintime = 0;
							_winact ++;
						}
					break;
					case 6:
						if(_wintime >= 60){
							if(!_addcash_draw){
								if(_addcash_total < global._moneypickups.cur){
									_addcash_randcur = irandom_range(0,array_length(_addcash_rand)-1);
		
									_addcash_draw = true;
									_addcash_scale = 3;
									_addcash_pos = [_addcash_rand[_addcash_randcur].xpos,HEIGHT+240+260];
									_addcash_spd = [_addcash_rand[_addcash_randcur].xspd,_addcash_rand[_addcash_randcur].yspd];
								
									_addcash_amnt = global._plusmoney.cur[_addcash_total];
									
									sfx_play_choose([snd_swish1,snd_swish2,snd_swish3]);
								} else {
									_confirmexit = true;
									_winact ++;
								}
							}
						}
					break;
				}
				if(_winact >= 5){
					scr_textrender_switchfont("dh_font2_big");
					scr_textrender_type(floor(WIDTH/2)+224, 460, "You got 'NOCKED 0 times!\nHere's your", false, #FFCC00, 1, 0.85, 0.85);
						
					var str = string(floor(global._reward));
						
					var doloffsetx = 0;
					if(string_length(str) >= 5){
						for(var i = 0; i < string_length(str)-4; i++){
							doloffsetx -= sprite_get_width(spr_gui_dollarnum)*0.5;
						}
					}
						
					draw_sprite_ext(spr_gui_dollar, 0, (floor(WIDTH/2)+22)+doloffsetx+(sin(random(480))*_addcash_amp), 612+(sin(random(480))*_addcash_amp), 1.2, 1.2, 0, #FFFFFF, 1);
						
					var offset = [floor(WIDTH/2)+130, 610];
					var dlrtext = "";
					var dlrx = 0;
					var dlry = 0;
					for(var i = 0; i < string_length(str)+1; i++){
						dlrx = offset[0]+(i*86);
						dlry = offset[1] + sin((-current_time / 80) + (i * 7.5)) * 10;
						if(i > 0){
							dlrtext = real(string_char_at(str, i));
						} else {
							dlrtext = 10;
						}
						draw_sprite_ext(spr_gui_dollarnum, dlrtext, dlrx+doloffsetx+(sin(random(480))*_addcash_amp), dlry+16+(sin(random(480))*_addcash_amp), 1, 1, 0, #000000, 1);
						draw_sprite_ext(spr_gui_dollarnum, dlrtext, dlrx+doloffsetx+(sin(random(480))*_addcash_amp), dlry+(sin(random(480))*_addcash_amp), 1, 1, 0, #FFFFFF, 1);
					}
				}
			}
				
			if(_winact >= 6 || _hellyeah){
				//-200 things
				for(var j = 0; j < ds_map_size(_badnumb); j++){
					if(ds_map_exists(_badnumb, j)){
						_badnumb[? j][1] -= 1.2;
						_badnumb[? j][2] -= 0.03;
						scr_textrender_type(_badnumb[? j][0], _badnumb[? j][1], _badnumb[? j][3], false, _badnumb[? j][4], _badnumb[? j][2]);
						if(_badnumb[? j][2] <= 0){
							ds_map_delete(_badnumb, j);
						}
					}
				}
				_koHeight += _koSpd;
				_koSpd += 0.7;
				if(_koHeight >= 0){
					_koSpd = 0;
					_koHeight = 0;
				}
			}
			
			if(_addcash_total > 0){
				var drawx = WIDTH-28;
				for(var i = _addcash_total-1; i >= 0; i--){
					draw_sprite_ext(spr_gui_dollar, 0, drawx, HEIGHT-28, 0.45, 0.45, 0, c_white, 1);
					drawx -= 60;
				}
			}
			
			if(_confirmexit){
				scr_textrender_switchfont("dh_font2");
				scr_textrender_halign("left");
				scr_textrender_halign("top");
				var conpos = [20,40];
				if(scr_compareinput("confirm","menu_select")){
					scr_textrender_type(conpos[0], conpos[1], "Press keycode@CONFIRMkeycode to continue", true);
				} else {
					scr_textrender_type(conpos[0], conpos[1], "Press keycode@MENU_SELECTkeycode or keycode@CONFIRMkeycode to continue", true);
				}
				
				if(!_exit_enddemo){
					if(check_keypress(global._input[global._inptype][? "confirm"],global._inptype) || check_keypress(global._input[global._inptype][? "menu_select"],global._inptype)){							
						sfx_play(snd_comic_advance);
						mus_stop();
						with(obj_screen_tr){
							_show = true;
							_type = "out";
							global._loadState = "tapes";
							_roomto = r_loading;
						}
						_exit_enddemo = true;
					}
				}
			}
			
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_halign("left");
			scr_textrender_valign("top");
		}
			
		if(_addcash_draw){
			if(!global._pause){
				//extra cash code
				_addcash_pos[0] += _addcash_spd[0]*_addcash_spdmult;
				_addcash_pos[1] += _addcash_spd[1]*_addcash_spdmult;
				_addcash_spd[1] += 0.4*_addcash_spdmult;
				_addcash_scale -= _addcash_rand[_addcash_randcur].scalespd*_addcash_spdmult;
					
				var maxheight = HEIGHT-320;
				var ypos = 390;
				if(_hellyeah){
					ypos = 570;
				}
					
				if(_addcash_spd[1] > 0 && _addcash_pos[1] >= maxheight){
					_badnumb = ds_map_create();
					_badnumb[? 0] = [floor(WIDTH/2)+430, ypos, 1, "+"+string(_addcash_amnt), #96ed1c];
						
					global._reward += _addcash_amnt;
						
					_addcash_amp = 14;
						
					sfx_play(snd_addcash);
					sfx_pitch(snd_addcash, random_range(0.9,1.1));
						
					_addcash_total ++;
					_addcash_draw = false;
				}
			}
				
			draw_sprite_ext(spr_gui_dollar, 0, _addcash_pos[0],_addcash_pos[1], max(0,_addcash_scale), max(0,_addcash_scale), 0, c_white, 1);
		}
	}
	
	if(global._state == "dead"){
		if(_drawloser > 0){
			_drawloserPos[0] += 4;
			_drawloserPos[1] -= 4;
			
			if(_drawloserPos[0] >= 0){
				_drawloserPos[0] = -412;
			}
			if(_drawloserPos[1] <= WIDTH+6){
				_drawloserPos[1] = WIDTH+700
			}
			
			if(_loseralpha < 1){
				_loseralpha += 0.07;
			}
			if(_loseralpha > 1){
				_loseralpha = 1;
			}
			
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(_drawloserPos[0], 32, _losertext, true, #db0404, _loseralpha);
			scr_textrender_halign("right");
			scr_textrender_type(_drawloserPos[1], HEIGHT-64, _losertext, true, #db0404, _loseralpha);
			scr_textrender_halign("left");
			scr_textrender_switchfont(global._defaultFont);
		
			/*if(keyboard_check(vk_left)){
				_drawloserPos[0] += 4;
				_drawloserPos[1] -= 4;
			} else if(keyboard_check(vk_right)){
				_drawloserPos[0] -= 4;
				_drawloserPos[1] += 4;
			}
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type(0,0, "pos1:"+string(_drawloserPos[0])+"\n"+"pos2:"+string(_drawloserPos[1]));*/
		}
		if(_drawloser == 2){
			if(!_retry){
				if(check_keypress(global._input[global._inptype][? "up"], global._inptype ) || check_keypress(global._input[global._inptype][? "menu_up"], global._inptype )){
					_loseOpt --;
					global._menubuttontimer = 0;
					if(_loseOpt < 0){
						_loseOpt = array_length(_loseOpts)-1;
					}
				} else if(check_keypress(global._input[global._inptype][? "down"], global._inptype ) || check_keypress(global._input[global._inptype][? "menu_down"], global._inptype )){
					_loseOpt ++;
					global._menubuttontimer = 0;
					if(_loseOpt > array_length(_loseOpts)-1){
						_loseOpt = 0;
					}
				} else if(check_keypress(global._input[global._inptype][? "confirm"], global._inptype ) || check_keypress(global._input[global._inptype][? "menu_select"], global._inptype )){
					switch(_loseOpt){
						case 0:
							mus_stop();
							sfx_play(snd_retry);
							_retrymenu = false;
							_retry = true;
						break;
						case 1:
							mus_stop();
							sfx_play(snd_retry);
							_retrymenu = true;
							_retry = true;
						break;
					}
				}
			}
			
			scr_textrender_halign("center");
			for(var i = 0; i < array_length(_loseOpts); i++){
				var col = global._menuColorNo;
				var xoffset = 0;
				if(_loseOpt == i){
					col = global._menuColorYes;
					xoffset = global._menubuttonsin;
					scr_textrender_shake(3);
				}
				scr_textrender_switchfont("dh_font2");
				scr_textrender_type((WIDTH/2)+xoffset, ((HEIGHT/2)+150)+(i*64), _loseOpts[i], true, col);
				scr_textrender_switchfont(global._defaultFont);
				scr_textrender_shake(0);
			}
			scr_textrender_halign("left");
		}
		
		if(_retry){
			draw_set_color(#000000);
			draw_rectangle(0, 0, WIDTH, HEIGHT, false);
			draw_set_color(#FFFFFF);
			
			_retrytimer ++;
			if(_retrytimer >= 100){
				if(!_retrymenu){
					var stages = [r_stage1, r_stage2];
					room_goto(stages[global._location]);
				} else {
					with(obj_music){
						global.music_bus.effects[0] = undefined;
					}
					audio_stop_all();
					global._loadState = "tomenu";
					room_goto(r_loading);
				}
			}
		}
	}
		
	//battlezone maker
		
	if(global._bzmaker){
		_bztimer += 0.1;
		var bzalp = clamp(sin(_bztimer)+1,0,1);
		scr_textrender_halign("center");
		var addtext = "";
		if(!global._battlezone){
			addtext = "\nEnter a battlezone to begin";
		}
		if(mouse_check_button(mb_left) && _hovertimer > 0){
			addtext = "\nPress any arrow key\nTo position enemy to the sides\nBackspace: center";
		}
		scr_textrender_type(floor(WIDTH/2),128, "Battlezone maker"+addtext, true, c_white, bzalp);
		scr_textrender_halign("left");
			
		if(global._battlezone){
			if(global._battleobj != noone && instance_exists(global._battleobj)){
				scr_textrender_type(0, 16, "Wave count: "+string(array_length(global._bzone_enemies))+"\nCurrent wave: "+string(global._battleobj._curwave)+"\nAdd wave: + (numpad)\nRemove wave: - (numpad)\n\nLeft Mouse Click: spawn enemy\nRight Mouse Click: destroy enemy\nMiddle scroll: Change enemy's alt\nQ/W: Change enemy's order\nR/T: Change enemy's spawn type\nY: Set fade in\nShift: Log spawn information\nEnter: Activate all enemies", true, #FFFFFF, 0.75, 0.6,0.6);
					
				//popup
				if(_bzpopup){
					var startpos = [_bz_mousestart[0],_bz_mousestart[1]];
					var enmpos = [startpos[0],startpos[1]];
					var maxwidth = 0;
					_popupopt = -1;
					for(var e = 0; e < array_length(global._bzenemies); e++){
						var enmtext = global._bzenemies[e].dispname;
						draw_set_color(c_black);
						draw_rectangle(enmpos[0], enmpos[1],enmpos[0]+scr_textrender_width(enmtext),enmpos[1]+scr_textrender_height(enmtext), false);
						if(scr_textrender_width(enmtext)> maxwidth){
							maxwidth = scr_textrender_width(enmtext);
						}
						draw_set_color(c_white);
						var colr = make_color_rgb(100,100,100);
							
						if(scr_mousehover(enmpos[0], enmpos[1],enmpos[0]+scr_textrender_width(enmtext),enmpos[1]+scr_textrender_height(enmtext), true)){
							colr = c_white;
							_popupopt = e;
						}
							
						scr_textrender_type(enmpos[0], enmpos[1], enmtext, true, colr);
						enmpos[1] += scr_textrender_height(enmtext);
						if(enmpos[1] >= startpos[1]+280){
							enmpos[0] += maxwidth+64;
							enmpos[1] = startpos[1];
						}
					}
				}
			}
		}
	}
	
	//gamepads
	if(global._padtime > 0){
		global._padtime --;
		var alp = 1;
		if(global._padtime <= 100){
			alp = global._padtime/100;
		}
		var text = "";
		if(global._padmsgtype == 0){
			text = "GAMEPAD CONNECTED";
		} else if(global._padmsgtype == 1){
			text = "GAMEPAD DISCONNECTED";
		}
		scr_textrender_switchfont("dh_font2");
		scr_textrender_halign("right");
		scr_textrender_valign("top");
		scr_textrender_type(WIDTH,0,text,true, #FFFFFF, alp);
		scr_textrender_halign("left");
		scr_textrender_switchfont(global._defaultFont);
	}
	
	if(global._state == "quit"){
		if(!_exitinit){
			mus_stop();
			with(obj_camera){
				_ampX = 20;
				_ampY = 20;
			}
			_exitinit = true;
		}
		_exitimer ++;
		if(_exitimer >= 90){
			game_end();
		}
		draw_sprite(spr_exitcard, 0, global._screenOffsetX, global._screenOffsetY);
	}
		
	if(global._debug){
		var buildver = "";
		switch(global._buildver){
			case WINDOWS:
				buildver = "WINDOWS";
			break;
			case HTML:
				buildver = "HTML";
			break;
		}
		scr_textrender_switchfont(global._defaultFont);
		if(global._showDebug == 0){
			scr_textrender_type(0, 0, "DEBUG MODE ON\nBUILD VER: "+buildver+"\nTAB: show debug help   ALT+Q: toggle hitbox view\nALT+E: free roam\nSHIFT+1: debug room select\nALT+D: death\nALT+B: battlezone maker\nALT+T: loaded texgroups\nALT+M: memory debug", true, #FFFF00);
		} else if(global._showDebug == 1) {
			scr_textrender_type(0, 0, "DEBUG MODE ON", true, #FFFF00);
		}
		
		if(global._showTexGroupDebug){
			var loadedgroups = "";
			var groupnames = texturegroup_get_names();
			for(var i = 0; i < array_length(groupnames); ++i){
				if(texturegroup_get_status(groupnames[i]) == texturegroup_status_loaded || texturegroup_get_status(groupnames[i]) == texturegroup_status_fetched){
					if(string_pos("fallbacktexture", groupnames[i]) == 0){
						loadedgroups += "\n" + groupnames[i];
					}
				}
			}
			scr_textrender_halign("right");
			scr_textrender_type(WIDTH, 48, "loaded texture groups:" + loadedgroups, true);
			scr_textrender_halign("left");
		}
		
		if(global._buildver == WINDOWS){
			if(global._showDebug == 0 || global._showDebug == 1){
				var mem = debug_event("DumpMemory");
				scr_textrender_type(0, HEIGHT - 40, "FPS:" + string(fps) + " | MEM:" + bytes_get_size(mem.totalUsed), true, #FFFF00);
				if(global._showMemoryDebug){
					scr_textrender_halign("center");
					scr_textrender_valign("middle");
					scr_textrender_type(WIDTH / 2, HEIGHT - 128, "Total DS Maps:" + string(_dbg_mapcount) + " | Total MP Grids:" + string(global._mpGridCount) + "\nSequence Layer Count:" + string(_dbg_layercount)+"\npress ALT+M again to update", true);
					scr_textrender_halign("left");
					scr_textrender_valign("top");
				}
			}
		}
	}
}