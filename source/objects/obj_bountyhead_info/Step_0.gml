{
	if(!global._pause && _infoshow){
		if(!_infohide){
			_infotimer ++;
			
			_spin ++;
			
			//show info screen stretching vertically once it appears
			if(_infotimer < 24){
				_infoscale = 0;
			} else if(_infotimer >= 25 && _infotimer < 35){
				_infoscale = 1.5;
			} else {
				if(!_snd){
					sfx_play(snd_bountyhead_info,0.45);
				
					_snd = true;
				}
				
				_infoscale = 1;
			}
			
			_text_hideoffset = 0;
			_boss_hideoffset = 0;
		} else {
			//shrink info screen once done
			_infotimer = 0;
			_infoscale -= 0.1;
			_text_hideoffset += 18;
			_boss_hideoffset += 32;
			if(_infoscale <= 0){
				_infohide = false;
				_infoshow = false;
			}
		}
	}
}