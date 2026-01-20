function scr_player_animtransitions(type = ""){
	if(type == "before"){
		//transitions
		if(_state == "item"){
			_anim_transition = false;
		}
		switch(_anim_tr_anim){
			case "idle_jump":
				if(!_jump || _attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_idle_jump";
			break;
			case "fall_idle":
				if(_attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_fall_idle";
			break;
			case "fall_walk":
				if(_attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_fall_walk";
			break;
			case "jump_fall":
				if(_attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_jump_fall";
			break;
					
			case "walk_longjump":
				if(!_jump || _attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_walk_longjump";
			break;
			case "longjump_walk":
				if(_jump || _attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_longjump_walk";
			break;
					
			case "intro2_intro3":
				_anim = "tr_intro2_intro3";
			break;
			case "intro3":
				_anim = "tr_intro3";
			break;
			case "intro3_idle":
				if(_state != "default"){
					_anim_transition = false;
				}
				_anim = "tr_intro3_idle";
			break;
			case "tnt_idle":
				_anim = "tr_tnt_idle";
			break;
			case "crouch_in":
				if(_state != "crouch" || _attack){
					_anim_transition = false;
				}
				_anim = "tr_crouch_in";
			break;
			case "crouch_out":
				if(_attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_crouch_out";
			break;
			case "slide_crouch":
				if(_attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_slide_crouch";
			break;
			case "slide_idle":
				if(_attack){
					_anim_transition = false;
				}
				_anim = "tr_slide_idle";
			break;
			case "run_idle":
				if(_jump || _attack){
					_anim_transition = false;
				}
				_anim = "tr_run_idle";
			break;
			case "grab_idle":
				_anim = "tr_grab_idle";
			break;
			case "grab_pick":
				_anim = "tr_grab_pick";
			break;
			case "mash_idle":
				if(_jump || _attack){
					_anim_transition = false;
				}
				_anim = "tr_mash_out";
			break;
			case "block_idle":
				if(_attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_block_idle";
			break;
			case "taunt_idle":
				if(_attack || _slide){
					_anim_transition = false;
				}
				_anim = "tr_"+_taunt_type+"_idle";
			break;
			case "meleedown_idle":
				_anim = "tr_meleedown_idle";
			break;
		}
		if(_displayobj.image_index >= _displayobj.image_number-1){
			if(_taunt_type != ""){
				_taunt_type = "";
			}
			_anim_tr_anim = "";
			_anim_prev = _anim;
			_anim_transition = false;
		}
	} else if(type == "after"){
		//make transition
		if(_anim_prev != _anim){
			if(compare_anim("idle", "jump_loop") || compare_anim("crouch", "jump_loop")){
				_anim_tr_anim = "idle_jump";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("fall_loop", "idle") || compare_anim("melee_jump", "idle") || compare_anim("air_ground", "idle")){
				_anim_tr_anim = "fall_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("fall_loop", "walk") || compare_anim("fall_loop", "run") || compare_anim("melee_jump", "walk") || compare_anim("air_ground", "walk") || compare_anim("melee_jump", "run") || compare_anim("air_ground", "run") || compare_anim("fall_loop", "idle_lowhp")){
				_anim_tr_anim = "fall_walk";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("jump_loop", "fall_loop")){
				_anim_tr_anim = "jump_fall";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			
			if(compare_anim("runroll", "idle")){
				_anim_tr_anim = "fall_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("runroll", "walk") || compare_anim("runroll", "run")){
				_anim_tr_anim = "fall_walk";
				_anim_tr_init = false;
				_anim_transition = true;
			}
					
			if(compare_anim("walk", "longjump") || compare_anim("run", "longjump")){
				_anim_tr_anim = "walk_longjump";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("longjump", "idle") || compare_anim("longjump", "walk") || compare_anim("longjump", "run")){
				_anim_tr_anim = "longjump_walk";
				_anim_tr_init = false;
				_anim_transition = true;
			}
					
			if(compare_anim("intro2", "intro3")){
				_anim_tr_anim = "intro2_intro3";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("intro3", "idle") || compare_anim("intro3", "walk")){
				_anim_tr_anim = "intro3_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("tnt", "idle") || compare_anim("tnt", "walk") || compare_anim("tnt", "run")){
				_anim_tr_anim = "tnt_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("idle", "crouch") || compare_anim("idle_lowhp", "crouch") || compare_anim("walk", "crouch") || compare_anim("run", "crouch") || compare_anim("fall_loop", "crouch") || compare_anim("intro3", "crouch")){
				_anim_tr_anim = "crouch_in";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("crouch", "idle") || compare_anim("crouch", "idle_lowhp") || compare_anim("crouch", "walk") || compare_anim("crouch", "run")){
				_anim_tr_anim = "crouch_out";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("runroll", "idle") || compare_anim("runroll", "idle_lowhp") || compare_anim("runroll", "walk") || compare_anim("runroll", "run")){
				_anim_tr_anim = "crouch_out";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("slide", "crouch")){
				_anim_tr_anim = "slide_crouch";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("slide", "idle") || compare_anim("slide", "walk") || compare_anim("slide", "run")){
				_anim_tr_anim = "slide_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("runhit", "idle") || compare_anim("runhit", "walk") || compare_anim("runhit", "run")){
				_anim_tr_anim = "slide_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("run", "idle")){
				_anim_tr_anim = "run_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			
			if(compare_anim("standup", "idle") || compare_anim("standup", "idle_lowhp") || compare_anim("standup", "walk")){
				_anim_tr_anim = "fall_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			
			/*if(compare_anim("grab", "idle") || compare_anim("grab", "walk")){
				_anim_tr_anim = "grab_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}*/
			if(compare_anim("grab", "pick") || compare_anim("grab", "pick_walk")){
				_anim_tr_anim = "grab_pick";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("mash1", "idle")){
				_anim_tr_anim = "fall_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("mash1", "walk")){
				_anim_tr_anim = "fall_walk";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("mash2", "idle") || compare_anim("mash2", "walk")){
				_anim_tr_anim = "mash_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("block", "idle") || compare_anim("block", "idle_lowhp") || compare_anim("block", "walk") || compare_anim("block", "run")){
				_anim_tr_anim = "block_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("block_air", "jump_loop") || compare_anim("block_air", "fall_loop")){
				_anim_tr_anim = "idle_jump";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("block_air", "longjump")){
				_anim_tr_anim = "walk_longjump";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim("shakeoff", "idle") || compare_anim("shakeoff", "idle_lowhp") || compare_anim("shakeoff", "walk") || compare_anim("shakeoff", "run")){
				_anim_tr_anim = "crouch_out";
				_anim_tr_init = false;
				_anim_transition = true;
			}
			if(compare_anim(_taunt_type, "idle") || compare_anim(_taunt_type, "idle_lowhp") || compare_anim(_taunt_type, "walk") || compare_anim(_taunt_type, "run")){
				_anim_tr_anim = "taunt_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
				
			if(compare_anim("melee_down1", "idle") || compare_anim("melee_down1", "walk") || compare_anim("melee_down2", "idle") || compare_anim("melee_down2", "walk")){
				_anim_tr_anim = "meleedown_idle";
				_anim_tr_init = false;
				_anim_transition = true;
			}
				
			_anim_prev = _anim;
		}
	}
}