{
	if(_active){
		//draw fog
		var dsmapkeys = ds_map_keys_to_array(_fogmap);
		for(var i = 0; i < array_length(dsmapkeys); i++){
			var curind = _fogmap[? dsmapkeys[i]];
			draw_sprite_ext(spr_st2_fog,curind[0],curind[1],curind[2], 1.8, 1.8, 0, image_blend,clamp(0,curind[4],0.22));
		}
	}
}