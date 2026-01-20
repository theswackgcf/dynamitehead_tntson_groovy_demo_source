{
	global._sticktimer = 1;
	
	global._allgpinput = [gp_face1,gp_face2,gp_face3,gp_face4,gp_shoulderl,gp_shoulderlb,gp_shoulderr,gp_shoulderrb,gp_select,gp_start,gp_stickl,gp_stickr,gp_padu,gp_padd,gp_padl,gp_padr];
	
	global._axisspd = [1,1];
	global._padaxis = [[0,0],[0,0]];
	_array = ["stick1_l","stick1_r","stick1_u","stick1_d","stick2_l","stick2_r","stick2_u","stick2_d"];
	global._stickheld = ds_map_create();
	global._stickpressed = ds_map_create();
	global._stickreleased = ds_map_create();
	
	global._pad_vibrate = 0;
	
	_vibr_time = 999;
	_vibr_pad = 0;
	
	for(var i = 0; i < array_length(_array); i++){
		global._stickheld[? _array[i]] = false;
		global._stickpressed[? _array[i]] = false;
		global._stickreleased[? _array[i]] = false;
	}
}