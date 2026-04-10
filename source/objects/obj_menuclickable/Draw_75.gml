{
	if(global._state != "minigame" || (global._state == "minigame" && global._pause)){
		if(global._debug && global._showHitbox){
			if(_active){
				draw_set_alpha(0.45);
				draw_rectangle(_bbox[0],_bbox[1],_bbox[2],_bbox[3], false);
				draw_set_alpha(1);
			}
		}
	}
}