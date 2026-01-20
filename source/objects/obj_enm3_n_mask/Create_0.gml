{
	//enemy specific variables
	_name = "Bagdiot";
	_codename = "enm3";
	_enmtype = -1;
	_enmtypes = global._enmtypes[? _codename];
	_maxhp = 17;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_enm3_n_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_enm3_n_hurtbox);
	_hitobj._parentobj = self.id;

	//generic variables
	scr_enemyscript_init("create");
	
	//enemy specific variables
	_movespd[? SPD_WALK] = 6;
	_movespd[? SPD_BACK] = 7;
	_movespd[? SPD_PANIC] = 8;
	_movespd[? SPD_FALL] = 8;
	_movespd[? SPD_GRABFALL] = 12;
	_spdmode = SPD_WALK;
	
	_ailevel = 5;
	
	array_push(_enemytraits, TRAIT_KO, TRAIT_TAUNT, TRAIT_BACKOFF);
	
	_meleeanims = 2;
	
	_playvoice.death = snd_enmdie3;
	_maxcolors = global._maxcolors[? _codename];
	
	_hpcolor = [make_color_rgb(48, 109, 57),make_color_rgb(243, 65, 20),make_color_rgb(142, 99, 197)];
	
	
	_tp = false;
	_tpact = 0;
	_tptime = 0;
	_notp = 0;
}