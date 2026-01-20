{
	var c = instance_create_depth(x+(sprite_width*0.05), y, depth, obj_crouchspot);
	c.image_xscale = image_xscale*0.9;
	c.image_yscale = image_yscale;
	
	visible = false;
	_height = 9999;
	_collidewith = "all";
}