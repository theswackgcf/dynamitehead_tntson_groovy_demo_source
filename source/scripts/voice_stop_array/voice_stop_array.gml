///function voice_stop_array(array)
function voice_stop_array(array){
	for(var i = 0; i < array_length(array); i++){
		voice_stop(array[i]);
	}
}