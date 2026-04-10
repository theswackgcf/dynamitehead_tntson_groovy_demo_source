function scr_lode_overtile(){
	if(global._lode_editor){
		with(obj_mg_lode){
			if(other._tilepos[1] >= _editor_dims_tiles[0] || other._tilepos[0] >= _editor_dims_tiles[1]){
				other._show = false;
			} else {
				other._show = true;
			}
		}
	}
}