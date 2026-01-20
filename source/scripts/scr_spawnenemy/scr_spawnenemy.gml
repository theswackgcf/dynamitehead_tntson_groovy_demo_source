///function scr_spawnenemy(object_index)
function scr_spawnenemy(enemyobj){
	if(!global._easteregg_goblin && !global._battlezone){
		if(!_checkdelete){
			if(global._deleteready){
				if(ds_map_exists(global._deletedStuff, self.id)){
					instance_destroy();
				}
				_checkdelete = true;
			}
		}
		if(_trigger){
			if(place_meeting(x,y,obj_fade)){
				var inst = instance_create_depth(x, y, depth, enemyobj);
				inst._ailevel += global._progress;
				inst._enmtype = _enmtype;
				inst._startTimer = 2;
				inst._startFade = _startFade;
				inst._deleteid = self.id;
				inst._matchid = _matchid;
				if(_nameoverwrite != ""){
					inst._nameoverwrite = _nameoverwrite;
				}
				
				if(_enmtrigger){
					inst._didspot = true;
					inst._spottimer = 0;
				}
				
				inst._glass = _glass;
				
				switch(_spawntype){
					//default spawn
					case SPAWN_NORMAL:
						inst._dh = instance_nearest(x, y, obj_dh_mask);
						if(inst._dh != noone && instance_exists(inst._dh)){
							inst._curstate = STATE_FOLLOW;
							inst._walkto = [(inst._dh).x,(inst._dh).y];
						}
						if(_enmtrigger){
							inst._spdmult_timer = 180;
							inst._spdmult = 1.7;
							
							with(inst){
								scr_hopspot(HOP_CLOSE_DH);
								
								if(scr_enemyscript_calculatejump(0)){
									sfx_play_proximity(snd_jump);
									_dohop = true;
								}
							}
						}
					break;
					//enemy instantly falls onto the ground
					case SPAWN_FALLPLANKS:
						inst._height = 10;
						inst._vspd = -8;
						inst._fallabove = true;
						inst._jump = true;
						inst._standup = true;
						
						if(global._toxicshack){
							sfx_play_proximity(snd_woodcrash);
							sfx_pitch(snd_woodcrash, random_range(0.7, 1.3));
					
							for(var i = 0; i < 5; i++){
								var plank = instance_create_depth(x+random_range(-42,42), ((HEIGHT*0.75)+global._cameraY)+random_range(-42,42), 0, obj_lv1_plank);
							}
						}
					break;
					//enemy spawns with an entrance cutscene
					case SPAWN_CUTSCENE:
						inst._spawncutscene = true;
						inst._spawndir = _spawndir;
						inst._offscreenpos = [inst.x,inst.y];
						inst._spawnpos = [inst.x,inst.y];
					break;
					//enemy hops from a side
					case SPAWN_HOP:
						inst._spawncutscene = true;
						inst._spawndir = _spawndir;
						inst._seq_forcehop = true;
						inst._spawnpos = [inst.x,inst.y];
						var offset = 380;
						if(_spawndir == "l"){
							inst._offscreenpos[0] = inst.x-offset;
							inst._offscreenpos[1] = inst.y;
						}
						if(_spawndir == "r"){
							inst._offscreenpos[0] = inst.x+offset;
							inst._offscreenpos[1] = inst.y;
						}
						if(_spawndir == "u"){
							inst._offscreenpos[0] = inst.x;
							inst._offscreenpos[1] = inst.y-offset;
						}
						if(_spawndir == "d"){
							inst._offscreenpos[0] = inst.x;
							inst._offscreenpos[1] = inst.y+offset;
						}
					break;
					//enemy glides down on a parachute
					case SPAWN_PARACHUTE:
						inst._parachute = true;
						inst._fallfloat = true;
						inst._fallfloat_offset = 260;
						inst._nocrouchatk = true;
						inst._jump = true;
						inst._fall_ko = true;
						inst._standup = true;
						inst._height = inst._groundlevel+(HEIGHT*1.4);
					break;
					case SPAWN_CRUCIFIED:
						//enemy appears crucified (henchie only)
						if(variable_instance_exists(inst,"_hn_crucified")){
							inst.x += 72;
							inst._hn_crucified = true;
						}
					break;
				}
				instance_destroy();
			}
		} else {
			if(place_meeting(x,y,obj_enmtrigger_connect)){
				var connect = instance_place(x,y,obj_enmtrigger_connect);
				if(instance_exists(connect) && connect._trigger){
					_enmtrigger = true;
					_trigger = true;
				}
			}
		}
	}
}