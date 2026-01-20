function scr_gamepadasync(type, changepad = false){
	if(type == "discovered"){
		if(changepad){
			var pad = async_load[? "pad_index"];
			global._padnum = pad;
			global._padfound = true;
			global._padtime = 240;
			global._padmsgtype = 0;
		}
		global._inptype = 1;
		global._axisspd = [1,1];
		with(obj_dh_mask){
			_inptype = global._inptype;
		}
		with(obj_options){
			_inpcheck = 0;
			_getinput = false;
		}
		with(obj_menufinal){
			_changedinput = false;
			_inputinit = false;
			_changehold = 0;
		}
	} else if(type == "lost"){
		if(changepad){
			global._padfound = false;
			global._padnum = 0;
			global._padtime = 240;
			global._padmsgtype = 1;
		}
		global._inptype = 0;
		global._axisspd = [1,1];
		with(obj_dh_mask){
			_inptype = global._inptype;
		}
		with(obj_options){
			_inpcheck = 0;
			_getinput = false;
		}
		with(obj_menufinal){
			_changedinput = false;
			_inputinit = false;
			_changehold = 0;
		}
	}
}