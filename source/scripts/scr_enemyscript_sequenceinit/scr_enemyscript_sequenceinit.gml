function scr_enemyscript_sequenceinit(){
	_sequence_finished = false;
	_sequence_act = 0;
	
	_stuntimer = 0;
	_scrclear_happened = false;
	_scrcleartimer = 0;
	_freeze = 0;
	_scrclear = false;
	
	_mashed = false;
	_mashedobj = noone;
	
	_shockwave = false;
	
	if(ds_map_exists(global._sequenceLayers, _seqid)){
		ds_map_delete(global._sequenceLayers, _seqid);
		layer_sequence_headpos(_sequence, 0);
	}
	if(ds_map_exists(global._sequenceLayers, _seqid) && layer_exists(global._sequenceLayers[? _seqid])){
		layer_destroy(global._sequenceLayers[? _seqid]);
	}
}