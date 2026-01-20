{
	//FUCK interpolation. all my homies HATE interpolation
	function int_off(){
		gpu_set_texfilter(false);
	}
	function int_on(){
		gpu_set_texfilter(global._texfilter);
	}
	
	var intoff_layers = ["lvtiles2","main2","path2","seamless_spots"];
	if(global._tutorial){
		array_push(intoff_layers,"lvbg1","lv_parallaxbg1");
	}
	
	for(var i = 0; i < array_length(intoff_layers); i++){
		layer_script_begin(intoff_layers[i], int_off);
		layer_script_end(intoff_layers[i], int_on);
	}
}