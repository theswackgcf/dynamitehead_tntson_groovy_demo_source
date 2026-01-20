{
	_allsounds = ds_map_create();
	
	_yspd = 24;
	_fallto = 0;
	_height = 0;
	_timer = 0;
	_sort = true;
	_curdir = choose(DIR_L,DIR_R);
	sfx_play(snd_whistle);
	
	image_speed = 0;
	image_index = random(image_number);
}