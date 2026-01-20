function scr_showhits(){
	//use in the enemy hurtbox object
	if(global._hitscd <= 0){
		global._hits += 1;
		global._hitscd = 2;
																	
		var val = 1;
		if(_parentobj._pissedoff > 0){
			val = _parentobj._pissedoff_hit[clamp(0,_parentobj._pissedoff_int,2)];
		}
		array_push(global._hitsarray, val);
	}
	if(global._hits < 1){
		global._hits = 1;
	}
	if(array_length(global._hitsarray) < 1){
		var val = 1;
		if(_parentobj._pissedoff > 0){
			val = _parentobj._pissedoff_hit[clamp(0,_parentobj._pissedoff_int,2)];
		}
		array_push(global._hitsarray, val);
	}
	global._hitmeter = 50;
	with(obj_game){
		hitjump();
	}
}