{
	depth = 9000;
	if(_parentobj != noone && instance_exists(_parentobj)){
		image_xscale = _parentobj._scale;
		image_yscale = _parentobj._scale+(sin(_parentobj._timer)*0.2);
		image_alpha = _parentobj._alp;
	}
}