function scr_lode_project(spr_ind,img_index,pos,scale,depth_ = 0,angle = 0,blend = c_white,alpha = 1,text = ""){
	//project onto main object
	var cullx = pos[0]-global._lode_cullingoffset[0];
	var cully = pos[1]-global._lode_cullingoffset[1];
	var ignoreculling = false;
	if(variable_instance_exists(self.id, "_ignoreculling")){
		if(_ignoreculling){
			ignoreculling = _ignoreculling;
		}
	}
	
	var project = false;
	
	if(cullx >= global._lode_cullingbox[0] && cullx <= global._lode_cullingbox[2]){
		if(cully >= global._lode_cullingbox[1] && cully <= global._lode_cullingbox[3]){
			project = true;
		}
	}
	if(ignoreculling){
		project = true;
	}
	
	if(project){
		var lodeobj = instance_find(obj_mg_lode,0);
		if(instance_exists(lodeobj)){
			var show = true;
			if(variable_instance_exists(self.id,"_show")){
				show = _show;
			}
			lodeobj._project[? _id] = {
				spr: spr_ind,
				img: img_index,
				pos: [floor(pos[0]),floor(pos[1])],
				scale: [scale[0],scale[1]],
				angle: angle,
				blend: blend,
				alpha: alpha,
				depth_: depth_,
				show: show,
				tilelayer: _tilelayer,
				tilepos: [_tilepos[0],_tilepos[1]],
				text: text,
				ignoreculling: ignoreculling,
			};
		}
	}
}