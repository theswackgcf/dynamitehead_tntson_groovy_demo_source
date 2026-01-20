{
	if(!_init){
		var layerid = layer_get_id(_layer);
		if(layer_exists(layerid)){
			_assets = layer_get_all_elements(layerid);
		} else {
			_assets = [];
		}

		_init = true;
	}
	
	if(!global._pause){
		if(place_meeting(x,y,obj_dh_mask)){
			if(_alpha > 0){
				_alpha -= 0.08;
			}
		} else {
			if(_alpha < 1){
				_alpha += 0.08;
			}
		}
	}
	
	_alpha = clamp(_alpha,0,1);
	
	for (var i = 0; i < array_length(_assets); i++){
		layer_sprite_alpha(_assets[i], _alpha);
	}
}