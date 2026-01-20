///scr_textrender_type(x, y, text, [shadow], [color], [alpha], [scale_x], [scale_y])
function scr_textrender_type(x, y, text, shadow = false, color = make_color_rgb(255,255,255), alpha = 1, scale_x = 1, scale_y = 1){
	if(global._fontInit){
		if(global._font == "dh_fontnes"){
			gpu_set_texfilter(false);
		}
		
		var addspacing = 0;
		
		if(ds_map_exists(global._fontSpacing, global._font)){
			addspacing = global._fontSpacing[? global._font]
		}
		scr_textrender_spacing(addspacing + global._addSpacing);
		
		var invisible = false;
		
		var colors = [
			["w", color],
			["y", make_color_rgb(255, 183, 15)],
			["r", make_color_rgb(237, 14, 44)],
			["g", make_color_rgb(145, 245, 22)],
			["b", make_color_rgb(31, 97, 240)],
		];
	
		var textReplace1 = string_replace_all(text, "\n", "/n");
		var textReplace2 = string_replace_all(textReplace1, "\\", "\\\\");
		var textArray = string_split(textReplace2, "/n");
		
		var textNoCols = string_replace_all(text, "\n", "/n");
		
		//replace invisible characters
		
		/*var invsArray = [];
		var _splitby = string_split(textNoCols, "/");
		for(var i = 0; i < array_length(_splitby); i++){
			if(string_starts_with(_splitby[i], "i")){
				array_push(invsArray,string_copy(_splitby[i], 2, string_length(_splitby[i])-1));
			}
		}
		
		for(var i = 0; i < array_length(invsArray); i++){
			textNoCols = string_replace_all(textNoCols, invsArray[i], "");
		}*/
		
		textNoCols = string_replace_all(textNoCols, "/i", "");
		
		for(var i = 0; i < array_length(colors); i++){
			textNoCols = string_replace_all(textNoCols, "/"+colors[i][0], "");
		}
		var textArrayNoCols = string_split(textNoCols, "/n");
	
		var toX = [];
		var toY = y;
	
		var drawx = x;
		var drawy = y;
		var curletter;
		var drawchar = true;
		var col = colors[0][1];
	
		var totalwidth = [];
		var totallength = [];
		var totalheight = array_length(textArray)*(global._textheight[? global._font]*scale_y);
	
		var PtextKeySplit = [];
		var textKeySplit;
		var doText;
		var bindInput;
		var lineHasKey = false;
		var PlineHasKey = false;
		var keyheight = 0;
		var defkeyheight = global._keybindH*scale_y;
		var change = global._keybindW*scale_x;
		var offsety = 0;
		var waveoffset = [0,0];
		
		var curchar = 0;
	
		var textKeySplitNoCols;
		for(var o = 0; o < array_length(textArrayNoCols); o++){
			textKeySplitNoCols = string_split(textArrayNoCols[o], "keycode");
			totalwidth[o] = 0;
			totallength[o] = 0;
			
			//calculate width
			for(var m = 0; m < array_length(textKeySplitNoCols); m++){
				doText = true;
				if(string_starts_with(textKeySplitNoCols[m],">")){
					doText = false;
					bindInput = false;
				}
				if(string_starts_with(textKeySplitNoCols[m],"@")){
					doText = false;
					bindInput = true;
				}
				if(doText){
					totallength[o] += string_length(textKeySplitNoCols[m]);
					for(var i = 0; i < string_length(textKeySplitNoCols[m]); i++){
						if(ds_map_exists(global._fontdata[? global._font], string_char_at(textKeySplitNoCols[m], i+1))){
							totalwidth[o] += (global._fontdata[? global._font][? string_char_at(textKeySplitNoCols[m], i+1)][2])*scale_x;
						}
					}
				} else {
					var keysize = change;
					if(!bindInput){
						//key codes
						var keystring = string_lower(string_replace_all(textKeySplitNoCols[m], ">",""));
						for(var st = 0; st < array_length(global._binds); st++){
							if(string_lower(global._keystrings[st]) == keystring){	
								if(is_array(global._binds[st])){
									keysize = (sprite_get_width(global._binds[st][1])+global._keyoffset)*scale_x;
								}
							}
						}
					} else {
						//player defined inputs
						var keystring = string_lower(string_replace_all(textKeySplitNoCols[m], "@",""));
						if(ds_map_exists(global._input[global._inptype], keystring)){
							var keycode = global._input[global._inptype][? keystring];
							switch(global._inptype){
								case 0:
									for(var i = 0; i < array_length(global._binds); i++){
										var curcode;
										if(!is_array(global._binds[i])){
											curcode = global._binds[i];
										} else {
											curcode = global._binds[i][0];
										}
										if(keycode == curcode){
											if(is_array(global._binds[i])){
												keysize = (sprite_get_width(global._binds[i][1])+global._keyoffset)*scale_x;
											}
											break;
										}
									}
								break;
								case 1:
									for(var i = 0; i < array_length(global._gpbinds); i++){
										var curcode;
										if(!is_array(global._gpbinds[i])){
											curcode = global._gpbinds[i];
										} else {
											curcode = global._gpbinds[i][0];
										}
										if(keycode == curcode){
											if(is_array(global._gpbinds[i])){
												keysize = (sprite_get_width(global._gpbinds[i][1])+global._keyoffset)*scale_x;
											}
											break;
										}
									}
								break;
							}
						}
					}
					
					totallength[o] += 2;
					totalwidth[o] += keysize;
				}
			}
		}
	
		for(var o = 0; o < array_length(textArray); o++){
			textKeySplit = string_split(textArray[o], "keycode");
			if(array_length(textArray) > 1 && o >= array_length(textArray)-1){
				PtextKeySplit = string_split(textArray[o-1], "keycode");
			}
			
			lineHasKey = false;
			PlineHasKey = false;
			for(var m = 0; m < array_length(textKeySplit); m++){
				if(string_starts_with(textKeySplit[m],">") || string_starts_with(textKeySplit[m],"@")){
					lineHasKey = true;
				}
			}
			
			for(var m = 0; m < array_length(PtextKeySplit); m++){
				if(string_starts_with(PtextKeySplit[m],">") || string_starts_with(PtextKeySplit[m],"@")){
					PlineHasKey = true;
				}
			}
			
			if(lineHasKey && o < array_length(textArray)-1){
				keyheight += defkeyheight;
			}
			
			//height align
			switch(global._valign){
				case 1:
					toY = y - floor((totalheight/2)+(keyheight/2));
				break;
				case 2:
					toY = y - (totalheight+(keyheight));
				break;
			}
				
			if(lineHasKey && o > 0 && o < array_length(textArray)-1){
				switch(global._valign){
					case 0:
						offsety += defkeyheight/2;
					break;
					case 1:
						offsety += defkeyheight;
					break;
					case 2:
						offsety += defkeyheight*1.5;
					break;
				}
			}
			
			drawy = toY+((global._textheight[? global._font]*scale_y)*o);
			
			if(array_length(textArray) > 1){
				if((lineHasKey || PlineHasKey) && o >= array_length(textArray)-1){
					drawy += defkeyheight/2;
				}
			}
			
			toX[o] = x;
					
			//width align
			switch(global._halign){
				case 1:
					toX[o] = x - floor(totalwidth[o]/2) - floor((totallength[o]*global._textspacing)/2);
				break;
				case 2:
					toX[o] = x - totalwidth[o] - (totallength[o]*global._textspacing);
				break;
			}
			
			drawx = toX[o];
			
			lineHasKey = false;
			
			curchar = 0;
			for(var m = 0; m < array_length(textKeySplit); m++){
				doText = true;
				if(string_starts_with(textKeySplit[m],">")){
					doText = false;
					bindInput = false;
				}
				if(string_starts_with(textKeySplit[m],"@")){
					doText = false;
					bindInput = true;
				}
				
				if(doText){
					//not keycode
					for(var i = 0; i < string_length(textKeySplit[m]); i++){
						var curtextstring = textKeySplit[m];
						if(string_char_at(curtextstring, i+1) == "/" && string_char_at(curtextstring, i+2) == "i"){
							//toggle invisible text
							if(!invisible){
								invisible = true;
								drawchar = false;
								i += 1;
							} else {
								invisible = false;
								drawchar = false;
								i += 1;
							}
						}
						for(var j = 0; j < array_length(colors); j++){
							if(string_char_at(curtextstring, i+1) == "/" && string_char_at(curtextstring, i+2) == colors[j][0]){
								//colored text
								col = colors[j][1];
								drawchar = false;
								i += 1;
							}
						}
						if(ds_map_exists(global._fontdata[? global._font], string_char_at(curtextstring, i+1))){
							curletter = global._fontdata[? global._font][? string_char_at(curtextstring, i+1)];
						}
						if(i == string_length(curtextstring)-1 && string_char_at(curtextstring, i+1) == "/"){
							drawchar = false;
						}
						if(string_char_at(curtextstring, i+1) == "\\"){
							drawchar = false;
						}
						if(drawchar){
							if(variable_instance_exists(self.id, "u_position") && variable_instance_exists(self.id, "_hue")){
								shader_set(shd_hue);
								shader_set_uniform_f(u_position, _hue);
							}
							if(!invisible){
								var shakerange = [random_range(-global._textshaking[0],global._textshaking[0]),random_range(-global._textshaking[1],global._textshaking[1])];
								
								for(var wavei = 0; wavei < 2; wavei++){
									if(global._textwavetime[wavei] != 0){
										var timertouse = current_time;
										if(global._usegametimer){
											timertouse = global._gametimer;
										}
										var adjustedtime = timertouse / (500 / global._textwavetime[wavei]);
										var sinorcosvalue = 0;
										if(wavei == 1){
											sinorcosvalue = sin(adjustedtime + (i * -64));
										} else {
											sinorcosvalue = cos(adjustedtime + (i * -64));
										}
										waveoffset[wavei] = sinorcosvalue * global._textwave[wavei];
									}
									else{
										waveoffset[wavei] = 0;
									}
								}
								
								if(shadow){
									draw_sprite_part_ext(asset_get_index("spr_"+global._font), 0, curletter[0], curletter[1], curletter[2], curletter[3], (drawx+(3*scale_x)+shakerange[1]+waveoffset[1])+(curchar*global._textspacing), (drawy+(3*scale_y)+offsety)+shakerange[0]+waveoffset[0], scale_x, scale_y, c_black, alpha);
								}
								draw_sprite_part_ext(asset_get_index("spr_"+global._font), 0, curletter[0], curletter[1], curletter[2], curletter[3], (drawx+shakerange[1]+waveoffset[1])+(curchar*global._textspacing), (drawy+offsety)+shakerange[0]+waveoffset[0], scale_x, scale_y, col, alpha);
							}
							shader_reset();
							
							drawx += curletter[2]*scale_x;
							curchar ++;
						}
						drawchar = true;
					}
				} else {
					//keycode
					if(!bindInput){
						//show any key
						var keystring = string_lower(string_replace_all(textKeySplit[m], ">",""));
						for(var st = 0; st < array_length(global._binds); st++){
							if(string_lower(global._keystrings[st]) == keystring){
								var keysize = change;
								if(!invisible){
									for(var wavei = 0; wavei < 2; wavei++){
										if(global._textwavetime[wavei] != 0){
											var timertouse = current_time;
											if(global._usegametimer){
												timertouse = global._gametimer;
											}
											var adjustedtime = timertouse / (500 / global._textwavetime[wavei]);
											var sinorcosvalue = 0;
											if(wavei == 1){
												sinorcosvalue = sin(adjustedtime + (i * -64));
											} else {
												sinorcosvalue = cos(adjustedtime + (i * -64));
											}
											waveoffset[wavei] = sinorcosvalue * global._textwave[wavei];
										}
									}
									
									var sptodraw;
									var frtodraw;
									
									if(!is_array(global._binds[st])){
										sptodraw = spr_keybinds;
										frtodraw = st;
									} else {
										sptodraw = global._binds[st][1];
										frtodraw = global._binds[st][2];
										keysize = (sprite_get_width(sptodraw)+global._keyoffset)*scale_x;
									}
									draw_sprite_ext(sptodraw, frtodraw, (((drawx+(curchar*global._textspacing))-8)+random_range(-global._textshaking[1],global._textshaking[1]))+(sprite_get_xoffset(sptodraw)*scale_x)+waveoffset[1], (((drawy-8)+offsety)+random_range(-global._textshaking[0],global._textshaking[0]))+(sprite_get_yoffset(sptodraw)*scale_y)+waveoffset[0], scale_x, scale_y, 0, #FFFFFF, alpha);
								}
								drawx += keysize;
								curchar ++;
								break;
							}
						}
						for(var st = 0; st < array_length(global._gpbinds); st++){
							if(string_lower(global._gpstrings[st]) == keystring){
								var keysize = change;
								if(!invisible){
									for(var wavei = 0; wavei < 2; wavei++){
										if(global._textwavetime[wavei] != 0){
											var timertouse = current_time;
											if(global._usegametimer){
												timertouse = global._gametimer;
											}
											var adjustedtime = timertouse / (500 / global._textwavetime[wavei]);
											var sinorcosvalue = 0;
											if(wavei == 1){
												sinorcosvalue = sin(adjustedtime + (i * -64));
											} else {
												sinorcosvalue = cos(adjustedtime + (i * -64));
											}
											waveoffset[wavei] = sinorcosvalue * global._textwave[wavei];
										}
										else{
											waveoffset[wavei] = 0;
										}
									}
									
									var sptodraw;
									var frtodraw;
									
									if(!is_array(global._gpbinds[st])){
										sptodraw = spr_padbinds;
										frtodraw = st;
									} else {
										sptodraw = global._gpbinds[st][1];
										frtodraw = global._gpbinds[st][2];
										keysize = (sprite_get_width(sptodraw)+global._keyoffset)*scale_x;
									}
									
									draw_sprite_ext(sptodraw, frtodraw, (((drawx+(curchar*global._textspacing))-8)+random_range(-global._textshaking[1],global._textshaking[1]))+(sprite_get_xoffset(sptodraw)*scale_x)+waveoffset[1], (((drawy-8)+offsety)+random_range(-global._textshaking[0],global._textshaking[0]))+(sprite_get_yoffset(sptodraw)*scale_y)+waveoffset[0], scale_x, scale_y, 0, #FFFFFF, alpha);
								}
								drawx += keysize;
								curchar ++;
								break;
							}
						}
					} else {
						//show defined player input
						var keystring = string_lower(string_replace_all(textKeySplit[m], "@",""));
						if(ds_map_exists(global._input[global._inptype], keystring)){
							var keycode = global._input[global._inptype][? keystring];
							switch(global._inptype){
								case 0:
									for(var i = 0; i < array_length(global._binds); i++){
										var curcode;
										if(!is_array(global._binds[i])){
											curcode = global._binds[i];
										} else {
											curcode = global._binds[i][0];
										}
										if(keycode == curcode){
											var keysize = change;
											if(!invisible){
												for(var wavei = 0; wavei < 2; wavei++){
													if(global._textwavetime[wavei] != 0){
														var timertouse = current_time;
														if(global._usegametimer){
															timertouse = global._gametimer;
														}
														var adjustedtime = timertouse / (500 / global._textwavetime[wavei]);
														var sinorcosvalue = 0;
														if(wavei == 1){
															sinorcosvalue = sin(adjustedtime + (i * -64));
														} else {
															sinorcosvalue = cos(adjustedtime + (i * -64));
														}
														waveoffset[wavei] = sinorcosvalue * global._textwave[wavei];
													}
													else{
														waveoffset[wavei] = 0;
													}
												}
												
												var sptodraw;
												var frtodraw;
												
												if(!is_array(global._binds[i])){
													sptodraw = spr_keybinds;
													frtodraw = i;
												} else {
													sptodraw = global._binds[i][1];
													frtodraw = global._binds[i][2];
													keysize = (sprite_get_width(sptodraw)+global._keyoffset)*scale_x;
												}
												draw_sprite_ext(sptodraw, frtodraw, (((drawx+(curchar*global._textspacing))-8)+random_range(-global._textshaking[1],global._textshaking[1]))+(sprite_get_xoffset(sptodraw)*scale_x)+waveoffset[1], (((drawy-8)+offsety)+random_range(-global._textshaking[0],global._textshaking[0]))+(sprite_get_yoffset(sptodraw)*scale_y)+waveoffset[0], scale_x, scale_y, 0, #FFFFFF, alpha);
											}
											drawx += keysize;
											curchar ++;
											break;
										}
									}
								break;
								case 1:
									for(var i = 0; i < array_length(global._gpbinds); i++){
										var curcode;
										if(!is_array(global._gpbinds[i])){
											curcode = global._gpbinds[i];
										} else {
											curcode = global._gpbinds[i][0];
										}
										if(keycode == curcode){
											var keysize = change;
											if(!invisible){
												for(var wavei = 0; wavei < 2; wavei++){
													if(global._textwavetime[wavei] != 0){
														var timertouse = current_time;
														if(global._usegametimer){
															timertouse = global._gametimer;
														}
														var adjustedtime = timertouse / (500 / global._textwavetime[wavei]);
														var sinorcosvalue = 0;
														if(wavei == 1){
															sinorcosvalue = sin(adjustedtime + (i * -64));
														} else {
															sinorcosvalue = cos(adjustedtime + (i * -64));
														}
														waveoffset[wavei] = sinorcosvalue * global._textwave[wavei];
													}
													else{
														waveoffset[wavei] = 0;
													}
												}
												
												var sptodraw;
												var frtodraw;
												
												if(!is_array(global._gpbinds[i])){
													sptodraw = spr_padbinds;
													frtodraw = i;
												} else {
													sptodraw = global._gpbinds[i][1];
													frtodraw = global._gpbinds[i][2];
													keysize = (sprite_get_width(sptodraw)+global._keyoffset)*scale_x;
												}
												
												draw_sprite_ext(sptodraw, frtodraw, (((drawx+(curchar*global._textspacing))-8)+random_range(-global._textshaking[1],global._textshaking[1]))+(sprite_get_xoffset(sptodraw)*scale_x)+waveoffset[1], (((drawy-8)+offsety)+random_range(-global._textshaking[0],global._textshaking[0]))+(sprite_get_yoffset(sptodraw)*scale_y)+waveoffset[0], scale_x, scale_y, 0, #FFFFFF, alpha);
											}
											drawx += keysize;
											curchar ++;
											break;
										}
									}
								break;
							}
						}
					}
				}
			}
		}
		
		if(global._font == "dh_fontnes"){
			gpu_set_texfilter(global._texfilter);
		}
	}
}