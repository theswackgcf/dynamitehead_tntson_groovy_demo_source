{
	_parentobj = noone;
	
	_mousepos = [0,0];
	
	_visibtimer = 0;
	
	_barsz = [58,50];
	_scrollheight = 90;
	_scrollwidth = 90;
	_upselect = 0;
	_downselect = 0;
	_scrollselect = 0;
	
	_prevpos = 0;
	_dir = 0;
	
	_scrollpos = 0;
	_scrolloffs = _barsz[1];
	_totaloffset = 0;
	_bottom = HEIGHT;
	
	_mousetimer = 0;
	_maxmousetimer = 5;
	
	_scrollspd = 0;
	
	_drag = false;
	_dragoffset = 0;
	_dragpos = 0;
	
	_scrollup = 0;
	_scrolldown = 0;
	
	_bbox = {
		up: [0,0,0,0], //up arrow
		down: [0,0,0,0], //down arrow
		scroll: [0,0,0,0], //scrollbar
	};
	
	function go_direction(dir){
		_scrollpos += _scrollspd*dir;
		_mousetimer = 0;
		if(_scrollpos < 0){
			_scrollpos = 0;
		} else if(_scrollpos > 1){
			_scrollpos = 1;
		}
		_parentobj._offsetY = -(_parentobj._scrheight * _scrollpos);
	}
}