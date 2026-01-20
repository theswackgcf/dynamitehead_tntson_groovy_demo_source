// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_checkaxis(key, type){
	for(var i = 0; i < 2; i++){
		if(key == "stick"+string(i+1)+"_l" || key == "stick"+string(i+1)+"_r" || key == "stick"+string(i+1)+"_u" || key == "stick"+string(i+1)+"_d"){
			switch(type){
				case 0:
					if(global._stickheld[? key]){
						return true;
					} else {
						return false;
					}
				break;
				case 1:
					if(global._stickpressed[? key]){
						return true;
					} else {
						return false;
					}
				break;
				case 2:
					if(global._stickreleased[? key]){
						return true;
					} else {
						return false;
					}
				break;
			}
		}
	}
}