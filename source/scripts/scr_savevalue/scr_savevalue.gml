///function scr_savevalue(value, key, file, [section], [openini], [closeini])
function scr_savevalue(value, key, file, section = "", openini = true, closeini = true){
	
	if(openini){
		ini_open(file+".ini");
	}
	if( typeof(value) == "number" ){
		ini_write_real(section, key, value);
	} else if( typeof(value) == "string" ){
		ini_write_string(section, key, value);
	} else if( typeof(value) == "bool" ){
		var str;
		if(value){
			str = "true";
		} else {
			str = "false";
		}
		ini_write_string(section, key, str);
	}
	if(closeini){
		ini_close();
	}
}