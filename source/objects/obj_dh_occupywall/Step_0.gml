{
	visible = false;
	if(global._debug){
		visible = global._showHitbox;
	}
	image_blend = c_white;
	if(place_meeting_array(x, y, _solidarray)){
		image_blend = c_black;
	}
	
	if(!_init){
		_solidarray = global._solidArray;
		_init = true;
	}
	
	if(_parentobj != noone && instance_exists(_parentobj)){
		x = _parentobj.x;
		y = _parentobj.y;
	}
	if(_type == "l"){
		sprite_index = spr_dh_occupywall_l;
		mask_index = spr_dh_occupywall_l;
	} else if(_type == "r"){
		sprite_index = spr_dh_occupywall_r;
		mask_index = spr_dh_occupywall_r;
	}
}