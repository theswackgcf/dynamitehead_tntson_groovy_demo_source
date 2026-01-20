///scr_textrender_height(text, [array], [scale_y])
function scr_textrender_height(text, array = false, scale_y = 1){
	if(global._fontInit){
		var textReplace1 = string_replace_all(text, "\n", "/n");
		var textReplace2 = string_replace_all(textReplace1, "\\", "\\\\");
		var textArray = string_split(textReplace2, "/n");
		
		var textKeySplit;
		var lineHasKey = false;
		var defkeyheight = global._keybindH*scale_y;
		var totalheight = 0;
		
		for(var o = 0; o < array_length(textArray); o++){
			textKeySplit = string_split(textArray[o], "keycode");
			lineHasKey = false;
			for(var m = 0; m < array_length(textKeySplit); m++){
				if(string_starts_with(textKeySplit[m],">") || string_starts_with(textKeySplit[m],"@")){
					lineHasKey = true;
				}
			}
			if(!lineHasKey){
				totalheight += global._textheight[? global._font]*scale_y;
			} else {
				if(global._valign <> 1){
					totalheight += defkeyheight*2;
				} else {
					totalheight += defkeyheight*2.5;
				}
			}
		}
		
		if(!array){
			return totalheight;
		} else {
			return array_length(textArray);
		}
	}
}