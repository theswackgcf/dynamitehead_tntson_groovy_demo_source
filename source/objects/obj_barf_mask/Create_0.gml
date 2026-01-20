{
	//enemy specific variables
	_name = "";
	_codename = "barf";
	_maxhp = 1;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_barf_display);
	_displayobj._parentobj = self.id;
	_displayobj._depthoffset = 32;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_barf_hurtbox);
	_hitobj._parentobj = self.id;
	
	scr_enemyinit();

	_init = true;

	_startspd = [0,0];
	_land = 0;
	_landtime = 0;
	
	_punchbox = noone;

	_ailevel = 1;
	_canCollide = false;
}