{
	if(surface_exists(_surface)){
		//draw shadows
		surface_set_target(_surface);
		
		draw_clear_alpha(c_black, 0);
		
		var dskeys = ds_map_keys_to_array(global._gameshadows);
		for(var i = 0; i < array_length(dskeys); i++){
			if(ds_map_exists(global._gameshadows,dskeys[i])){
				if(global._gameshadows[? dskeys[i]][? "draw"]){
					var sprtodraw = spr_shadow;
					if(global._lightsout){
						sprtodraw = spr_lv2_itemlight;
					}
					draw_sprite_ext(sprtodraw, 0, global._gameshadows[? dskeys[i]][? "x"]-global._cameraX,global._gameshadows[? dskeys[i]][? "y"]-global._cameraY,global._gameshadows[? dskeys[i]][? "scalex"],global._gameshadows[? dskeys[i]][? "scaley"], 0, c_white, 1);
				}
			}
		}
		surface_reset_target();
		var alp = 0.42;
		if(global._lightsout){
			alp = 1;
		}
		draw_surface_ext(_surface, global._cameraX, global._cameraY, 1, 1, 0, c_white, alp);
	} else {
		_surface = surface_create(_surfdim[0],_surfdim[1]);
	}
}