{
	if(!global._pause){
		if(_active){
			repeat(abs(_xspd)){
				if(!place_meeting_array(x+sign(_xspd),y,global._solidArray)){
					x += sign(_xspd);
				}
			}
		
			_freeze -= 1;
		
			if(_height > _groundlevel){
				if(_xspd > 0){
					image_angle -= _rotspeed;
				} else {
					image_angle += _rotspeed;
				}
			} else {
				_rest = true;
				image_angle = lerp(image_angle, _randangle, 0.3);
			}
		
			if(_height > _groundlevel){
				_height += _vspd;
				_vspd -= 0.6;
			} else {
				if(!_bump){
					_height = _groundlevel + 8;
					_vspd = 4;
					_bump = true;
				} else {
					_xspd = lerp(_xspd, 0, 0.07);
					if(abs(_xspd) <= 1){
						_xspd = 0;
					}
					_vspd = 0;
					_height = _groundlevel;
				}
			}
		
			if(place_meeting(x,y,obj_dh_mask)){
				var dh = instance_place(x,y,obj_dh_mask);
				if(!_kill && _rest && instance_exists(dh) && dh._height <= dh._groundlevel){
					_kill = true;
				}
			}
		
			_deathtimer ++;
			if(_deathtimer >= 240+_plustimer || _kill){
				var p = instance_create_depth(x,y,depth-1,obj_particle);
				p._type = "bone";
				if(_kill){
					sfx_play(snd_bonecrack);
					sfx_pitch(snd_bonecrack, random_range(0.8,1.3));
				}
				
				_active = false;
			}
		} else {
			_deadtimer ++;
			if(!sfx_isplaying(snd_bonecrack) || _deadtimer >= 70){
				instance_destroy();
			}
		}
	}
}