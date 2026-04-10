if(!global._pause){
	if(!_balled){
		//simulate guide
		_guideverts = [];
		_ballpos = [mouse_x, mouse_y];
		_ballvel = [0, 0];
		for(var i = 0; i < 256; i++){
		    for(var j = 0; j < array_length(_pegs); j++){
			    if(point_in_circle(_pegs[j][0], _pegs[j][1], _ballpos[0] + _ballvel[0], _ballpos[1] + _ballvel[1], 28)){
					var dx = _ballpos[0] - _pegs[j][0];
					var dy = _ballpos[1] - _pegs[j][1];
					var len = point_distance(0, 0, dx, dy);
					
					dx /= len;
					dy /= len;
					
					var dot = _ballvel[0] * dx + _ballvel[1] * dy;
					
					_ballvel[0] = _ballvel[0] - 2 * dot * dx;
					_ballvel[1] = _ballvel[1] - 2 * dot * dy;
					
					var spd = point_distance(0, 0, _ballvel[0], _ballvel[1]);
					if (spd < _minspeed) {
					    var dir = point_direction(0, 0, _ballvel[0], _ballvel[1]);
					    _ballvel[0] = lengthdir_x(_minspeed, dir);
					    _ballvel[1] = lengthdir_y(_minspeed, dir);
					}
				}
			}
			_ballvel = [_ballvel[0], _ballvel[1] + _gravity];
			_ballpos = [_ballpos[0] + _ballvel[0], _ballpos[1] + _ballvel[1]];
			
			_guideverts[i] = [_ballpos[0], _ballpos[1]];
		}
		
		if(mouse_check_button_pressed(mb_left)){
			sfx_play(snd_menu1);
			_ballpos = [mouse_x, mouse_y];
			_ballvel = [0, 0];
			_ballrotspd = 0;
			_ballrot = 0;
			_balled = true;
		}
		
		if(mouse_wheel_up()){
			_pegs = [0];
			_pegcount += 5;
			generatepegs();
		}
		else if(mouse_wheel_down()){
			_pegs = [0];
			_pegcount -= 5;
			generatepegs();
		}
	}
	else{
		for(var i = 0; i < array_length(_pegs); i++){
		    if(point_in_circle(_pegs[i][0], _pegs[i][1], _ballpos[0] + _ballvel[0], _ballpos[1] + _ballvel[1], 28)){
				with(obj_camera){
					_ampX = other._ballvel[0] / 2;
					_ampY = other._ballvel[1] / 2;
				}
				
				var dx = _ballpos[0] - _pegs[i][0];
				var dy = _ballpos[1] - _pegs[i][1];
				var len = point_distance(0, 0, dx, dy);
				
				dx /= len;
				dy /= len;
				
				var dot = _ballvel[0] * dx + _ballvel[1] * dy;
				
				_ballvel[0] = _ballvel[0] - 2 * dot * dx;
				_ballvel[1] = _ballvel[1] - 2 * dot * dy;
				
				var spd = point_distance(0, 0, _ballvel[0], _ballvel[1]);
				if (spd < _minspeed) {
				    var dir = point_direction(0, 0, _ballvel[0], _ballvel[1]);
				    _ballvel[0] = lengthdir_x(_minspeed, dir);
				    _ballvel[1] = lengthdir_y(_minspeed, dir);
				}
				
				_ballrotspd = -_ballvel[0];
				
				if(_pegs[i][2] != true){
					_pegs[i][2] = true;
					_pegshit++;
				}
				_pegs[i][3] = 10;
				
				sfx_play_choose([snd_pegbonk, snd_pegbonk2, snd_pegbonk3, snd_pegbonk4, snd_pegbonk5, snd_pegbonk6]);
			}
		}
		
		_ballvel = [_ballvel[0], _ballvel[1] + _gravity];
		_ballpos = [_ballpos[0] + _ballvel[0], _ballpos[1] + _ballvel[1]];
		_ballrot += _ballrotspd;
	}
	
	for(var i = 0; i < array_length(_pegs); i++){
	    _pegs[i][3] -= 0.7;
		if(_pegs[i][3] < 0){
			_pegs[i][3] = 0;
		}
	}
}