{
	//enemy specific variables
	_name = "Musclethug";
	_codename = "enm2";
	_enmtype = -1;
	_enmtypes = global._enmtypes[? _codename];
	_maxhp = 18;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_enm2_n_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_enm2_n_hurtbox);
	_hitobj._parentobj = self.id;

	//generic variables
	scr_enemyscript_init("create");
	
	//enemy specific variables
	_movespd[? SPD_WALK] = 4;
	_movespd[? SPD_BACK] = 0;
	_movespd[? SPD_PANIC] = 7;
	_movespd[? SPD_FALL] = 7;
	_movespd[? SPD_GRABFALL] = 10;
	_spdmode = SPD_WALK;
	
	_ailevel = 4;
	_koframe = 4;
	
	remove_trait(TRAIT_JABS);
	array_push(_enemytraits, TRAIT_KO, TRAIT_TAUNT);
	
	_grabweight = 0.68;
	
	_meleeanims = 2;
	
	_playvoice.death = snd_enmdie2;
	_maxcolors = global._maxcolors[? _codename];
	
	_hpcolor = [make_color_rgb(77, 114, 174),make_color_rgb(233, 10, 104),make_color_rgb(154, 95, 153)];
	
	
	_punch = false;
	_punchtimer = 0;
}