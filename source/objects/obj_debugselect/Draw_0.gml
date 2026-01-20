{
	var curarray = _rooms;
	if(_full){
		curarray = _allrooms;
	}
	
	if(!_init){
		//sort array
		_dslist = ds_list_create();
		for(var i = 0; i < array_length(_rooms); i++){
			ds_list_add(_dslist, room_get_name(_rooms[i]));
		}
		
		ds_list_sort(_dslist, true);
		
		for(var i = 0; i < ds_list_size(_dslist); i++){
			_rooms[i] = asset_get_index(ds_list_find_value(_dslist, i));
		}
		ds_list_destroy(_dslist);
		_dslist = -1;
		
		_init = true;
	}
	
	if(keyboard_check_pressed(vk_down)){
		_curroom ++;
		if(_curroom > array_length(curarray)-1){
			_curroom = 0;
		}
	} else if(keyboard_check_pressed(vk_up)){
		_curroom --;
		if(_curroom < 0){
			_curroom = array_length(curarray)-1;
		}
	}
	
	if(keyboard_check_pressed(vk_enter)){
		audio_stop_all();
		room_goto(asset_get_index(curarray[_curroom]));
	}
	
	var yoffset = (0 - _curroom) * 48;
	
	for(var i = 0; i < array_length(curarray); i++){
		var loadonstart = scr_loadvalue("string", "startuproom", "debug", "noone", "", true, true);
		var loadonstartstring = "";
		if(loadonstart != "noone" && loadonstart == room_get_name(curarray[i])){
			loadonstartstring = " /y<instaload>/w";
		}
		var col = c_white;
		if(_full){
			col = c_lime;
		}
		if(_curroom == i){
			scr_textrender_type(32, 96+(i*48) + yoffset, "--- "+room_get_name(curarray[i])+loadonstartstring, false, col);
		} else {
			scr_textrender_type(32, 96+(i*48) + yoffset, room_get_name(curarray[i])+loadonstartstring, false, col);
		}
	}
	
	if(keyboard_check_pressed(vk_shift)){
		if(loadonstart == "noone" || (loadonstart != "noone" && room_get_name(curarray[_curroom]) != loadonstart)){
			scr_savevalue(room_get_name(curarray[_curroom]), "startuproom", "debug", "", true, true);
		}
		else{
			scr_savevalue("noone", "startuproom", "debug", "", true, true);
		}
	}
	
	if(keyboard_check_pressed(ord("Q"))){
		_full = !_full;
		_curroom = 0;
		if(array_length(_allrooms) == 0){
			for(var i = 0; room_exists(i); i++){
				_allrooms[i] = asset_get_index(room_get_name(i));
			}
			//sort array
			_dslist = ds_list_create();
			for(var i = 0; i < array_length(_allrooms); i++){
				ds_list_add(_dslist, room_get_name(_allrooms[i]));
			}
		
			ds_list_sort(_dslist, true);
		
			for(var i = 0; i < ds_list_size(_dslist); i++){
				_allrooms[i] = asset_get_index(ds_list_find_value(_dslist, i));
			}
			ds_list_destroy(_dslist);
			_dslist = -1;
		}
	}
	
	scr_textrender_halign("right");
	scr_textrender_valign("top");
	scr_textrender_type(WIDTH, 0, "Press \"SHIFT\" to mark a room\nto load instantly on startup.");
	
	scr_textrender_halign("right");
	scr_textrender_valign("bottom");
	scr_textrender_type(WIDTH, HEIGHT, "Press \"Q\" to see all rooms.");
}