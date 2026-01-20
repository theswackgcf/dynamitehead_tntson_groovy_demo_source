function scr_setgamevals(){
	global._speedruntimer = 0;
	
	global._died = false;
	global._knockouts = 0;
	global._plusmoney.prev = [];
	global._plusmoney.cur = [];
	global._moneypickups.prev = 0;
	global._moneypickups.cur = 0;
	global._checkpoint = noone;
	global._checkPos = [0,0];
	ds_map_destroy(global._checkps);
	global._checkps = ds_map_create();
	global._bossintro = false;
	global._bossphase_save = 0;
	global._bosswave_save = 0;
}