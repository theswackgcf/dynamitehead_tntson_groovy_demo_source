{
	_init = false;
	
	_allsounds = ds_map_create();
	_displayselect = false;
	
	_bg_alp = 0;
	_other_alp = 0;
	
	_staticact = 0;
	_statictimer = 0;
	_staticind = 0;
	_staticscale = 0;
	_staticsnd = false;
	
	_mouseactive = false;
	_mouseprev = [mouse_x,mouse_y];
	_optionhovered = false;
	
	_input_active = false;
	_input_timer = 0;
	
	_end = false;
	_endtimer = 0;
	
	_back = false;
	_backtimer = 0;
	
	_xpos = 0;
	_ypos = 0;
	_action = "";
	_on = false;
	
	_bgtint = c_white;
	
	_showstages = false;
	_stageframeind = 0;
	_stscale = 0.7;
	_surfoffset = [32,24];
	_surfsize = [sprite_get_width(spr_menu_stageframe)-(_surfoffset[0]*2),(sprite_get_height(spr_menu_stageframe)*_stscale)-(_surfoffset[1]*2)];
	_stages = [
		{
			stage: "tutorial",
			title: "BITSTREET BRAWL",
			subtitle: "TUTORIAL",
			desc: "New to this stuff? There's plenty to learn here.",
			bg: [spr_tutr_bg, [290,120], 0.28],
			parallax: [spr_menu_tutr_parallax2,[spr_menu_tutr_parallax1,[-50,0]]],
			surf: surface_create(_surfsize[0],_surfsize[1]),
			scroll_1_pos: 0,
			scroll_2_pos: 0,
			tint: #FF8400,
		},
		{
			stage: "stage2",
			title: "GROOVY GRAVEYARD",
			subtitle: "STAGE 2",
			desc: "Step into a whole new adventure through\nthe Calobian graveyard.",
			bg: [spr_lv2_bg1, [365,0], 0.5],
			parallax: [spr_menu_lv2_parallax2,[spr_menu_lv2_parallax1,[-6,-36]]],
			surf: surface_create(_surfsize[0],_surfsize[1]),
			scroll_1_pos: 0,
			scroll_2_pos: 0,
			tint: #E400FF,
		}
	];
	if(global._buildver == HTML){
		_stages[1].bg[0] = spr_lv2_bg1_html;
	}
	_scrollspd = 1;
	_curoption = 0;
}