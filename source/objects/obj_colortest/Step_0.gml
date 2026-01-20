{
	if(!_init){
		_rep = _names[? _entities[_curent]][_curname][0];
		
		makecolors("def",_rep);
		_init = true;
	}
	
	if(keyboard_check_pressed(vk_add)){
		_zoom += 0.5;
	}

	if(keyboard_check_pressed(vk_subtract)){
		_zoom -= 0.5;
	}

	if(mouse_wheel_up()){
		_zoom += 0.2;
	} else if(mouse_wheel_down()){
		_zoom -= 0.2;
	}
	
	if(keyboard_check_pressed(ord("R"))){
		if(_curent == 0){
			makecolors("def",_rep);
		} else {
			makecolors("def",_rep, _entities[_curent]);
		}
	}
	
	if(keyboard_check_pressed(ord("A"))){
		_curtolindex --;
		if(_curtolindex < 0){
			_curtolindex = 3;
		}
	} else if(keyboard_check_pressed(ord("D"))){
		_curtolindex ++;
		if(_curtolindex > 3){
			_curtolindex = 0;
		}
	}
	
	var tolarray = [];
	if(_curent == 0){
		tolarray = global._colors[? _rep][1][0];
	} else {
		tolarray = global._enemyColors[? _entities[_curent]][? _rep][1][0];
	}

	if(keyboard_check(ord("Q"))){
		tolarray[_curtolindex] -= 0.01;
		tolarray[_curtolindex] = clamp(tolarray[_curtolindex], 0, 1);
		if(_curent == 0){
			makecolors("def",_rep);
		} else {
			makecolors("def",_rep, _entities[_curent]);
		}
	} else if(keyboard_check(ord("E"))){
		tolarray[_curtolindex] += 0.01;
		tolarray[_curtolindex] = clamp(tolarray[_curtolindex], 0, 1);
		if(_curent == 0){
			makecolors("def",_rep);
		} else {
			makecolors("def",_rep, _entities[_curent]);
		}
	}
	
	function doreplace() {
		_rep = _names[? _entities[_curent]][_curname][0];
		if(_curent == 0){
			makecolors("def",_rep);
		} else {
			makecolors("def",_rep, _entities[_curent]);
		}
	}
	
	if(keyboard_check_pressed(vk_up)){
		_curent --;
		if(_curent < 0){
			_curent = array_length(_entities)-1;
		}
		_curname = 0;
		doreplace();
	} else if(keyboard_check_pressed(vk_down)){
		_curent ++;
		if(_curent > array_length(_entities)-1){
			_curent = 0;
		}
		_curname = 0;
		doreplace();
	}
	
	if(keyboard_check_pressed(vk_left)){
		_curname --;
		if(_curname < 0){
			_curname = 0;
		}
		doreplace();
	} else if(keyboard_check_pressed(vk_right)){
		_curname ++;
		if(_curname > array_length(_names[? _entities[_curent]])-1){
			_curname = array_length(_names[? _entities[_curent]])-1;
		}
		doreplace();
	}
}