{
	if(global._sequenceLayers != undefined){
		ds_map_destroy(global._sequenceLayers);
		global._sequenceLayers = -1;
	}
	
	if(global._sequenceColors != undefined){
		ds_map_destroy(global._sequenceColors);
		global._sequenceColors = -1;
	}
}