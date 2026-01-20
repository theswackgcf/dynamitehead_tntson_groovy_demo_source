{
	_allsounds = ds_map_create();
	
	_checkdelete = false;
	
	#macro ST2_SECRET_TRIGGER_IDLE 0
	#macro ST2_SECRET_TRIGGER_AIR 1
	#macro ST2_SECRET_TRIGGER_CROUCH 2
	
	_trigger = false;
	_triggertype = ST2_SECRET_TRIGGER_IDLE;
	
	_layer = "";
	
	_destroy = false;
	
	_visible = true;
	
	_forcedepth = 0;
}