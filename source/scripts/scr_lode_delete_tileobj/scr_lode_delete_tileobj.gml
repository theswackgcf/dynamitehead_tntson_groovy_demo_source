function scr_lode_delete_tileobj(){
	if(_tilelayer != -1){
		if(global._stage_layout[_tilelayer][_tilepos[0]][_tilepos[1]] != _curtile){
			instance_destroy();
		}
	}
}