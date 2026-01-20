{
	//lerping
	if(!global._pause){
		for(var j = 0; j < array_length(_color); j++){
			for(var i = 0; i < array_length(_color[j]); i++){
				_color[j][i] = lerp(_color[j][i], _colorTo[j][i], _spd);
				_color[j][i] = round(_color[j][i]);
			}
		}
	}
	
	_scalex = global._res[global._curres][0]/WIDTH;
	_scaley = global._res[global._curres][1]/HEIGHT;
	
	//surface
	if(global._buildver != HTML){
		if(global._kohit <= 0 && !global._lightsout){
			_offtimer = 0;
			_ontimer ++;
			if(_ontimer < 2){
				draw_set_color(c_black);
				draw_rectangle(-256, -256, WIDTH+256, HEIGHT+256, false);
				draw_set_color(c_white);
			}
			if(_draw){
				if(surface_exists(_surface)){
					surface_set_target(_surface);
			
					//black screen
					draw_set_color(make_color_rgb(_color[0][0], _color[0][1], _color[0][2]));
					draw_rectangle(0, 0, _surfdim[0], _surfdim[1], false);
			
					//light
			
					with(obj_lightsource){
						var lighting = instance_find(obj_lighting, 0);
						var camzoom = instance_find(obj_camera,0)._cameraZoom;
						if(camzoom <> 0){
							draw_sprite_ext(sprite_index, image_index, (x - global._cameraX)*other._scalex/camzoom, (y - global._cameraY)*other._scaley/camzoom, image_xscale*other._scalex/camzoom, image_yscale*other._scaley/camzoom, image_angle, make_color_rgb(lighting._color[1][0], lighting._color[1][1], lighting._color[1][2]), 1);
						}
					}
				
					if(_thunderalp > 0){
						draw_set_alpha(_thunderalp);
						draw_set_color(c_black);
						draw_rectangle(0, 0, _surfdim[0], _surfdim[1], false);
						draw_set_alpha(1);
					}
				
					if(global._lightstop || global._seteffect > 0){
						draw_set_color(c_black);
						draw_rectangle(0, 0, _surfdim[0], _surfdim[1], false);
					}
			
					draw_set_color(c_white);
			
					surface_reset_target();
				} else {
					_surfdim = [global._res[global._curres][0], global._res[global._curres][1]];
					_surface = surface_create(_surfdim[0], _surfdim[1]);
				}
				if(diff(_color[0][0],_colorTo[0][0]) < 8 && _colorTo[0][0] == 0){
					_draw = false;
				}
			}
	
			var drawscale = [WIDTH,HEIGHT];
	
			//blendmode
			if(_draw){
				gpu_set_blendmode(bm_subtract);
				draw_surface_stretched(_surface, global._screenOffsetX, global._screenOffsetY, drawscale[0], drawscale[1]);
				gpu_set_blendmode(bm_normal);
			}
		}
		if(global._kohit <= 0 && global._lightsout){
			_ontimer = 0;
			_offtimer ++;
			if(_offtimer < 2){
				draw_set_color(c_black);
				draw_rectangle(-256, -256, WIDTH+256, HEIGHT+256, false);
				draw_set_color(c_white);
			}
		}
	
		if(!_draw){
			if(surface_exists(_surface)){
				surface_free(_surface);
			}
		}
	}
}