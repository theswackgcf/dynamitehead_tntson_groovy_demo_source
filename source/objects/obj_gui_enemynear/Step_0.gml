{
	depth = -6000;
	if(!global._pause){
		image_speed = 1;
		
		visible = _active;
		
		if(image_index >= image_number-1){
			image_index = 2;
		}
		if(!_active){
			image_index = 0;
		}
		
		var spacing = 86;
		if(_parentobj != noone && instance_exists(_parentobj)){
			_active = false;
			var diff_zoom = [diff_abs(WIDTH, WIDTH*global._defCamZoom),diff_abs(HEIGHT, HEIGHT*global._defCamZoom)];
			if(_parentobj.x < global._cameraX-diff_zoom[0] || _parentobj.x > global._cameraX+WIDTH+diff_zoom[0] || _parentobj.y < global._cameraY-diff_zoom[1] || _parentobj.y > global._cameraY+HEIGHT+diff_zoom[1]){
				_active = true;
			}
			if(_dir == "u" && global._bossstart){
				_active = false;
			}
			if(variable_instance_exists(_parentobj.id, "_sequence_finished")){
				if(_parentobj._sequence_finished && _sequence){
					_active = false;
				}
			}
			
			//var centerpos = [global._cameraX+((WIDTH+diff_zoom[0])/2),global._cameraY+((HEIGHT+diff_zoom[1])/2)];
			
			var toppos = (global._cameraY-diff_zoom[1])+180;
			var bottompos = (global._cameraY+HEIGHT+diff_zoom[1])-185;
			
			var leftpos = (global._cameraX-diff_zoom[0])+480;
			var rightpos = (global._cameraX+WIDTH+diff_zoom[0])-495;
			
			switch(_dir){
				case "l":
					image_angle = 180;
					x = global._cameraX+(spacing*1.8);
					y = clamp(_parentobj.y, toppos, bottompos);
				break;
				case "r":
					x = (global._cameraX+WIDTH)+(spacing*0.5);
					y = clamp(_parentobj.y, toppos, bottompos);
				break;
				case "u":
					image_angle = 90;
					x = _parentobj.x;
					if(!_setpos){
						y = global._cameraY+(spacing*1.8);
					}
					
					//over enemy ui
					if(x <= leftpos){
						y = global._cameraY+(spacing*1.8)+180;
						_setpos = true;
					}
				break;
				case "d":
					image_angle = 270;
					x = _parentobj.x;
					if(!_setpos){
						y = (global._cameraY+HEIGHT)-(spacing*0.2);
					}
					
					//over dh ui or tnt ui
					if(x <= leftpos || x >= rightpos){
						y = ((global._cameraY+HEIGHT)-(spacing*0.2))-180;
						_setpos = true;
					}
				break;
			}
		}
		_timer ++;
		if(_timer >= 120){
			image_xscale -= 0.1;
			image_yscale -= 0.1;
			if(image_xscale <= 0){
				instance_destroy();
			}
		}
	} else {
		image_speed = 0;
	}
}