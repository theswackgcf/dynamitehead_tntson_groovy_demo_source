///scr_textrender_width(text, [line], [scale_x])
function scr_textrender_width(text, line = -1, scale_x = 1){
	if(global._fontInit){
		scr_textrender_spacing(0);
		
		var textReplace1 = string_replace_all(text, "\n", "/n");
		var textReplace2 = string_replace_all(textReplace1, "\\", "\\\\");
		var textArray = string_split(textReplace2, "/n");
	
		var totalwidth = [];
	
		var keyscale_nes = global._keyscale_nes;
	
		var _init_keyscale_x = scale_x;
		if(global._font == "dh_fontnes" || global._font == "dh_fontnes_lode"){
			_init_keyscale_x = scale_x*keyscale_nes;
		}
	
		var textKeySplit;
		var doText;
		var bindInput;
		var change = global._keybindW*_init_keyscale_x;
	
		for(var o = 0; o < array_length(textArray); o++){
			textKeySplit = string_split(textArray[o], "keycode");
			totalwidth[o] = 0;
			
			//calculate width
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
					for(var i = 0; i < string_length(textKeySplit[m]); i++){
						if(ds_map_exists(global._fontdata[? global._font], string_char_at(textKeySplit[m], i+1))){
							totalwidth[o] += (global._fontdata[? global._font][? string_char_at(textKeySplit[m], i+1)][2]);
						}
					}
				} else {
					var keysize = change;
					if(!bindInput){
						//key codes
						var keystring = string_lower(string_replace_all(textKeySplit[m], ">",""));
						for(var st = 0; st < array_length(global._binds); st++){
							if(string_lower(global._keystrings[st]) == keystring){	
								if(is_array(global._binds[st])){
									keysize = (sprite_get_width(global._binds[st][1]));
								}
							}
						}
					} else {
						//player defined inputs
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
											if(is_array(global._binds[i])){
												keysize = (sprite_get_width(global._binds[i][1]));
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
												keysize = (sprite_get_width(global._gpbinds[i][1]));
											}
											break;
										}
									}
								break;
							}
						}
					}
					
					totalwidth[o] += keysize;
				}
			}
		}
		
		var maxval = 0;
		for(var i = 0; i < array_length(totalwidth); i++){
			if(totalwidth[i]*scale_x > maxval){
				maxval = totalwidth[i]*scale_x;
			}
		}
		if(line == -1){
			return maxval;
		} else {
			if(line < array_length(totalwidth)){
				return totalwidth[line]*scale_x;
			} else {
				return totalwidth[line-1]*scale_x;
			}
		}
	}
}