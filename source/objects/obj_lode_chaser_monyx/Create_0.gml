{
	_lode_object = true;
	
	image_speed = 0;
	visible = false;
	
	_tilepos = [0,0];
	_tilelayer = -1;
	
	_show = true;

	scr_lode_enm_create();
	
	_codename = "enm2";
	_spawnblend = make_color_rgb(229,146,52);
	
	_snd = {
		taunt: snd_mg_yolobones,
		death: snd_lode_yolo_dead,
	}
	
	_behaviortype = LODE_ENM_MONYX;
	_movespd = 1;
}