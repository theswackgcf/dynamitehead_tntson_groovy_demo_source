{
	//scary evil face of dinamit
	_facetimer ++;
	if(_facetimer % 10 == 9){
		if(_faceact == 0){
			_faceframe ++;
			if(_faceframe >= image_number-1){
				_faceact = 1;
			}
		} else {
			_faceframe --;
			if(_faceframe <= 0){
				_faceact = 0;
			}
		}
	}
	
	//draw waveform
	if(_init){
		var chunk = floor(_bufferlength/_scale);
		var linelen = 23;
		var lineamp = 0.0035;
		var progress = 0;
		var cap = 4;
		
		_chunkpos = _bufferlength*_soundpercent;
		
		for(var i = _chunkpos; i < chunk+_chunkpos; i++){
			var drawoffset = [0,350];
			var point = [
				buffer_peek(_audiobuffer, min(i,buffer_get_size(_audiobuffer)-cap), buffer_s16),
				buffer_peek(_audiobuffer, min(i+1,buffer_get_size(_audiobuffer)-cap), buffer_s16),
			];
			
			var offsets = [-(WIDTH),WIDTH,0];
			if(progress <= WIDTH){
				for(var j = 0; j < 3; j++){
					draw_set_color(#2e0322);
					if(j < 2){
						draw_set_color(#5c0000);
					}
					draw_line_width(
						((drawoffset[0]+progress)+(progress*linelen))+offsets[j],
						(drawoffset[1]+(point[0]*lineamp)),
						((drawoffset[0]+progress)+((progress+1)*linelen))+offsets[j],
						(drawoffset[1]+(point[1]*lineamp)),
						5
					);
					draw_set_color(c_white);
				}
			}
			
			var offsetright = linelen-1;
			progress += linelen-offsetright;
		}
	}
	
	draw_sprite_ext(sprite_index, _faceframe, WIDTH/2, _facey+(sin(current_time / 400) * 5), 0.62 * _facescale, 0.62 * _facescale, 0, #FFFFFF, 1);
}