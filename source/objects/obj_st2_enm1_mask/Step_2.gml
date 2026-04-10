{
	if(!global._pause){
		if(_enmtype == 0){
			if(place_meeting(x,y,obj_aiblock)){
				var aiblock = instance_place(x,y,obj_aiblock);
				if(instance_exists(aiblock)){
					//set ai level
					_ailevel = aiblock._ailevel;
				}
			}
			
			if(_ailevel >= 1 && !_hn_setrounds){
				if(!_hn_ring_fake){
					if(_ailevel > 4){
						_hn_rounds = 2;
						_hn_dmgadd = 2;
					}
					if(_ailevel >= 6.75){
						_hn_rounds = 3;
						_hn_dmgadd = 1;
					}
				}
					
				_hn_setrounds = true;
			}
				
			_maxblockcount = 2;
		}
		
		scr_enemyscript_animation("endstep");
	}
}