function scr_enemyscript_display(type){
	if(type == "create"){
		_shadowmult = 1;
	
		_scale = 1;
		_xscale = _scale;
		_yscale = _scale;
		
		image_xscale = global._scale;
		image_yscale = global._scale;
	
		_height = 0;
	
		_shakeX = 0;
		_shakeY = 0;
	
		_offset = [0,42];
	
		_colorblend = 0;
	
		_sort = true;
		_depthoffset = 0;
	
		_forcedepth = 0;
	
		//parent mask object
		_parentobj = noone;
		
		//set occupy id
		_occupy_id = "";
		_letr = global._occupyCharset;
		for(var i = 0; i < 7; i++){
			_occupy_id += string_char_at(_letr, round(random_range(1, string_length(_letr))));
		}
		
		_shadowsinit = false;
		
		function drawrect (xx, yy, colind, array) {
			var curarray = [];
			if(array == 0){
				curarray = _parentobj._mult_colorinArray;
			} else if(array == 1){
				curarray = _parentobj._mult_coloroutArray;
			}
			var col = make_color_rgb(curarray[colind]*255,curarray[colind+1]*255,curarray[colind+2]*255);
			draw_set_color(col);
			draw_rectangle(xx,yy,xx+16,yy+16,false);
			draw_set_color(#FFFFFF);
		}
	}
	if(type == "step"){
		if(_parentobj != noone && instance_exists(_parentobj)){
			if(_parentobj._holdframetimer <= 0){
				_parentobj._holdframe = [sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha];
			} else {
				_parentobj._holdframetimer --;
			}
		}
		
		_scale = global._scale;
	
		var _dispscale_spd = 0.16;
		_parentobj._dispscale[0] = lerp(_parentobj._dispscale[0], 1, _dispscale_spd);
		_parentobj._dispscale[1] = lerp(_parentobj._dispscale[1], 1, _dispscale_spd);
	
		image_xscale = _xscale * _scale * _parentobj._dispscale[0];
		image_yscale = _yscale * _scale * _parentobj._dispscale[1];
		_height = _parentobj._height;
		if(_parentobj != noone){
			x = _parentobj.x + _offset[0];
			y = (_parentobj.y + _offset[1]);
		}
	}
	if(type == "draw"){
		if(_parentobj._draw_display){
			if(!_shadowsinit){
				//shadows
				global._gameshadows[? _occupy_id] = ds_map_create();
				global._gameshadows[? _occupy_id][? "draw"] = false;
				global._gameshadows[? _occupy_id][? "x"] = x+_parentobj._shadowoffset[0];
				global._gameshadows[? _occupy_id][? "y"] = y+_parentobj._shadowoffset[1];
				global._gameshadows[? _occupy_id][? "scalex"] = 1;
				global._gameshadows[? _occupy_id][? "scaley"] = 1;
			
				_shadowsinit = true;
			}
		
			if(ds_map_exists(global._gameshadows,_occupy_id)){
				if(_parentobj != noone && instance_exists(_parentobj)){
					if(_parentobj._holdframetimer <= 0){
						global._gameshadows[? _occupy_id][? "draw"] = false;
					}
				}
			}
			if(_parentobj != noone && instance_exists(_parentobj)){
				var drawshader = false;
				if(_parentobj._docolors || (_parentobj._difftype && !_parentobj._recolorstop)){
					drawshader = true;
				}
			
				if(!_parentobj._sequence_finished && !global._sequenceInfo[? _parentobj._sequence_id].anim_finish){
					if(ds_map_exists(global._sequenceLayers, _parentobj._seqid) && layer_exists(global._sequenceLayers[? _parentobj._seqid]) && layer_sequence_exists(global._sequenceLayers[? _parentobj._seqid], _parentobj._sequence)){
						if(global._sequenceInfo[? _parentobj._sequence_id].show_shadow){
							var offsy = floor((_parentobj._displayobj).sprite_height/4);
							if(!global._sequenceInfo[? _parentobj._sequence_id].do_arc){
								offsy = 0;
							}
							var drawy;
							var drawx;
							var dodraw;
						
							//draw shadow depending on the hop object position
							if(_parentobj._sequence_hop_obj == noone || !instance_exists(_parentobj._sequence_hop_obj)){
								dodraw = false;
							} else {
								_shadowmult = clamp(0, 1-(abs(_parentobj._sequence_hop_obj._hop_arc)/((_parentobj._sequence_hop_obj._seqhop_archeight+2)/2)), 1);	
								
								drawx = _parentobj._sequence_hop_obj.x;
								if(!global._sequenceInfo[? _parentobj._sequence_id].do_arc){
									drawy = _parentobj._sequence_hop_obj.y+offsy;
								} else {
									drawy = _parentobj._sequence_hop_obj._hop_base_y+offsy;
								}
								
								dodraw = true;
							}
						
							if(dodraw && _shadowsinit && ds_map_exists(global._gameshadows,_occupy_id)){
								global._gameshadows[? _occupy_id][? "draw"] = _parentobj._haveshadow;
								global._gameshadows[? _occupy_id][? "x"] = drawx+_parentobj._shadowoffset[0];
								global._gameshadows[? _occupy_id][? "y"] = drawy+_parentobj._shadowoffset[1];
								global._gameshadows[? _occupy_id][? "scalex"] = _parentobj._shadowsize*_shadowmult;
								global._gameshadows[? _occupy_id][? "scaley"] = _parentobj._shadowsize*_shadowmult;
						
								if(variable_instance_exists(_parentobj,"_hn_crucified")){
									if(_parentobj._hn_crucified){
										global._gameshadows[? _occupy_id][? "draw"] = false;
									}
								}
							}
						}
					}
				}
				if(_parentobj._startTimer <= 0 && _parentobj._sequence_finished && _parentobj._nohopobj){
					if(global._debug && global._showHitbox){
						if(_parentobj._drawifmoving > 0){
							draw_set_color(#FFFF00);
							draw_set_alpha(0.6);
							draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
							draw_set_color(#FFFFFF);
							draw_set_alpha(1);
						}
					}
				
					//draw shadow
					if(!_parentobj._grabbed){
						if(_parentobj._curstate != STATE_JUMP){
							_shadowmult = clamp(0, 1-((_parentobj._height+_parentobj._heightoffset)/HEIGHT), 1);
						} else {
							var arc = _parentobj._hop_arc;
							var arch = (_parentobj._hop_archeight+2)/2;
							_shadowmult = clamp(0, 1-(abs(arc)/arch), 1);
						}
						if(_shadowsinit){
							if(ds_map_exists(global._gameshadows,_occupy_id)){
								global._gameshadows[? _occupy_id][? "draw"] = _parentobj._haveshadow;
								global._gameshadows[? _occupy_id][? "x"] = x+_parentobj._dispoffset[0]+_parentobj._shadowoffset[0];
								global._gameshadows[? _occupy_id][? "y"] = y+_parentobj._shadowoffset[1];
								global._gameshadows[? _occupy_id][? "scalex"] = _parentobj._shadowsize*_shadowmult;
								global._gameshadows[? _occupy_id][? "scaley"] = _parentobj._shadowsize*_shadowmult;
							
								if(_parentobj._phaseend_act >= 3){
									global._gameshadows[? _occupy_id][? "draw"] = false;
								}
								if(variable_instance_exists(_parentobj,"_hn_crucified")){
									if(_parentobj._hn_crucified){
										global._gameshadows[? _occupy_id][? "draw"] = false;
									}
								}
							}
						}
					}
		
					//set color of sprite
					_colorblend = make_color_rgb(_parentobj._fadeCol[0],_parentobj._fadeCol[1],_parentobj._fadeCol[2]);
					if(global._kohit > 0){
						_colorblend = c_black;
					}
		
					//draw sprite
					if(_parentobj._freeze > 0){
						image_speed = 0;
					}
		
					if(!global._pause && global._blowup_kill > 0 && _parentobj._freeze > 0){
						_shakeX = random_range(-6,6);
						_shakeY = random_range(-6,6);
					}
		
					var posx = x+_shakeX;
					var posy = y-_height+_shakeY;
		
					if(_parentobj._curstate != STATE_JUMP && _parentobj._grabbed){
						posx = _parentobj._grabDrawX;
						posy = _parentobj._grabDrawY;
			
						if(!_parentobj._slam){
							_depthoffset = 20;
						} else {
							_depthoffset = -20;
						}
					} else {
						_depthoffset = 0;
					}
					if(_parentobj._parachute){
						_depthoffset = HEIGHT;
					}
					if(variable_instance_exists(_parentobj,"_hn_crucified") && _parentobj._hn_crucified){
						_depthoffset = -200;
					}
		
					function drawSprite(posx,posy){
						if(_parentobj._holdframetimer <= 0){
							//additional offset
							var addxamp = 0;
							var addxoffs = 0;
					
							if(_parentobj._grabbed){
								addxamp = (_parentobj._grabresist/_parentobj._grabresist_curtimer)*16;
								addxoffs = sin(random(480))*addxamp;
								if(_parentobj._slam){
									addxamp = 0;
									addxoffs = 0;
								}
							}
					
							if(_parentobj._successparry > 0){
								addxoffs = random_range(-10,10);
							}
						
							if(_parentobj._stunlock_after > 0 && _parentobj._anim == "ricochet"){
								addxoffs = sin(random(480))*(_parentobj._stunlock_after/1.5);
							}
						
							if(global._pause){
								addxoffs = 0;
							}
					
							var arc = _parentobj._hop_arc;
					
							_parentobj._dispangle = image_angle;
							if(_parentobj._parachute){
								var timdiv = 12;
								_parentobj._dispoffset[0] = sin(_parentobj._sintimer/timdiv)*32;
								_parentobj._dispangle = sin(_parentobj._sintimer/timdiv)*24;
								_parentobj._shadowoffset[0] = sin(_parentobj._sintimer/timdiv)*96;
							}
					
							if(sprite_exists(sprite_index)){
								draw_sprite_ext(sprite_index, image_index, posx+_parentobj._dispoffset[0]+addxoffs, posy+_parentobj._dispoffset[1]+_parentobj._heightoffset+arc, image_xscale, image_yscale, _parentobj._dispangle, _colorblend, image_alpha);
							} else {
								var addanim = "_idle";
								if(_parentobj._boss){
									addanim = "_idle1";
								}
								draw_sprite_ext(asset_get_index("spr_"+string(_parentobj._codename)+addanim), image_index, posx+_parentobj._dispoffset[0]+addxoffs, posy+_parentobj._dispoffset[1]+_parentobj._heightoffset+arc, image_xscale, image_yscale, _parentobj._dispangle, _colorblend, image_alpha);
							}
						}
						//pissed off effect
						if((_parentobj._curstate == STATE_IDLE || _parentobj._curstate == STATE_WALK || _parentobj._curstate == STATE_FOLLOW || _parentobj._attack) && !_parentobj._fall_ko && _parentobj._height <= _parentobj._groundlevel && !_parentobj._death && _parentobj._taunt <= 0 && _parentobj._pissedoff > 0){
							var spd = 0;
							switch(_parentobj._pissedoff_int){
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
							draw_sprite_ext(spr_p_angryicon, (_parentobj._pissedoff_icontimer*spd)%6, posx+_parentobj._dispoffset[0]+addxoffs+(_parentobj._pissedoff_offset[0]*_parentobj._curdir), posy+_parentobj._dispoffset[1]+_parentobj._heightoffset+arc+_parentobj._pissedoff_offset[1], image_xscale, image_yscale, image_angle, _colorblend, image_alpha);
						}
					}
	
					if(_parentobj._colorsinit){
						if(drawshader){
							//draw recolored version	
							var _shdr = asset_get_index("shd_replace_col");
							if(global._buildver == HTML){
								_shdr = asset_get_index("shd_replace_col"+string(_parentobj._maxcolors));
							}
						
							shader_set(_shdr);
				
							shader_set_uniform_i(shader_get_uniform(_shdr, "maxcolors"), _parentobj._maxcolors);
							shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorIn"), _parentobj._mult_colorinArray);
							shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorOut"), _parentobj._mult_coloroutArray);
							shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorTolerance"), _parentobj._mult_tolrArray);
							shader_set_uniform_f_array(shader_get_uniform(_shdr, "blend"), _parentobj._mult_blendArray);
				
							drawSprite(posx,posy);
			
							shader_reset();
						} else {
							//draw default version
							drawSprite(posx,posy);
						}
					} else {
						//draw default version
						drawSprite(posx,posy);
					}
		
					//debug
					if(global._debug && global._showHitbox){
						if(_parentobj._path != 0){
							draw_set_color(#FF0000);
							draw_rectangle(_parentobj._pathgridarea[0],_parentobj._pathgridarea[1],_parentobj._pathgridarea[0]+_parentobj._pathgridarea[2],_parentobj._pathgridarea[1]+_parentobj._pathgridarea[3], true);				
						
							draw_path(_parentobj._path, _parentobj._pathgridarea[0], _parentobj._pathgridarea[1], true);
							var point = [_parentobj._walkto[0]-16,_parentobj._walkto[1]-16,_parentobj._walkto[0]+16,_parentobj._walkto[1]+16];
							draw_set_color(#FFFF00);
							draw_rectangle(point[0],point[1],point[2],point[3],false);
						
							draw_set_color(#00FFFF);
							point = [round((_parentobj._pathpoint[0]-_parentobj._pathgridarea[0])/_parentobj._pathgridsize[0]),round((_parentobj._pathpoint[1]-_parentobj._pathgridarea[1])/_parentobj._pathgridsize[1])];
							draw_rectangle(point[0]-16,point[1]-16,point[0]+16,point[1]+16,false);
							draw_set_color(#FFFFFF);
						
							//draw color squares
							for(var i = 0; i < floor(array_length(_parentobj._mult_colorinArray)/4); i++){
								drawrect((i*16)+x, 48+y, i*4, 0);
							}
							for(var i = 0; i < floor(array_length(_parentobj._mult_coloroutArray)/4); i++){
								drawrect((i*16)+x, 64+y, i*4, 1);
							}
						}
						var follow = "no";
						if(_parentobj._curstate == STATE_FOLLOW){
							follow = "yes";
						}
						scr_textrender_switchfont(global._defaultFont);
						var curstate = "";
						switch(_parentobj._curstate){
							//shitty ass code lmfao
							case STATE_ATTACK:
								curstate = "STATE_ATTACK";
							break;
							case STATE_BLOCK:
								curstate = "STATE_BLOCK";
							break;
							case STATE_FALL:
								curstate = "STATE_FALL";
							break;
							case STATE_FOLLOW:
								curstate = "STATE_FOLLOW";
							break;
							case STATE_IDLE:
								curstate = "STATE_IDLE";
							break;
							case STATE_JUMP:
								curstate = "STATE_JUMP";
							break;
							case STATE_OTHER:
								curstate = "STATE_OTHER";
							break;
							case STATE_SLIDE:
								curstate = "STATE_SLIDE";
							break;
							case STATE_WALK:
								curstate = "STATE_WALK";
							break;
						}
						scr_textrender_type(x+96,y+48,"depth:"+string(depth)+"/add:"+string(_depthoffset)+"/force:"+string(_forcedepth)+"\nai level:"+string(_parentobj._total_ailevel)+"\nfollowing: "+follow+"\nstate: "+string(_parentobj._behaviortype)+"\n_curstate: "+string(curstate)+"\nanim: "+_parentobj._anim+"\nwalktimer: "+string(_parentobj._walktimer)+"\ncolors: "+string(_parentobj._maxcolors)+"\ntype: "+string(_parentobj._enmtype));
				
						draw_set_color(c_aqua);
						draw_rectangle(_parentobj._jumptopos[0],_parentobj._jumptopos[1],_parentobj._jumptopos[0]+16,_parentobj._jumptopos[1]+16,false);
						draw_set_color(c_white);
					}
				}
			
				//draw a temp "hold" sprite
				if(_parentobj._holdframetimer > 0 && _parentobj._colorsinit){
					if(drawshader){
						//draw recolored version	
						var _shdr = asset_get_index("shd_replace_col");
						if(global._buildver == HTML){
							_shdr = asset_get_index("shd_replace_col"+string(_parentobj._maxcolors));
						}
						
						shader_set(_shdr);
				
						shader_set_uniform_i(shader_get_uniform(_shdr, "maxcolors"), _parentobj._maxcolors);
						shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorIn"), _parentobj._mult_colorinArray);
						shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorOut"), _parentobj._mult_coloroutArray);
						shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorTolerance"), _parentobj._mult_tolrArray);
						shader_set_uniform_f_array(shader_get_uniform(_shdr, "blend"), _parentobj._mult_blendArray);
				
						draw_sprite_ext(
						_parentobj._holdframe[0],
						_parentobj._holdframe[1],
						_parentobj._holdframe[2],
						_parentobj._holdframe[3],
						_parentobj._holdframe[4],
						_parentobj._holdframe[5],
						_parentobj._holdframe[6],
						_parentobj._holdframe[7],
						_parentobj._holdframe[8]
						);
			
						shader_reset();
					} else {
						draw_sprite_ext(
						_parentobj._holdframe[0],
						_parentobj._holdframe[1],
						_parentobj._holdframe[2],
						_parentobj._holdframe[3],
						_parentobj._holdframe[4],
						_parentobj._holdframe[5],
						_parentobj._holdframe[6],
						_parentobj._holdframe[7],
						_parentobj._holdframe[8]
						);
					}
				}
			}
		} else {
			if(_shadowsinit){
				if(ds_map_exists(global._gameshadows,_occupy_id)){
					global._gameshadows[? _occupy_id][? "draw"] = false;
				}
			}
		}
	}
	if(type == "destroy"){
		if(ds_map_exists(global._gameshadows, _occupy_id)){
			ds_map_delete(global._gameshadows, _occupy_id);
		}
	}
}