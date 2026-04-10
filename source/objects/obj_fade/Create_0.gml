{
	_allsounds = ds_map_create();
	
	_init = false;
	
	_time = 0;
	_fade = 0;
	_fadeTo = 0;
	_fadeSpd = 0;
	_fadefg = 0;
	_fadefgTo = 0;
	_mode = 0;
	
	_nolight = false;
	
	_surfdim = [sprite_width*image_xscale, sprite_height*image_yscale];
	_surface = surface_create(_surfdim[0], _surfdim[1]);
	
	_instmap = ds_map_create();
	
	_layerfx_val = 0.38;
	_store_layerfx = 0;
}