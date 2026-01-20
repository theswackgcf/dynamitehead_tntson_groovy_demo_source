{
	_restore = 0;
	_restore_type = 0;
	_item = ITEM_CHOCO;
	_frombox = false;
	_init = false;
	
	_color = make_color_rgb(255,255,255);
	_itemcolor = [
		make_color_rgb(147, 70, 153),
		make_color_rgb(147, 47, 21),
		make_color_rgb(249, 200, 51),
		make_color_rgb(250, 22, 22),
	];
	
	_sort = true;
	
	if(_frombox){
		y += 80;
	}
	
	_hop_startpos = [x,y];
	_jumptopos = [x,y];
	_hopping = false;
	
	_hop_arcstart = false;
	
	_hop_base_y = y;
	_hop_time = 0;
	_hop_arc = 0;
	
	_hop_spd = 0.05;
	_hop_archeight = 500;
	
	_timer = random(1000);
	
	_checkdelete = false;
	
	//set occupy id
	_occupy_id = "";
	_letr = global._occupyCharset;
	for(var i = 0; i < 7; i++){
		_occupy_id += string_char_at(_letr, round(random_range(1, string_length(_letr))));
	}
	
	_shadowsinit = false;
}