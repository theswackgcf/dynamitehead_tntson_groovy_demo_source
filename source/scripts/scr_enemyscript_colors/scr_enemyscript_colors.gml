function scr_enemyscript_colors(){
	if(!_colorsinit){
		if(ds_map_exists(global._enemyColors, _codename)){
			if(_enmtype == -1){
				_rep = "def";
				_docolors = false;
				if(global._lightsout){
					_docolors = true;
				}
			} else {
				_rep = _enmtypes[_enmtype][0];
				_name = _enmtypes[_enmtype][1];
				if(!_althp){
					_maxhp = _enmtypes[_enmtype][2];
					_hp = _maxhp;
					
					_althp = true;
				}
			}
			makecolors("def",_rep,_codename);
			
			if(_enmtype != -1){
				_difftype = true;
			}
		}
		_colorsinit = true;
	}
}