{
	if(global._lode_stages != undefined && global._lode_stages != -1){
		ds_map_destroy(global._lode_stages);
		global._lode_stages = -1;
	}
}