{
	depth = -5001;
	
	_bg = false;
	
	_scale = 0.86;
	
	image_xscale = _scale;
	image_yscale = _scale;
	
	image_index = irandom_range(0,2);
	_timer = random(1000);
	
	_faceparts = {
		eyeL: {
			l: 17,
			t: 11,
			w: 66,
			h: 88
		},
		eyeR: {
			l: 173,
			t: 7,
			w: 63,
			h: 99
		},
		mouth: {
			l: 22,
			t: 129,
			w: 221,
			h: 124
		}
	}
	_startpos = [x-((sprite_width/2)*_scale),y-((sprite_height/2)*_scale)];
	_facepos = [_startpos[0],_startpos[1]];
	_faceoffset = {
		eyeL: [81,107],
		eyeR: [134,88],
		mouth: [35,150],
	}
	
	_motionoffset = {
		eyeL: [0,0],
		eyeR: [0,0],
		mouth: [0,0],
	}
	
	_alp = 1;
}