{
	draw_set_color(_bgcolor);
	draw_rectangle(0,0,WIDTH,HEIGHT,false);
	draw_set_color(c_white);

	if(_font_init == 1){
		global._showDebug = -1;
		
		if(surface_exists(_glyphsurface)){
			scr_textrender_type(0,_fontheight, "Calculating width of every character...\nThis might take some time\n"+string(_subimg+1)+"/"+string(sprite_get_info(_fontsprite).num_subimages) + " (" + string(round(((_subimg+1)/sprite_get_info(_fontsprite).num_subimages)*100)) + "%)");
			surface_set_target(_glyphsurface);
			draw_clear_alpha(c_black, 0);
			draw_sprite(_fontsprite, _subimg, 0,0);
			
			if(!_doglyph){
				//create widths
				if(!_monospace){
					for(var yy = 0; yy < _fontheight*_accuracy; yy++){
						for(var xx = 0; xx < _fontwidth*_accuracy; xx++){
							//store position only if alpha is greater than 0
							var col = surface_getpixel_ext(_glyphsurface, xx/_accuracy,yy/_accuracy);
							var alpha = (col >> 24) & 255;
							if(alpha > 0){
								if(xx/_accuracy > 0){
									array_push(_lowestx, round(xx/_accuracy));
								}
								if(xx/_accuracy < _fontwidth){
									array_push(_highestx, round(xx/_accuracy));
								}
							}
						}
					}
					_startw = array_min(_lowestx);
					_endw = array_max(_highestx);
				} else {
					_startw = _fontwidth-_monospace_w;
					_endw = _fontwidth-(_fontwidth-_monospace_w);
				}
				
				_doglyph = true;
			} else {
				if(!ds_map_exists(_fontdata, _subimg)){
					_fontdata[? _subimg] = [];
				} else {
					_fontdata[? _subimg][0] = _startw;
					if(_endw-_startw <= 0){
						_fontdata[? _subimg][1] = _spacew;
					} else {
						_fontdata[? _subimg][1] = _endw-_startw;
					}
				
					_subimg ++;
					_doglyph = false;
					
					_lowestx = [];
					_highestx = [];
					_startw = 0;
					_endw = 0;
					
					if(_subimg >= sprite_get_info(_fontsprite).num_subimages){
						global._showDebug = _storedebug;
						_font_init = 2;
					}
				}
			}
			
			surface_reset_target();
			draw_surface(_glyphsurface, 0, 0);
		} else {
			_glyphsurface = surface_create(WIDTH, HEIGHT);
		}
	} else {
		if(_font_init == 2){
			var offset = _spacing;
			var size_curx = offset;
			var size_cury = 1;
			var offsetborder = _hborder+(offset*2)
			
			_fontsurface_dim[0] = offsetborder;
			
			//calc surface size
			for(var i = 0; i < ds_map_size(_fontdata); i++){
				if(is_array(_fontdata[? i]) && array_length(_fontdata[? i]) == 2){
					size_curx += _fontdata[? i][1]+_spacing;
					size_curx += _fontdata[? i][0];
					if(size_curx >= offsetborder){
						if(_fontsurface_dim[0] < size_curx){
							_fontsurface_dim[0] = size_curx;
						}
						size_curx = offset;
						size_cury ++;
					}
				}
			}
			
			_fontsurface_dim[1] = (size_cury*_fontheight)+(size_cury*_spacing)+offset;
			
			if(surface_exists(_fontsurface)){
				surface_resize(_fontsurface, _fontsurface_dim[0], _fontsurface_dim[1]);
				
				//draw glyphs depending on widths
				surface_set_target(_fontsurface);
				draw_clear_alpha(c_black, 0);
				var curx = offset;
				var cury = offset;
				
				//draw onto surface
				for(var i = 0; i < ds_map_size(_fontdata); i++){
					if(is_array(_fontdata[? i]) && array_length(_fontdata[? i]) == 2){
						curx += _fontdata[? i][0];
						
						if(_modifyexport){
							_exportdata[? i] = ds_map_create();
							_exportdata[? i][? "x"] = curx;
							_exportdata[? i][? "y"] = cury;
							_exportdata[? i][? "w"] = _fontdata[? i][1];
							_exportdata[? i][? "h"] = _fontheight;
							
							if(i >= ds_map_size(_fontdata)-1){
								_modifyexport = false;
							}
						}
						
						if(!_exportval && ds_map_exists(_exportdata, i)){
							draw_set_color(c_red);
							var bounds = [_exportdata[? i][? "x"], _exportdata[? i][? "y"], _exportdata[? i][? "x"]+_exportdata[? i][? "w"], _exportdata[? i][? "y"]+_exportdata[? i][? "h"]];
							draw_rectangle(bounds[0], bounds[1], bounds[2], bounds[3], true);
							draw_set_color(c_white);
						}
						draw_sprite(_fontsprite, i, curx-_fontdata[? i][0], cury);
						curx += _fontdata[? i][1]+_spacing;
						if(curx >= offsetborder){
							curx = offset;
							cury += _fontheight+_spacing;
						}
					}
				}
				surface_reset_target();
				
				draw_set_color(c_yellow);
				draw_rectangle(_drawpos[0],_drawpos[1],_drawpos[0]+(surface_get_width(_fontsurface)*_surfscale),_drawpos[1]+(surface_get_height(_fontsurface)*_surfscale), true);
				draw_set_color(c_white);
				draw_surface_stretched(_fontsurface, _drawpos[0], _drawpos[1], surface_get_width(_fontsurface)*_surfscale, surface_get_height(_fontsurface)*_surfscale);
				
				//draw preview text
				var drawpreviewpos = [_drawpos[0],_drawpos[1]+(surface_get_height(_fontsurface)*_surfscale)+(96*_surfscale)];
				scr_textrender_type(drawpreviewpos[0],drawpreviewpos[1]-(64*_surfscale), "Preview:", false, c_white, 1, _surfscale, _surfscale);
				
				var curx = drawpreviewpos[0];
				for(var i = 0; i < string_length(_test_string); i++){
					var curchar = "";
					for(var o = 0; o < string_length(_charset); o++){
						//compare string char and charset char
						if(string_char_at(_charset, o+1) == string_char_at(_test_string, i+1)){
							curchar = o;
							if(is_array(_fontdata[? curchar]) && array_length(_fontdata[? curchar]) == 2){
								curx += _fontdata[? curchar][0]*_surfscale;
								draw_sprite_ext(_fontsprite, curchar, curx-(_fontdata[? curchar][0]*_surfscale), drawpreviewpos[1], _surfscale, _surfscale, 0, c_white, 1);
								curx += (_fontdata[? curchar][1]+_string_spacing)*_surfscale;
							}
							break;
						}
					}
				}
			} else {
				_fontsurface = surface_create(_fontsurface_dim[0], _fontsurface_dim[1]);
			}
			
			var btstring = "CTRL+F: Copy font data\nGrid spacing: "+string(_spacing)+", Preview spacing: "+string(_string_spacing)+"\nCTRL+S: Change spacing\nCTRL+E: Export .png and .json";
			
			draw_set_color(c_black);
			draw_set_alpha(0.45);
			draw_rectangle(0, HEIGHT-32-scr_textrender_height(btstring), WIDTH, HEIGHT, false);
			draw_set_color(c_white);
			draw_set_alpha(1);
			scr_textrender_valign("bottom");
			scr_textrender_type(32, HEIGHT-32, btstring, false, c_white, 1, 0.7, 0.7);
			scr_textrender_halign("right");
			scr_textrender_type(WIDTH-32, HEIGHT-32, "Charset: "+_charset_string+"\nCTRL+C: Modify charset\nCTRL+T: Change preview text\n\n", false, c_white, 1, 0.7, 0.7);
			scr_textrender_halign("left");
			scr_textrender_valign("top");
		}
		
		
		if(!_introtext){
			var introtext = "DynamiteHead Font Maker\nPress keycode>ENTERkeycode to begin\n\nCTRL+L: Load existing font data";
			if(_loadeddata){
				introtext += "\n\n/yFont data has been supplied/w";
			}
			scr_textrender_type(32, 32, introtext);
		}
		
		if(_widthclip > 0){
			scr_textrender_type(0, 0, "Font data has been copied to clipboard.", false, c_white, clamp(_widthclip,0,1));
		}
		
		if(_savepopup){
			draw_set_color(c_black);
			draw_set_alpha(0.6);
			draw_rectangle(floor(WIDTH/2)-520,floor(HEIGHT/2)-164,floor(WIDTH/2)+520,floor(HEIGHT/2)+164,false);
			draw_set_alpha(1);
			draw_set_color(c_white);
			scr_textrender_halign("center");
			scr_textrender_valign("middle");
			scr_textrender_type(floor(WIDTH/2),floor(HEIGHT/2),scr_wordwrap("Font saved to\n"+string_replace_all(game_save_id+_dir, "\\","/")+"\nFile path has been copied to the clipboard\nLeft Click to remove this popup", 960, "\n", true));
			scr_textrender_halign("left");
			scr_textrender_valign("top");
		}
	}
}