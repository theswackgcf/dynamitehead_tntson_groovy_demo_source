{
	draw_set_color(#FFFFFF);
	
	//text
	scr_textrender_halign("left");
	scr_textrender_valign("bottom");
	
	scr_textrender_shake(0);
	
	scr_textrender_switchfont("dh_font2");
	scr_textrender_type(24, HEIGHT-24, "swackygames 2024", true);
	scr_textrender_halign("right");
	scr_textrender_type(WIDTH-24, HEIGHT-24, "version alpha 2.2", true);
	
	scr_textrender_halign("center");
	scr_textrender_valign("middle");
	
	switch(_menustate){
		case "main":
			draw_sprite_ext(spr_menulogo, 0, floor(WIDTH/2), 160, 0.6, 0.6, 0, #FFFFFF, 1);
			for(var i = 0; i < array_length(_mainopts); i++){
				var col = global._menuColorNo;
				var xoffset = 0;
				scr_textrender_shake(0);
				if(i == _curopt[0]){
					col = global._menuColorYes;
					xoffset = global._menubuttonsin;
					scr_textrender_shake(3);
				}
				scr_textrender_type(floor(WIDTH/2)+xoffset, (floor(HEIGHT/2)-50)+(i*64), _mainopts[i], false, col);
			}
			scr_textrender_shake(0);
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_type(floor(WIDTH/2), HEIGHT-32, "menu not final btw");
		break;
		case "options":
			scr_textrender_switchfont("dh_font2");
			scr_textrender_halign("left");
			scr_textrender_valign("top");
			
			scr_textrender_type(24, 24, "keycode@PAUSEkeycode - Back");
			
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			
			for(var i = 0; i < array_length(_settopts); i++){
				var col = global._menuColorNo;
				var xoffset = 0;
				scr_textrender_shake(0);
				if(i == _curopt[1]){
					col = global._menuColorYes;
					xoffset = global._menubuttonsin;
					scr_textrender_shake(3);
				}
				var vol = 0;
				switch(i){
					case 0:
						vol = global._masterVolume;
					break;
					case 1:
						vol = global._musVolume;
					break;
					case 2:
						vol = global._sfxVolume;
					break;
					case 3:
						vol = global._voiceVolume;
					break;
				}
				
				scr_textrender_type(floor(WIDTH/2)+xoffset, (floor(HEIGHT/2)-50)+(i*64), _settopts[i]+"  "+string(round(vol*100))+"/100", false, col);
			}
			scr_textrender_shake(0);
			scr_textrender_type(floor(WIDTH/2), HEIGHT-64, "keycode@LEFTkeycode / keycode@RIGHTkeycode - adjust setting");
		break;
		case "howto":
			scr_textrender_switchfont("dh_font2");
			scr_textrender_halign("left");
			scr_textrender_valign("top");
			
			scr_textrender_type(24, 24, "keycode@PAUSEkeycode - Back");
			
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			draw_sprite(spr_menuhowto,_howtoframe,0,0);
			switch(_howtoframe){
				case 0:
					scr_textrender_type(WIDTH/2, (HEIGHT/2)+120, "keycode@JUMPkeycode - Jumping\n\nkeycode@PUNCHkeycode - Punching\n\nkeycode@CROUCHkeycode - Crouching\n\nkeycode@TNTkeycode - TNT Blast");
				break;
				case 1:
					scr_textrender_type(WIDTH/2, (HEIGHT/2)+110, "Use keycode@PUNCHkeycode to land punches on enemies\n\nThe faster you hit the more\nchances you have of knocking out an enemy\n\nCrouch with keycode@CROUCHkeycode\nand hit with keycode@LEFTkeycode or keycode@RIGHTkeycode to do a slide\n\nHold down keycode@PUNCHkeycode for a second when\nnear an enemy to grab them.");
				break;
				case 2:
					scr_textrender_type(WIDTH/2, (HEIGHT/2)+48, "You can do a double tap to run\nPress keycode@PUNCHkeycode while running to do a running slide\n\nPress keycode@UPkeycode + keycode@PUNCHkeycode to do an uppercut\n\nYou can do a quick ground pound mid-air\nby pressing keycode@CROUCHkeycode\nThis way you can avoid getting knocked\nout while jumping\n\nPress keycode@CONFIRMkeycode to bring back GUI.");
				break;
			}
		break;
	}
	
	if(!_confirm){
		if(check_keypress(global._input[global._inptype][? "up"], global._inptype)){
			//pressing up
			switch(_menustate){
				case "main":
					sfx_play(snd_slam);
					_curopt[0] --;
					if(_curopt[0] < 0){
						_curopt[0] = 0;
					}
				break;
				case "options":
					sfx_play(snd_slam);
					_curopt[1] --;
					if(_curopt[1] < 0){
						_curopt[1] = 0;
					}
				break;
			}	
		} else if(check_keypress(global._input[global._inptype][? "down"], global._inptype)){
			//pressing down
			switch(_menustate){
				case "main":
					sfx_play(snd_slam);
					_curopt[0] ++;
					if(_curopt[0] > array_length(_mainopts)-1){
						_curopt[0] = array_length(_mainopts)-1;
					}
				break;
				case "options":
					sfx_play(snd_slam);
					_curopt[1] ++;
					if(_curopt[1] > array_length(_settopts)-1){
						_curopt[1] = array_length(_settopts)-1;
					}
				break;
			}	
		} else if(check_keypress(global._input[global._inptype][? "confirm"], global._inptype)){
			sfx_play(snd_slam);
			//enter
			switch(_menustate){
				case "main":
					switch(_curopt[0]){
						case 0:
							//start
							with(obj_screen_tr){
								_show = true;
								_type = "out";
								_roomto = r_dialogue;
							}
							_confirm = true;
						break;
						case 1:
							_howtoframe = 0;
							_menustate = "howto";
							_curopt[1] = 0;
						break;
						case 2:
							//setting
							_menustate = "options";
							_curopt[1] = 0;
						break;
						case 3:
							//quit
							with(obj_screen_tr){
								_show = true;
								_type = "out";
								_exit = true;
							}
							_confirm = true;
						break;
					}
				break;
				case "howto":
					_howtoframe ++;
					if(_howtoframe >= 4){
						_menustate = "main";
					}
				break;
			}
		} else if(check_keypress(global._input[global._inptype][? "pause"], global._inptype)){
			sfx_play(snd_slam);
			//back
			switch(_menustate){
				case "howto":
					_menustate = "main";
				break;
				case "options":
					_menustate = "main";
				break;
			}	
		} else if(check_keypress(global._input[global._inptype][? "left"], global._inptype)){
			//left opt
			switch(_menustate){
				case "options":
					switch(_curopt[1]){
						case 0:
							global._masterVolume -= 0.1;
							global._masterVolume = clamp(global._masterVolume, 0, 1);
							sfx_play(snd_slam);
							voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
							audio_sound_gain(global._cursong, global._curSongGain, 0);
						break;
						case 1:
							global._musVolume -= 0.1;
							global._musVolume = clamp(global._musVolume, 0, 1);
							audio_sound_gain(global._cursong, global._curSongGain, 0);
						break;
						case 2:
							global._sfxVolume -= 0.1;
							global._sfxVolume = clamp(global._sfxVolume, 0, 1);
							sfx_play(snd_slam);
						break;
						case 3:
							global._voiceVolume -= 0.1;
							global._voiceVolume = clamp(global._voiceVolume, 0, 1);
							voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
						break;
					}
				break;
			}	
		} else if(check_keypress(global._input[global._inptype][? "right"], global._inptype)){
			//right opt
			switch(_menustate){
				case "options":
					switch(_curopt[1]){
						case 0:
							global._masterVolume += 0.1;
							global._masterVolume = clamp(global._masterVolume, 0, 1);
							sfx_play(snd_slam);
							voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
							audio_sound_gain(global._cursong, global._curSongGain, 0);
						break;
						case 1:
							global._musVolume += 0.1;
							global._musVolume = clamp(global._musVolume, 0, 1);
							audio_sound_gain(global._cursong, global._curSongGain, 0);
						break;
						case 2:
							global._sfxVolume += 0.1;
							global._sfxVolume = clamp(global._sfxVolume, 0, 1);
							sfx_play(snd_slam);
						break;
						case 3:
							global._voiceVolume += 0.1;
							global._voiceVolume = clamp(global._voiceVolume, 0, 1);
							voice_play(snd_dh_ko, global._testvoices, global._testsndgain);
						break;
					}
				break;
			}	
		}
	}
	
	scr_textrender_halign("left");
	scr_textrender_valign("top");
	scr_textrender_switchfont(global._defaultFont);
}