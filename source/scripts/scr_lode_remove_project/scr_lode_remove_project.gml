function scr_lode_remove_project(){
	with(obj_mg_lode){
		if(ds_map_exists(_project, other._id)){
			ds_map_delete(_project, other._id);
		}
	}
}