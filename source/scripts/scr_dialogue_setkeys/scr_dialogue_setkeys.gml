function scr_dialogue_setkeys(str, keys_array){
	keys_array = [];
	var split = string_split(str, "keycode");
	for(var i = 0; i < array_length(split); i++){
		if(string_starts_with(split[i], ">") || string_starts_with(split[i], "@")){
			var symbol = ">";
			if(string_starts_with(split[i], "@")){
				symbol = "@";
			}
			keys_array[array_length(keys_array)] = "keycode"+symbol+string_copy(split[i], 2, string_length(split[i])-1)+"keycode";
		}
	}
	return keys_array;
}