///function rapidfire(_key)
function rapidfire(_key){
	if(!ds_map_exists(_actiontimer, _key+string(global._inptype))){
		_actiontimer[? _key+string(global._inptype)] = [false, 0];
	} else {
		if(check_key(global._input[global._inptype][? _key], global._inptype)){
			var gamepad = "1";
			if(keyboard_check(vk_anykey)){
				gamepad = "0";
			}
			_actiontimer[? _key+gamepad][1] ++;
			if(_actiontimer[? _key+gamepad][1] >= 20){
				_actiontimer[? _key+gamepad][0] = true;
			}
		} else {
			_actiontimer[? _key+string(global._inptype)] = [false, 0];
		}
	}
}