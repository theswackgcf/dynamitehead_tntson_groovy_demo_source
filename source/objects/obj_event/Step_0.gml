{
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
	
	if(!_init){
		switch(global._location){
			case 0:
				//toxic trenches
				_defcolors = [hex_to_rgb("#8b6dbc"),hex_to_rgb("#112a51")] //[dark part, bright part]
			break;
			case 1:
				if(!global._bossstart){
					//groovy graveyard
					_defcolors = [hex_to_rgb("#208a19"),hex_to_rgb("#0f0408")] //[dark part, bright part]
				} else {
					//lanky larry
					_defcolors = [hex_to_rgb("#48d4ae"),hex_to_rgb("#140d03")] //[dark part, bright part]
				}
			break;
		}
		
		if(_overridecol){
			//override colors
			_defcolors = [_ov_col1[0],_ov_col2[0]] //[dark part, bright part]
			if(global._buildver == HTML){
				_defcolors = [_ov_col1[1],_ov_col2[1]] //[dark part, bright part]
			}
		}
		
		_init = true;
	}
	
	if(!_checkdelete){
		if(_destroy){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					instance_destroy();
				}
			}
		}
		_checkdelete = true;
	} else {
		if(_init){
			_timer ++;
		
			if(!global._dialogue && _timer >= 3 && place_meeting(x, y, obj_dh_mask)){
				_dh = instance_place(x,y,obj_dh_mask);
				if(!_trigger){
					switch(_event){
						case "lighting":
							with(obj_lighting){
								_colorTo[0] = other._defcolors[0];
								_colorTo[1] = other._defcolors[1];
								_spd = other._spd;
								_draw = true;
							}
						break;
						case "muffled":
							with(obj_music){
								global.music_bus.effects[0] = _ef_muffled;
							}
						break;
						case "rainstart":
							with(obj_st2_rain){
								_start = true;
							}
						break;
						case "rainstop":
							with(obj_st2_rain){
								_stop = true;
							}
						break;
						case "mashfill":
							_dh._forcemash = true;
						break;
						case "tntfill":
							_dh._forcemash = false;
							_dh._forcetnt = true;
						break;
						case "fridge_parryspot":
							_dh._parryspot = true;
						break;
					}
			
					if(_destroy){
						global._deletedStuff[? self.id] = self.id;
				
						instance_destroy();
					}
			
					_trigger = true;
				}
			}
			if(_dh != noone && instance_exists(_dh)){
				if(!place_meeting(x, y, _dh)){
					switch(_event){
						case "lighting":
							_trigger = false;
				
							with(obj_lighting){
								_colorTo[0] = [0,0,0];
								_colorTo[1] = [0,0,0];
								_spd = other._spd;
							}
							_dh = noone;
						break;
						case "muffled":
							_trigger = false;
				
							with(obj_music){
								global.music_bus.effects[0] = undefined;
							}
						break;
						case "fridge_parryspot":
							_trigger = false;
							
							_dh._parryspot = false;
						break;
					}
				}
			}
		}
	}
}