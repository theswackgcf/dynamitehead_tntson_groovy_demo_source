function scr_lode_project_array(info_array){
	//project onto main object
	var pos = [
		floor(info_array[0].pos[0]),
		floor(info_array[0].pos[1]),
	];
	var cullx = pos[0]-global._lode_cullingoffset[0];
	var cully = pos[1]-global._lode_cullingoffset[1];
	if(cullx >= global._lode_cullingbox[0] && cullx <= global._lode_cullingbox[2]){
		if(cully >= global._lode_cullingbox[1] && cully <= global._lode_cullingbox[3]){
			var lodeobj = instance_find(obj_mg_lode,0);
			if(instance_exists(lodeobj)){
				var show = true;
				if(variable_instance_exists(self.id,"_show")){
					show = _show;
				}
				for(var i = 0; i < array_length(info_array); i++){
					var angle = 0;
					if(variable_struct_exists(info_array[i],"angle")){
						angle = info_array[i].angle;
					}
					var blend = c_white;
					if(variable_struct_exists(info_array[i],"blend")){
						angle = info_array[i].blend;
					}
					var alpha = 1;
					if(variable_struct_exists(info_array[i],"alpha")){
						angle = info_array[i].alpha;
					}
					var depth_ = 0;
					if(variable_struct_exists(info_array[i],"depth_")){
						depth_ = info_array[i].depth_;
					}
					var text = "";
					if(variable_struct_exists(info_array[i],"text")){
						text = info_array[i].text;
					}
					var tilepos = [0,0];
					if(variable_struct_exists(info_array[i],"tilepos")){
						tilepos = info_array[i].tilepos;
					}
			
					var spr = info_array[i].spr;
					if(spr == -1){
						show = false;
						spr = spr_lode_camera;
					}
			
					lodeobj._project[? _id+string(i)] = {
						spr: info_array[i].spr,
						img: info_array[i].ind,
						pos: [floor(info_array[i].pos[0]),floor(info_array[i].pos[1])],
						scale: [info_array[i].scale[0],info_array[i].scale[1]],
						angle: angle,
						blend: blend,
						alpha: alpha,
						depth_: depth_,
						show: show,
						tilelayer: _tilelayer,
						tilepos: [tilepos[0],tilepos[1]],
						text: text,
					};
				}
			}
		}
	}
}