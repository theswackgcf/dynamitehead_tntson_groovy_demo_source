{
	_allsounds = ds_map_create();
	
	_start = false;
	_timer = 0;
	_act = 0;
	
	_barreldraw = false;
	_barrelpos = [0,0];
	_barrelamp = 0;
	
	_spawntype = SPAWN_NORMAL;
	_spawnX = 0;
	
	_bignukedraw = false;
	_bignukeact = 0;
	_bignuketimer = 0;
	_bignukeframe = 0;
	_nukeamp = 0;
	
	_startspawn = false;
	_enmtimer = 0;
	_spawnenm = 0;
	
	//nuke lighting
	_defcolors = [hex_to_rgb("#4dcbd0"),hex_to_rgb("#4dcbd0")] //[dark part, bright part]
	if(global._buildver == HTML){
		_defcolors = [hex_to_rgb("#254cf2"),hex_to_rgb("#254cf2")] //[dark part, bright part]
	}
}