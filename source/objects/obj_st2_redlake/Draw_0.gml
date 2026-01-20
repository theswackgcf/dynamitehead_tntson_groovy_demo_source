{
	if(_inview){
		gpu_set_texfilter(false);
		gpu_set_texrepeat(true);
		shader_set(shd_wavy);
		shader_set_uniform_f(t, _timer);
		shader_set_uniform_f(aX, 0);
		shader_set_uniform_f(aY, 0.01);
		shader_set_uniform_f(s, 0.14);
		shader_set_uniform_f(fX, 0);
		shader_set_uniform_f(fY, 80);
			
		draw_sprite_ext(sprite_index,_ind,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
		draw_sprite_ext(sprite_index,_indnext,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha*_alp);
			
		shader_reset();
		gpu_set_texrepeat(false);
		gpu_set_texfilter(global._texfilter);
	}
}