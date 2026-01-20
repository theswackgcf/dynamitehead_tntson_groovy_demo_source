{
	image_xscale = _scale;
	image_yscale = _scale;
	
	if(place_meeting(x,y,obj_fade)){
		draw_sprite_part_ext(sprite_index, image_index, _faceparts.eyeL.l,_faceparts.eyeL.t,_faceparts.eyeL.w,_faceparts.eyeL.h,_facepos[0]+(_faceoffset.eyeL[0]*_scale)+_motionoffset.eyeL[0],_facepos[1]+(_faceoffset.eyeL[1]*_scale)+_motionoffset.eyeL[1], image_xscale, image_yscale, image_blend, _alp);
		draw_sprite_part_ext(sprite_index, image_index, _faceparts.eyeR.l,_faceparts.eyeR.t,_faceparts.eyeR.w,_faceparts.eyeR.h,_facepos[0]+(_faceoffset.eyeR[0]*_scale)+_motionoffset.eyeR[0],_facepos[1]+(_faceoffset.eyeR[1]*_scale)+_motionoffset.eyeR[1], image_xscale, image_yscale, image_blend, _alp);
		draw_sprite_part_ext(sprite_index, image_index, _faceparts.mouth.l,_faceparts.mouth.t,_faceparts.mouth.w,_faceparts.mouth.h,_facepos[0]+(_faceoffset.mouth[0]*_scale)+_motionoffset.mouth[0],_facepos[1]+(_faceoffset.mouth[1]*_scale)+_motionoffset.mouth[1], image_xscale, image_yscale, image_blend, _alp);
	}
}