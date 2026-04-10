{	
	if(!_init){
		if(global._buildver == HTML){
			array_push(_shader_array, shd_replace_col5);
			array_push(_shader_array, shd_replace_col4);
			array_push(_shader_array, shd_replace_col3);
		} else {
			array_push(_shader_array, shd_replace_col);
		}
		
		array_push(_shader_array, shd_wavy);
		array_push(_shader_array, shd_hue);
		array_push(_shader_array, shd_sepia);
		array_push(_shader_array, shd_glass);
		array_push(_shader_array, shd_wireframe);
		array_push(_shader_array, shd_solidcolor);
		array_push(_shader_array, shd_highcontrast);
		
		//set assets to load
		switch(global._loadState){
			//loading
			case "start":
				_drawbg = false;
				_compile_shaders = true;
				_load_textures = [
					"ui_sprites",
					"other_sprites",
					"menu_sprites",
					"pause_sprites",
					"stage_bgs",
				];
				_load_audio = [
					audiogroup_sfx,
					audiogroup_music,
					audiogroup_voices
				];
				
				_hold = 32;
			break;
			case "briefing":
				_silent = true;
				
				_flush_textures = [
					"menu_sprites",
				];
				_load_textures = [
					"comics_sprites",
					"pause_sprites",
					"dialogue_sprites",
					"stageintro",
				];
			break;
			case "stage":
				if(global._menututorial){
					_load_spr = spr_load_tutr;
					_load_textures = [
						"tutorial_gfx",
						"dh_sprites",
						"stage_generic",
						"fridge_sprites",
						"dialogue_sprites",
					];
				} else {
					_flush_textures = [
						"comics_sprites",
						"stageintro",
					];
					_load_textures = [
						"stage_bgs",
						"dh_sprites",
						"stage_generic",
						"dialogue_sprites",
						"results_sprites",
					];
					switch(global._location){
						case 0:
							array_push(_load_textures, 
								"lv1_gfx",
								"lv1_fg",
								"barrel_sprites",
								"stage1_enemies",
								"stage1_boss",
							);
						break;
						case 1:
							array_push(_load_textures, 
								"lv2_gfx",
								"stage2_enemy1",
								"stage2_enemy2",
								"stage2_enemy3",
							);
						break;
					}
				}
				
				_flush_textures = [
					"menu_sprites",
				];
			break;
			case "boss2":
				_silent = true;
			
				_flush_textures = [
					"stage2_enemy3",
				];
				_load_textures = [
					"stage2_boss",
				];
			break;
			
			case "tapes":
				_silent = true;
			
				_flush_textures = [
					"stageintro",
					"stage_bgs",
				
					"tutorial_gfx",
					"fridge_sprites",
					"dialogue_sprites",
				
					"stage_bgs",
					"dh_sprites",
					"stage_generic",
					"results_sprites",
					"lv2_gfx",
					"stage2_enemy1",
					"stage2_enemy2",
					"stage2_enemy3",
					"stage2_boss",
				];
			
				_load_textures = [
					"sprites_tape3",
				];
			break;
			case "minigame":
				_silent = true;
				
				_load_textures = [
					"pause_sprites",
					"ui_sprites",
				];
				
				switch(global._minigame){
					case "whack":
						array_push(_load_textures,"minigame1_sprites");
					break;
					case "lode":
						array_push(_load_textures,"minigame2_sprites");
					break;
				}
				
				_flush_textures = [
					"menu_sprites",
				];
			break;
			
			//flushing
			case "enddemo":
			case "tomenu":
				_silent = true;
			
				_load_textures = [
					"menu_sprites",
				];
			
				_flush_textures = [
					"dialogue_sprites",
					"stageintro",
					"stage_bgs",
				
					"tutorial_gfx",
					"fridge_sprites",
					"dialogue_sprites",
				
					"stage_bgs",
					"dh_sprites",
					"stage_generic",
					"results_sprites",
					"lv2_gfx",
					"stage2_enemy1",
					"stage2_enemy2",
					"stage2_enemy3",
					"stage2_boss",
					
					"comics_sprites",
					"sprites_tape3",
					
					"minigame1_sprites",
					"minigame2_sprites",
				];
			break;
		}
		
		if(!_compile_shaders){
			_shaders = true;
		}
		
		_total_array = array_concat(_load_textures, _load_audio);
		
		_assetnum = 0;
		
		_init = true;
	} else {
		if(_silent){
			global._doLoading = true;
		}
		if(global._doLoading){
			//flush textures/audios
			if(array_length(_flush_textures) > 0){
				for(var f = 0; f < array_length(_flush_textures); f++){
					texture_flush(_flush_textures[f]);
					texturegroup_unload(_flush_textures[f]);
					
					if(f == array_length(_flush_textures)-1){
						_flush[0] = true;
					}
				}
			} else {
				_flush[0] = true;
			}
			if(array_length(_flush_audio) > 0){
				for(var f = 0; f < array_length(_flush_audio); f++){
					if(audio_group_is_loaded(_flush_audio[f])){
						audio_group_unload(_flush_audio[f]);
					}
					if(f == array_length(_flush_audio)-1){
						_flush[1] = true;
					}
				}
			} else {
				_flush[1] = true;
			}
		
			//load assets
			if(_current_pass == 0){
				//texture group pass
				if(array_length(_load_textures) == 0){
					_current_pass = 1;
				} else {
					if(global._buildver == WINDOWS || global._gxLoading){
						//load each texture
						if(texturegroup_get_status(_load_textures[_assetnum]) == texturegroup_status_unloaded){
							_curasset = texturegroup_load(_load_textures[_assetnum], false);
						}
				
						//fetch texture's pages and adjust progress
						var pages = texturegroup_get_textures(_load_textures[_assetnum]);
						if(texturegroup_get_status(_load_textures[_assetnum]) != texturegroup_status_fetched){
							if(!texture_is_ready(pages[_curpage])){
								texture_prefetch(pages[_curpage]);
								_errorfix ++;
								if(_errorfix >= array_length(pages)){
									texturegroup_load(_load_textures[_assetnum]);
									_curpage = array_length(pages)-1;
								}
							} else {
								_errorfix = 0;
								_curpage ++;
								if(_curpage >= array_length(pages)-1){
									_curpage = array_length(pages)-1;
								}
							}
						} else {
							//texture already fetched
							_curpage = array_length(pages)-1;
						}
						if(array_length(pages) == 1){
							_progress = 1;
						} else if(array_length(pages) > 1){
							_progress = _curpage/array_length(pages);
						}
		
						if(_curasset == -1){
							//something went wrong, try again
							texturegroup_unload(_load_textures[_assetnum]);
							_total_count --;
							if(_total_count < 0){
								_total_count = 0;
							}
						} else {
							//texture has been loaded and fetched
							if((texturegroup_get_status(_load_textures[_assetnum]) == texturegroup_status_loaded
							|| texturegroup_get_status(_load_textures[_assetnum]) == texturegroup_status_fetched)
							&& _curpage >= array_length(pages)-1){
								_curpage = 0;
								_assetnum ++;
								_total_count ++;
						
								//next pass
								if(_assetnum >= array_length(_load_textures)){
									_assetnum = 0;
									_current_pass = 1;
								}
							}
						}
					} else if(global._buildver == HTML && !global._gxLoading){
						_spritearray = texturegroup_get_sprites(_load_textures[_assetnum]);
						if(_cursprite < array_length(_spritearray)){
							_spritedraw = _spritearray[_cursprite];
							_cursprite ++;
							
							_progress = _cursprite/array_length(_spritearray);
						} else {
							_cursprite = 0;
							_assetnum ++;
							_total_count ++;
							
							//next pass
							if(_assetnum >= array_length(_load_textures)){
								_spritedraw = -1;
								_assetnum = 0;
								_current_pass = 1;
							}
						}
					}
				}
			} else if(_current_pass == 1){
				//audio group pass
				if(array_length(_load_audio) == 0){
					_current_pass = 2;
				} else {
					//load each audio group
					if(!audio_group_is_loaded(_load_audio[_assetnum])){
						audio_group_load(_load_audio[_assetnum]);
						_progress = audio_group_load_progress(_load_audio[_assetnum])/100;
					} else {
						_assetnum ++;
						_total_count ++;
						
						//next pass
						if(_assetnum >= array_length(_load_audio)){
							_assetnum = 0;
							_current_pass = 2;
						}
					}
				}
			} else if(_current_pass == 2){
				_progress = 0;
				
				//compile shaders
				if(!_shaders){
					var comp = 0;
					for(var i = 0; i < array_length(_shader_array); i++){
						if(shader_is_compiled(_shader_array[i])){
							comp ++;
						}
					}
			
					//shaders compiled
					if(comp >= array_length(_shader_array)-1){
						_shaders = true;
					}
				} else {
					if(_flush[0] && _flush[1]){
						if(audio_is_playing(global._stageintro_theme)){
							audio_sound_gain(global._stageintro_theme, 0, 1000);
						}
						if(audio_is_playing(global._stageintro_leit)){
							audio_sound_gain(global._stageintro_leit, 0, 1000);
						}
						
						//assets loaded, go to a specific room
						switch(global._loadState){
							case "start":
								_loaded = true;
							break;
							case "briefing":
								roomto(r_briefing);
							break;
							case "stage":
								if(!global._menututorial){
									switch(global._location){
										case 0:
											roomto(r_stage1);
										break;
										case 1:
											roomto(r_stage2);
										break;
									}
								} else {
									roomto(r_tutorial);
								}
							break;
							case "boss2":
								roomto(r_stage2);
							break;
							case "tapes":
								roomto(r_enddemo);
							break;
							case "minigame":
								roomto(r_minigames);
							break;
							case "enddemo":
								audio_stop_all();
								roomto(r_gameintro);
							break;
							case "tomenu":
								global._backtomenu = true;
								roomto(r_menu);
							break;
						}
					}
				}
			}
		
			//total progress
			if(_total_count >= array_length(_total_array)-1){
				_total_count = array_length(_total_array)-1;
			}
			if(array_length(_total_array) > 0){
				_total_progress = min(1,(_total_count+1)/array_length(_total_array));
			} else {
				_total_progress = 1;
			}
		}
	}
}