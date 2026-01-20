{
	depth = 9900;
	
	if(global._kohit > 0 && !global._kdeffect){
		global._kohit = 0;
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
				image_blend = c_black;
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
	}
}