{
	if(_barreldraw){
		if(global._pause){
			_barrelamp = 0;
		} else {
			if(_timer % 6 == 0){
				var p = instance_create_depth((_barrelpos[0]+global._cameraX)-64, (_barrelpos[1]+global._cameraY)-64, depth, obj_particle);
				p._type = "barrelfly";
				p._forcedepth = depth+1;
				p._move = true;
				p._yspd = -3;
				p._xspd = -2;
			}
			_barrelamp = 4;
			_barrelpos[0] += 2;
			_barrelpos[1] += 8;
		}
		draw_sprite_ext(spr_barrelfly, 0, (_barrelpos[0]+sin(random(320))*_barrelamp)+global._cameraX, (_barrelpos[1]+cos(random(320))*_barrelamp)+global._cameraY, 1, 1, -70, #FFFFFF, 1);
	}
	if(_bignukedraw){
		if(global._pause){
			_nukeamp = 0;
		} else {
			_nukeamp = 0.02;
		}
		draw_sprite_ext(spr_barrel_nuke2, _bignukeframe, floor(WIDTH/2)+global._cameraX, (HEIGHT-global._screenSideOffset)+global._cameraY, 1+(sin(random(480))*_nukeamp), 1+(cos(random(480))*_nukeamp), 0, #FFFFFF, 1);
	}
}