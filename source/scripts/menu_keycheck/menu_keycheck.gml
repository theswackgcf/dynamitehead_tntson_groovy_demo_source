///function menu_keycheck(_key, _rapidfactor)
function menu_keycheck(_key, _rapidfactor = 1){
	var gamepad = "1";
	if(keyboard_check(vk_anykey)){
		gamepad = "0";
	}
	if(!ds_map_exists(_actiontimer, _key+gamepad)){
		_actiontimer[? _key+gamepad] = [false, 0];
	}
	
	//check both input types
	var maxind = 1;
	if(global._padfound){
		maxind = 2;
	}
	for(var i = 0; i < maxind; i++){
		if(check_keypress(global._input[i][? _key], i) || (check_key(global._input[i][? _key], global._inptype) && _actiontimer[? _key+gamepad][0] && _menutimer % (global._rapidtimer*_rapidfactor) < 1)){
			return true;
		}
	}
}