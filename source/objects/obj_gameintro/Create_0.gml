{
	_allsounds = ds_map_create();
	
	_timer = 0;
	_act = 0;
	_logoscale = 1;
	
	_rare = random_range(0,1000);
	_frame = 0;
	
	_load = noone;
	_gotodebugroom = false;
	
	_canskip = false;
	
	function roomto(roomname){
		room_goto(roomname);
	}
}