gpu_set_texrepeat(true);
shader_set(shd_wavy);
shader_set_uniform_f(t, _timer);
shader_set_uniform_f(aX, 0.015);
shader_set_uniform_f(aY, 0.015);
shader_set_uniform_f(s, 0.02);
shader_set_uniform_f(fX, 20);
shader_set_uniform_f(fY, 20);
shader_reset();
gpu_set_texrepeat(false);

if(_balled){
	draw_sprite_ext(spr_ball, 0, _ballpos[0] + 4, _ballpos[1] + 4, 1, 1, _ballrot, c_black, 0.2);
	draw_sprite_ext(spr_ball, 0, _ballpos[0], _ballpos[1], 1, 1, _ballrot, c_white, 1);
}
else{
	for(var i = 0; i < array_length(_guideverts); i++){
		if(i != array_length(_guideverts)-1){
			draw_set_alpha(lerp(0.5, 0, i / (array_length(_guideverts) - 1)));
			draw_line_width(_guideverts[i][0], _guideverts[i][1], _guideverts[i+1][0], _guideverts[i+1][1], 5);
			draw_set_alpha(1);
		}
	}
}

for(var i = 0; i < array_length(_pegs); i++){
	var xx = _pegs[i][0] + random_range(-_pegs[i][3], _pegs[i][3]);
	var yy = _pegs[i][1] + random_range(-_pegs[i][3], _pegs[i][3]);
	
	draw_sprite_ext(spr_ball, 0, xx + 4, yy + 4, 1, 1, 0, c_black, 0.2);
	if(_pegs[i][2] == true){
		draw_sprite_ext(spr_ball, 0, xx, yy, 1, 1, 0, c_blue, 1);
	}
	else{
		draw_sprite_ext(spr_ball, 0, xx, yy, 1, 1, 0, c_orange, 1);
	}
}