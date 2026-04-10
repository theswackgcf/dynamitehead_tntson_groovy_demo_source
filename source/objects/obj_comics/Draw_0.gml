{	
	if(_active && _transition_act == 0){
		if(_init && _pageinit){
			for(var j = 0; j < array_length(_panels); j++){
				for(var i = array_length(_panels)-1; i >= 0; i--){
					var sp = asset_get_index(_panels[i].sprite);
					var sp_speech = asset_get_index(_panels[i].sprite+"_speech");
					if(sprite_exists(sp)){
						if(_curpanel >= _panels[i].panel && _panels[i].delay <= 0){
							var addx = 0;
							var addy = 0;
							if(_curpanel == _panels[i].panel){
								addx = _shake_addX;
								addy = _shake_addY;
							}
							if(j == 0 || (j > 0 && _panels[i].plusdepth >= j)){
								draw_sprite_ext(sp, _panels[i].panel, _panels[i].xx+floor(WIDTH/2)+addx, _panels[i].yy+floor(HEIGHT/2)+addy, _panels[i].scale, _panels[i].scale, 0, c_white, clamp(_panels[i].alpha,0,1));
							}
							var sp_speech = asset_get_index(_panels[i].sprite+"_speech");
							if(sprite_exists(sp_speech)){
								draw_sprite_ext(sp_speech, _panels[i].panel, _panels[i].xx+floor(WIDTH/2)+addx, _panels[i].yy+floor(HEIGHT/2)+addy, _panels[i].scale, _panels[i].scale, 0, c_white, clamp(_panels[i].alpha,0,1));
							}
							if(_panels[i].text_ != -1){
								scr_textrender_switchfont("dh_fontcomic1");
								scr_textrender_halign("center");
								for(var t = 0; t < array_length(_panels[i].text_); t++){
									var curtext = _panels[i].text_[t][0];
									var curx = _panels[i].text_[t][1];
									var cury = _panels[i].text_[t][2];
									var curscale = _panels[i].text_[t][3];
									scr_textrender_type(_panels[i].xx+curx,_panels[i].yy+cury,curtext,false,c_black,1,curscale*_panels[i].scale,curscale*_panels[i].scale);
								}
								scr_textrender_halign("left");
								scr_textrender_switchfont(global._defaultFont);
							}
						}
					}
				}
			}
			
			if(_end){
				if(_endsprite != -1){
					draw_set_alpha(_endalpha);
					draw_sprite(_endsprite, 0, floor(WIDTH/2), floor(HEIGHT/2));
					draw_set_alpha(1);
				}
			} else {
				if(_gonext && _gonext_timer >= 16){
					scr_textrender_halign("right");
					scr_textrender_switchfont("dh_font1");
					var sinYoffset = sin(_timer/20)*12;
					scr_textrender_type(WIDTH-16,18+sinYoffset,"keycode@CONFIRMkeycode",true);
					scr_textrender_type(WIDTH-16,68+sinYoffset,"Continue",true, c_white,1, 0.5,0.5);
					scr_textrender_switchfont(global._defaultFont);
					scr_textrender_halign("left");
				}
			}
		}
	}
	
	if(_skipall_act > 0){
		scr_textrender_switchfont("dh_font1");
		scr_textrender_valign("bottom");
		scr_textrender_type(_skipall_x+12, HEIGHT-12, "keycode@PAUSEkeycode - Skip", true);
		scr_textrender_valign("top");
		scr_textrender_switchfont(global._defaultFont);
	}
}