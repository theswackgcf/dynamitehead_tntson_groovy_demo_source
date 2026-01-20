{
	//enemy specific variables
	_name = "giant fridge lol";
	_codename = "boss0";
	_maxhp = 80;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_boss0_display);
	_displayobj._parentobj = self.id;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_boss0_hurtbox);
	_hitobj._parentobj = self.id;
	
	scr_enemyinit();
	
	_boss = true;
	_begin = false;
	_beginoffset = 0;
	_beginact = 0;
	_begintime = 0;
	
	_shakeX = 0;
	_shakeY = 0;
}