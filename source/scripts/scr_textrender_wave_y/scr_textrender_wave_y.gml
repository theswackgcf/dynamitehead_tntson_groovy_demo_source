///function scr_textrender_wave_y(amp, spd, _cos, [stops_with_pause])
function scr_textrender_wave_y(amp, spd, stops_with_pause = false){
	if(global._fontInit){
		global._textwave[0] = amp;
		global._textwavetime[0] = spd;
		global._usegametimer = stops_with_pause;
	}
}