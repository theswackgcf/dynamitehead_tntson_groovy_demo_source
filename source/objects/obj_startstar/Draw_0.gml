{	
	_scalex = global._res[global._curres][0]/WIDTH;
	_scaley = global._res[global._curres][1]/HEIGHT;
	
	//surface
	if(global._kohit <= 0){
		if(_draw){
			if(surface_exists(_surface)){
				surface_set_target(_surface);
			
				//black screen
				draw_set_color(c_white);
				draw_rectangle(0, 0, _surfdim[0], _surfdim[1], false);
			
				//star
				var dh = instance_find(obj_dh_mask,0);
				if(dh != noone && instance_exists(dh)){
					var offset = [0,0];
					if(global._res[global._curres][1] < 400){
						offset = [90,120];;
					}
					if(global._res[global._curres][1] < 300){
						offset = [164,250];;
					}
					draw_sprite_ext(spr_star, 0, ((dh.x+offset[0])-(camera_get_view_x(global._camera))/global._cameraZoom)*_scalex, ((dh.y+offset[1])-(camera_get_view_y(global._camera))/global._cameraZoom)*_scaley, _starscale*_scalex, _starscale*_scaley, _starrot,c_black,1);
				}
			
				surface_reset_target();
			} else {
				_surfdim = [global._res[global._curres][0]+_offset, global._res[global._curres][1]+_offset];
				_surface = surface_create(_surfdim[0], _surfdim[1]);
			}
		}
	
		var drawscale = [WIDTH+global._screenSideOffset,HEIGHT+global._screenSideOffset];
	
		//blendmode
		if(_draw){
			if(global._buildver != HTML){
				gpu_set_blendmode(bm_subtract);
				draw_set_alpha(0);
				draw_surface_stretched(_surface, (camera_get_view_x(global._camera)/global._cameraZoom)+global._screenOffsetX, (camera_get_view_y(global._camera)/global._cameraZoom)+global._screenOffsetY, drawscale[0], drawscale[1]);
				draw_set_alpha(1);
				gpu_set_blendmode(bm_normal);
			}
		}
	}
}