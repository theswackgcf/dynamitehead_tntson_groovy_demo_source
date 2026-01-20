{
	_infoshow = false;
	_infohide = false;
	
	_infotimer = 0;
	_infoscale = 0;
	
	_bosscolor = [
		[0,255,0],
		[255, 199, 15],
	];
	
	_curboss = 1; //global._location;
	_bossinfo = ds_map_create();
	_bossinfo[? 0] = ["frankenbarf", ["380 lbs.","172 kg."], ["7 ft. 8 inch.","2 m. 33 cm."], "5000", "causes havoc on\nthe streets.\napparently has no\nidea what\nhe is doing."];
	_bossinfo[? 1] = ["lanky \"hit it!\" larry", ["127 lbs.","58 kg."], ["7 ft. 3 inch.","2 m. 21 cm."], "10000", "head of the \n\"smile :)\" cartel.\nhigh school dropout.\nwreaks havoc on the\nlocal graveyard."];

	_bossoffset = [-110, 24];
	_boss_hideoffset = 0;

	_text_hideoffset = 0;

	//3d model
	
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_texcoord();
	vertex_format_add_color();
	_vertexformat = vertex_format_end();
	
	_camx = 0;
	_camy = -10;
	_camz = 1.75;
	
	_spin = 55;
	
	_models = [
		"boss2",
		"boss2",
	];
	
	_tempbuffer = vertex_create_buffer();
	
	_camera = camera_create();
	_loadm = buffer_load("./models/"+_models[_curboss]+".buf");
	_model = vertex_create_buffer_from_buffer(_loadm, _vertexformat);
	_barycentric = vertex_buffer_to_wireframe(_model);
	buffer_delete(_loadm);
	
	_surf_divby = 2;
	
	_boss_surface_dim = [WIDTH,HEIGHT];
	_boss_surface = surface_create(_boss_surface_dim[0],_boss_surface_dim[1]);
	
	_boss_surface_resize = surface_create(_boss_surface_dim[0]/_surf_divby,_boss_surface_dim[0]/_surf_divby);
}