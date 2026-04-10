{	
	var prompt_scale = 0.8;
	var toffset = 32;
			
	//prompt text
	switch(global._prompt_desc_type){
		case "punch":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Hold keycode@PUNCHkeycode - Punch the gate";
			toffset = 48;
			prompt_scale = 1.1;
		break;
		case "lowkick":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "keycode@CROUCHkeycode + keycode@PUNCHkeycode - Lowkick";
			toffset = 48;
			prompt_scale = 1.1;
		break;
		case "upper":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "keycode@CROUCHkeycode + keycode@JUMPkeycode - Uppercut";
			toffset = 48;
			prompt_scale = 1.1;
		break;
				
		case "grab":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "keycode@GRABkeycode - Throw enemy\nkeycode@PUNCHkeycode (Hold keycode@LEFTkeycode or keycode@RIGHTkeycode) - Slam";
		break;
		case "jumpback":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "keycode@JUMPkeycode - Jump";
			prompt_scale = 0.9;
			toffset = 48;
		break;
		case "roll":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "keycode@JUMPkeycode - Jump\nkeycode@PUNCHkeycode - Dive";
			prompt_scale = 0.9;
		break;
		case "dive":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "keycode@DIVEkeycode - Roll";
			toffset = 48;
			prompt_scale = 1.1;
		break;
				
		//tutorial
		case "tutr_punch":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Hold keycode@PUNCHkeycode - Punch";
			prompt_scale = 1;
			toffset = 48;
		break;
		case "tutr_crouch":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "keycode@CROUCHkeycode + Press keycode@PUNCHkeycode - Low kick";
			prompt_scale = 1;
			toffset = 48;
		break;
		case "tutr_upper":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "keycode@CROUCHkeycode + Press keycode@JUMPkeycode - Uppercut";
			prompt_scale = 0.9;
			toffset = 42;
		break;
		case "tutr_jump":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Hold keycode@JUMPkeycode & press keycode@PUNCHkeycode - Smackdown";
			prompt_scale = 0.9;
			toffset = 42;
		break;
		case "tutr_grab":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Press keycode@GRABkeycode - Grab\nPress keycode@GRABkeycode again - Throw";
			prompt_scale = 0.85;
			toffset = 36;
		break;
		case "tutr_shield":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Hold keycode@SHIELDkeycode - Flame shield";
			prompt_scale = 1;
			toffset = 48;
		break;
		case "tutr_mash":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Press keycode@TNTkeycode - TNT Pummel";
			prompt_scale = 1;
			toffset = 48;
		break;
		case "tutr_mash2":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Press keycode@PUNCHkeycode - PIERCE THROUGH!";
			prompt_scale = 1;
			toffset = 48;
		break;
		case "tutr_tnt":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Hold keycode@TNTkeycode - TNT Quake";
			prompt_scale = 1;
			toffset = 48;
		break;
				
		case "tutr_roll":
			var dh = instance_find(obj_dh_mask,0);
			if(instance_exists(dh)){
				if(dh._running || dh._runroll){
					_prompt_desc_text_prev = _prompt_desc_text;
					_prompt_desc_text = "keycode@DIVEkeycode (while running) - Roll";
					toffset = 42;
					prompt_scale = 0.92;
				} else {
					_prompt_desc_text_prev = _prompt_desc_text;
					_prompt_desc_text = "keycode@DIVEkeycode + keycode@RIGHTkeycode - Run\nOR Double tap keycode@RIGHTkeycode - Run";
					prompt_scale = 0.85;
					toffset = 36;
				}
			}
		break;
		case "tutr_slam1":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Press keycode@GRABkeycode - Grab";
			prompt_scale = 1;
			toffset = 48;
		break;
		case "tutr_slam2":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Hold keycode@PUNCHkeycode (when grabbing)\n& press keycode@LEFTkeycode or keycode@RIGHTkeycode - Start slamming";
			prompt_scale = 0.9;
			toffset = 36;
		break;
		case "tutr_parry":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Press keycode@SHIELDkeycode - Parry";
			prompt_scale = 1;
			toffset = 48;
		break;
		case "tutr_combo1":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "keycode@CROUCHkeycode + keycode@PUNCHkeycode - Lowkick the fridge";
			prompt_scale = 0.95;
			toffset = 48;
		break;
		case "tutr_combo2":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Hold keycode@JUMPkeycode & press keycode@PUNCHkeycode - Smackdown";
			prompt_scale = 0.9;
			toffset = 42;
		break;
		case "tutr_combo3":
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_text = "Hold keycode@PUNCHkeycode - Send fridge offscreen";
			prompt_scale = 0.95;
			toffset = 48;
		break;
	}
			
	if(global._showtips || global._tutorial){
		draw_sprite_ext(spr_gui_prompt, 0, 0, _prompt_desc_pos[0],1,1,0,c_white,global._prompt_desc_mult*0.45);
		scr_textrender_halign("center");
		scr_textrender_wave_y(2, 9, true);
		scr_textrender_type(floor(WIDTH/2),_prompt_desc_pos[1]+toffset,_prompt_desc_text, false, c_white, global._prompt_desc_mult, prompt_scale,prompt_scale);
		scr_textrender_wave_y(0, 0, true);
		scr_textrender_halign("left");
	}
}