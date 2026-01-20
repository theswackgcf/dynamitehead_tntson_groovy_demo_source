///function scr_textrender_wave_x(amp, spd, _cos, [stops_with_pause])
function scr_textrender_wave_x(amp, spd, stops_with_pause = false){
	if(global._fontInit){
		global._textwave[1] = amp;
		global._textwavetime[1] = spd;
		global._usegametimer = stops_with_pause;
	}
}