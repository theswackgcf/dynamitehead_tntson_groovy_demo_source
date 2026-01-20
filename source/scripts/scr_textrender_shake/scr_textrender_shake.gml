///function scr_textrender_shake(value)
function scr_textrender_shake(valy, valx = 0){
	if(global._fontInit){
		global._textshaking = [valy,valx];
	}
}