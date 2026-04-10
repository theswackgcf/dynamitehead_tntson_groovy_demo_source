function scr_lode_digbox_offset(){
	var offset = global._lode_tilesize*_parentobj._digdir;
	
	var xformula = ((_parentobj.x-(global._lode_tilesize*0.5))+offset)/global._lode_tilesize;
	
	x = round(xformula)*global._lode_tilesize;
	
	var yval = _parentobj.y;
	if(_parentobj._plstate == LODE_STATE_LADDER){
		yval = _parentobj.y-global._lode_tilesize;
	}
	
	y = round(yval/global._lode_tilesize)*global._lode_tilesize;
}