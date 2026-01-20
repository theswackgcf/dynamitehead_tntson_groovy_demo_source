{
	//enemy specific variables
	_name = "fridge";
	_codename = "fridge";
	_enmtypes = [];
	_enmtype = -1;
	_maxhp = 99;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_fridge_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_fridge_hurtbox);
	_hitobj._parentobj = self.id;

	//generic variables
	scr_enemyscript_init("create");
	
	//enemy specific variables
	_movespd[? SPD_WALK] = 0;
	_movespd[? SPD_BACK] = 0;
	_movespd[? SPD_PANIC] = 0;
	_movespd[? SPD_FALL] = 7;
	_movespd[? SPD_GRABFALL] = 7;
	_spdmode = SPD_WALK;
	
	_shadowsize = 0.35;
	
	_ailevel = 1;
	
	_dostepsound = false;
	
	_meleeanims = 1;
	_hurtanims = 1;
	
	_animloop[? "spin"] = 2;
	_animloop[? "fire"] = 3;
	
	_enemytraits = [];
	
	_maxcolors = 1;
	
	_hpcolor = [make_color_rgb(255, 0, 0)];

	//enemy specific
	_fr_tipobj = noone;
	
	_fr_solid = noone;
	_fr_startx = x;
	_fr_starty = y;
	_fr_settype = false;
	_fr_type = "fridge_tnt";
	_fr_kicked = false;
	_fr_jump = false;
	_fr_upperready = false;
	_fr_bonkcd = 0;
	_fr_throw = false;
	_fr_dir = DIR_L;
	_fr_rollkill = false;
	_fr_sethp = false;
	_fr_parryactive = false;
	_fr_parrytimer = 0;
	_fr_parryact = 0;
	_fr_shoot = false;
	_fr_crackstate = 0;
	_fr_crackamp = 0;
	_fr_combocount = 0;
	_fr_backtopos = false;
}