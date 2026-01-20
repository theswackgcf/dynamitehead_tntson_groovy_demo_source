{
	if(!global._pause){
		image_speed = 1;
		if(place_meeting(x,y,obj_fade)){
			if(_bg){
				depth = 9992;
			} else {
				depth = -5001;
			}
			
			_timer ++;
		
			var time = 22;
			var amp = 14;
		
			_facepos[0] = _startpos[0] + (sin(_timer/(time*2.75))*32)*_scale;
			_facepos[1] = _startpos[1] + (cos(_timer/(time*2.75))*32)*_scale;
		
			_motionoffset.eyeL[0] = (sin(_timer/time)*amp)*_scale;
			_motionoffset.eyeL[1] = (cos(_timer/time)*amp)*_scale;
		
			_motionoffset.eyeR[0] = (sin((-_timer+24)/time)*amp)*_scale;
			_motionoffset.eyeR[1] = (cos((-_timer+24)/time)*amp)*_scale;
		
			_motionoffset.mouth[0] = (sin((_timer+48)/time)*amp)*_scale;
			_motionoffset.mouth[1] = (cos((_timer+48)/time)*amp)*_scale;
		
			_alp = clamp(0, sin(_timer/77)+1, 1);
		}
	} else {
		image_speed = 0;
	}
}