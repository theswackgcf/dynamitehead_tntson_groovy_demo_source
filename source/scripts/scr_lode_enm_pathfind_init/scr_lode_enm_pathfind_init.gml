function scr_lode_enm_pathfind_init(){
	if(_ignore_pathfinding <= 0){
		for(var yy = 0; yy < array_length(global._stage_layout[0]); yy++){
			for(var xx = 0; xx < array_length(global._stage_layout[0][yy]); xx++){
				_path_array[yy][xx] = -1;
			}
		}
			
		with(obj_lode_followbox){
			if(_parentobj.id == other.id){
				instance_destroy();
			}
		}
			
		_pathinit = true;
	}
}