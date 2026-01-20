// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function hex_to_rgb(argument0){
	var text = argument0

	if (string_char_at(text, 1) == "#") {
	    text = string_delete(text, 1, 1)
	}

	if (string_char_at(text, 1) == "$") {
	    text = string_delete(text, 1, 1)
	}

	var len = string_length(text)
	var hex = array_create(len)
	var i

	for (i = 0; i < len; i += 1){
	    hex[i] = string_char_at(text, i + 1)
	}

	len = array_length_1d(hex)
	var r = 0
	var g = 0
	var b = 0

	for (i = 0; i < len; i++){
	    switch(string_upper(hex[i])){
	        case "A":
	            hex[i] = 10
	            break
                  
	        case "B":
	            hex[i] = 11
	            break
              
	        case "C":
	            hex[i] = 12
	            break
              
	        case "D":
	            hex[i] = 13
	            break
              
	        case "E":
	            hex[i] = 14
	            break
              
	        case "F":
	            hex[i] = 15
	            break
              
	        default:
	            hex[i] = real(hex[i])
	    }
	}

	if len == 6 {
	    r = hex[0] * 16 + hex[1]
	    g = hex[2] * 16 + hex[3]
	    b = hex[4] * 16 + hex[5]
	} else if len == 3 {
	    r = hex[0] * 16 + hex[0]
	    g = hex[1] * 16 + hex[1]
	    b = hex[2] * 16 + hex[2]
	} else if len == 2 {
	    r = hex[0] * 16 + hex[1] 
	    g = r
	    b = r
	} else if len == 1 {
	    r = hex[0] * 16 + hex[0]
	    g = r
	    b = r
	}

	return [r, g, b]
}