{
	if(_trigger){
		if(_act == 1){
			var henchscale = 0.89;
			draw_sprite_ext(spr_st2_cut_hench,_henchind,_hench1pos,y,henchscale,henchscale,0,image_blend,image_alpha);
			draw_sprite_ext(spr_st2_cut_hench,_henchind,_hench2pos,y,henchscale,henchscale,0,image_blend,image_alpha);
		}
		
		if(_act >= 0){
			var lankscale = 0.93;
			draw_sprite_ext(spr_st2_cut_lank,_lankind,_lankpos,y,lankscale,lankscale,0,image_blend,image_alpha);
		}
	}
}