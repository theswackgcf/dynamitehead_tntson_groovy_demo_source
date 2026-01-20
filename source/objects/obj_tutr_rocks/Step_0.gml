{
	if(!global._pause){
		if(!_trigger){
			if(_solid == noone){
				if(place_meeting_array(x,y,[obj_solid])){
					var sol = place_meeting_array(x,y,[obj_solid],true,true);
					if(instance_exists(sol) && sol._delete){
						_solid = sol;
					}
				}
			}
		}
		
		if(_throw){
			if(!_trigger && place_meeting(x-32,y,obj_fridge_mask)){
				var fridge = instance_place(x-32,y,obj_fridge_mask);
				if(instance_exists(fridge) && !fridge._grabbed && fridge._height <= fridge._groundlevel+32){
					with(obj_camera){
						_ampX = 20;
						_ampY = 20;
					}
					
					_trigger = true;
					_timer = 30;
					fridge._fr_throw = true;
					sfx_play(snd_mashko, 0.65);
				}
			}
		}
		
		if(_roll){
			if(!_trigger && place_meeting(x-32,y,obj_dh_mask)){
				var dh = instance_place(x-32,y,obj_dh_mask);
				if(instance_exists(dh) && dh._runroll){
					with(obj_camera){
						_ampX = 20;
						_ampY = 20;
					}
					
					_trigger = true;
					_timer = 5;
					
					if(_solid != noone && instance_exists(_solid)){
						instance_destroy(_solid.id);
					}
					
					sfx_play(snd_mashko, 0.65);
				}
			}
		}
		
		if(_trigger){
			if(!_p){
				var p = instance_create_depth(x-64,y-64,-16,obj_particle);
				p._type = "fx6";
				
				global._pad_vibrate = 25;
				
				_p = true;
			}
			if(_timer > 0){
				_offsetx = sin(random(480))*20;
				_timer --;
			} else {
				if(!_destroy){
					if(_allsounds != -1){
						sfx_play_proximity(snd_dh_ko, 0.76);
					}
					with(obj_camera){
						_ampX = 30;
						_ampY = 30;
					}
					
					global._pad_vibrate = 12;
					
					_offsetx = 0;
					
					_destroy = true;
				}
			}
		}
		
		if(_destroy){
			if(_dusttimer <= 0){
				var p = instance_create_depth((x+_offsetx)-120,(y+_offsety)-120,-16,obj_particle);
				p._type = "vanish";
				
				_dusttimer = 3;
			} else {
				_dusttimer --;
			}
			
			if(_solid != noone && instance_exists(_solid)){
				instance_destroy(_solid.id);
			}
			
			_offsetx += 26;
			_offsety -= 17;
			_deathtimer ++;
			
			if(_deathtimer >= 30 && !_spawndialm){
				with(obj_game){
					_dialm_active = true;
				}
				_spawndialm = true;
			}
			
			if(_deathtimer >= 100){
				instance_destroy();
			}
		}
	}
}