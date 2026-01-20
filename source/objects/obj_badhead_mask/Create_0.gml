{
	//enemy specific variables
	_name = "badhead";
	_codename = "badhead";
	_enmtypes = global._enmtypes[? _codename];
	_enmtype = -1;
	_maxhp = 99;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_badhead_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_badhead_hurtbox);
	_hitobj._parentobj = self.id;

	//generic variables
	scr_enemyscript_init("create");
	
	//enemy specific variables
	_movespd[? SPD_WALK] = 7;
	_movespd[? SPD_BACK] = 7;
	_movespd[? SPD_PANIC] = 7;
	_movespd[? SPD_FALL] = 7;
	_movespd[? SPD_GRABFALL] = 7;
	_spdmode = SPD_WALK;
	randomspd();
	
	_ailevel = 1;
	
	_dostepsound = true;
	
	_meleeanims = 1;
	_hurtanims = 1;
	
	array_push(_enemytraits,
	TRAIT_KO, TRAIT_TAUNT,
	TRAIT_BACKOFF);
	
	_maxcolors = 1;
	
	_hpcolor = [make_color_rgb(255, 0, 0),make_color_rgb(255, 0, 0),make_color_rgb(255, 0, 0)];

	//enemy specific
	
}