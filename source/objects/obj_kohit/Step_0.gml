{
	depth = 9900;
	
	if(global._kohit > 0 && !global._kdeffect){
		global._kohit = 0;
	}
	
	if(!global._pause){
		if(global._contrasthit > 0){
			global._seteffect = 2;
			global._effect = EFFECT_CONTRAST;
			
			global._contrasthit_val -= 0.02;
			if(global._contrasthit_val <= 1){
				global._contrasthit_val = 1;
			}
			
			global._contrasthit --;
		} else {
			if(global._seteffect <= 0){
				global._contrasthit_val = 1.2;
			}
		}
	}
	
	if(global._kohit > 0){
		if(!global._pause){
			global._kohit --;
		}
		if(!_init){
			var layers = layer_get_all();
			for(var i = 0; i < array_length(layers); i++){
				var l = layers[i];
				if(!string_starts_with(layer_get_name(l),"Instances")){
					if(string_starts_with(layer_get_name(l),"secret")){
						_storevisib[? layer_get_name(l)] = layer_get_visible(l);
					}
					layer_set_visible(l, false);
				}
			}
			
			_init = true;
		} else {
			with(all){
				image_blend = make_color_rgb(3, 3, 3);
			}
			if(global._kohit <= 1){
				global._kohit_after = 2;
			}
		}
	} else {
		if(_init){
			global._kohit_after = 2;
			var layers = layer_get_all();
			for(var i = 0; i < array_length(layers); i++){
				var l = layers[i];
				if(!string_starts_with(layer_get_name(l),"Instances")){
					layer_set_visible(l, true);
					if(string_starts_with(layer_get_name(l),"secret")){
						if(ds_map_exists(_storevisib, layer_get_name(l))){
							layer_set_visible(l, _storevisib[? layer_get_name(l)]);
						}
					}
				}
			}
			with(all){
				image_blend = c_white;
			}
			_init = false;
		}
		
		_checktimer ++;
		if(_checktimer >= 4){
			with(all){
				if(image_blend == make_color_rgb(3, 3, 3)){
					image_blend = c_white;
				}
			}
			_checktimer = 0;
		}
	}
}