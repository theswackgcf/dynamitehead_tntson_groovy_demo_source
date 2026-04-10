function scr_lightsout_affect(){
	with(all){
		if(variable_instance_exists(self.id, "_colorsinit")){
			_colorsinit = false;
		}
	}
	with(obj_fade){
		if(layer_exists(layer_get_id("desaturate"))){
			var desat_layer = layer_get_id("desaturate");
			var params = fx_get_parameters(layer_get_fx(desat_layer));
			var fxval = 0;
		}
		
		if(global._lightsout){
			_fade = 1;
			_fadefg = 1;
			
			fxval = 0;
		} else {
			_fade = 0;
			_fadefg = 0;
			
			fxval = _store_layerfx;
		}
		
		if(layer_exists(layer_get_id("desaturate"))){
			params.g_Intensity = fxval;
			fx_set_parameters(layer_get_fx(desat_layer), params);
		}
		
		var fade = _fade;
		if(_mode == 1){
			fade = _fadefg;
		}
		if(layer_exists("lv_parallaxfg")){
			elements = layer_get_all_elements(layer_get_id("lv_parallaxfg"));
		} else {
			elements = [];
		}
		for(var i = 0; i < array_length(elements); i++){
			if(global._lightsout){
				layer_sprite_blend(elements[i],c_black);
			} else {
				layer_sprite_blend(elements[i], make_color_rgb(255*(1-fade),255*(1-fade),255*(1-fade)));
			}
		}
	}
}