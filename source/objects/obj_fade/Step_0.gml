{
	if(!global._pause){
		if(!_init){
			//store desaturation value at the beginning
			if(layer_exists(layer_get_id("desaturate"))){
				var desat_layer = layer_get_id("desaturate");
				var fx = fx_get_parameters(layer_get_fx(desat_layer));
				fx.g_Intensity = _layerfx_val;
				_store_layerfx = fx.g_Intensity;
				fx_set_parameters(layer_get_fx(desat_layer), fx);
			}
			
			_init = true;
		}
		
		if(global._lightsout){
			_fadeTo = 1;
			_fade = 1;
			_fadeSpd = 1;
			_nolight = true;
		} else {
			if(_nolight){
				_fadeTo = 0;
				_fade = 0;
				_fadeSpd = 1;
				_nolight = false;
			}
		}
		if((global._finalhit > 0 && !global._finalhit_phase) || instance_number(obj_boss_finalko) > 0){
			_fadeTo = 0;
			_fade = 0;
			_fadeSpd = 1;
		}
		
		if(global._switchlights != ""){
			if(global._gametimer % 4 == 0){
				global._lightsout = !global._lightsout;
				
				scr_lightsout_affect();
				
				global._switchlights_act ++;
				if(global._switchlights_act >= 5){
					if(global._switchlights_sound){
						sfx_stop(snd_lightflicker);
					}
					if(global._switchlights == "on"){
						if(global._switchlights_sound){
							sfx_play(snd_light_on);
						}
						global._lightsout = false;
					} else if(global._switchlights == "off"){
						if(global._switchlights_sound){
							sfx_play(snd_light_on);
						}
						global._lightsout = true;
					}
					
					scr_lightsout_affect();
					
					global._switchlights_act = 0;
					global._switchlights = "";
				}
			}
		}
		
		_time ++;
		_fade = _fade + (_fadeTo - _fade) * _fadeSpd;
		_fadefg = _fadefg + (_fadefgTo - _fadefg) * _fadeSpd;
		if(_time % 4 == 0){
			var fade = _fade;
			if(_mode == 1){
				fade = _fadefg;
			}
			var elements
			if(layer_exists("lvfg")){
				elements = layer_get_all_elements(layer_get_id("lvfg"));
			} else {
				var elements = [];
			}
			for(var i = 0; i < array_length(elements); i++){
				layer_sprite_blend(elements[i], make_color_rgb(255*(1-fade),255*(1-fade),255*(1-fade)));
			}
			if(layer_exists("lv_parallaxfg")){
				elements = layer_get_all_elements(layer_get_id("lv_parallaxfg"));
			} else {
				elements = [];
			}
			for(var i = 0; i < array_length(elements); i++){
				layer_sprite_blend(elements[i], make_color_rgb(255*(1-fade),255*(1-fade),255*(1-fade)));
			}
			with(obj_st2_grass){
				_colfade = make_color_rgb(255*(1-fade),255*(1-fade),255*(1-fade));
			}
			with(obj_st2_graves){
				_colfade = make_color_rgb(255*(1-fade),255*(1-fade),255*(1-fade));
			}
		}
	}
	
	x = global._cameraX;
	y = global._cameraY;
	depth = 9980;
	image_alpha = _fade;
}