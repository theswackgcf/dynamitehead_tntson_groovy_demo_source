{	
	if(_start && _act >= 2){		
		//draw screen
		if(global._buildver == WINDOWS){
			scr_textrender_switchfont("dh_font4_big");
		} else if(global._buildver == HTML){
			scr_textrender_switchfont("dh_font4");
		}
		scr_textrender_halign("center");
		scr_textrender_valign("middle");
			
		if(!global._pause){
			scr_textrender_shake(10+_addamp, _addamp);
		}
			
		if(global._buildver == WINDOWS){
			scr_textrender_type(_bosspos[0]+_bossoffset[0],_bosspos[1]+_bossoffset[1],_bossname,true,c_white,1,0.78,0.78);
		} else if(global._buildver == HTML){
			scr_textrender_type(_bosspos[0]+_bossoffset[0],_bosspos[1]+_bossoffset[1],_bossname,true,c_white,1,1.54,1.54);
		}
		scr_textrender_shake(0);
			
		scr_textrender_halign("left");
		scr_textrender_valign("top");
		scr_textrender_switchfont(global._defaultFont);
	}
}