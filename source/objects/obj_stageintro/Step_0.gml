{
	if(!_colorsinit){
		if(global._tutorial){
			_rep = "st0";
		} else {
			_rep = "st"+string(global._location+1);
		}
		makecolors("def",_rep);
		
		_colorsinit = true;
	}
	
	if(!_init){
		with(obj_music){
			global.music_bus.effects[0] = undefined;
		}
		
		switch(global._location){
			case 1:
				_bgspr = spr_lv2intro_bg;
			break;
		}
		
		for(var i = 0; i < sprite_get_info(_bgspr).num_subimages; i++){
			_bgpos[i] = 0;
		}
		
		_init = true;
	}
	
	//scrolling background
	_timer += 0.14;
	
	_xpos -= 1;
	if(_xpos <= -2000+(WIDTH/2)){
		_xpos = WIDTH/2;
	}
	
	_bgspd += 0.06;
	
	for(var i = 0; i < sprite_get_info(_bgspr).num_subimages; i++){
		_bgpos[i] -= _bgspd*((i+1)*0.7);
		if(_bgpos[i] <= -WIDTH){
			_bgpos[i] = 0;
		}
	}
	_dhframe += 0.32;
	
	_dhtime ++;
	
	var _channel = animcurve_get_channel(ac_dhstageintro, 0);
	_dhpos = animcurve_channel_evaluate(_channel, _dhtime / 800);
	
	//vibration
	var time = 8;
	var dist = 320;
	if(_dhpos >= (WIDTH/2)-dist && _dhpos <= (WIDTH/2)+dist){
		time = 5;
	}
	if(_dhtime % time == 0){
		global._pad_vibrate = 1;
	}
	
	if(_dhtime >= 260){
		global._loadState = "stage";
		with(obj_screen_tr){
			_show = true;
			_type = "out";
			_roomto = r_loading;
		}
		
		_confirm = true;
	}
	
	var dist;
	var maxdist = WIDTH-400;
	if(diff(_dhpos, WIDTH/2) > maxdist){
		dist = 0;
	} else {
		dist = abs(maxdist-diff(_dhpos, WIDTH/2))/maxdist;
	}
	sfx_volume(snd_surf, dist, 0);
	
	//fg stuff
	_randfgtimer ++;
	if(_randfgtimer >= random_range(30,70)){
		var fg = instance_create_depth(WIDTH+512, HEIGHT, -1000, obj_intro_fg);
		fg._fgspd = _bgspd * 3.14;
		_randfgtimer = 0;
	}
	
	if(!_confirm){
		if( check_keypress(global._input[global._inptype][? "confirm"], global._inptype) || check_keypress(global._input[global._inptype][? "pause"], global._inptype) ){
			global._loadState = "stage";
			with(obj_screen_tr){
				_show = true;
				_type = "out";
				_roomto = r_loading;
				_audiostop = false;
			}
			audio_stop_sound(snd_surf);
			
			_confirm = true;
		}
	}
	
	//timed effects
	var trackpos = 0;
	if(global._stageintro_theme != -1){
		trackpos = audio_sound_get_track_position(global._stageintro_theme);
	}
	
	if(!_stageeffect){
		switch(global._location){
			case 1:
				if(trackpos >= 1.91){
					_thunder_alp = 1.32;
					
					sfx_play(snd_lvintro2_laugh);
					
					_stageeffect = true;
				}
			break;
		}
	}
	
	if(_thunder_alp > 0){
		_thunder_alp -= 0.01;
	}
}