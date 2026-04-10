{
	if(!global._pause){
		//prompt position
		if(global._prompt_desc_show > 0){
			_prompt_desc_posto = [0,0];
				
			if(diff_abs(_prompt_desc_pos[1],_prompt_desc_posto[1]) <= 12){
				_prompt_desc_ready = true;
			}
				
			global._prompt_desc_show --;
		} else {
			_prompt_desc_ready = false;
			_prompt_desc_posto = [_prompt_desc_offpos,_prompt_desc_offpos];
				
			if(diff_abs(_prompt_desc_pos[1],_prompt_desc_posto[1]) <= 12){
				_prompt_desc_text = "";
				_prompt_desc_text_prev = _prompt_desc_text;
			}
		}
	
		//set position when new text appears
		if(_prompt_desc_ready && _prompt_desc_text_prev <> _prompt_desc_text){
			_prompt_desc_text_prev = _prompt_desc_text;
			_prompt_desc_posto = [_prompt_desc_offpos/1.5,_prompt_desc_offpos/1.5];
		}
			
		var lerpval = [0.2,0.12];
			
		for(var d = 0; d < 2; d++){
			_prompt_desc_pos[d] = lerp(_prompt_desc_pos[d],_prompt_desc_posto[d],lerpval[d]);
		}
		global._prompt_desc_mult = lerp(global._prompt_desc_mult, global._prompt_desc_multTo, 0.15);	
	}
}