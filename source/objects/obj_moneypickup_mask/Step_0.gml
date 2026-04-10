{
	if(!_colorsinit){
		if(global._tutorial){
			_rep = "st0";
		} else {
			_rep = "st"+string(global._location+1);
		}
		makecolors("def",_rep);
		
		_colorsinit = true;
	}
	
	if(!_shadowsinit){
		//shadows
		global._gameshadows[? self.id] = ds_map_create();
		global._gameshadows[? self.id][? "draw"] = false;
		global._gameshadows[? self.id][? "x"] = x;
		global._gameshadows[? self.id][? "y"] = y;
		global._gameshadows[? self.id][? "scalex"] = _defshadowsize;
		global._gameshadows[? self.id][? "scaley"] = _defshadowsize;
		
		_shadowsinit = true;
	}
	
	if(!global._pause){
		if(place_meeting(x,y,obj_cash_set)){
			var cash = instance_place(x,y,obj_cash_set);
			if(instance_exists(cash)){
				_amount = cash._amount;
				instance_destroy(cash.id);
			}
		}
		
		switch(_act){
			case 0:
				//fall down
				if(!_snd.falling){
					sfx_play_choose(global._swishsounds[2]);
					_snd.falling = true;
				}
				sprite_index = spr_moneypickup_fall;
				_height -= 180;
				if(_height <= 0){
					for(var i = 0; i < 2; i++){
						var p = instance_create_depth(x-42, y+32, depth, obj_particle);
						p._move = true;
						if(i == 0){
							p._type = "run4";
							p._xspd = -14;
						} else if(i == 1){
							p._type = "run5";
							p._xspd = 14;
						}
					}
					
					sfx_play(snd_moneythud);
					
					_height = 0;
					_act = 1;
				}
			break;
			case 1:
				x = lerp(x, _lerptopos[0], 0.25);
				y = lerp(y, _lerptopos[1], 0.25);
				
				if(_dh != noone && instance_exists(_dh)){
					_lerptopos = [(_dh._displayobj).x+96, (_dh._displayobj).y+42];
				}
			
				_timr ++;
				if(_timr >= 20 && !_snd.tada){
					sfx_play(snd_prize, 0.6);
					_snd.tada = true;
				}
				
				if(_picked){
					global._musFade = 0.35;
					
					sfx_stop(snd_prize);
				}
			
				sprite_index = spr_moneypickup;
				if(image_index >= image_number-1){
					image_index = 3;
				}
			break;
		}
	}
}