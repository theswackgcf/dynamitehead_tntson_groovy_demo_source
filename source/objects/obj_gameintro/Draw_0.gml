{
	if(_act == 2){
		draw_sprite(spr_swackygames, _frame, 0, 0);
		if(_load != noone && instance_exists(_load)){
			if(_timer >= _timer_val && _load._loaded && !_focus){
				draw_sprite(spr_clicktofocus,0,0,0);
			}
		}
	}
	if(_act == 4){
		draw_sprite_ext(spr_menulogo, 0, floor(WIDTH/2), floor(HEIGHT/2), _logoscale, _logoscale, 0, #FFFFFF, 1);
	}
}