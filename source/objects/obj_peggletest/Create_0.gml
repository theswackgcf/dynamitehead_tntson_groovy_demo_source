_allsounds = ds_map_create();

_gravity = 0.5;
_pegcount = 24;

_balled = false;
_ballpos = [0,0];
_ballvel = [0,0];
_ballrot = 0;
_ballrotspd = 0;
_minspeed = 5;

_pegshit = 0;

_pegs = [];
_blowingup = false;
_blowuptimer = 8;
_curblowuptimer = _blowuptimer;
_blows = 0;

_guideverts = [];

//bg stuff
t = shader_get_uniform(shd_wavy, "timer");
fX = shader_get_uniform(shd_wavy, "freqX");
fY = shader_get_uniform(shd_wavy, "freqY");
s = shader_get_uniform(shd_wavy, "scaling");
aX = shader_get_uniform(shd_wavy, "ampX");
aY = shader_get_uniform(shd_wavy, "ampY");
_timer = 0;

//random pegs
function generatepegs(){
	if(_pegcount < 1){
		_pegcount = 1;
	}
	
	var placed = 0;
	var gridsize = ceil(sqrt(_pegcount));
	var cellsizex = ceil(WIDTH / gridsize);
	var cellsizey = ceil(HEIGHT / gridsize);
	
	while(placed < _pegcount){
		var gx = placed % gridsize;
		var gy = placed / gridsize;
		
		var xx = random_range(1 + (gx * cellsizex), min((gx + 1) * cellsizex, WIDTH) - 1);
		var yy = random_range(1 + (gy * cellsizey), min((gy + 1) * cellsizey, HEIGHT) - 1);
		
	    _pegs[placed][0] = xx; //x
		_pegs[placed][1] = yy; //y
		_pegs[placed][2] = false; //hit
		_pegs[placed][3] = 0; //shakeamp
		
		placed++;
	}
}

generatepegs();

instance_create_depth(0, 0, depth, obj_camera);