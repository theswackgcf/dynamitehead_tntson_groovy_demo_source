///function scr_textrender_typewrite(str, disp_str, char, [keys_array])
function scr_textrender_typewrite(str, disp_str, char, keys_array = []){
	if(array_length(keys_array) < 1){
		disp_str += string_char_at(str, char);
		char ++;
		
		return [disp_str, char];
	} else {
		if(string_copy(str, char, 8) == "keycode@" || string_copy(str, char, 8) == "keycode>"){
			//keycode
			for(var i = 0; i < array_length(keys_array); i++){
				if(string_copy(str, char, string_length(keys_array[i])) == keys_array[i]){
					//match
					disp_str += string_copy(str, char, string_length(keys_array[i]));
					char += string_length(keys_array[i]);
						
					return [disp_str, char];
				}
			}
		} else {
			disp_str += string_char_at(str, char);
			char ++;
			
			return [disp_str, char];
		}
	}
}