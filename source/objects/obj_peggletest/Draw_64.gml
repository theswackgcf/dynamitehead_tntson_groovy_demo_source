if(!_balled){
	scr_textrender_setfont("dh_font1", global._charset[? "ascii"]);
	scr_textrender_wave_y(5, 5, true);
	scr_textrender_halign("center");
	scr_textrender_type(WIDTH / 2, 256, "go ahead. /rfling /wmy /bballs. /w(click)\nmouse wheel to change peg amount", true);
	scr_textrender_type(WIDTH / 2, 400, "hit /yescape /wto /rescape/w.", true);
	scr_textrender_wave_y(0, 0, false);
}