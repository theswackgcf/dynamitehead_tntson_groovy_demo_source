///function sfx_stop_array(array)
function sfx_stop_array(array){
	for(var i = 0; i < array_length(array); i++){
		sfx_stop(array[i]);
	}
}