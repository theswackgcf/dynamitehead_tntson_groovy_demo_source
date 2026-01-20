{
	if(variable_global_exists("_stickheld")){
		if(global._stickheld != undefined){
			ds_map_destroy(global._stickheld);
			global._stickheld = -1;
		}
	}
	
	if(variable_global_exists("_stickpressed")){
		if(global._stickpressed != undefined){
			ds_map_destroy(global._stickpressed);
			global._stickpressed = -1;
		}
	}
	
	if(variable_global_exists("_stickreleased")){
		if(global._stickreleased != undefined){
			ds_map_destroy(global._stickreleased);
			global._stickreleased = -1;
		}
	}
}