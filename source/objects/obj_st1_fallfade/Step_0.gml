{
	if(!global._pause){
		image_blend = c_red;
		image_alpha -= 0.1;
		if(image_alpha <= 0){
			instance_destroy();
		}
	}
}