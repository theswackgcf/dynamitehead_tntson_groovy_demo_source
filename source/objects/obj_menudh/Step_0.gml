{
	depth = -10;
	if(_wall){
		//turn that dinamit into a wall
		depth = -20;
		image_speed = 0;
		image_index = 1;
	} else {
		//headbop
		if(global._cursong != -1){
			if( (audio_sound_get_track_position(global._cursong))%(60/_bpm) <= 0.05 ){
				image_index = 0;
				if(_sprtype == 1){
					_beats ++;
					if(_beats >= 4){
						if(_curspr <> 1){
							_curspr = 1;
							if(_menuobj != noone && _menuobj._menustate = "main"){
								sfx_play(snd_whipcrack, 0.76);
								sfx_pitch(snd_whipcrack, random_range(0.6, 1.4));
							}
						}
					}
				}
				_sprtype = 2;
			}
		}
		if(_sprtype == 2 && image_index >= image_number-1){
			_sprtype = 1;
		}
	
		//clicking
		if(_menuobj != noone && _menuobj._menustate = "main"){
			function snap() {
				image_index = 0;
				_curspr ++;
				if(_curspr >= 6){
					_curspr = 2;
				}
				_sprtype = 2;
				_beats = 0;
				sfx_play(snd_whipcrack, 0.76);
				sfx_pitch(snd_whipcrack, random_range(0.6, 1.4));
			}
			if(global._inptype == 1 && check_keypress(global._input[global._inptype][? "tnt"], global._inptype)){
				snap();
			}
			if(scr_mousehover(72, 110, WIDTH/3, HEIGHT-180) && mouse_check_button_pressed(mb_left)){
				snap();
			}
		}
		
		sprite_index = asset_get_index("spr_menubg_dh"+string(_curspr)+"_"+string(_sprtype));
		if(_curspr == 4){
			depth = -21;
		}
	}
}