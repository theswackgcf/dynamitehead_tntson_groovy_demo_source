function scr_enemyscript_dir(){
	//direction
	if(instance_exists(_displayobj)){
		if(_freeze <= 0){
			//hurt direction
			if(!_falling && !_fall_ko){
				if(_dh_atk > 0 && _dh_atk_inst != noone && instance_exists(_dh_atk_inst)){
					_curdir = -_dh_atk_inst._curdir;
					_dh_atk = 0;
					_dh_atk_inst = noone;
				}
			}
			
			if(_freespd){
				_tempdir = _freedir;
				_curdir = _freedir;
			}
			
			if(!_falling && _panictimer > 0){
				var dhavoid = instance_nearest(x, y, obj_dh_mask);
				if(dhavoid != noone && instance_exists(dhavoid)){
					if(x < dhavoid.x-16){
						_curdir = DIR_R;
					} else if(x > dhavoid.x+16){
						_curdir = DIR_L;
					}
				}
			}
		
			_curdir = clamp(_curdir, DIR_L, DIR_R);
			if(!_falling){
				if(round(_curdir) == 0){
					_curdir = choose(DIR_L, DIR_R);
				}
			}
			var mirrordir = 1;
			var mirroranims = ["fall","dead","standup","fall_stun","dead_stun","standup_stun","shockwave","picked"];
			//mirror direction when one of the animations above are playing
			for(var ind = 0; ind < array_length(mirroranims); ind++){
				if(_anim == mirroranims[ind]){
					mirrordir = -1;
				}
			}
			_displayobj._xscale = _curdir*mirrordir;
		}
	}
}