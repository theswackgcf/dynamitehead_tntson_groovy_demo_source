{
	depth = -10800;
	
	_allsounds = ds_map_create();
	
	_guioffset = [39,42];
	_hpoffset = [5, HEIGHT-123];
	_tntoffset = [WIDTH-407,HEIGHT-66];
	_hitoffset = [32,(WIDTH/2)-320];
	_hitnumoffset = [22,38];
	_bossoffsetlerp = -320;
	_bossoffset = [24,_bossoffsetlerp];
	
	_firetimer = 0;
	_fireframe = 0;

	_tntamp = 0;
	
	_jump = false;
	_vspd = 0;
	_height = 0;
	_flyaway = false;
	_flypos = [0,0];
	_flyto = [0,0];
	_hitstemp = 0;
	_hitsarraytemp = [];
	_holdc = 0; 
	
	_dialm_active = false;
	_dialm_pos = WIDTH;
	_dialm_timer = 0;
	_dialm_act = 0;
	_dialm_quote = -1;
	_dialm_quotes = [
		"AWESOME!",
		"THAT'S THE\nSTUFF!",
		"MY MAN!",
		"OH YEAH!",
		"SICK AS HELL!",
		"DUUUUDE!!!",
		"ROCKIN'!",
		"COOL!",
		"RADICAL!!",
		"WICKED!",
		"NOW WE'RE\nTALKIN'!"
	];
	_dialm_surfsize = [1000,380];
	_dialm_surf = surface_create(_dialm_surfsize[0],_dialm_surfsize[1]);
	
	_uitextshow = false;
	_uitext = "";
	_uitextact = 0;
	_uitexttime = 0;
	_uitextspacing = 0;
	
	global._deadid = 0;
	
	global._tntjuice = 0;
	global._displayjuice = global._tntjuice;
	global._tntjuice_store = global._tntjuice;
	global._tntjuice_max = 100;
	global._tntjuice_mash = 30;
	
	global._hits = 0;
	global._hitsarray = [];
	global._hitscd = 0;
	global._hitmeter = 50;
	
	global._ui_stuff_alpha = [1,1,1,1]; //dh tnt enemy boss
	global._ui_stuff_alphaTo = [];
	global._ui_stuff_alphaMult = [];
	global._ui_stuff_alphaMultTo = [];
	global._fadeOutTimer = [];
	for(var i = 0; i < array_length(global._ui_stuff_alpha); i++){
		global._ui_stuff_alphaTo[i] = global._ui_stuff_alpha[i];
		global._ui_stuff_alphaMult[i] = global._ui_stuff_alpha[i];
		global._ui_stuff_alphaMultTo[i] = global._ui_stuff_alpha[i];
		global._fadeOutTimer[i] = 0;
	}
	
	global._ui_shieldMult = 0;
	global._ui_shieldMultTo = 0;
	
	function ui_all_fade(num){
		for(var i = 0; i < array_length(global._ui_stuff_alphaTo); i++){
			global._fadeOutTimer[i] = 0;
			global._ui_stuff_alphaTo[i] = num;
		}
	}
	
	function ui_fade(uiname, num){
		var uinum = 0;
		switch(uiname){
			case "dh":
				uinum = 0;
			break;
			case "tnt":
				uinum = 1;
			break;
			case "enemy":
				uinum = 2;
			break;
			case "boss":
				uinum = 3;
			break;
		}
		global._ui_stuff_alphaTo[uinum] = num;
		global._fadeOutTimer[uinum] = 0;
	}
	
	function ui_fade_get(uiname){
		var uinum = 0;
		switch(uiname){
			case "dh":
				uinum = 0;
			break;
			case "tnt":
				uinum = 1;
			break;
			case "enemy":
				uinum = 2;
			break;
			case "boss":
				uinum = 3;
			break;
		}
		
		return global._ui_stuff_alpha[uinum];
	}
	
	function drawEnemyHp(xpos,ypos,xsize,ysize,pos){
		var guioff = [xpos,ypos];
		var hpoff = [88,2];
		var alp = global._ui_stuff_alpha[2] * global._ui_stuff_alphaMult[2];
				
		var curEnm = global._curenemy[pos];
		var enmtype = curEnm._enmtype+1;
				
		draw_sprite_ext(spr_gui_enemyborder, 1, guioff[0], guioff[1], xsize, ysize, 0, #FFFFFF, alp);
		draw_sprite_part_ext(spr_gui_enemyhp, 0, 0, 0, (global._curenemy[pos]._displayhp/global._curenemy[pos]._maxhp)*(sprite_get_width(spr_gui_enemyhp)), sprite_get_height(spr_gui_enemyhp), guioff[0]+(hpoff[0]*xsize), guioff[1]+(hpoff[1]*ysize), xsize, ysize, global._curenemy[pos]._hpcolor[enmtype], alp);
		draw_sprite_ext(spr_gui_enemyborder, 0, guioff[0], guioff[1], xsize, ysize, 0, #FFFFFF, alp);
				
		function drawPortrait(guioff, pos, xsize, ysize, alp) {
			var sp = spr_gui_enemyportraits;
			var curEnm = global._curenemy[pos];
			if(curEnm._hp <= 5){
				sp = spr_gui_enemyportraits_lowhp;
			}
			draw_sprite_ext(sp, global._portraits[? global._curenemy[pos]._codename], (guioff[0]-(42*xsize))+(116*xsize), (guioff[1]-(42*ysize))+(126*ysize), xsize, ysize, 0, #FFFFFF, alp);
			if(curEnm._pissedoff > 0){
				var spd = 0;
				switch(curEnm._pissedoff_int){
					case 0:
						spd = 0.2;
					break;
					case 1:
						spd = 0.35;
					break;
					case 2:
						spd = 0.5;
					break;
				}
				shader_reset();
				draw_sprite_ext(spr_p_angryicon, (curEnm._pissedoff_icontimer*spd)%6, (guioff[0]-(42*xsize))+(135*xsize), (guioff[1]-(42*ysize))+(32*ysize), xsize*0.35, ysize*0.35, 0, #FFFFFF, alp);
			}
		}
				
		if(curEnm._colorsinit){
			if(curEnm._difftype){
				//draw recolored version
				var _shdr = asset_get_index("shd_replace_col");
				if(global._buildver == HTML){
					_shdr = asset_get_index("shd_replace_col"+string(curEnm._maxcolors));
				}
							
				shader_set(_shdr);
				
				shader_set_uniform_i(shader_get_uniform(_shdr, "maxcolors"), curEnm._maxcolors);
				shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorIn"), curEnm._mult_colorinArray);
				shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorOut"), curEnm._mult_coloroutArray);
				shader_set_uniform_f_array(shader_get_uniform(_shdr, "colorTolerance"), curEnm._mult_tolrArray);
				shader_set_uniform_f_array(shader_get_uniform(_shdr, "blend"), curEnm._mult_blendArray);
				
				drawPortrait(guioff, pos, xsize, ysize, alp);
			
				shader_reset();
			} else {
				//draw default version
				drawPortrait(guioff, pos, xsize, ysize, alp);
			}
		}
				
		scr_textrender_switchfont("dh_font2_hue");
		var addsize = (1 - xsize)/3;
		var enmnamestr = global._curenemy[pos]._name;
		if(global._curenemy[pos]._nameoverwrite != ""){
			enmnamestr = global._curenemy[pos]._nameoverwrite;
		}
		scr_textrender_type(guioff[0]+(82*xsize), guioff[1]+(57*ysize), string_upper(enmnamestr), true, #FFFFFF, alp, xsize+addsize, ysize+addsize);
		if(xsize >= 0.5 && ysize >= 0.5){
			scr_textrender_switchfont("dh_font3");
			scr_textrender_type(guioff[0]+(289*xsize), guioff[1]+(1*ysize), "HP\n"+string(clamp(floor(global._curenemy[pos]._displayhp), 0, global._curenemy[pos]._maxhp))+"/"+string(floor(global._curenemy[pos]._maxhp)), true, #FFFFFF, alp, xsize, ysize);
		}
		scr_textrender_switchfont(global._defaultFont);
	}
}