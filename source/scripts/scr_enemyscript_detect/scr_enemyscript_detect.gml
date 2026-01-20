function scr_enemyscript_detect(){
	//player detection
	
	if(_curstate == STATE_WALK && _state_cooldown == 0 && _hurttimer <= 0 && !_falling && !_death && !_fall_ko && !_grabbed){
		_dh = instance_nearest(x, y, obj_dh_mask);
		if(distance_to_object(_dh) <= _noticedist && !place_meeting_array(_dh.x,_dh.y, _collide_solid)){
			switch(_codename){
				case "enm3":
					//bagdiot
					if(_notp <= 0){
						if(!_standup && !_shockwave){
							if(_dh != noone && instance_exists(_dh) && !_dh._falling && !_dh._dead && _dh._mashact == 0){
								scr_dh_pathpoint();
								if(path_exists(_path) && scr_check_path_end(_path)){
									_pointtime = 8;
									if(_bzstart <= 0 && diff_abs(_dh.x, x) <= 720 && diff_abs(_dh.y, y) <= 720){
										if(_walktimer > 0){
											//player detected and near
											_interest = 45;
											_curstate = STATE_FOLLOW;
										}
									} else {
										if(_bzstart <= 0){
											_curstate = STATE_WALK;
										}
									}
								} else {
									if(_bzstart <= 0){
										_curstate = STATE_WALK;
									}
								}
								if(_bzstart <= 0 && diff_abs(_dh.x, x) <= 320 && diff_abs(_dh.y, y) <= 320 && _notp <= 0){
									//teleport
									remove_trait([TRAIT_GRAB,TRAIT_HURT]);
							
									_curspd = [0,0];
									_displayobj.image_index = 0;
									_interest = 100;
									_tp = true;
									sfx_play_proximity(snd_tp_away);
								}
							}
						}
					}
				break;
				default:
					//other enemies
					if(_dh != noone && instance_exists(_dh) && _dh._mashact == 0){
						scr_dh_pathpoint();
						if(path_exists(_path) && scr_check_path_end(_path)){
							_pointtime = 8;
							if(_bzstart <= 0){
								if(_walktimer > 0){
									if(!_falling && !_fall_ko && !_standup && _stuntimer == 0){
										if((_curstate == STATE_IDLE || _curstate == STATE_WALK) && has_trait(TRAIT_SPOT) && !_didspot){
											if(_dh.x < x){
												_curdir = DIR_L;
											} else {
												_curdir = DIR_R;
											}
											_displayobj.image_index = 0;
											_didspot = true;
											if(!_attack){
												_spottimer = 60;
											} else {
												_spottimer = 0;
											}
										}
									
										_interest = 60;
										_curstate = STATE_FOLLOW;
									}
								}
							}
						} else {
							if(_bzstart <= 0){
								_spotwalk = false;
								_curstate = STATE_WALK;
							}
						}
						if(_curstate == STATE_FOLLOW){
							_interest = 60;
						}
					}
				break;
			}
		}
	}
}