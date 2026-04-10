{
	if(_drawloser > 0){
		scr_textrender_switchfont("dh_font2");
		scr_textrender_type(_drawloserPos[0], 32, _losertext, true, #db0404, _loseralpha);
		scr_textrender_halign("right");
		scr_textrender_type(_drawloserPos[1], HEIGHT-64, _losertext, true, #db0404, _loseralpha);
		scr_textrender_halign("left");
		scr_textrender_switchfont(global._defaultFont);
	}
	if(_drawloser == 2){
		scr_textrender_halign("center");
		for(var i = 0; i < array_length(_loseOpts); i++){
			var col = global._menuColorNo;
			var xoffset = 0;
			if(_loseOpt == i){
				col = global._menuColorYes;
				xoffset = global._menubuttonsin;
				scr_textrender_shake(3);
			}
			scr_textrender_switchfont("dh_font2");
			scr_textrender_type((WIDTH/2)+xoffset, ((HEIGHT/2)+150)+(i*64), _loseOpts[i], true, col);
			scr_textrender_switchfont(global._defaultFont);
			scr_textrender_shake(0);
		}
		scr_textrender_halign("left");
	}
		
	if(_retry){
		draw_set_color(#000000);
		draw_rectangle(0, 0, WIDTH, HEIGHT, false);
		draw_set_color(#FFFFFF);
	}
}