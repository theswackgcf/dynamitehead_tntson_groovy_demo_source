function scr_sequence_pause(){
	if(!_sequence_finished){
		if(ds_map_exists(global._sequenceLayers, _seqid) && layer_exists(global._sequenceLayers[? _seqid])){
			if(layer_sequence_exists(global._sequenceLayers[? _seqid], _sequence)){
				layer_sequence_speedscale(_sequence, clamp((_ailevel/2)*0.6, 1, 1.38));
				
				if(global._pause){
					layer_sequence_pause(_sequence);
				} else {
					layer_sequence_play(_sequence);
				}
			}
		}
	}
}