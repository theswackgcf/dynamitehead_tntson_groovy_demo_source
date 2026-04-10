{
	depth = -5100;
	if(!global._pause){
		mus_stop();
		
		image_speed = 1;
		
		if(_amp > 0){
			_offset[0] = sin(random(480))*_amp;
			_offset[1] = cos(random(480))*_amp;
			_amp --;
		} else {
			_amp = 0;
		}
		
		if(_act >= 1){
			x = global._cameraX+(WIDTH/2);
			y = global._cameraY+(HEIGHT/2);
			image_xscale = 2;
			image_yscale = 2;
		}
		
		switch(_act){
			case 0:
				_timer ++;
				_sintimer ++;
				if(!_init){
					sfx_play(snd_whistle);
					if(_voiceclip != -1){
						voice_play(_voiceclip, global._bossvoices);
					}
					
					if(x < _centerpoint){
						_dir = DIR_R;
					} else {
						_dir = DIR_L;
					}
					
					_init = true;
				}
				_centerpoint = global._cameraX+(WIDTH/2);
				x = lerp(x, _centerpoint, 0.05);
				y += _spd[1];
				image_xscale = _dir*_scale;
				image_yscale = _scale;
				_scale += 0.032;
				_spd[1] += 0.52;
				
				if(!_dh){
					with(obj_dh_mask){
						_displayobj.image_index = 0;
						
						_idletimer = 0;
						_idleanim = [false,false];
						_idles = 0;
						
						_runroll = false;
						_rollspd = 0;
						_runroll_bump = false;
						_runroll_dive = false;
						_runroll_slide = false;
						
						_blowup = false;
						_blowuptimer = 0;
						_explosiontimer = 0;
						_wintimeroffset = 180;
						_doWin = true;
					}
					_dh = true;
				}
				
				if(_scale >= 3.28){
					sfx_stop(snd_whistle);
					sfx_play(snd_screencrack);
					if(array_length(_boss_sounds[global._location]) > 0){
						voice_play_choose(_boss_sounds[global._location], global._bossvoices);
					}
					with(obj_camera){
						_ampX = 16;
						_ampY = 16;
					}
					image_index = 0;
					_amp = 26;
					_timer = 0;
					_act = 1;
				}
			break;
			case 1:
				_sintimer = 0;
				_timer ++;
				if(_amp <= 8){
					_amp = 8;
				}
				
				_crack = true;
				
				if(_timer >= 50){
					_anim = "finalko3";
					image_index = 0;
					_act = 2;
					_timer = 0;
				} else {
					_anim = "finalko2";
					if(image_index >= image_number-1){
						image_index = 1;
					}
				}
			break;
			case 2:
				_amp = 0;
				_crackpos += 7;
				_crackalpha -= 0.07;
			
				if(image_index >= image_number-1){
					image_index = image_number-1;
					y += 170;
					
					if(y >= (HEIGHT+1300)-global._cameraY){
						sfx_play(snd_bosscrash);
						sfx_play_choose([snd_badhead_crash1,snd_badhead_crash2,snd_badhead_crash3,snd_badhead_crash4], 0.75);
						with(obj_camera){
							_ampY = 72;
						}
						
						_timer = 0;
						
						var spawnpos = [global._cameraX+(WIDTH/2)+374,(global._cameraY+HEIGHT)-86];
						var p = instance_create_depth(spawnpos[0],spawnpos[1],depth,obj_particle);
						p._type = "vanish";
						p._forcedepth = -5001;
						p._scale = 4;
						
						sfx_play(snd_ghost);
						
						_skull = true;
						_skullpos = [spawnpos[0],spawnpos[1]];
						_skullvel = [-10, -27];
						
						_act = 3;
					}
				}
			break;
			case 3:
				_drawself = false;
				_timer ++;
			
				_skullangle += 8;
				_skullpos[0] += _skullvel[0];
				_skullpos[1] += _skullvel[1];
				_skullvel[1] += 0.8;
				
				if(_timer >= 90){
					_act = 4;
				}
			break;
			case 4:
				instance_destroy();
			break;
		}
	} else {
		image_speed = 0;
	}
	
	sprite_index = asset_get_index("spr_"+_codename+"_"+_anim);
}