function bool_to_string(boolean, string_to_bool = false){
	if(!string_to_bool){
		if(boolean){
			return "true";
		} else {
			return "false";
		}
	} else {
		if(string_lower(boolean) == "true"){
			return true;
		} else if(string_lower(boolean) == "false"){
			return false;
		}
	}
}