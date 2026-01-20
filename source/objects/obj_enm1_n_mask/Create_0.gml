{
	//enemy specific variables
	_name = "Sourosaur";
	_codename = "enm1";
	_enmtype = -1;
	_enmtypes = global._enmtypes[? _codename];
	_maxhp = 14;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_enm1_n_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_enm1_n_hurtbox);
	_hitobj._parentobj = self.id;

	//generic variables
	scr_enemyscript_init("create");
	
	//enemy specific variables
	_movespd[? SPD_WALK] = 5;
	_movespd[? SPD_BACK] = 3;
	_movespd[? SPD_PANIC] = 9;
	_movespd[? SPD_FALL] = 8;
	_movespd[? SPD_GRABFALL] = 12;
	_spdmode = SPD_WALK;
	
	_ailevel = 3;
	
	array_push(_enemytraits, TRAIT_KO, TRAIT_TAUNT, TRAIT_BACKOFF);
	
	_meleeanims = 2;
	
	_playvoice.death = snd_enmdie3;
	_maxcolors = global._maxcolors[? _codename];
	
	_hpcolor = [make_color_rgb(138, 60, 145),make_color_rgb(130, 217, 43),make_color_rgb(249, 204, 51)];
}