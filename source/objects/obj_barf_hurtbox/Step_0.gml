{
	if(_parentobj != noone){
		if(_parentobj._startTimer <= 0){
			x = _parentobj.x + _offset[0];
			y = (_parentobj.y + _offset[1]) - _parentobj._height;
		}
		if(place_meeting(x,y,obj_punchhitbox)){
			var inst = instance_place(x,y,obj_punchhitbox);
			if(instance_exists(inst) && inst._active){
				inst._active = false;
				var p = instance_create_depth(x, y, 0, obj_particle);
				p._type = "barf_splash";
				sfx_play(snd_slimesplat);
				with(_parentobj){
					killself();
				}
			}
		}
	}
}