{
	if(!_colorsinit){
		if(global._tutorial){
			_rep = "st0";
		} else {
			_rep = "st"+string(global._location+1);
		}
		makecolors("def",_rep);
		
		with(obj_tnt){
			_docolors = true;
			_mult_colorinArray = other._mult_colorinArray;
			_mult_coloroutArray = other._mult_coloroutArray;
			_mult_tolrArray = other._mult_tolrArray;
			_mult_blendArray = other._mult_blendArray;
		}
		
		_outline_col = _parentobj._hpcolor;
		
		_colorsinit = true;
	}
	
	if(_shadowsinit){
		if(ds_map_exists(global._gameshadows,_occupy_id)){
			global._gameshadows[? _occupy_id][? "draw"] = false;
		}
	}
	
	if(_parentobj._init){
		_shadowmult = clamp(0, 1-(_parentobj._height/HEIGHT), 1);
		if(_shadowsinit){
			if(ds_map_exists(global._gameshadows,_occupy_id)){
				global._gameshadows[? _occupy_id][? "draw"] = true;
				global._gameshadows[? _occupy_id][? "x"] = x+_shadowoffset[0];
				global._gameshadows[? _occupy_id][? "y"] = y-_groundlevel+_shadowoffset[1];
				global._gameshadows[? _occupy_id][? "scalex"] = global._defShadowSize*_shadowmult;
				global._gameshadows[? _occupy_id][? "scaley"] = global._defShadowSize*_shadowmult;
			}
		}
	
		var crouchOffset = 0;
		if(_parentobj._crouch || _parentobj._dead){
			crouchOffset = 64;
		}
	
		if(global._showHitbox){
			if(_parentobj._parrytimer > 0){
				draw_set_color(c_green);
				draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
				draw_set_color(c_white);
			}
		}
	
		if(global._tntjuice >= global._tntjuice_max){
			draw_sprite_ext(spr_dh_sparkling_back, -1, x, (y-_height)+crouchOffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		}
			
		if(_colorsinit){
			var sptodraw = sprite_index;
			if(_parentobj._anim == "idle" && global._tutorial){
				sptodraw = asset_get_index("spr_"+_parentobj._codename+"_idle_tutr");
			}
			
			if(_parentobj._phasehit > 0){
				var kickobj = _parentobj._kickass_obj;
				if(kickobj != noone && instance_exists(kickobj)){
					draw_sprite_ext(kickobj.sprite_index, kickobj.image_index, x+_parentobj._dispoffset[0], y+_parentobj._dispoffset[1]-_height, kickobj.image_xscale, kickobj.image_yscale, 0, c_white, 1);
				}
			} else {
				if(_outline_alp > 0){
					scr_draw_outline(sptodraw, image_index, x+_parentobj._dispoffset[0], y+_parentobj._dispoffset[1]-_height, image_xscale, image_yscale, image_angle, c_white, _outline_alp, [color_get_red(_outline_col)*0.86,color_get_green(_outline_col)*0.86,color_get_blue(_outline_col)*0.86],(5.6+(sin(_outline_timer/8)*3))*_outline_dist);
				}
			}
			
			var _shdr = asset_get_index("shd_replace_col");
			if(global._buildver == HTML){
				_shdr = asset_get_index("shd_replace_col"+string(_maxcolors));
			}
				
			shader_set(_shdr);
				
			shader_set_uniform_i(shader_get_uniform(_shdr, "maxcolors"), _maxcolors);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorIn"), _mult_colorinArray);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorOut"), _mult_coloroutArray);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorTolerance"), _mult_tolrArray);
			shader_set_uniform_f_array(shader_get_uniform(_shdr, "blend"), _mult_blendArray);
				
			if(global._bigpunch > 0){
				_parentobj._shield = false;
				_parentobj._dispoffset[0] = sin(random(480))*_parentobj._bigpunch_amp;
			}
			if(_parentobj._shield){
				var fireoffset = [32*_parentobj._curdir,-175];
				if(_parentobj._height >_groundlevel){
					fireoffset[0] = -32*_parentobj._curdir;
				}
				draw_sprite_ext(asset_get_index("spr_"+_parentobj._codename+"_block_fire"), image_index, x+_parentobj._dispoffset[0]+fireoffset[0], y+_parentobj._dispoffset[1]-_height+fireoffset[1], image_xscale*(_parentobj._shieldpower+0.4), image_yscale*(_parentobj._shieldpower+0.4), image_angle, image_blend, image_alpha*_parentobj._invalpha);
			}
			
			draw_sprite_ext(sptodraw, image_index, x+_parentobj._dispoffset[0], y+_parentobj._dispoffset[1]-_height, image_xscale, image_yscale, image_angle, image_blend, image_alpha*_parentobj._invalpha);
			
			shader_reset();
		}
		if(global._tntjuice >= global._tntjuice_max){
			draw_sprite_ext(spr_dh_sparkling_front, -1, x+_shadowoffset[0], (y-_height)+crouchOffset, image_xscale, image_yscale, image_angle, image_blend, image_alpha*_parentobj._invalpha);
		}
	}
	
	//debug
	if(global._showHitbox){
		scr_textrender_switchfont("dh_font1");
		for(var i = 0; i < array_length(_parentobj._doublekickcheck); i++){
			scr_textrender_type(_parentobj.x + _parentobj._doublekickcheck[i][0][0], _parentobj.y + _parentobj._doublekickcheck[i][0][1], string(_parentobj._doublekickbools[i]));
		    draw_rectangle(_parentobj.x + _parentobj._doublekickcheck[i][0][0], _parentobj.y + _parentobj._doublekickcheck[i][0][1], _parentobj.x + _parentobj._doublekickcheck[i][1][0], _parentobj.y + _parentobj._doublekickcheck[i][1][1], true);
		}
		scr_textrender_type(x+96,y+48,"depth:"+string(depth));
	}
}