function scr_lode_enm_movement(){
	if(!_getup && !_taunt){
		//collision and movement
		_frac_x = frac(_xspd*global._lode_spd);
		_frac_y = frac(_yspd*global._lode_spd);
		
		//x speed
		repeat(abs(_xspd*global._lode_spd)){
			_go_x = true;
			var pixel = sign(_xspd*global._lode_spd);
			
			checkcol(pixel, COL_X);
			
			if(_go_x){
				x += pixel;
			} else {
				_xspd = 0;
			}
		}
		
		//x fraction
		if(_frac_x <> 0){
			_go_x = true;
			var pixel = _frac_x;
			
			checkcol(pixel, COL_X);
			
			if(_go_x){
				x += pixel;
			} else {
				_xspd = 0;
			}
		}
		
		//y speed
		repeat(abs(_yspd*global._lode_spd)){
			_go_y = true;
			var pixel = sign(_yspd*global._lode_spd);
			
			checkcol(pixel, COL_Y);
			
			if(_go_y){
				y += pixel;
			} else {
				if(_yspd > 0){
					_groundtimer = 2;
				}
				_yspd = 0;
			}
		}
		
		//y fraction
		if(_frac_y <> 0){
			_go_y = true;
			var pixel = _frac_y;
			
			checkcol(pixel, COL_Y);
			
			if(_go_y){
				y += pixel;
			} else {
				if(_yspd > 0){
					_groundtimer = 2;
				}
				_yspd = 0;
			}
		}
		
		_movespd = _movespd_init*_move_mult;
		
		if(_enmwalk > 0){
			_groundtimer = 16
			_yspd = 0;
			y = _enmwalk_y;
			_xspd = _enmwalk_xspd;
			
			if(!place_meeting_array(x,y+8,global._lode_collide_solid,false,true) && place_meeting_array(x,y+8,global._lode_collide_enemy,false,true)){
				_groundtimer = 8;
				_enmwalk = 0;
			}
			
			_enmwalk --;
		}
		
		_frac_x = 0;
		_frac_y = 0;
		
		update_tilepos();
		
		_disppos[0] = lerp(_disppos[0],x,0.14);
		_disppos[1] = lerp(_disppos[1],y,0.14);
	}
}