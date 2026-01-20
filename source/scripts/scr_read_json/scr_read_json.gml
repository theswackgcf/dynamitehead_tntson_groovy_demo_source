function scr_read_json(dir){
	if(file_exists(dir)){
		var json = "";
		var file = file_text_open_read(dir);
		while(!file_text_eof(file)){
			json += file_text_readln(file);
		}
		file_text_close(file);
		return json_parse(json);
	}
	return noone;
}