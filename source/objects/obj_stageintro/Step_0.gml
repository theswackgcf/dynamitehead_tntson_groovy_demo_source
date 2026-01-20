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
		
		_init = true;
	}
	
	//scrolling background
	_timer += 0.14;
	
	_xpos -= 1;
	if(_xpos <= -2000+(WIDTH/2)){
		_xpos = WIDTH/2;
	}
	_bgpos[0] -= 7;
	_bgpos[1] -= 12;
	
	for(var i = 0; i < 2; i++){
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
		instance_create_depth(WIDTH+512, HEIGHT, -1000, obj_intro_fg);
		_randfgtimer = 0;
	}
	
	if(!_confirm){
		if( check_keypress(global._input[global._inptype][? "confirm"], global._inptype) || check_keypress(global._input[global._inptype][? "pause"], global._inptype) ){
			global._loadState = "stage";
			with(obj_screen_tr){
				_show = true;
				_type = "out";
				_roomto = r_loading;
				_audiostop = true;
			}
			
			_confirm = true;
		}
	}
}