{
	with(obj_mg_lode){
		//gate handles
		if(ds_map_exists(_project, other._id+"0")){
			ds_map_delete(_project, other._id+"0");
		}
		//gate wall
		if(ds_map_exists(_project, other._id+"1")){
			ds_map_delete(_project, other._id+"1");
		}
	}
}