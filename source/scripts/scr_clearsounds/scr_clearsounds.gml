function scr_clearsounds(){
	if(_allsounds != -1){
		var dskeys = ds_map_keys_to_array(_allsounds);
		for(var i = 0; i < array_length(dskeys); i++){
			if(ds_map_exists(_allsounds, dskeys[i]) && !sfx_isplaying(_allsounds[? dskeys[i]])){
				ds_map_delete(_allsounds, dskeys[i]);
			}
		}
	}
}