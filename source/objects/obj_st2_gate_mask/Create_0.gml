{
	//enemy specific variables
	_name = "gate";
	_codename = "st2_gate";
	_enmtype = -1;
	_maxhp = 7;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_st2_gate_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x+250, y, 0, obj_st2_gate_hurtbox);
	_hitobj._parentobj = self.id;

	_object = true;

	//generic variables
	scr_enemyscript_init("create");
	
	//enemy specific variables
	_movespd[? SPD_WALK] = 0;
	_movespd[? SPD_BACK] = 0;
	_movespd[? SPD_PANIC] = 0;
	_movespd[? SPD_FALL] = 0;
	_movespd[? SPD_GRABFALL] = 0;
	_spdmode = SPD_WALK;
	
	_ailevel = 1;
	
	_dostepsound = false;
	
	_haveshadow = false;
	
	_meleeanims = 1;
	_hurtanims = 1;
	
	_fatalko = true;
	
	_enemytraits = [TRAIT_HURT];
	_atkallowed = [ATK_NORM];
	_typeallowed = ["idle"];
	
	_maxcolors = 1;
	
	_hpcolor = [make_color_rgb(255, 0, 0)];

	_checkdelete = false;

	//enemy specific
	_opened = false;
	_g_offsets = [[188,50],[8,-77]];
}