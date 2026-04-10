function scr_lode_project_surface(surface,xx,yy){
	//project onto main object
	var lodeobj = instance_find(obj_mg_lode,0);
	if(instance_exists(lodeobj)){
		var show = true;
		if(variable_instance_exists(self.id,"_show")){
			show = _show;
		}
		lodeobj._project[? _id] = {
			surface: surface,
			pos: [floor(xx),floor(yy)],
			depth_: _depth,
			tilelayer: _tilelayer,
			tilepos: [_tilepos[0],_tilepos[1]],
			show: show,
		};
	}
}