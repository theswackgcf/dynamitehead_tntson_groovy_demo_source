{
	global._cursong = -1;
	
	if(!mouse_check_button(mb_left)){
		global._dragobj = noone;
	}
	
	with(obj_guimaker_spr){
		if(depth == 0){
			global._mainoffset = [x,y];
		}
	}
	
	if(keyboard_check_pressed(vk_escape)){
		if(_show){
			_show = false;
		} else {
			_show = true;
		}
	}
	
	if(keyboard_check_pressed(ord("B"))){
		if(_showborder){
			_showborder = false;
		} else {
			_showborder = true;
		}
	}
	
	//add new object
	if(keyboard_check_pressed(vk_space)){
		var spr_name = get_string("enter sprite name", "spr_gui_"); //i dont care if its deprecated. they made it worse with this async shit
		var ind = real(get_string("enter image index", "0"));
		if(sprite_exists(asset_get_index(spr_name))){
			var obj = instance_create_depth(floor(WIDTH/2),floor(HEIGHT/2),0,obj_guimaker_spr);
			obj._guimaker = self;
			obj.sprite_index = asset_get_index(spr_name);
			obj.image_index = ind;
			obj.image_speed = 0;
			obj.depth = _curdepth;
			_curdepth --;
			global._curobj = obj;
		}
	}
	//add new text
	if(keyboard_check_pressed(vk_backspace)){
		var texts = get_string("enter text", "");
		var tfont = get_string("enter font name", "dh_font");
		if(!array_contains(global._acceptedFonts, tfont)) return;
		var tsize = get_string("xscale yscale", "1 1");
		var tsize_array = string_split(tsize, " ");
		if(array_length(tsize_array) < 2) return;
		var talign = get_string("text align: (left | center | right), (top | middle | bottom)", "left, top");
		var talign_array = string_split(talign, ",");
		if(array_length(talign_array) < 2) return;
		var xscale = real(tsize_array[0]);
		var yscale = real(tsize_array[1]);
		var halign = string_trim(string_lower(talign_array[0]));
		var valign = string_trim(string_lower(talign_array[1]));
		var obj = instance_create_depth(floor(WIDTH/2),floor(HEIGHT/2),0,obj_guimaker_spr);
		obj._guimaker = self;
		obj.sprite_index = asset_get_index(spr_enm1_spawner);
		obj._font = tfont;
		obj._text = texts;
		obj._scale = [xscale,yscale];
		obj._halign = halign;
		obj._valign = valign;
		obj.depth = _curdepth;
		_curdepth --;
		global._curobj = obj;
	}
	if(keyboard_check_pressed(vk_down)){
		if(global._curobj != noone && instance_exists(global._curobj)){
			with(global._curobj){
				depth += 1;
			}
		}
	} else if(keyboard_check_pressed(vk_up)){
		if(global._curobj != noone && instance_exists(global._curobj)){
			with(global._curobj){
				depth -= 1;
			}
		}
	}
	
	//delete
	if(keyboard_check_pressed(vk_delete)){
		if(global._curobj != noone && instance_exists(global._curobj)){
			instance_destroy(global._curobj);
			global._curobj = noone;
			_curdepth ++;
		}
	}
	
	//log info
	if(keyboard_check_pressed(vk_enter)){
		for(var i = 0; i < instance_number(obj_guimaker_spr); i++){
			//don't remove this show_debug_message
			show_debug_message("---");
			var curobj = instance_find(obj_guimaker_spr, i);
			show_debug_message("spr: "+string( sprite_get_name(curobj.sprite_index)));
			show_debug_message("text: "+curobj._text);
			show_debug_message("font: "+curobj._font);
			show_debug_message("x: "+string(curobj.x));
			show_debug_message("y: "+string(curobj.y));
			show_debug_message("offset x: "+string(curobj.x - global._mainoffset[0]));
			show_debug_message("offset y: "+string(curobj.y - global._mainoffset[1]));
			show_debug_message("---");
		}
	}
	
	//save info
	if(keyboard_check(vk_control)){
		if(keyboard_check(ord("S"))){
			//save
			_dsmap = ds_map_create();
			for(var i = 0; i < instance_number(obj_guimaker_spr); i++){
				var curobj = instance_find(obj_guimaker_spr, i);
				var spr = sprite_get_name(curobj.sprite_index);
				var ind = curobj.image_index;
				_dsmap[? i] = [spr, ind, curobj.x, curobj.y, curobj.depth, curobj._text, curobj._font, curobj._scale[0], curobj._scale[1], curobj._halign, curobj._valign];
				clipboard_set_text(ds_map_write(_dsmap));
				_clipboard = 30;
			}
		} else if(keyboard_check(ord("L"))){
			//load
			_deleteall = true;
			try {
				var str = get_string("paste ds map data", "");
				if(str != ""){
					ds_map_read(_dsmap, str);
				}
			} catch(e) {
				_deleteall = false;
				show_debug_message("bad ds map data\n"+string(e));
			}
			if(_deleteall){
				with(obj_guimaker_spr){
					instance_destroy();
				}
			}
			
			for(var i = 0; i < ds_map_size(_dsmap); i++){
				var obj = instance_create_depth(0,0,0,obj_guimaker_spr);
				obj._guimaker = self;
				obj.sprite_index = asset_get_index(_dsmap[? i][0]);
				obj.image_index = _dsmap[? i][1];
				obj.image_speed = 0;
				obj.x = _dsmap[? i][2];
				obj.y = _dsmap[? i][3];
				obj.depth = _dsmap[? i][4];
				obj._text = _dsmap[? i][5];
				obj._font = _dsmap[? i][6];
				obj._scale[0] = _dsmap[? i][7];
				obj._scale[1] = _dsmap[? i][8];
				obj._halign = _dsmap[? i][9];
				obj._valign = _dsmap[? i][10];
			}
		}
	}
	
	if(keyboard_check_pressed(ord("T"))){
		if(global._guitrailer){
			global._guitrailer = false;
		} else {
			global._guitrailer = true;
		}
	}
}