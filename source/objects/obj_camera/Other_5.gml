{
	if(variable_global_exists("_camera") && global._camera != undefined){
		camera_destroy(global._camera);
	}
}