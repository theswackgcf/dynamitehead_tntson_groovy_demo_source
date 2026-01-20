{
	//enemy specific variables
	_name = "Toxic Barrel";
	_codename = "st1_barrel";
	_enmtype = -1;
	_maxhp = 10;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_st1_barrel_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_st1_barrel_hurtbox);
	_hitobj._parentobj = self.id;
	
	scr_enemyscript_init("create");

	_startpos = [x,y];

	_ailevel = 0;
	
	_fatalko = true;
	
	_enemytraits = [TRAIT_HURT, TRAIT_HP];
	
	_explode = false;
	_fly = false;
	_showDmg = false;
	
	_flytimer = 0;
	
	_hpcolor = [make_color_rgb(236, 231, 17)];
	
	_checkdelete = false;
}