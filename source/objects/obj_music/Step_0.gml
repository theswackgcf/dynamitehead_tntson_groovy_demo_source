{
	if(_musicstart){
		if(!_musicinit){
			switch(global._state){
				case "menu":
					if(!audio_is_playing(mus_menuintro)){
						mus_play(mus_menuintro, 1);
					}
				break;
				case "comics":
					if(!audio_is_playing(mus_briefing)){
						mus_play(mus_briefing, 0.86);
					}
				break;
				case "game":
					if(!global._bossmusic){
						if(!global._tutorial){
							var curtheme = asset_get_index("mus_theme"+string(global._location+1));
							if(audio_exists(curtheme)){
								if(!audio_is_playing(curtheme)){
									mus_play(curtheme, 0.8);
								}
							}
						} else {
							if(!audio_is_playing(mus_tutorial)){
								mus_play(mus_tutorial, 1);
							}
						}
					} else {
						var bossmusic = asset_get_index("mus_boss"+string(global._location+1));
						if(!audio_is_playing(bossmusic)){
							mus_play(bossmusic, global._bossgains[global._location]);
						}
					}
					
					if(global._cursong != -1){
						audio_sound_set_track_position(global._cursong, global._saveMusPos);
					}
				break;
			}
		
			_musicinit = true;
		} else {
			global._musFadeLerp = lerp(global._musFadeLerp, global._musFade, 0.06);
		}
	}
	
	if(_musicstart){
		if(!global._pause && _musindex != -1 && global._cursong != -1 && !global._forceStopMusic && !audio_is_playing(_musindex)){
			_musnotplaying ++;
			if(_musnotplaying >= 60){
				mus_play(_musindex);
				_resumepos = true;
			}
		} else {
			_musnotplaying = 0;
		}
		
		if(_resumepos){
			if(ds_map_exists(global._musicPos, audio_get_name(global._cursong))){
				audio_sound_set_track_position(global._cursong, global._musicPos[? audio_get_name(global._cursong)]);
			}
			global.music_bus.effects[0] = global._storeEffect;
			_resumepos = false;
		}
	}
	
	//loop from specifc point
	if(global._cursong != -1){
		var pos = audio_sound_get_track_position(global._cursong);
		if(ds_map_exists(global._loops, audio_get_name(global._cursong))){
			if(global._looped == 0 && pos >= global._loops[? audio_get_name(global._cursong)]){
				global._looped = 1;
			}
		}
		if(global._looped == 1 && ds_map_exists(global._loops, audio_get_name(global._cursong)) && pos < global._loops[? audio_get_name(global._cursong)]){
			audio_sound_set_track_position(global._cursong, global._loops[? audio_get_name(global._cursong)]);
		}
	}
}