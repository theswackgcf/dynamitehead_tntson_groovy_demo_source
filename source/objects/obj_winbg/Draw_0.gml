{
	draw_set_alpha(_alpha);
	draw_set_color(#000000);
	draw_rectangle(x, y, x+WIDTH, y+HEIGHT, false);
	draw_set_color(#FFFFFF);
	draw_set_alpha(1);
	
	if(_drawfire){
		draw_set_color(#581E09);
		draw_rectangle(x, y, x+WIDTH, y+HEIGHT, false);
		draw_set_color(#FFFFFF);
		
		_firetimer ++;
		if(_firetimer % 10 == 9){
			_fireframe ++;
			if(_fireframe >= 3){
				_fireframe = 0;
			}
		}
		
		var spd = 3;
		
		_firepos[0] += spd;
		if(_firepos[0] >= WIDTH){
			_firepos[0] = 0;
		}
		_firepos[1] -= spd;
		if(_firepos[1] <= -WIDTH){
			_firepos[1] = 0;
		}
		
		draw_sprite(spr_resultsfire_1, _fireframe, (_firepos[0]-WIDTH)+global._cameraX, global._cameraY);
		draw_sprite(spr_resultsfire_1, _fireframe, _firepos[0]+global._cameraX, global._cameraY);
		draw_sprite(spr_resultsfire_2, _fireframe, _firepos[1]+global._cameraX, global._cameraY);
		draw_sprite(spr_resultsfire_2, _fireframe, (_firepos[1]+WIDTH)+global._cameraX, global._cameraY);
	}
	
	if(_drawspot){
		draw_sprite_ext(spr_results_spotlight, _spotlightframe, x+440, y, 1, 1, (sin(_timer/14)*_amp)-3, #FFFFFF, 1);
		_amp -= 1;
		if(_amp <= 0){
			_amp = 0;
		}
	}
}