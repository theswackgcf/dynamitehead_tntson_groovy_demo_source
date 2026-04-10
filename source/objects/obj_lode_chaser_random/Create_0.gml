{
	_lode_object = true;
	
	image_speed = 0;
	visible = false;
	
	_sintimer = 0;
	_sinoffset = 0;
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_show = true;

	scr_lode_enm_create();
	
	_codename = "enm3";
	_spawnblend = make_color_rgb(126,156,221);
	
	_snd = {
		taunt: snd_mg_gostlik,
		death: snd_lode_gostlik_dead,
	}
	
	_behaviortype = LODE_ENM_RANDOM;
	_movespd = 0.76;
}