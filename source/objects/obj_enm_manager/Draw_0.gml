{
	if(global._state == "game"){
		function seq_shader_begin() {
			if(event_type == ev_draw && event_number == 0){
				var _shdr = asset_get_index("shd_replace_col");
				if(global._buildver == HTML){
					_shdr = asset_get_index("shd_replace_col"+string(global._sequenceColors[? layer_get_name(layer)][2]));
				}
			
				shader_set(_shdr);
				
				shader_set_uniform_i(shader_get_uniform(_shdr, "maxcolors"), global._sequenceColors[? layer_get_name(layer)][2]);
				shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorIn"), global._sequenceColors[? layer_get_name(layer)][3]);
				shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorOut"), global._sequenceColors[? layer_get_name(layer)][4]);
				shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorTolerance"), global._sequenceColors[? layer_get_name(layer)][5]);
				shader_set_uniform_f_array(shader_get_uniform(_shdr, "blend"), global._sequenceColors[? layer_get_name(layer)][6]);
			}
		}
	
		function seq_shader_end() {
			if(event_type == ev_draw && event_number == 0){
				shader_reset();
			}
		}
	
		var seqkeys = ds_map_keys_to_array(global._sequenceLayers);
	
		for(var i = 0; i < array_length(seqkeys); i++){
			_codename = global._sequenceColors[? seqkeys[i]][0];
			_enmtype = global._sequenceColors[? seqkeys[i]][1];
		
			if(global._sequenceColors[? seqkeys[i]][7] || (ds_map_exists(global._enemyColors, _codename) && _enmtype != -1)){
				layer_script_begin(global._sequenceLayers[? seqkeys[i]], seq_shader_begin);
				layer_script_end(global._sequenceLayers[? seqkeys[i]], seq_shader_end);
			}
		}
	}	
}