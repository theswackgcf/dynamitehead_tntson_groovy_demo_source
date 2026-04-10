{
	_lode_object = true;
	
	image_speed = 0;
	visible = false;
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_show = true;

	scr_lode_enm_create();
	
	_codename = "enm1";
	_spawnblend = make_color_rgb(178,73,145);
	
	_snd = {
		taunt: snd_mg_henchie,
		death: snd_lode_henchie_dead,
	}
	
	_behaviortype = LODE_ENM_CHASER;
}