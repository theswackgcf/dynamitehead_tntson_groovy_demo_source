{
	if(!global._pause){
		if(instance_number(obj_boss2_mask) > 0 && _intro){
			with(obj_gui){
				ui_fade("dh",0);
				ui_fade("tnt",0);
			}
			
			with(obj_dh_mask){
				_candospecial = false;
			}
		}
	}
}