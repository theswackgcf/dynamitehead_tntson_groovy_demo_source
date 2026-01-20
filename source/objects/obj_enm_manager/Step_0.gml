{
	if(global._state == "game"){
		if(!global._pause){
			if(global._enmCollideCooldown > 0){
				global._enmCollideCooldown --;
			}
		
			//two enemies collided with each other
			if(array_length(global._curEnmCollide) > 0){
				var curenm = noone;
				for(var i = 0; i < array_length(global._curEnmCollide); i++){
					curenm = global._curEnmCollide[i];
					
					with(curenm){
						if(_standup && !_docrouchkick && _stuntimer <= 0 && !_grabdodge){
							scr_hopspot(HOP_NEAR);
							if(scr_enemyscript_calculatejump(0)){
								_grabout = false;
								_grabfall = false;
								_falling = false;
								_jump = false;
								_vspd = 0;
								_height = _groundlevel;
								_hop_quiet = 5;
								_hop_walk = true;
								_dohop = true;
							}
						} else {
							_jumpingtimer = 0;
						}
					}
				}
			
				global._curEnmCollide = [];
			}
		}
	}
}