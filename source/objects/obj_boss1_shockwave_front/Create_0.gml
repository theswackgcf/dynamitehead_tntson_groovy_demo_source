{
	_allsounds = ds_map_create();
	
	_timer = 0;
	_alp = 1;
	_scale = 0.1;
	
	_shtime = 0;
	_shframe = 0;
	
	_shockback = instance_create_depth(x, y, 0, obj_boss1_shockwave_back);
	_shockback._parentobj = self;
	
	image_xscale = _scale;
	image_yscale = _scale;
}