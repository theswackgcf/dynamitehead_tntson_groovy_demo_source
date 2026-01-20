scr_textrender_halign("center");
scr_textrender_valign("middle");
scr_textrender_type(WIDTH / 2, 32, "EASING TEST");

var types = ["linear", "ease in", "ease out", "ease in and out", "ease out elastic"];
var baseyoffset = 64;
var duration = 60;

for(var i = 0; i < array_length(types); i++){
	scr_textrender_type(WIDTH / 2, baseyoffset + ((i + 1) * 48), types[i] + ":");
	
	var ballx = 0;
	switch(types[i]){
		case "linear":
			ballx = ease_linear(_leftx, _rightx, duration, types[i]);
		break;
		case "ease in":
			ballx = ease_in(_leftx, _rightx, duration, types[i]);
		break;
		case "ease out":
			ballx = ease_out(_leftx, _rightx, duration, types[i]);
		break;
		case "ease in and out":
			ballx = ease_in_out(_leftx, _rightx, duration, types[i]);
		break;
		case "ease out elastic":
			ballx = ease_out_elastic(_leftx, _rightx, duration, 0.5, types[i]);
		break;
		default:
			ballx = WIDTH / 2;
		break;
	}
	
    draw_sprite_ext(spr_ball, 0, ballx, baseyoffset + 100 + (i * 48), 1.5, 1.5, 0, c_white, 1);
	baseyoffset += 64;
}

//swap directions
for(var i = 0; i < array_length(types); i++){
	if(global._easings[? types[i]] >= duration){
		global._easings[? types[i]] = 0;
		var tempStart = _leftx;
		_leftx = _rightx;
		_rightx = tempStart;
	}
}