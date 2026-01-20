{
	_starttimer = 80;
	_active = false;
	
	_allsounds = ds_map_create();
	
	_comic = "";
	_comics = ds_map_create();
	_panels = [];
	
	_curpage = 1;
	_curpanel = 0;
	
	_init = false;
	_pageinit = false;
	
	_shake_addX = 0;
	_shake_addY = 0;
	
	_input = true;
	_end = false;
	_endtimer = 0;
	_endalpha = 0;
	_endsprite = -1;
	
	_muffle = false;
	
	_skipall_act = 1;
	_skipall_timer = 0;
	_skipall_xstart = -WIDTH;
	_skipall_x = _skipall_xstart;
	_skip = false;
	_skipdg = false;
	
	_dialogue = false;
	
	_timer = 0;
	_gonext = false;
	_gonext_timer = 0;
	
	_transition_act = 0;
	_transition_timer = 0;
	_splash_scale = 3.2;
	_splash_amp = 45;
	_splash_amp_y = 0;
	
	fX = shader_get_uniform(shd_wavy, "freqX");
	fY = shader_get_uniform(shd_wavy, "freqY");
	s = shader_get_uniform(shd_wavy, "scaling");
	aX = shader_get_uniform(shd_wavy, "ampX");
	aY = shader_get_uniform(shd_wavy, "ampY");
	
	_splash_ampX = 0.025;
	_splash_ampY = 0.025;
	
	_splashes = [
		["IT'S\n   ON:.:.:.",140],
		["LEMME\n   TRY:.:.:.",70],
		["MAKE A\n   MESS:.:.:.",32],
		["I'M ON\n   IT:.:.:.",145],
		["I'M ON\n   A ROLL:.:.:.",0],
		["HIT THE\n   SURF.:.:.",0],
	];
	_cursplash = irandom_range(0,array_length(_splashes)-1);
	
	_leit = -1;
	_tr_frame = 0;
	
	function updatepanel(){
		if(ds_map_exists(global._easings, "panelx")){
			ds_map_delete(global._easings, "panelx");
		}
		if(ds_map_exists(global._easings, "panely")){
			ds_map_delete(global._easings, "panely");
		}
		if(ds_map_exists(global._easings, "panelscale")){
			ds_map_delete(global._easings, "panelscale");
		}
		if(ds_map_exists(global._easings, "panelalpha")){
			ds_map_delete(global._easings, "panelalpha");
		}
		_curpanel ++;
		if(_curpanel < array_length(_panels)){
			if(_panels[_curpanel].sfx != -1){
				sfx_stop_all();
			}
		}
		sfx_play(snd_comic_advance, 0.76);
		_shake_addX = 0;
		_shake_addY = 0;
		_gonext_timer = 0;
		if(_curpanel >= array_length(_panels)){
			if(_curpage < ds_map_size(_comics[? _comic])){
				_pageinit = false;
				_curpanel = 0;
				_curpage ++;
				sfx_stop_all();
				sfx_play(snd_comic_advance, 0.76);
			}
		}
	}
}
