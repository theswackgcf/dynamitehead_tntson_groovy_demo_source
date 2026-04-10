{
	//restart
	if(global._debug){
		if(global._state != "game" || (global._state == "game" && instance_number(obj_gui) > 0)){
			if(keyboard_check_pressed(vk_f2)){
				global._loadState = "start";
				with(obj_music){
					global.music_bus.effects[0] = undefined;
				}
				audio_stop_all();
				room_goto(room_first);
			}
		
			//debug shortcuts
			if(keyboard_check_pressed(vk_tab)){
				global._showDebug ++;
				if(global._showDebug >= 3){
					global._showDebug = 0;
				}
			}
		
			if(keyboard_check(vk_shift)){
				if(keyboard_check_pressed(ord("1"))){
					audio_stop_all();
					room_goto(r_debug);
				}
			}
		
			if(keyboard_check(vk_alt)){
				if(keyboard_check_pressed(ord("Q"))){
					global._showHitbox = !global._showHitbox;
				}
			
				if(keyboard_check_pressed(ord("E"))){
					global._freeRoam = !global._freeRoam;
				}
			
				if(keyboard_check_pressed(ord("P"))){
					global._debughidepause = !global._debughidepause
				}
				
				if(keyboard_check_pressed(ord("C"))){
					global._enableCamera = !global._enableCamera;
				}
			
				if(keyboard_check_pressed(ord("K"))){
					global._knockouts ++;
				}
			
				if(keyboard_check_pressed(ord("T"))){
					global._showTexGroupDebug = !global._showTexGroupDebug;
				}
			
				if(keyboard_check_pressed(ord("M"))){
					global._showMemoryDebug = !global._showMemoryDebug;
					if(global._showMemoryDebug){
						//count ds maps and sequence layers
						_dbg_mapcount = 0;
						for(var i = 0; i < 10000; i++){
							if(ds_exists(i, ds_type_map)){
								_dbg_mapcount++;
							}
						}
						_dbg_layercount = 0;
						if(variable_global_exists("_sequenceLayers")){
							if(global._sequenceLayers != -1){
								var seqlayers = ds_map_keys_to_array(global._sequenceLayers);
								_dbg_layercount = array_length(seqlayers);
							}
						}
					}
				}
			}
		
			if(keyboard_check(ord("T"))){
				if(variable_global_exists("_tntjuice")){
					global._tntjuice += 5;
					if(global._tntjuice >= global._tntjuice_max){
						global._tntjuice = global._tntjuice_max;
					}
					with(obj_gui){
						ui_fade("tnt", 1);
					}
				}
			}
		
			//battlezone maker
			if(global._state == "game"){
				if(keyboard_check(vk_alt) && keyboard_check_pressed(ord("B"))){
					global._bzmaker = !global._bzmaker;
				}
			} else {
				global._bzmaker = false;
			}
		}
	}
}