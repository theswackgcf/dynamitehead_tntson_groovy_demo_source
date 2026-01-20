{
	if(_init && _start){
		gpu_set_blendmode(bm_add);
		for(var i = 0; i < array_length(_rainframes[_curframe]); i++){
			if(i >= _stoptimer){
				if(_rainframes[_curframe][i][1] <= _floorpoint){
					draw_sprite_ext(spr_st2_rain,0,x+_rainframes[_curframe][i][0],y+_rainframes[_curframe][i][1],0.55,1.2,0,_col,_alp);
				}
			}
		}
		gpu_set_blendmode(bm_normal);
	}
}