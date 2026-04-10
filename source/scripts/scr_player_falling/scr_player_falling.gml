function scr_player_falling(){
	if(_falling){
		_attack = false;
		_attacktype = "";
		
		_finalcombo = false;
		_spd[0] = _initspeed*_curdir;
		_spd[1] = 0;
		
		_runroll = false;
		_runroll_dive = false;
		_runroll_slide = false;
		_slide = false;
		_slidespd = 0;
				
		//already holding enemy
		if(_enemygrab && _grabinst != noone && instance_exists(_grabinst)){
			force_throw_enemy();
		}
				
		if(_height == _groundlevel){
			switch(_falls){
				case 0:
					with(obj_camera){
						_ampY = 24;
					}
					var pos = 90;
					var curpos = pos*_curdir;
					var partc = instance_create_depth((x-170)+pos, y, 0, obj_particle);
					partc._type = "fx5";
						
					if(_koenemy != noone && instance_exists(_koenemy)){
						if(has_trait(TRAIT_TAUNT, _koenemy) && !_koenemy._spin && _koenemy._stuntimer <= 0){
							if(_koenemy._behaviortype != "spinning"){
								_koenemy._taunt = _koenemy._taunttime;
							}
						}
					}
					_koenemy = noone;
						
					sfx_play_choose([snd_thud,snd_thud2,snd_thud3,snd_thud4]);
						
					_vspd = 6;
					_falls ++;
				break;
				case 1:
					_spd[0] = 0;
					_jump = false;
					_falling = false;
					_falls = 0;
					if(!_dead){
						_displayobj.image_index = 0;
					}
					_dead = true;
					_hitobj._once = false;
				break;
			}
		}
	}
	if(_dead){
		if(!_jumpback){
			_deadtimer ++;
			if(_deadtimer >= 45 || (_deadtimer >= 4 && _stunnedtimer <= 0 && keypress("jump"))){
				_jumpreach = 0;
				_jump = true;
				_height = _groundlevel+4;
				_vspd = 10;
				_dead = false;
				_state = "jump";
				if(!_jumpback){
					_displayobj.image_index = 0;
				}
				_jumpback = true;
				
				_curdir *= -1;
				
				if(_stunnedtimer <= 0 && !_runroll_bump){
					_invframe = _invmax;
					voice_play_choose([snd_dh_voice_ko1,snd_dh_voice_ko2,snd_dh_voice_ko3,snd_dh_voice_ko4,snd_dh_voice_ko5,snd_dh_voice_ko6,snd_dh_voice_ko7,snd_dh_voice_ko8,snd_dh_voice_ko9,snd_dh_voice_ko10], global._dhvoices, 1);
				}
					
				_runroll_bump = false;
					
				sfx_play(snd_jump);
			}
		} else {
			_stopwalk = 0;
		}
	}
}