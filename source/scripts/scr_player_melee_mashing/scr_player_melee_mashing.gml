function scr_player_melee_mashing(){
	//mashing
	if(_mashenemy > 0){
		_mashenemy --;
	}
	if(_mashact > 0){
		_attack = true;
		_attacktype = "idle";
		_mashtime --;
		_mashattack ++;
		if(_mashact == 1){
			_spd[0] = _curdir;
		}
		_spd[1] = 0;
		if(!_mashko && !_mashpress && _mashact == 1 && _mashattack % 8 == 0){
			//do attacking
			_attackcooldown = 2;
			var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
			atk._parentobj = self.id;
			atk._scale = [8.5, 5.6];
			atk._offset = [176,-38];
			atk._timer = 5;
			atk._damage = ATK_MASH;
					
			sfx_play_choose(global._swishsounds[0]);
		}
		if(_mashtime <= 0 && _mashact == 1){
			_displayobj.image_index = 0;

			if(_mashenemy > 0 && _mashobj != noone && instance_exists(_mashobj) && !_mashobj._block){
				//enemy exists
				global._mashZoomMode = 1;
						
				with(obj_fade){
					_fadeTo = 1;
					_fadeSpd = 0.06;
				}
						
				_mashtime = 5;
				_mashact = 2;
						
				global._storeMashed = global.music_bus.effects[0];
				with(obj_music){
					global.music_bus.effects[0] = _ef_muffled;
				}
			} else {
				//no enemy to mash
				global._dhmashing = false;
				if(!_mashsuccess){
					_mashpenalty ++;
					if(_mashpenalty < _mashpenalty_max){
						global._tntjuice = global._tntjuice_store;
					} else {
						_mashpenalty = 0;
					}
				} else {
					_mashpenalty = 0;
				}
				_attack = false;
				_attacktype = "";
				_mashtime = 0;
				_mashattack = 0;
				_mashobj = noone;
				_mashact = 0;
				_mashko = false;
				_mashsuccess = false;
				
				_slide_cooldown = 12;
			}
		}
				
		var punchframe = 24;
				
		if(_mashact == 2){
			//camera
			global._mashZoom = true;
			global._mashZoomTimer = 2;
			global._mashinst = _displayobj;
			if(_mashobj != noone && instance_exists(_mashobj)){
				if(_mashobj.x >= x){
					global._cameraOffset = [global._defCamOffset[0]+diff_abs(x, _mashobj.x)/16, global._defCamOffset[1]-32];
				} else {
					global._cameraOffset = [global._defCamOffset[0]+(diff_abs(x, _mashobj.x)/16)*-1, global._defCamOffset[1]-32];
				}
			}
			
			//vibration
			if(_displayobj.image_index % 3 == 0){
				global._pad_vibrate = 2;
			}
					
			//play sounds in order
			for(var s = 0; s < array_length(_mashsounds); s++){
				if(_displayobj.image_index >= _mashsounds[s][1] && !_mashsounds[s][2]){
					if(_mashsounds[s][3] != 0){
						sfx_stop(_mashsounds[s][3]);
					}
					sfx_play(_mashsounds[s][0]);
					_mashsounds[s][2] = true;
				}
			}
					
			//punch to end this early
			if(_displayobj.image_index >= 4 && _displayobj.image_index < punchframe && !_mashko){
				if(keypress("punch")){
					_mashenemy = 0;
					_mashpress = true;
					with(obj_particle){
						if(_type == "mash"){
							instance_destroy();
						}
					}
					audio_stop_sound(snd_mashblip);
					_displayobj.image_index = punchframe-1;
				}
			}
					
			//do particles in order
			if(!_mashpress){
				for(var m = 0; m < array_length(_mashparticle); m++){
					if(_displayobj.image_index >= _mashparticle[m][2] && !_mashparticle[m][3]){
						var offset = -200;
						if(_curdir == DIR_L){
							offset = 54;
						}
						var p = instance_create_depth(_displayobj.x+offset, _displayobj.y-200, 0, obj_particle);
						p._type = _mashparticle[m][0];
						p._forcedepth = _displayobj.depth-8;
						p._angle = _mashparticle[m][1];
						_mashparticle[m][3] = true;
						sfx_play(snd_mashblip);
						sfx_pitch(snd_mashblip, random_range(1,1.3));
					}
				}
			}
					
			//freeze
			if(_displayobj.image_index >= punchframe-1 && !_mashfreeze){
				global._pad_vibrate = 20;
				_mashfreeze = true;
					
				global._mashZoomMode = 2;
					
				with(obj_fade){
					_fadeTo = 0;
					_fadeSpd = 1;
				}
					
				if(_mashobj != noone && instance_exists(_mashobj)){
					var freezevar = 28;
					_freeze = freezevar;
					_mashobj._freeze = freezevar;
				}
											
				with(obj_camera){
					_ampX = 28;
					_ampY = 28;
				}
								
				if(global._kdeffect){
					global._kohit = 16;
				}
			}
			
			//KO!!!!
			if(_displayobj.image_index >= punchframe && !_mashko){
				var atk = instance_create_depth(x, y, -1, obj_punchhitbox);
				atk._parentobj = self.id;
				atk._scale = [10, 5];
				atk._offset = [180,-64];
				atk._timer = 30;
				atk._damage = ATK_MASHKO;
					
				_mashko = true;
			}
					
			//end
			if(!instance_exists(_mashobj) || _mashobj._death || (_mashtime <= 0 && _displayobj.image_index >= _displayobj.image_number-1)){
				with(obj_fade){
					_fadeTo = 0;
					_fadeSpd = 0.3;
				}
						
				global._dhmashing = false;
				if(!_mashsuccess){
					_mashpenalty ++;
					if(_mashpenalty < _mashpenalty_max){
						global._tntjuice = global._tntjuice_store;
					} else {
						_mashpenalty = 0;
					}
				} else {
					_mashpenalty = 0;
				}
				_attack = false;
				_attacktype = "";
				_mashtime = 0;
				_mashattack = 0;
				_mashact = 0;
				_mashko = false;
				_mashfreeze = false;
				_mashobj = noone;
				_mashpress = false;
				_mashsuccess = false;
				
				_slide_cooldown = 12;
						
				with(obj_music){
					global.music_bus.effects[0] = global._storeMashed;
				}
						
				//reset sounds/particles
				for(var s = 0; s < array_length(_mashsounds); s++){
					_mashsounds[s][2] = false;
				}
				for(var m = 0; m < array_length(_mashparticle); m++){
					_mashparticle[m][3] = false;
				}
			}
		}
	}
			
	if(!instance_exists(_mashobj)){
		_mashobj = noone;
	}
}