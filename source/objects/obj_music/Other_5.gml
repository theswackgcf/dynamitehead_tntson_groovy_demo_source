{
	if(variable_global_exists("_musicPos") && global._musicPos != undefined){
		ds_map_destroy(global._musicPos);
		global._musicPos = -1;
	}
	
	if(variable_global_exists("_loops") && global._loops != undefined){
		ds_map_destroy(global._loops);
		global._loops = -1;
	}
}