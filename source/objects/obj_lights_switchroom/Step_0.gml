{
	if(global._lights_switchroom){
		with(obj_music){
			mus_stop();
		}
		
		global._lightsout = true;
		scr_lightsout_affect();
		
		_timer ++;
		
		with(obj_dh_mask){
			x = obj_finish.x;
			y = obj_finish.y+128;
			
			_hp = global._switch_storehp;
			_hplastframe = _hp;
			global._tntjuice = global._switch_storetnt;
		}
		if(_timer >= 3){
			global._lights_switchroom = false;
			instance_destroy();
		}
	}
	
	if(!global._lights_switchroom && global._battlezone){
		if(place_meeting(x,y,obj_dh_mask)){
			var dh = instance_place(x,y,obj_dh_mask);
			if(instance_exists(dh)){
				global._switch_storehp = dh._hp;
				global._switch_storetnt = global._tntjuice;
			}
			
			mus_stop();
			audio_stop_all();
			room_goto(r_roomswitch);
		}
	}
}