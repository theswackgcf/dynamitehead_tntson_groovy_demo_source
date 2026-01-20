{
	//enemy specific variables
	_name = "DynamiteHead's fridge";
	_codename = "fridge";
	_enmtype = -1;
	_maxhp = 99;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_fridge_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_fridge_hurtbox);
	_hitobj._parentobj = self.id;
	
	scr_enemyscript_init("create");

	//enemy specific variables
	_starty = y;
	_movespd[? SPD_WALK] = 0;
	_movespd[? SPD_BACK] = 0;
	_movespd[? SPD_FALL] = 7;
	_movespd[? SPD_GRABFALL] = 7;
	_spdmode = SPD_WALK;

	_ailevel = 0;
	
	_enemytraits = [TRAIT_HURT];
	
	_begin = false;
	
	_hpcolor = [make_color_rgb(255, 214, 102)];
	
	
	_invinc = true;
	_setko = false;
}