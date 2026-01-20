{
	if(place_meeting(x,y,obj_dh_mask)){
		with(obj_st2_goblin){
			visible = true;
		}
		with(obj_st2_wall){
			instance_destroy();
		}
		instance_destroy();
	}
}