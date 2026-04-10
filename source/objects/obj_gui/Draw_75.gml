{
	if(!global._winscreen){
		if(!global._stageentrance){
			//dynamitehead hp bar
			if(ui_fade_get("dh") > 0){
				_dh = instance_find(obj_dh_mask, 0);
				if(instance_exists(_dh)){
					var hpoff = [100,46];
					var alp = global._ui_stuff_alpha[0] * global._ui_stuff_alphaMult[0];
					draw_set_alpha(alp);
					draw_sprite(spr_gui_dhfire, 0, _hpoffset[0]+9, _hpoffset[1]-45);
					draw_sprite(spr_gui_dhborder, 1, _hpoffset[0], _hpoffset[1]);
					draw_sprite_part_ext(spr_gui_dhhp, 0, 0, 0, (_dh._displayhp/_dh._maxhp)*sprite_get_width(spr_gui_dhhp), sprite_get_height(spr_gui_dhhp), _hpoffset[0]+hpoff[0], _hpoffset[1]+hpoff[1], 1, 1, _dh._hpcolor, alp);
					draw_sprite(spr_gui_dhborder, 0, _hpoffset[0], _hpoffset[1]);
					var lowhp = 0;
					if(_dh._hp <= 10){
						lowhp = 1;
					}
					draw_sprite(spr_gui_dhportrait, lowhp, _hpoffset[0]-17, _hpoffset[1]-63);
					scr_textrender_switchfont("dh_font2_hue");
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
			if(ui_fade_get("enemy") > 0){
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
						}
					}
				}	
			}
		}
	
		//boss hp bar
		if(global._curboss != noone && instance_exists(global._curboss)){
			if(ui_fade_get("boss") > 0){
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
						
				scr_textrender_switchfont("dh_font2_hue");
				scr_textrender_type(_bossoffset[0], _bossoffset[1]+(96*scale_y), string_upper(global._curboss._name), true, #FFFFFF, alp);
				scr_textrender_switchfont("dh_font3");
				scr_textrender_type(_bossoffset[0], _bossoffset[1]-10, "HP "+string(clamp(floor(global._curboss._displayhp), 0, global._curboss._maxhp))+"/"+string(floor(global._curboss._maxhp)), true, #FFFFFF, alp);
				scr_textrender_switchfont(global._defaultFont);
			}
		}
	
		if(!global._stageentrance){
			if(ui_fade_get("tnt") > 0){
				//tnt juice
				var hpoff = [-6,-26];
				var offset = cos(random(480))*_tntamp;
				if(global._pause){
					offset = 0;
				}
			
				var alp = global._ui_stuff_alpha[1] * global._ui_stuff_alphaMult[1];
				draw_set_alpha(alp);
				draw_sprite(spr_gui_tntborder, 0, _tntoffset[0], _tntoffset[1]+offset);
			
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
				scr_textrender_switchfont("dh_font2_hue");
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
		}
	
		//hits
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
		}
				
		//dial-m tutorial popup
		if(_dialm_active){	
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
		}
	}
		
	//spacing text
	if(_uitextshow){
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
		scr_textrender_switchfont("dh_font2_hue");
		global._addSpacing = 0;
	}
}