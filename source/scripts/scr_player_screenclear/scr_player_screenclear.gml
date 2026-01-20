function scr_player_screenclear(){
	if(_blowup){
		_blowuptimer ++;
		_explosiontimer ++;
		global._tntZoomTimer = 5;
		if(_displayobj.image_index >= 14 && !_blowupexpl){
			_blowup_countperfect = 0;
			for(var e = 0; e < array_length(global._enemyArray); e++){
				with(global._enemyArray[e]){
					if(variable_instance_exists(self.id, "_boss")){
						if((_boss && _boss_active) || !_boss){
							if(!_inactive){
								other._blowup_countperfect ++;
							}
						}
					}
				}
			}
			
			if(_blowup_countperfect >= 3){
				sfx_play(snd_perfect);
			}
			
			global._tntZoomState = 1;
			sfx_play(snd_explosion2);
			with(obj_camera){
				_ampX = 36;
				_ampY = 36;
			}
			
			global._pad_vibrate = 8;
			
			var p = instance_create_depth(x, y, (_displayobj.depth)+99, obj_particle);
			p._type = "explosion";
			_blowupexpl = true;
		}
		if(_blowuptimer < 175){
			with(obj_camera){
				_ampY = 5;
			}
			if(_explosiontimer % 5 == 0){
				global._pad_vibrate = 1;
			}
			if(_explosiontimer % 8 == 4){
				var p = instance_create_depth(random_range(global._cameraX+24, (global._cameraX+WIDTH)-24), random_range(global._cameraY+24, (global._cameraY+WIDTH)-24), 0, obj_particle);
				p._type = "explosion";
				sfx_play(snd_explosion, 0.4);
			}
			with(obj_fade){
				_fadeTo = 1;
				_fadeSpd = 0.12;
			}
			for(var i = 0; i < array_length(global._enemyArray); i++){
				with(global._enemyArray[i]){
					if(variable_instance_exists(self.id, "_shockwave")){
						if(!_inactive && !_parachute){
							if(_behaviortype != "hopping" || _hop_walk){
								if(_phaseend_act == 0){
									_shockwave = true;
								}
								if(variable_instance_exists(self.id, "_begin")){
									if(_begin){
										if(_phaseend_act == 0){
											_curstate = STATE_OTHER;
											_curspd = [0,0];
											clearpath();
										}
									}
								} else {
									if(_phaseend_act == 0){
										_curstate = STATE_OTHER;
										_curspd = [0,0];
										clearpath();
									}
								}
							}
							/*if(variable_instance_exists(self.id, "_attacknum") && variable_instance_exists(self.id, "_attacktimer")){
								_attacknum = 0;
								_attacktimer = 0;
							}*/
						}
					}
				}
			}
			_spd = [0,0];
			_state = "tnt";
		} else {
			if(global._blowup_kill == 0){
				_blowupenm = 0;
				_blowupenmmax = 0;
				for(var i = 0; i < array_length(global._enemyArray); i++){
					with(global._enemyArray[i]){
						if(variable_instance_exists(self.id, "_inactive")){
							if(!_inactive && !_parachute){
								other._blowupenmmax ++;
							}
						}
					}
				}
				global._blowup_kill = 1;
			}
		}
	} else {
		_blowup_err = 0;
		global._blowup_kill = 0;
	}
	
	if(global._blowup_kill > 0){
		if(global._blowup_kill == 1){
			if(global._finalhit <= 0){
				for(var i = 0; i < array_length(global._enemyArray); i++){
					with(global._enemyArray[i]){
						if(variable_instance_exists(self.id, "_scrcleartimer")){
							if(!_idiot && !_inactive && !_parachute && !_scrclear){
								_scrclear_happened = true;
								if(other._blowupenmmax == 1){
									_scrcleartimer = 0;
								} else {
									_scrcleartimer = irandom(10);
								}
								_freeze = _scrcleartimer+1;
								_scrclear = true;
							}
						}
					}
				}
			}
			global._blowup_kill = 2;
		}
			
		for(var i = 0; i < array_length(global._enemyArray); i++){
			//kill enemies onscreen
			with(global._enemyArray[i]){
				if(variable_instance_exists(self.id, "_scrclearend")){
					if(_freeze <= 0 && _scrclearend){
						tntko_kill();
					}
				}
			}
		}
		
		//softlock prevention
		if(_blowupenm < _blowupenmmax){
			_blowup_err ++;
		}
		
		if(_blowupenm >= _blowupenmmax || instance_number_array(global._enemyArray) <= 0 || _blowup_err >= _blowup_errmax){
			_blowup = false;
			_blowuptimer = 0;
			_explosiontimer = 0;
			_state = "default";
			if(_blowup_err >= _blowup_errmax){
				global._tntjuice = 100;
			}
			with(obj_fade){
				_fadeTo = 0;
				_fadeSpd = 0.04;
			}
		}
	}
}