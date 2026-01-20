{
	if(_getdata){
		_fontsprite = asset_get_index(get_string("font sprite index", "spr_testfont"));
		if(_fontsprite != -1 && sprite_exists(_fontsprite)){
			_storedebug = global._showDebug;
			global._showDebug = -1;
				_fontwidth = sprite_get_width(_fontsprite);
				_fontheight = sprite_get_height(_fontsprite);
				
				if(!_loadeddata){
					_monospace = bool_to_string(get_string("monospace font? (true/false)","false"), true);
					if(!_monospace){
						_spacew = real(get_string("spacebar width", string(floor(sprite_get_width(_fontsprite)/2.5))));
					} else {
						_monospace_w = real(get_string("monospace width", string(sprite_get_width(_fontsprite))));
						_spacew = _monospace_w;
					}
					_accuracy = clamp(real(get_string("accuracy (0.1-1)", "1")), 0.1, 1);
					_font_init = 1;
				} else {
					_font_init = 2;
				}
				_subimg = 0;
			_getdata = false;
		} else {
			_getdata = false;
		}
	} else {
		if(!_savepopup && !_introtext){
			if(keyboard_check_pressed(vk_enter)){
				if(!_savepopup && keyboard_check_pressed(vk_enter)){
					_drawpos = [_defpos[0],_defpos[1]];
					_surfscale = 1;
					if(!_loadeddata){
						_fontdata = ds_map_create();
					}
					_monospace = false;
					_getdata = true;
					_introtext = true;
				}
			} else if(keyboard_check(vk_control)){
				//load font data
				if(keyboard_check_pressed(ord("L"))){
					_loadeddata = false;
					var dsmap = get_string("copy font data here","");
					try {
						if(dsmap != ""){
							//separate json into entries and arrays
							var jsonstring = dsmap;
							var entries = string_split(jsonstring, "\"");
							var arrays = string_split(string_split(jsonstring, "["), "]");
							var realentries = [];
							var realarrays = [];
							
							//separate entries
							for(var i = 0; i < array_length(entries); i++){
								if(i%2 == 1){
									array_push(realentries, real(entries[i]));
								}
							}
							
							//separate arrays
							for(var i = 0; i < array_length(arrays); i++){
								var arraytext = string_split(string_replace_all(arrays[i], "\"", ""), ",", true);
								if(array_length(arraytext) == 3){
									array_push(realarrays, [real(arraytext[1]),real(arraytext[2])]);
								}
							}
							
							//paste into ds map
							_fontdata = ds_map_create();
							for(var i = 0; i < array_length(realentries); i++){
								_fontdata[? realentries[i]] = realarrays[i];
							}
							_loadeddata = true;
						}
					} catch(e) {
						show_debug_message("bad ds map data\n"+string(e));
					}
				}
			}
		}
	}
	
	if(_clipboard){
		clipboard_set_text(ds_map_write(_fontdata));
		_widthclip = 1.6;
		_clipboard = false;
	}
	
	if(_widthclip > 0){
		_widthclip -= 0.007;
	}
	
	if(_exportval){
		//assemble font json
		var arrexport = [];
		array_push(arrexport, "{");
		array_push(arrexport, "	\"frames\": [");
		var dskeys = ds_map_keys_to_array(_exportdata);
		for(var i = 0; i < array_length(dskeys); i++){
			array_push(arrexport, "		{");
					
			array_push(arrexport, "			\"frame\": {");
			array_push(arrexport, "				\"x\": "+string(_exportdata[? i][? "x"])+",");
			array_push(arrexport, "				\"y\": "+string(_exportdata[? i][? "y"])+",");
			array_push(arrexport, "				\"w\": "+string(_exportdata[? i][? "w"])+",");
			array_push(arrexport, "				\"h\": "+string(_exportdata[? i][? "h"]));
			array_push(arrexport, "			}");
					
			if(i < array_length(dskeys)-1){
				array_push(arrexport, "		},");
			} else {
				array_push(arrexport, "		}");
			}
		}
		array_push(arrexport, "	]");
		array_push(arrexport, "}");
				
		//assemble json array into a single string
		var strexport = string_join_ext("\n",arrexport);
				
		var addtime = "-"+string(current_year)+"-"+string(current_month)+"-"+string(current_day)+"-"+string(current_hour)+"-"+string(current_minute)+"-"+string(current_second);
		var files = ["dh_exportedfont"+addtime+".json","dh_exportedfont"+addtime+".png"];
				
		//export string into a json and save to working directory
		var file_id = file_text_open_write(_dir+files[0]);
		file_text_write_string(file_id, strexport);
		file_text_close(file_id);
				
		//save .png
		surface_save(_fontsurface, _dir+files[1]);
				
		//copy path and do popup
		clipboard_set_text(game_save_id+_dir);
				
		_popuptimer = 60;
		_savepopup = true;
		
		_exportval = false;
	}
	
	if(!_savepopup && _font_init == 2){
		if(keyboard_check(vk_control)){
			if(keyboard_check_pressed(ord("S"))){
				_spacing = real(get_string("Font grid spacing",string(_spacing)));
				_string_spacing = real(get_string("Preview text spacing",string(_string_spacing)));
				_drawpos = [_defpos[0],_defpos[1]];
				_modifyexport = true;
			} else if(keyboard_check_pressed(ord("E"))){
				_exportval = true;
			} else if(keyboard_check_pressed(ord("C"))){
				//supply charset
				var charset_temp = get_string("Current charset", _charset_string);
				if(string_starts_with(charset_temp, "global._charset[? \"") || string_starts_with(charset_temp, "global._charset[?\"")){
					if(string_ends_with(charset_temp, "\"]")){
						//get existing charset from ds map
						var charset_isolate = string_split(charset_temp,"\"")[1];
						if(ds_map_exists(global._charset, charset_isolate)){
							_charset = global._charset[? charset_isolate];
							_charset_string = "global._charset[? \""+charset_isolate+"\"]";
						} else {
							_charset = global._charset[? "ascii"];
							_charset_string = "global._charset[? \"ascii\"]";
						}
					} else {
						_charset = charset_temp;
						_charset_string = charset_temp;
					}
				} else {
					_charset = charset_temp;
					_charset_string = charset_temp;
				}
			} else if(keyboard_check_pressed(ord("T"))){
				_test_string = get_string("Preview string", _test_string);
			} else if(keyboard_check_pressed(ord("F"))){
				clipboard_set_text(json_encode(_fontdata));
				_widthclip = 1.6;
			}
		}
		
		//dragging surface
		if(mouse_check_button_pressed(mb_left)){
			_drag = true;
			_dragoffset = [_drawpos[0]-mouse_x,_drawpos[1]-mouse_y];
		}
		if(!mouse_check_button(mb_left)){
			_drag = false;
		}
		
		if(_drag){
			_drawpos[0] = mouse_x+_dragoffset[0];
			_drawpos[1] = mouse_y+_dragoffset[1];
		}
		
		//scaling surface
		var oldscale = _surfscale;
		
		if(mouse_wheel_up()){
			var newscale = min(oldscale + 0.3, 16);
		}
		else if(mouse_wheel_down()){
			var newscale = max(oldscale - 0.3, 0.1);
		}
		else{
			newscale = oldscale;
		}
		
		if(newscale == oldscale) exit;
		
		_drawpos[0] = mouse_x - ((mouse_x - _drawpos[0]) * (newscale / oldscale));
		_drawpos[1] = mouse_y - ((mouse_y - _drawpos[1]) * (newscale / oldscale));
		
		_surfscale = newscale;
	}
	
	if(_savepopup){
		_popuptimer --;
		if(_popuptimer <= 0 && mouse_check_button_pressed(mb_left)){
			_savepopup = false;
		}
	}
}