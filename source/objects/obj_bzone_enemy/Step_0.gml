{
	if(!_die){
		if(!_colorsinit){
			_enmtypes = global._enmtypes[? _codename];
			_maxcolors = global._maxcolors[? _codename];
		
			if(ds_map_exists(global._enemyColors, _codename)){
				if(_enmtype != -1){
					_rep = _enmtypes[_enmtype][0];
					makecolors("def",_rep,_codename);
				}
			}
			_colorsinit = true;
		}
	
		if(_drag){
			if(global._battleobj != noone && instance_exists(global._battleobj)){	
				if(keyboard_check_pressed(vk_left)){
					_dir = "l";
				}
				if(keyboard_check_pressed(vk_right)){
					_dir = "r";
				}
				if(keyboard_check_pressed(vk_up)){
					_dir = "u";
				}
				if(keyboard_check_pressed(vk_down)){
					_dir = "d";
				}
				if(keyboard_check_pressed(vk_backspace)){
					_dir = "c";
				}
		
				switch(_dir){
					case "c":
						x = mouse_x+_dragoffset[0];
						y = mouse_y+_dragoffset[1];
					break;
					case "l":
						x = global._battleobj.x-(global._battleobj._bzSize[0]/2)+global._battlezonerange;
						y = mouse_y+_dragoffset[1];
					break;
					case "r":
						x = global._battleobj.x+(global._battleobj._bzSize[0]/2)-global._battlezonerange;
						y = mouse_y+_dragoffset[1];
					break;
					case "u":
						x = mouse_x+_dragoffset[0];
						y = global._battleobj.y-(global._battleobj._bzSize[1]/2)+global._battlezonerange;
					break;
					case "d":
						x = mouse_x+_dragoffset[0];
						y = global._battleobj.y+(global._battleobj._bzSize[1]/2)-global._battlezonerange;
					break;
				}
			
				//update values
				global._bzone_enemies[global._battleobj._curwave][_index][0] = _dir;

				var temparray = [];
				switch(_dir){
					case "c":
						var temparray = [];
						array_push(temparray,(global._battleobj._bzSize[0]/2)+(x-global._battleobj.x));
						array_push(temparray,(global._battleobj._bzSize[1]/2)+(y-global._battleobj.y));
						global._bzone_enemies[global._battleobj._curwave][_index][1] = temparray;
					break;
					case "l":
					case "r":
						global._bzone_enemies[global._battleobj._curwave][_index][1] = (global._battleobj._bzSize[1]/2)+(y-global._battleobj.y);
					break;
					case "u":
					case "d":
						global._bzone_enemies[global._battleobj._curwave][_index][1] = (global._battleobj._bzSize[0]/2)+(x-global._battleobj.x);
					break;
				}
				
				global._bzone_enemies[global._battleobj._curwave][_index][2] = _order;
			}
		}
	
		if(_dir == "r"){
			image_xscale = -1;
		} else {
			image_xscale = 1;
		}
		image_yscale = 1;
	
		if(scr_mousehover(bbox_left,bbox_top,bbox_right,bbox_bottom,false,1)){
			with(obj_bz_maker){
				_hover_enm = other.id;
				_hovertimer = 5;
			}
		}
	} else {
		_dietimer ++;
		if(_dietimer > 4){
			instance_destroy();
		}
	}
	
	if(global._battleobj != noone && instance_exists(global._battleobj)){	
		if(_wave > array_length(global._battleobj._enemies)){
			with(obj_bz_maker){
				_hover_enm = noone;
				_last_enm = noone;
				_hovertimer = 0;
			}
			instance_destroy(_hover_enm);
		}
	}
	
	if(!global._bzmaker || !global._battlezone){
		instance_destroy();
	}
}