function scr_enemyscript_spd(){
	_sintimer ++;
	
	//getting current speed & horizontal direction
	if(!_falling){
		if(_movetimer % 2 == 0){
			_posprev = [x,y];
		}
		if(x <= _posprev[0]){
			_curspd[0] = x - _posprev[0];
			_realspd[0] = -_curspd[0];
			if(abs(_curspd[0]) > 2){
				_curdir_prev = _curdir;
				_curdir = DIR_L;
			}
		} else {
			_curspd[0] = _posprev[0] - x;
			_realspd[0] = _curspd[0];
			if(abs(_curspd[0]) > 2){
				_curdir_prev = _curdir;
				_curdir = DIR_R;
			}
		}
		if(y <= _posprev[1]){
			_curspd[1] = y - _posprev[1];
			_realspd[1] = -_curspd[1];
			if(abs(_curspd[1]) > 2){
				_vdir_prev = _vdir;
				_vdir = DIR_U;
			}
		} else {
			_curspd[1] = _posprev[1] - y;
			_realspd[1] = _curspd[1];
			if(abs(_curspd[1]) > 2){
				_vdir_prev = _vdir;
				_vdir = DIR_D;
			}
		}
	} else {
		if(_fallxspd < 0){
			_curdir = DIR_L;
		} else {
			_curdir = DIR_R;
		}
	}
				
	//detect change in direction
	if(_curdir != _curdir_prev || _vdir != _vdir_prev){
		if(_curdir != _curdir_prev){
			_curdir_prev = _curdir;
		}
		if(_vdir != _vdir_prev){
			_vdir_prev = _vdir;
		}
	}
	
	//redo collisions if touched any enemy
	/*if(place_meeting_array(x, y, _collide_enemy)){
		if(!_checkenmcol){
			var inst = place_meeting_array(x, y, _collide_enemy, true);
			if(instance_exists(inst) && inst.id != self.id){
				do_grid_collisions();
				_checkenmcol = true;
			}
		}
	} else {
		_checkenmcol = false;
	}*/
	
	//redo collisions if touched solid
	if(place_meeting_array(x+_curspd[0], y+_curspd[1], _collide_solid) || place_meeting_array(x+_curspd[0], y+_curspd[1], _collide_other)){
		if(!_checksolidcol){
			var inst;
			if(place_meeting_array(x+_curspd[0], y+_curspd[1], _collide_solid)){
				inst = place_meeting_array(x+_curspd[0], y+_curspd[1], _collide_solid, true);
			} else if(place_meeting_array(x+_curspd[0], y+_curspd[1], _collide_other)){
				inst = place_meeting_array(x+_curspd[0], y+_curspd[1], _collide_other, true);
			}
			if(instance_exists(inst) && inst.id != self.id){
				do_grid_collisions();
				_checksolidcol = true;
			}
		}
	} else {
		_checksolidcol = false;
	}
	
	//gravity
	if(_jump){
		if(_height < _groundlevel){
			_vspd = 0;
			_height = _groundlevel;
			_jump = false;
		}
		_height += _vspd;
		if(!_fallfloat){
			_vspd -= 0.8;
		} else {
			_vspd = _fallfloat_spd;
		}
	}
	
	//z-axis
	if(place_meeting_array(x, y, _collide_solid)){
		var inst = place_meeting_array(x, y, _collide_solid, true);
		if(instance_exists(inst) && variable_instance_exists(inst.id, "_height") && _height >= inst._height && _vspd <= 0){
			_groundlevel = inst._height;
		}
	} else {
		_groundlevel = 0;
	}
	if(_groundlevel < _height && !_jump){
		_height = _groundlevel;
	}
	
	//damage numbers stuff
	if(_height == _groundlevel){
		_hplastframe = _hp;
	}
}