{
	if(_init){
		scr_textrender_type(32, 72, "/yIMPORTANT!/w If you want the music to loop properly,\nmake sure it's set to either \"Uncompressed - Not Streamed\"\nOR \"Uncompress on Load - Not Streamed\"");
		
		scr_textrender_type(_trackoffset[0], _trackoffset[1]-64, audio_get_name(_audio));
	
		//draw state
		var curframe = 0;
		if(!_playing){
			curframe = 1;
		}
		if(_stopped){
			curframe = 2;
		}
		draw_sprite(spr_looptest_state, curframe, _trackoffset[0]-32,_trackoffset[1]);
	
		//draw trackbar
		draw_set_color(#401e73);
		draw_rectangle(_trackoffset[0],_trackoffset[1],_trackoffset[0]+_tracksize[0],_trackoffset[1]+_tracksize[1], false);
		draw_set_color(#ffffff);
		draw_rectangle(_trackoffset[0],_trackoffset[1],_trackoffset[0]+(_tracksize[0]*_soundpercent),_trackoffset[1]+_tracksize[1], false);
	
		//draw loop point
		var trioffset = [[0,0],[16,0],[0,24]];
		var tridrawX = _trackoffset[0]+(_tracksize[0]*_looppercent);
		var tridrawY = _trackoffset[1]-24;
		draw_set_color(c_lime);
		draw_triangle(tridrawX+trioffset[0][0],tridrawY+trioffset[0][1],tridrawX+trioffset[1][0],tridrawY+trioffset[1][1],tridrawX+trioffset[2][0],tridrawY+trioffset[2][1],false);
		
		scr_textrender_type(_trackoffset[0], (_trackoffset[1]+_tracksize[1])+24, string(_soundpos)+"/"+string(_soundlen)+"\nloop point: /y"+string(_looppoint)+"/w");
		scr_textrender_type(_trackoffset[0], (_trackoffset[1]+_tracksize[1])+120, "HELP:\nSPACE: Pause/Resume\nSHIFT+SPACE: stop\nSHIFT+L: set loop marker\nL: go to loop point\nclick to change position\nLEFT/RIGHT: precise position (on pause)");
	
		//draw music list
		_mushover = -1;
		for(var i = 0; i < array_length(_musiclist); i++){
			if(scr_mousehover(_muslistoffset[0],_muslistoffset[1]+(i*_muslistsize[1]),_muslistoffset[0]+_muslistsize[0],_muslistoffset[1]+(i*_muslistsize[1])+_muslistsize[1],true)){
				draw_set_color(#444444);
				draw_rectangle(_muslistoffset[0],_muslistoffset[1]+(i*_muslistsize[1]),_muslistoffset[0]+_muslistsize[0],_muslistoffset[1]+(i*_muslistsize[1])+_muslistsize[1],false);
				draw_set_color(c_white);
				_mushover = i;
			}
		}
		for(var i = 0; i < array_length(_musiclist); i++){
			scr_textrender_type(_muslistoffset[0],_muslistoffset[1]+(i*_muslistsize[1]),audio_get_name(_musiclist[i]));
		}
	}
}