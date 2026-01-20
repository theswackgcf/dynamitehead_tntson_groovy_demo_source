///scr_textrender_setfont(fontname, charset)
function scr_textrender_setfont(font, charset){
	global._font = font;
	global._fontInit = false;
	var buff = buffer_load("./jsondata/"+font+".json");
    var result = buffer_read(buff, buffer_string);
    buffer_delete(buff);
	var fontmap = json_parse(string(result));
	var fontdata = ds_map_create();
	
	global._textheight[? font] = fontmap.frames[0].frame.h;
	for(var i = 0; i < array_length(fontmap.frames); i++){
		fontdata[? string_char_at(charset, i+1)] = [
			fontmap.frames[i].frame.x,
			fontmap.frames[i].frame.y,
			fontmap.frames[i].frame.w,
			fontmap.frames[i].frame.h,
		];
	}
	
	array_push(global._acceptedFonts, font);
	
	global._fontmap[? font] = fontmap;
	global._fontdata[? font] = fontdata;
	global._fontInit = true;
}