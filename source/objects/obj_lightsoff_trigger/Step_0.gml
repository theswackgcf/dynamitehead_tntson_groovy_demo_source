{
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
	if(!global._pause){
		//trigger
		if(place_meeting(x,y,obj_dh_mask)){
			if(global._lightsout != _lightsout && global._switchlights == ""){
				global._lightsout = _lightsout;
				if(!_instant){
					with(obj_fade){
						sfx_play(snd_lightflicker, 0.55);
					}
					
					var state = "";
					if(_lightsout){
						state = "off";
					} else {
						state = "on";
					}
					
					global._switchlights_sound = !_instant;
					global._switchlights_act = 0;
					global._switchlights = state;
				}
			
				scr_lightsout_affect();
			}
		}
	}
}