{
	global._testloop_curmusic = 0;
	
	_init = false;
	
	_rooms = [
		r_loading,
		r_stage2,
		r_tutorial,
		r_st2_enemiestest,
		r_groovy,
		r_briefing,
		r_easing_test,
		r_menu,
		r_stageintro,
		r_template,
		r_loop_test,
		r_guimaker,
		r_fontmaker,
		r_debug_texttest,
		r_color_test,
		r_dead,
		r_enddemo,
	];
	_allrooms = [
	];
	
	_dslist = -1;
	
	_curroom = 0;
	
	_full = false;
}