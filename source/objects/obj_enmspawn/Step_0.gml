{
	scr_orderspawn();
	if(ds_map_size(global._bzone_fx) == 0){
		if(global._enmorder >= _order || _canspawn >= 8){
			if(_asset != noone){
				var en = instance_create_depth(_spawnX, _spawnY, 0, _asset);
				en._spawndir = _spawndir;
				en._spawnpos = [_spawnpos[0], _spawnpos[1]];
				en._offscreenpos = [_offscreenpos[0], _offscreenpos[1]];
				if(_doenmtype){
					en._enmtype = _enmtype;
				}
				if(_dostarttimer){
					en._startTimer = _startTimer;
				}
				en._battlezone = _battlezone;
				en._bzobj = _bzobj;
				if(!_enmobj){
					en._ailevel = _ailevel;
					en._bzstart = _bzstart;
					en._bzstart_offset = [_bzstart_offset[0],_bzstart_offset[1]];
					switch(_spawntype){
						case SPAWN_NORMAL:
							en._curstate = _curstate;
							en._walkto = [_walkto[0],_walkto[1]];
						break;
						case SPAWN_FALLPLANKS:
							en._fallabove = _fallabove;
							en._height = _height;
							en._vspd = _vspd;
							en._jump = _jump;
							en._standup = _standup;
							if(global._toxicshack){
								for(var j = 0; j < 5; j++){
									instance_create_depth(x+random_range(-42,42), ((HEIGHT*0.75)+global._cameraY)+random_range(-42,42), 0, obj_lv1_plank);
								}
							
								sfx_play_proximity(snd_woodcrash);
								sfx_pitch(snd_woodcrash, random_range(0.7, 1.3));
							}
						break;
						case SPAWN_HOP:
							en._seq_forcehop = true;
						break;
						case SPAWN_PARACHUTE:
							en._parachute = true;
							en._fallfloat = true;
							en._fallfloat_offset = 260;
							en._nocrouchatk = true;
							en._jump = true;
							en._fall_ko = true;
							en._standup = true;
							en._height = en._groundlevel+(HEIGHT*1.4);
						break;
					}
				}
			}
			instance_destroy();
		}
	}
}