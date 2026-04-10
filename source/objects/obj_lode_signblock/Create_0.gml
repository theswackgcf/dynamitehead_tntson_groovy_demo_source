{
	_allsounds = ds_map_create();
	
	_lode_object = true;
	
	_depth = 16;
	
	_init = false;
	
	_show = true;
	
	_id = "";
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_init = false;
	
	_signimg = 0;
	
	_textid = "";
	
	_text = "";
	_text_wrapped = "";
	
	_textrender_force_texfilter = false;
	
	_drawdeletetext = false;
	
	_showtext = false;
	_readtimer = 0;
	_textscale = 0;
	_out = false;
	
	_surf_dim = [global._lode_disp_dim[0],global._lode_disp_dim[1]];
	_drawsurface = surface_create(_surf_dim[0],_surf_dim[1]);
	
	_surf_sprites = ds_map_create();
	
	visible = true;
}