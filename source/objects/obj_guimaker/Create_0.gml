{
	depth = -9999;
	
	global._curobj = noone;
	global._dragobj = noone;
	global._dragdepth = 0;
	
	_show = true;
	_showborder = true;
	
	_curdepth = 0;
	_dsmap = ds_map_create();
	_clipboard = 0;
	_deleteall = false;
	
	global._guitrailer = false;
	
	global._mainoffset = [0,0];
	
	instance_create_depth(0,0,32,obj_guimaker_bg);
}