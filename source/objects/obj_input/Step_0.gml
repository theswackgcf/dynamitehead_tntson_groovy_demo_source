{
	if(global._padfound){
		global._axisspd = [1,1];
		for(var i = 0; i < 2; i++){
			if(global._padaxis[i][0] < -global._sensitivity){
				var key = "stick"+string(i+1)+"_l";
				if(!global._stickheld[? key]){
					global._stickheld[? key] = true;
					global._stickpressed[? key] = true;
					global._stickreleased[? key] = false;
					alarm[0] = global._sticktimer;
				}
				global._axisspd[0] = abs(global._padaxis[i][0]);
			} else {
				var key = "stick"+string(i+1)+"_l";
				if(global._stickheld[? key]){
					global._stickheld[? key] = false;
					global._stickpressed[? key] = false;
					global._stickreleased[? key] = true;
					alarm[0] = global._sticktimer;
				}
			}
			if(global._padaxis[i][0] > global._sensitivity){
				var key = "stick"+string(i+1)+"_r";
				if(!global._stickheld[? key]){
					global._stickheld[? key] = true;
					global._stickpressed[? key] = true;
					global._stickreleased[? key] = false;
					alarm[0] = global._sticktimer;
				}
				global._axisspd[0] = abs(global._padaxis[i][0]);
			} else {
				var key = "stick"+string(i+1)+"_r";
				if(global._stickheld[? key]){
					global._stickheld[? key] = false;
					global._stickpressed[? key] = false;
					global._stickreleased[? key] = true;
					alarm[0] = global._sticktimer;
				}
			}
			if(global._padaxis[i][1] < -global._sensitivity){
				var key = "stick"+string(i+1)+"_u";
				if(!global._stickheld[? key]){
					global._stickheld[? key] = true;
					global._stickpressed[? key] = true;
					global._stickreleased[? key] = false;
					alarm[0] = global._sticktimer;
				}
				global._axisspd[1] = abs(global._padaxis[i][1]);
			} else {
				var key = "stick"+string(i+1)+"_u";
				if(global._stickheld[? key]){
					global._stickheld[? key] = false;
					global._stickpressed[? key] = false;
					global._stickreleased[? key] = true;
					alarm[0] = global._sticktimer;
				}
			}
			if(global._padaxis[i][1] > global._sensitivity){
				var key = "stick"+string(i+1)+"_d";
				if(!global._stickheld[? key]){
					global._stickheld[? key] = true;
					global._stickpressed[? key] = true;
					global._stickreleased[? key] = false;
					alarm[0] = global._sticktimer;
				}
				global._axisspd[1] = abs(global._padaxis[i][1]);
			} else {
				var key = "stick"+string(i+1)+"_d";
				if(global._stickheld[? key]){
					global._stickheld[? key] = false;
					global._stickpressed[? key] = false;
					global._stickreleased[? key] = true;
					alarm[0] = global._sticktimer;
				}
			}
		}
		if(global._inptype == 0){
			global._axisspd = [1,1];
		}
		
		//gamepad vibration
		
		if(global._inptype == 1){
			_vibr_time ++;
			if(_vibr_time >= 60){
				for(var gp = 0; gp < gamepad_get_device_count(); gp++){
					if(gamepad_is_connected(gp)){
						_vibr_pad = gp;
						break;
					}
				}
				_vibr_time = 0;
			}
			
			var vibr_clamp = clamp(0,global._pad_vibrate*global._rumble,1);
			gamepad_set_vibration(_vibr_pad, vibr_clamp,vibr_clamp);
		} else {
			gamepad_set_vibration(_vibr_pad, 0,0);
		}
	} else {
		gamepad_set_vibration(_vibr_pad, 0,0);
		global._axisspd = [1,1];
	}
	
	if(global._pad_vibrate > 0){
		global._pad_vibrate -= 0.5;
	}
}