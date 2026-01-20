///function scr_loadvalue(type, key, file, default, [section], [openini], [closeini])
function scr_loadvalue(type, key, file, def, section = "", openini = true, closeini = true){
	if(openini){
		ini_open(file+".ini");
	}
	if( type == "number" ){
		return ini_read_real(section, key, def);
	} else if( type == "string" ){
		return ini_read_string(section, key, def);
	} else if( type == "bool" ){
		var tempbool = ini_read_string(section, key, def);
		if(tempbool == "true" || tempbool == true){
			return true;
		} else if(tempbool == "false" || tempbool == false){
			return false;
		} else {
			return false;
		}
	}
	if(closeini){
		ini_close();
	}
}