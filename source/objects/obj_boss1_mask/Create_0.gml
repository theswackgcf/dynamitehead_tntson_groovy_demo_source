{
	//enemy specific variables
	_name = "Frankenbarf";
	_codename = "boss1";
	_maxhp = 95;
	
	//create the "sprites" object
	_displayobj = instance_create_depth(x, y, -16, obj_boss1_display);
	_displayobj._parentobj = self.id;
	_displayobj.visible = false;
	
	//create the hitbox object
	_hitobj = instance_create_depth(x, y, 0, obj_boss1_hurtbox);
	_hitobj._parentobj = self.id;
	
	scr_enemyinit();
	
	_boss = true;
	_begin = false;
	_beginoffset = 0;
	_beginact = 0;
	_begintime = 0;
	_shadowsize = 1;
	
	_ai = 4;
	_light = 0.7;
	_walkspd = _maxspd[0]*_light;
	_grabweight = 0.42;
	
	_punch = false;
	
	_shakeX = 0;
	_shakeY = 0;
	
	_attacknum = 0;
	_attacktimer = 0;
	
	_barfed = false;
	_barfs = 0;
	_barfdir = "r";
	_barfstarttime = 0;
	
	_nomorebarf = false;
	
	_enemybarf = false;
	
	_jumps = 0;
	_land = false;
	_jumped = false;
	
	_jumpshake = 0;
	
	_trigger = false;
	
	_finalhit = false;
	_dodeath = 0;
	
	_heavygrab = true;
	
	_hpcolor = [make_color_rgb(123, 187, 26)];
	
	_growl = false;
	_randhurtmax = 3;
	
	_block = 0;
	_gotdamaged = 0;
	_diddamage = 0;
	
	_distattack = 160;
	_walkdist = 140;
	
	global._frankenId = 0;
	
	_afterfallhit = false;
	_flyout = false;
	
	_jumpSpd = [0,0];
	
	_playvoice.death = snd_boss1_tnt;
	
	_bugpreventionframechecker = 0;
}