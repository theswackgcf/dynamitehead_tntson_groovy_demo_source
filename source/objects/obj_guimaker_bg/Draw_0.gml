{
	if(global._guitrailer){
		_settingoffset += _spd;
		if(_settingoffset >= WIDTH){
			_settingoffset = 0;
		}
		
		if(keyboard_check(vk_left)){
			_hue -= 0.03;
		} else if(keyboard_check(vk_right)){
			_hue += 0.03;
		}
		
		shader_set(shd_hue);
		shader_set_uniform_f(shader_get_uniform(shd_hue, "u_Position"), _hue);
		
		draw_sprite_ext(spr_menu_settingbg, 0, _settingoffset, 0, 1, 1, 0, #9433e8, 1);
		draw_sprite_ext(spr_menu_settingbg, 0, _settingoffset-WIDTH, 0, 1, 1, 0, #9433e8, 1);
		
		shader_reset();
	}
}