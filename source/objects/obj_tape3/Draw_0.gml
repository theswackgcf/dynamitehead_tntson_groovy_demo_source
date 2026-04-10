{
	if(_scene > 0 && _scene < 3){
		draw_sprite(spr_tape3_sky, floor(_sky_frame), floor(WIDTH/2), 0);
	}
	switch(_scene){
		case 0:
			switch(_tv_act){
				case 1:
					draw_sprite(spr_tape3_tv1, floor(_tv_frame), 0, _tv_offset);
				break;
				case 2:
					draw_sprite(spr_tape3_tv2, floor(_tv_frame), 0, _tv_offset);
				break;
			}
		break;
		case 1:
			gpu_set_texfilter(false);
			draw_sprite(spr_tape3_bg1, 0, _scrollpos, 0);
			gpu_set_texfilter(global._texfilter);
			switch(_scene1_act){
				case 0:
				case 1:
					var offsety = 0;
					if(!global._pause && _phonering_state){
						offsety = sin(random(480))*7;
					}
					draw_sprite(spr_tape3_hand1, floor(_handframe), _handpos, floor(HEIGHT/2));
					draw_sprite(spr_tape3_phone, 0, 703, 496+offsety);
				break;
				case 2:
					draw_sprite(spr_tape3_hand2, floor(_handframe), _handpos, floor(HEIGHT/2));
					if(_showphone){
						draw_sprite(spr_tape3_phone, 0, 703, 496);
					}
				break;
				case 3:
					gpu_set_texfilter(false);
					draw_sprite(spr_tape3_bg2, 0, -WIDTH+_scrollpos+_squareoffset,0);
					gpu_set_texfilter(global._texfilter);
					draw_sprite(spr_tape3_couch, 0, -WIDTH+_scrollpos+_squareoffset,0);
					draw_sprite(spr_tape3_nomio1, floor(_nomio_frame), (-WIDTH+481)+_scrollpos+_squareoffset,639);
					draw_sprite(spr_tape3_nomio1_mouth1, 0, (-WIDTH+499)+_scrollpos+_squareoffset,688);
				break;
			}
		break;
		case 2:
			gpu_set_texfilter(false);
			draw_sprite(spr_tape3_bg2, 0, 0, 0);
			gpu_set_texfilter(global._texfilter);
			draw_sprite(spr_tape3_couch, 0, 0, 0);
			var nomiopos = [481,639];
			draw_sprite_ext(_nomio_sprite, floor(_nomio_frame), nomiopos[0], nomiopos[1], 1, _nomio_scaley, 0, c_white, 1);
			if(_nomio_showmouth){
				var mframe = floor(_nomio_frame);
				if(_nomio_talktimer > 0){
					mframe = floor(_nomio_mouthframe);
				}
				if(_nomio_mouthsprite != -1){
					draw_sprite_ext(_nomio_mouthsprite, floor(_nomio_frame), 499, 688+_nomio_mouthoffset, 1, _nomio_scaley, 0, c_white, 1);
				}
			}
			if(_scene2_act == 3){
				draw_sprite(spr_tape3_pissed_hat, floor(_nomio_frame), nomiopos[0]+33, nomiopos[1]-320);
				draw_sprite(spr_tape3_pissed_face, floor(_nomio_frame), nomiopos[0], nomiopos[1]-225);
				draw_sprite(spr_tape3_pissed_hand, floor(_nomio_frame), nomiopos[0]+116+_nomio_handoffset, nomiopos[1]-174);
			}
		break;
		case 3:
			scr_textrender_shake(4, 0);
			scr_textrender_switchfont("dh_font4");
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			scr_textrender_type(floor(WIDTH/2),floor(HEIGHT/2), "TO BE CONTINUED\nIN HELLISH HAVOC...", false, c_white, clamp(_scene3_alp, 0, 1), 1, 1);
			scr_textrender_halign("left");
			scr_textrender_valign("top");
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_shake(0, 0);
		break;
	}
	if(_caller_appear){
		var spr = spr_tape3_caller1;
		if(_caller_static <= 0){
			spr = spr_tape3_caller2;
		}
		draw_sprite(spr, floor(_callerframe), _callerx, 0);
	}
	
	if(_scene > 0){
		draw_sprite(spr_tape3_overlay, 0, 0, 0);
	}
	
	if((_scene == 0 && _tv_act >= 1) || _scene > 0){
		if(_skipall_act > 0){
			scr_textrender_switchfont("dh_font1");
			scr_textrender_valign("bottom");
			scr_textrender_type(_skipall_x+12, HEIGHT-12, "keycode@PAUSEkeycode - Skip", true);
			scr_textrender_valign("top");
			scr_textrender_switchfont(global._defaultFont);
		}
	}
}