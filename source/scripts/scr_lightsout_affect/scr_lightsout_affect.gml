function scr_lightsout_affect(){
	with(all){
		if(variable_instance_exists(self.id, "_colorsinit")){
			_colorsinit = false;
		}
	}
	with(obj_fade){
		if(global._lightsout){
			_fade = 1;
			_fadefg = 1;
		} else {
			_fade = 0;
			_fadefg = 0;
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