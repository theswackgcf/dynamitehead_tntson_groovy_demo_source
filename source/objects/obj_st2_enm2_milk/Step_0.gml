event_inherited();

if(!global._pause){
	if(_dhfollow == noone){
		_dhfollow = instance_nearest(x,y,obj_dh_mask);
	}
	if(_dhfollow != noone && instance_exists(_dhfollow)){
		if(_allsounds != undefined && _allsounds != -1){
			if(!sfx_isplaying(snd_swinging)){
				sfx_play_proximity(snd_swinging, 0.55, false, _dhfollow.x,_dhfollow.y);
			}
		}
		
		y = lerp(y, _dhfollow.y, 0.16);
	}
}