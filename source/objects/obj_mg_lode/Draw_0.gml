{
	gpu_set_texfilter(false);
	scr_textrender_switchfont("dh_fontnes_lode");
	
	var cammultipl = -1;
	
	if(_init){
		if(surface_exists(_display_bg)){
			surface_set_target(_display_bg);
			
			draw_clear_alpha(c_black,0);
			
			if(global._lode_editor){
				draw_set_alpha(1);
			} else {
				if(global._skyshader){
					gpu_set_texrepeat(true);
		
					shader_set(shd_wavy);
			
					shader_set_uniform_f(t, _bgtimer);
			
					shader_set_uniform_f(aX, 0.006);
					shader_set_uniform_f(aY, 0.006);
					shader_set_uniform_f(s, 0.2);
					shader_set_uniform_f(fX, 90);
					shader_set_uniform_f(fY, 90);
				}
			
				draw_sprite(spr_lode_sky, 0, floor(_disp_dim[0]/2), floor(_disp_dim[1]/2));
			
				if(global._skyshader){
					shader_reset();
					gpu_set_texrepeat(false);
				}
			
				var sp = [spr_lode_bg1,spr_lode_bg2];
				for(var i = array_length(_bgoffset)-1; i >= 0; i--){
					draw_sprite(sp[i], 0, floor(_disp_dim[0]/2)+_bgoffset[i][0], floor(_disp_dim[1]/2)+_bgoffset[i][1])
				}
				
				draw_set_alpha(0.25);
			}
			draw_set_color(make_color_rgb(76, 76, 76));
			draw_rectangle(0,0,_disp_dim[0],_disp_dim[1],false);
			draw_set_color(c_white);
			draw_set_alpha(1);
			
			surface_reset_target();
			
			draw_surface_stretched(_display_bg,0,0,WIDTH,HEIGHT);
		} else {
			_display_bg = surface_create(_disp_dim[0],_disp_dim[1]);
		}
		if(surface_exists(_display)){
			surface_set_target(_display);
			
			draw_clear_alpha(c_black,0);
			
			var base_pos_x = (_offset[0]*cammultipl)+_editor_dispoffset[0]+_stage_offset[0]+_scr_shake_offset[0];
			var base_pos_y = (_offset[1]*cammultipl)+_editor_dispoffset[1]+_stage_offset[1]+_scr_shake_offset[1];
			
			//draw black borders
			draw_set_color(c_black);
			draw_rectangle(base_pos_x-_disp_dim[0],0,base_pos_x,_disp_dim[0],false); //left
			draw_rectangle(0,base_pos_y-_disp_dim[1],_disp_dim[0],base_pos_y,false); //top
			draw_rectangle(base_pos_x+_stagedims_nooffset[0]+_disp_dim[0],0,base_pos_x+_stagedims_nooffset[0],_disp_dim[0],false); //right
			draw_rectangle(0,base_pos_y+_stagedims_nooffset[1]+_disp_dim[1],_disp_dim[0],base_pos_y+_stagedims_nooffset[1],false); //bottom
			draw_set_color(c_white);
			
			for(var zz = 0; zz < array_length(global._stage_layout); zz++){
				for(var yy = 0; yy < _editor_dims_tiles[1]; yy++){
					for(var xx = 0; xx < _editor_dims_tiles[0]; xx++){
						var tile = global._stage_layout[zz][yy][xx];
						if(ds_map_exists(_tileinfo, tile) && !_tileinfo[? tile].project){
							if(_tileinfo[? tile].obj == -1){
								if(variable_struct_exists(_tileinfo[? tile], "tile")){
									if(_tileinfo[? tile].tile){
										var scale_x = 1;
										var scale_y = 1;
										var alp = 0.2;
										random_set_seed(xx+yy);
										scale_x = choose(-1,1);
										scale_y = choose(-1,1);
										alp = random_range(0,0.2);
										randomize();
										draw_sprite_ext(spr_lode_tiles, global._lode_tileframe, floor(base_pos_x+(xx*global._lode_tilesize))+(global._lode_tilesize*0.5),floor(base_pos_y+(yy*global._lode_tilesize))+(global._lode_tilesize*0.5),scale_x,scale_y,0,merge_color(c_white,c_black,alp),1);
									}
								}
							}
						}
					}
				}
			}
			
			//draw stage layout tiles
			for(var zz = 0; zz < array_length(global._stage_layout); zz++){
				var drawalp = 1;
				if(global._lode_editor){
					if(zz <> _editor_curlayer){
						drawalp = 0.5;
					}
				}
				for(var yy = 0; yy < _editor_dims_tiles[1]; yy++){
					if(global._lode_editor && yy >= _editor_dims_tiles[1]-1){
						//show height
						scr_textrender_type(base_pos_x+((_editor_dims_tiles[0]-1)*global._lode_tilesize),base_pos_y+((yy+1)*global._lode_tilesize), "HEIGHT:/n"+string(yy+1));
					}
					for(var xx = 0; xx < _editor_dims_tiles[0]; xx++){
						var pos = [
							floor(base_pos_x+(xx*global._lode_tilesize)),
							floor(base_pos_y+(yy*global._lode_tilesize)),
						];
						var cullx = pos[0];
						var cully = pos[1];
						if(cullx >= global._lode_cullingbox[0] && cullx <= global._lode_cullingbox[2]){
							if(cully >= global._lode_cullingbox[1] && cully <= global._lode_cullingbox[3]){
								if(global._lode_editor && xx >= _editor_dims_tiles[0]-1){
									//show width
									scr_textrender_type(base_pos_x+(xx*global._lode_tilesize),base_pos_y+(-1*global._lode_tilesize), "WIDTH:/n"+string(xx+1));
								}
								var tile = global._stage_layout[zz][yy][xx];
								if(ds_map_exists(_tileinfo, tile) && !_tileinfo[? tile].project){
									var frame = 0;
									if(_tileinfo[? tile].obj != -1){
										var spr = object_get_sprite(_tileinfo[? tile].obj);
										if(!ds_map_exists(_sprinfo,spr)){
											_sprinfo[? spr] = sprite_get_info(spr).num_subimages;
										}
										if(_sprinfo[? spr] > 1){
											frame = floor((xx+yy)%_sprinfo[? spr]-1)+1;
										}
										var blend = c_white;
										if(tile == LTILE_SOL && global._stage_layout[0][yy][xx] == LTILE_COL){
											blend = global._lode_collectblend;
										}
										var ext = false;
										if(blend != c_white){
											ext = true;
										}
										if(global._lode_editor){
											ext = true;
										}
							
										var in_x = false;
										var in_y = false;
							
										if(_editor_tileselect){
											var pos1 = [
												_editor_tileselect_pos[0],
												_editor_tileselect_pos[1],
											];
											var pos2 = [
												_editor_tileselect_pos[0]+_editor_tileselect_size[0],
												_editor_tileselect_pos[1]+_editor_tileselect_size[1],
											];
								
											if(pos2[0] >= pos1[0]){
												if(xx >= pos1[0] && xx <= pos2[0]-1){
													in_x = true;
												}
											} else {
												if(xx >= pos2[0] && xx <= pos1[0]){
													in_x = true;
												}
											}
								
											if(pos2[1] >= pos1[1]){
												if(yy >= pos1[1] && yy <= pos2[1]-1){
													in_y = true;
												}
											} else {
												if(yy >= pos2[1] && yy <= pos1[1]){
													in_y = true;
												}
											}
								
											if(zz == _editor_curlayer && (!in_x || !in_y)){
												var curkey = string(xx)+string(yy);
												if(ds_map_exists(_editor_tileselect_dsmap, curkey)){
													ds_map_delete(_editor_tileselect_dsmap, curkey)
												}
											}
										} else {
											in_x = false;
											in_y = false;
										}
							
										var has_dsmap = false;
							
										if(!_editor_tileselect && zz == _editor_curlayer){
											if(ds_map_exists(_editor_tileselect_dsmap, string(xx)+string(yy))){
												has_dsmap = true;
											}
										}
							
										var addx_ = 0;
										var addy_ = 0;
							
										if(has_dsmap){
											addx_ = _editor_gottiles_drag_offset[0];
											addy_ = _editor_gottiles_drag_offset[1];
										}
							
										var hidetile = false;
										if(!global._lode_editor){
											hidetile = global._stage_hidetiles[zz][yy][xx];
										}
								
										if(!hidetile){
											if(!ext){
												draw_sprite(spr, frame, floor(base_pos_x+((xx+addx_)*global._lode_tilesize)),floor(base_pos_y+((yy+addy_)*global._lode_tilesize)));
											} else {
												draw_sprite_ext(spr, frame, floor(base_pos_x+((xx+addx_)*global._lode_tilesize)),floor(base_pos_y+((yy+addy_)*global._lode_tilesize)),1,1,0,blend,drawalp);
											}
										}
							
										if((in_x && in_y && zz == _editor_curlayer) || has_dsmap){
											_editor_tileselect_dsmap[? string(xx)+string(yy)] = [xx,yy,global._stage_layout[zz][yy][xx]];
											draw_sprite_ext(spr, frame, floor(base_pos_x+((xx+addx_)*global._lode_tilesize)),floor(base_pos_y+((yy+addy_)*global._lode_tilesize)),1,1,0,c_yellow,drawalp);
										}
									}
								}
						
								if(global._lode_editor){
									draw_sprite_ext(spr_lode_cell,0,floor(base_pos_x+(xx*global._lode_tilesize)),floor(base_pos_y+(yy*global._lode_tilesize)),1,1,0,c_white,0.5);
									if(yy == _editor_mousetile[1] && xx == _editor_mousetile[0]){
										var alp = 0.5;
										if(_editor_tilemenu_tile_preview != -1){
											if(!_editor_tileselect && _editor_tiles[_editor_tilemenu_tile_preview].sprite != -1){
												draw_sprite_stretched_ext(_editor_tiles[_editor_tilemenu_tile_preview].sprite,0,floor(base_pos_x+(_editor_mousetile[0]*global._lode_tilesize)),floor(base_pos_y+(_editor_mousetile[1]*global._lode_tilesize)),global._lode_tilesize,global._lode_tilesize, c_white, alp);
											}
										}
										draw_sprite_ext(spr_lode_cell_cur,0,floor(base_pos_x+(xx*global._lode_tilesize)),floor(base_pos_y+(yy*global._lode_tilesize)),1,1,0,c_white,alp);
									}
								}
							}
						}
					}
				}
			}
			
			var base_pos_x_obj = (_offset[0]*cammultipl)+_stage_offset[0]+_scr_shake_offset[0];
			var base_pos_y_obj = (_offset[1]*cammultipl)+_stage_offset[1]+_scr_shake_offset[1];
			
			//draw objects
			var dskeys = ds_map_keys_to_array(_project);
			for(var d = 0; d < array_length(_deptharray); d++){
				for(var i = 0; i < array_length(dskeys); i++){
					var curobj = _project[? dskeys[i]];
					if(curobj.show && curobj.depth_ == _deptharray[d]){
						var pos = [
							floor(base_pos_x_obj+curobj.pos[0]),
							floor(base_pos_y_obj+curobj.pos[1]),
						];
						var cullx = pos[0];
						var cully = pos[1];
						
						var render = false;
						
						if(cullx >= global._lode_cullingbox[0] && cullx <= global._lode_cullingbox[2]){
							if(cully >= global._lode_cullingbox[1] && cully <= global._lode_cullingbox[3]){
								render = true;
							}
						}
						
						if(variable_instance_exists(curobj,"ignoreculling")){
							if(curobj.ignoreculling){
								render = true;
							}
						}
						if(variable_instance_exists(curobj,"surface")){
							render = true;
						}
						
						if(!render){
							continue;
						} else {
							var drawalp = 1;
							if(global._lode_editor){
								if(curobj.tilelayer <> _editor_curlayer){
									drawalp = 0.5;
								}
							}
						
							var in_x = false;
							var in_y = false;
						
							if(_editor_tileselect){
								var pos1 = [
									_editor_tileselect_pos[0],
									_editor_tileselect_pos[1],
								];
								var pos2 = [
									_editor_tileselect_pos[0]+_editor_tileselect_size[0],
									_editor_tileselect_pos[1]+_editor_tileselect_size[1],
								];
							
								if(pos2[0] >= pos1[0]){
									if(curobj.tilepos[1] >= pos1[0] && curobj.tilepos[1] <= pos2[0]-1){
										in_x = true;
									}
								} else {
									if(curobj.tilepos[1] >= pos2[0] && curobj.tilepos[1] <= pos1[0]){
										in_x = true;
									}
								}
								
								if(pos2[1] >= pos1[1]){
									if(curobj.tilepos[0] >= pos1[1] && curobj.tilepos[0] <= pos2[1]-1){
										in_y = true;
									}
								} else {
									if(curobj.tilepos[0] >= pos2[1] && curobj.tilepos[0] <= pos1[1]){
										in_y = true;
									}
								}
							
								if(curobj.tilelayer == _editor_curlayer && (!in_x || !in_y)){
									var curkey = string(curobj.tilepos[1])+string(curobj.tilepos[0]);
									if(ds_map_exists(_editor_tileselect_dsmap, curkey)){
										ds_map_delete(_editor_tileselect_dsmap, curkey)
									}
								}
							
							} else {
								in_x = false;
								in_y = false;
							}
						
							var has_dsmap = false;
							
							if(!_editor_tileselect && curobj.tilelayer == _editor_curlayer){
								if(ds_map_exists(_editor_tileselect_dsmap, string(curobj.tilepos[1])+string(curobj.tilepos[0]))){
									has_dsmap = true;
								}
							}
						
							var addx_ = 0;
							var addy_ = 0;
						
							if(has_dsmap){
								addx_ = _editor_gottiles_drag_offset[0];
								addy_ = _editor_gottiles_drag_offset[1];
							}
							if(!variable_instance_exists(curobj,"surface")){
								if(curobj.spr != -1 && sprite_exists(curobj.spr)){
									draw_sprite_ext(curobj.spr,curobj.img,floor((addx_*global._lode_tilesize)+base_pos_x_obj+curobj.pos[0]),floor((addy_*global._lode_tilesize)+base_pos_y_obj+curobj.pos[1]),curobj.scale[0],curobj.scale[1],curobj.angle,curobj.blend,curobj.alpha*drawalp);
								}
								if(curobj.text != ""){
									scr_nesfont_shadow(floor((addx_*global._lode_tilesize)+base_pos_x_obj+curobj.pos[0]),floor((addy_*global._lode_tilesize)+base_pos_y_obj+curobj.pos[1]),curobj.text,false,curobj.blend,global._lode_textshadow_color,curobj.alpha*drawalp,curobj.scale[0],curobj.scale[1]);
								}
						
								if((in_x && in_y && curobj.tilelayer == _editor_curlayer) || has_dsmap){
									_editor_tileselect_dsmap[? string(curobj.tilepos[1])+string(curobj.tilepos[0])] = [curobj.tilepos[1],curobj.tilepos[0],global._stage_layout[curobj.tilelayer][curobj.tilepos[0]][curobj.tilepos[1]]];
								
									if(curobj.spr != -1 && sprite_exists(curobj.spr)){
										draw_sprite_ext(curobj.spr,curobj.img,floor((addx_*global._lode_tilesize)+base_pos_x_obj+curobj.pos[0]),floor((addy_*global._lode_tilesize)+base_pos_y_obj+curobj.pos[1]),curobj.scale[0],curobj.scale[1],curobj.angle,c_yellow,curobj.alpha*drawalp);
									}
									if(curobj.text != ""){
										scr_nesfont_shadow(floor((addx_*global._lode_tilesize)+base_pos_x_obj+curobj.pos[0]),floor((addy_*global._lode_tilesize)+base_pos_y_obj+curobj.pos[1]),curobj.text,false,c_yellow,global._lode_textshadow_color,curobj.alpha*drawalp,curobj.scale[0],curobj.scale[1]);
									}
								}
							} else {
								//draw surface
								if(surface_exists(curobj.surface)){
									draw_surface(curobj.surface,floor((addx_*global._lode_tilesize)+base_pos_x_obj+curobj.pos[0]),floor((addy_*global._lode_tilesize)+base_pos_y_obj+curobj.pos[1]));
								
									if((in_x && in_y && curobj.tilelayer == _editor_curlayer) || has_dsmap){
										_editor_tileselect_dsmap[? string(curobj.tilepos[1])+string(curobj.tilepos[0])] = [curobj.tilepos[1],curobj.tilepos[0],global._stage_layout[curobj.tilelayer][curobj.tilepos[0]][curobj.tilepos[1]]];
								
										draw_surface_ext(curobj.surface,floor((addx_*global._lode_tilesize)+base_pos_x_obj+curobj.pos[0]),floor((addy_*global._lode_tilesize)+base_pos_y_obj+curobj.pos[1]),1,1,0,c_yellow,1);
									}
								}
							}
						
							if(global._debug && global._showHitbox){
								scr_textrender_type((addx_*global._lode_tilesize)+base_pos_x_obj+curobj.pos[0]-16,(addy_*global._lode_tilesize)+base_pos_y_obj+curobj.pos[1]-16,string(curobj.depth_));
							}
						}
					}
				}
			}
			
			//selecting an area of tiles
			if(_editor_tileselect){
				var posx = _editor_tileselect_pos[0];
				var addx = 0;
				if(_editor_tileselect_mousepos[0] < _editor_tileselect_pos[0]){
					posx = _editor_tileselect_pos[0]+1;
					addx = -global._lode_tilesize;
				}
				var posy = _editor_tileselect_pos[1];
				var addy = 0;
				if(_editor_tileselect_mousepos[1] < _editor_tileselect_pos[1]){
					posy = _editor_tileselect_pos[1]+1;
					addy = -global._lode_tilesize;
				}
				var selectpos = [
					base_pos_x+(posx*global._lode_tilesize),
					base_pos_y+(posy*global._lode_tilesize),
				];
				
				draw_set_color(c_yellow);
				draw_rectangle(selectpos[0],selectpos[1],selectpos[0]+(_editor_tileselect_size[0]*global._lode_tilesize)+addx,selectpos[1]+(_editor_tileselect_size[1]*global._lode_tilesize)+addy,true);
				draw_set_color(c_white);
			}
			
			if(global._lode_editor){
				//editor ui stuff
				var offset = [0,96];
				var vertoffset = 0;
				if(_editor_dispoffset[1] == 0){
					vertoffset = 28;
				}
				var toptext = ["back layer","front layer"];
				for(var i = 1; i >= 0; i--){
					var bgcol = c_black;
					if(_editor_curlayer == i){
						bgcol = c_orange;
					}
					draw_set_color(bgcol);
					draw_rectangle(_editor_dispoffset[0]+offset[i],_editor_dispoffset[1]-24+vertoffset,_editor_dispoffset[0]+offset[i]+scr_textrender_width("press key  "),(_editor_dispoffset[1]-24+vertoffset)+16,false);
					draw_set_color(c_white);
					scr_textrender_type(_editor_dispoffset[0]+offset[i],_editor_dispoffset[1]-24+vertoffset,toptext[i]+"/n"+"press key "+string(i+1));
				}
				
				if(_editor_tilemenu){
					draw_set_alpha(0.65);
					draw_set_color(c_black);
					draw_rectangle(_editor_boxpos[0],_editor_boxpos[1],_editor_boxpos[0]+_editor_boxdims[0],_editor_boxpos[1]+_editor_boxdims[1],false);
					draw_set_color(c_white);
					draw_set_alpha(1);
					
					//draw all tiles
					var xx = _editor_boxpos[0];
					var yy = _editor_boxpos[1];
					for(var i = 0; i < array_length(_editor_tiles); i++){
						if(_editor_tiles[i].sprite != -1){
							draw_sprite_stretched(_editor_tiles[i].sprite,0,floor(xx),floor(yy),global._lode_tilesize,global._lode_tilesize);
						}
						
						//selecting
						var mpos = [
							-_offset[0]+_editor_mousepos[0]+_editor_dispoffset[0]+_stage_offset[0],
							-_offset[1]+_editor_mousepos[1]+_editor_dispoffset[1]+_stage_offset[1],
						];
						
						if(mpos[0] >= xx && mpos[0] <= xx+global._lode_tilesize){
							if(mpos[1] >= yy && mpos[1] <= yy+global._lode_tilesize){
								_editor_tilemenu_timer = 3;
								_editor_tilemenu_tile_preview = i;
								_editor_tilemenu_tile = _editor_tiles[i].tile;
								draw_sprite(spr_lode_cell_cur,0,xx,yy);
							}
						}
						
						xx += global._lode_tilesize;
						if(xx >= _editor_boxpos[0]+_editor_boxdims[0]){
							xx = _editor_boxpos[0];
							yy += global._lode_tilesize;
						}
					}
					
					if(_editor_tilemenu_timer > 0 && _editor_tilemenu_tile != -1){
						var m_offset = [(_offset[0]*cammultipl)+_editor_dispoffset[0]+_stage_offset[0]+12,(_offset[1]*cammultipl)+_editor_dispoffset[1]+_stage_offset[1]+12];
						draw_set_color(c_black);
						draw_rectangle(m_offset[0]+_editor_mousepos[0],m_offset[1]+_editor_mousepos[1],m_offset[0]+_editor_mousepos[0]+scr_textrender_width(_editor_tiles[_editor_tilemenu_tile_preview].tilename),m_offset[1]+_editor_mousepos[1]+scr_textrender_height(_editor_tiles[_editor_tilemenu_tile].tilename),false);
						draw_set_color(c_white);
						scr_textrender_type(m_offset[0]+_editor_mousepos[0],m_offset[1]+_editor_mousepos[1],_editor_tiles[_editor_tilemenu_tile_preview].tilename);
					}
				}
				
				scr_textrender_valign("bottom");
				scr_textrender_type(0,_disp_dim[1],"F1: HELP");
				scr_textrender_valign("top");
			} else {
				//draw game ui
				draw_sprite_ext(spr_lode_gui, 0, 0, 0,1,1,0,c_white,_ui_alpha);
				var ylevel = 6;
				draw_num(38,ylevel,global._lode_lives);
				
				var counter = global._lode_stage;
				var txt = "LV:";
				if(global._lode_tutorial){
					txt = "TUTORIAL";
				}
				if(global._lode_boss){
					counter = global._lode_curboss;
					txt = "BOSS:";
				}
				
				scr_nesfont_shadow(59, ylevel, txt,false,c_white,global._lode_textshadow_color,_ui_alpha)
				if(!global._lode_tutorial){
					draw_num(123,ylevel,counter,1,"right");
				}
				
				var collectx = 152;
				draw_num(collectx,ylevel+1,string_pad(global._lode_collect_cur,"0",2),0.82);
				var nummax = global._lode_collect_max;
				if(global._lode_boss){
					nummax = global._lode_collect_cur;
				}
				draw_num(collectx+33,ylevel+1,string_pad(nummax,"0",2),0.82);
				
				var tntx = 216;
				
				var scaler = _tnt_lerp;
				var plr = instance_find(obj_lode_plr,0);
				if(instance_exists(plr)){
					if(plr._tnt_activation){
						scaler = 100;
					} 
					if(plr._tnt_power > 0){
						scaler = plr._tnt_power*100;
					}
					
					if((plr.y-plr.sprite_height) <= sprite_get_height(spr_lode_gui)){
						_ui_alphaTo = 0.35;
					} else {
						_ui_alphaTo = 1;
					}
				}
				
				draw_sprite_part_ext(spr_lode_gui_tnt,1,0,0,sprite_get_width(spr_lode_gui_tnt)*(scaler/global._lode_tntmax),sprite_get_height(spr_lode_gui_tnt), tntx, ylevel-4,1,1,c_white,_ui_alpha);
				draw_sprite_ext(spr_lode_gui_tnt, 0, tntx, ylevel,1,1,0,c_white,_ui_alpha);
				if(global._lode_tnt >= global._lode_tntmax){
					draw_set_color(make_color_rgb(42, 8, 97));
					draw_set_alpha(0.6*_ui_alpha);
					var rectpos = [216, 1];
					var rectsize = [134, 27];
					draw_rectangle(rectpos[0],rectpos[1],rectpos[0]+rectsize[0],rectpos[1]+rectsize[1],false);
					draw_set_alpha(1);
					draw_set_color(c_white);
					
					if(global._lode_tnt_hold > 0){
						var offs = 20;
						draw_set_color(c_black);
						draw_set_alpha(_ui_alpha);
						draw_rectangle(rectpos[0],rectpos[1]+offs,rectpos[0]+rectsize[0],rectpos[1]+rectsize[1],false);
						draw_set_color(global._lode_tnt_blend);
						draw_rectangle(rectpos[0],rectpos[1]+offs,rectpos[0]+(rectsize[0]*global._lode_tnt_hold),rectpos[1]+rectsize[1],false);
						draw_set_alpha(1);
						draw_set_color(c_white);
					}
					
					scr_textrender_halign("center");
					scr_textrender_valign("middle");
					if(!global._pause && !global._gameover_stopall){
						scr_textrender_shake(0.76);
					}
					scr_nesfont_shadow(284, 14, "TNT QUAKE/nHOLD \""+key_to_string(global._input[global._inptype][? "tnt"])+"\"",false,c_white,global._lode_textshadow_color,_ui_alpha);
					scr_textrender_shake(0);
					scr_textrender_halign("left");
					scr_textrender_valign("top");
				}
				
				_lode_score_string = string_pad(round(_lode_score_lerp), "0", 7);
				_monyx_string = string_pad(round(_lode_monyx), "0", 7);
				
				var textpos = [360,5];
				var scoreblend = c_white;
				if(global._lode_score > _lode_monyx){
					scoreblend = make_color_rgb(255, 183, 15);
				}
				scr_nesfont_shadow(textpos[0], textpos[1], _lode_score_string,false,scoreblend,global._lode_textshadow_color,_ui_alpha);
				scr_nesfont_shadow(textpos[0], textpos[1]+13, _monyx_string,false,c_white,global._lode_textshadow_color,_ui_alpha);
			
				if(_exit_trigger){
					var wavevals = [1,2];
					if(global._pause || global._gameover_stopall){
						wavevals = [0,0];
					}
					
					draw_sprite_ext(spr_lode_gui_bottom,0,0,_exit_bottomy,1,1,0,c_white,_exit_bottomalp);
					scr_textrender_halign("center");
					scr_textrender_valign("middle");
					global._addSpacing = _exit_spacing;
					scr_textrender_wave_x(wavevals[0],wavevals[1]);
					scr_textrender_wave_y(wavevals[0],wavevals[1]);
					
					var texts = [
						"THE EXIT GATE HAS OPENED. GET IN!",
						"THE EXIT GATE IS LOCKED! FIND THE GOLDEN GLOVE! ",
						"UH-OH. IT'S THE SOULS OF THE DAMNED. RUN!",
					];
					
					scr_nesfont_shadow(floor(_disp_dim[0]/2),_disp_dim[1]-20,texts[_exit_type], false, c_white, global._lode_textshadow_color);
					global._addSpacing = 0;
					scr_textrender_wave_x(0,0);
					scr_textrender_wave_y(0,0);
					scr_textrender_halign("left");
					scr_textrender_valign("top");
				}
				
				minigame_lose_draw(_disp_dim[0],_disp_dim[1],spr_lode_loser,_lode_monyx,1);
			}
			
			if(_editor_tileset_gottiles){
				scr_textrender_halign("right");
				scr_textrender_valign("bottom");
				scr_nesfont_shadow(_disp_dim[0],_disp_dim[1],"LEFT MOUSE (HOLD): DRAG   SPACEBAR: PLACE/nBACKSPACE: CANCEL   DEL: REMOVE",false,c_white,global._lode_textshadow_color);
				scr_textrender_halign("left");
				scr_textrender_valign("top");
			}
			
			if(_savepopup){
				draw_set_color(c_black);
				draw_set_alpha(0.6);
				draw_rectangle(floor(_disp_dim[0]/2)-126,floor(_disp_dim[1]/2)-64,floor(_disp_dim[0]/2)+126,floor(_disp_dim[1]/2)+64,false);
				draw_set_alpha(1);
				draw_set_color(c_white);
				scr_textrender_halign("center");
				scr_textrender_valign("middle");
				scr_textrender_type(floor(_disp_dim[0]/2),floor(_disp_dim[1]/2),scr_wordwrap("Level saved to\n"+string_replace_all(game_save_id+_dir, "\\","/")+"\nFile path has been copied to the clipboard\nLeft Click to remove this popup", 200, "\n", true));
				scr_textrender_halign("left");
				scr_textrender_valign("top");
			}
			
			if(global._showHitbox){
				draw_set_alpha(0.45);
				draw_set_color(c_black);
				draw_rectangle(0,0,WIDTH,HEIGHT,false);
				draw_set_color(c_white);
				draw_set_alpha(1);
			}
			
			if(_editor_help){
				//editor help
				draw_set_color(c_black);
				draw_rectangle(0,0,_disp_dim[0],_disp_dim[1],false);
				draw_set_color(c_white);
				var lines = [
					"HELP:",
					"(E) - Tiles",
					"(MIDDLE MOUSE) - Select tiles",
					"(CTRL+A) - Select all tiles",
					"(WASD) - Move camera",
					"(SHIFT+A/D) - Subtract/Add stage WIDTH",
					"(SHIFT+W/S) - Subtract/Add stage HEIGHT",
					"(CTRL+S) - Save stage to game save directory",
					"(CTRL+L) - Load stage from a .json",
					"(ENTER) - Test the current stage",
					"\n",
					"Press F1 to close this",
				];
				scr_textrender_type(0,0,string_upper(string_join_ext("\n",lines)));
			}
			
			//draw help screen
			if(_howto_act > 0){
				draw_set_alpha(clamp(_howto_bg_alp,0,1));
				draw_set_color(c_black);
				draw_rectangle(0,0,_disp_dim[0],_disp_dim[1],false);
				
				draw_set_alpha(1);
				draw_rectangle(_howto_bbox[0],_howto_bbox[1],_howto_bbox[2],_howto_bbox[3],false);
				draw_set_color(c_white);
				draw_rectangle(_howto_bbox[0],_howto_bbox[1],_howto_bbox[2],_howto_bbox[3],true);

				if(_howto_page > 0){
					draw_sprite_ext(spr_lode_howto_side,0,_howto_bbox[0]-18,_howto_pos[1],-1,1,0,c_white,1);
					scr_nesfont_shadow(_howto_bbox[0],_howto_bbox[3]+4,string_upper(key_to_string(global._input[global._inptype][? "left"]))+": Previous page", false, c_white, global._lode_textshadow_color);
				}
				if(_howto_page < array_length(_howto_text)-1){
					scr_textrender_valign("bottom");
					scr_nesfont_shadow(_howto_bbox[0],_howto_bbox[1]-4,string_upper(key_to_string(global._input[global._inptype][? "confirm"]))+": Close", false, c_white, global._lode_textshadow_color);
					scr_textrender_valign("top");
					
					scr_textrender_halign("right");
					scr_nesfont_shadow(_howto_bbox[2],_howto_bbox[3]+4,string_upper(key_to_string(global._input[global._inptype][? "right"]))+": Next page", false, c_white, global._lode_textshadow_color);
					scr_textrender_halign("left");
				} else {
					scr_textrender_halign("right");
					scr_nesfont_shadow(_howto_bbox[2],_howto_bbox[3]+4,string_upper(key_to_string(global._input[global._inptype][? "right"]))+": Close", false, c_white, global._lode_textshadow_color);
					scr_textrender_halign("left");
				}
				
				draw_sprite_ext(spr_lode_howto_side,0,_howto_bbox[2]+18,_howto_pos[1],1,1,0,c_white,1);
				
				draw_sprite(spr_lode_howto_logo,0,_howto_pos[0],_howto_bbox[1]+8);
				draw_sprite(spr_lode_howto_gfx,_howto_page,_howto_pos[0],_howto_pos[1]);
				
				scr_textrender_halign("center");
				scr_textrender_valign("middle");
				scr_nesfont_shadow(_howto_pos[0]+4,_howto_pos[1],_howto_text_wrapped[_howto_page], false, c_white, global._lode_textshadow_color);
				scr_textrender_halign("left");
				scr_textrender_valign("top");
			}
			
			//draw screen transition
			if(_tr_draw){
				if(_tr_type == "in"){
					draw_set_color(c_black);
					draw_rectangle(0, floor(_disp_dim[1]*0.5)-((_disp_dim[1]*0.5)*_tr_scale[0]),_disp_dim[0],floor(_disp_dim[1]*0.5)+((_disp_dim[1]*0.5)*_tr_scale[0]), false);
					draw_set_color(c_white);
					draw_sprite_ext(spr_lode_static,_tr_img%3,0,floor(_disp_dim[1]*0.5),1,_tr_scale[1],0,c_white,1);
				} else if(_tr_type == "out"){
					draw_set_alpha(clamp(_tr_alp,0,1));
					draw_set_color(c_black);
					draw_rectangle(0, 0, _disp_dim[0], _disp_dim[1], false);
					draw_set_color(c_white);
					draw_set_alpha(1);
				}
			}
			
			if(_tr_exit_act >= 2){
				draw_set_color(c_black);
				draw_rectangle(0, floor(_disp_dim[1]*0.5)-((_disp_dim[1]*0.5)*_tr_exit_scale),_disp_dim[0],floor(_disp_dim[1]*0.5)+((_disp_dim[1]*0.5)*_tr_exit_scale), false);
				draw_set_color(c_white);
			}
			
			/*draw_set_color(c_green);
			draw_set_alpha(0.45);
			draw_rectangle(global._lode_cullingbox[0],global._lode_cullingbox[1],global._lode_cullingbox[2],global._lode_cullingbox[3],false);
			draw_set_color(c_white);
			draw_set_alpha(1);*/
			
			surface_reset_target();
			
			//draw surfaces
			if(!global._lode_editor){
				draw_surface_stretched_ext(_display,6,6,WIDTH,HEIGHT,c_black,0.32);
			}
			draw_surface_stretched(_display,0,0,WIDTH,HEIGHT);
		} else {
			_display = surface_create(_disp_dim[0],_disp_dim[1]);
		}
	}
	
	scr_textrender_switchfont(global._defaultFont);
	gpu_set_texfilter(global._texfilter);
}