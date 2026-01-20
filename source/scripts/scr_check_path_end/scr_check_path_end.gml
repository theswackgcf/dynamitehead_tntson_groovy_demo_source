///function scr_check_path_end(path, x_cell, y_cell){
function scr_check_path_end(path){
	if(path_get_length(path) > 0 && path_get_length(path) < WIDTH*2.8){
		return true;
	} else {
		return false;
	}
}