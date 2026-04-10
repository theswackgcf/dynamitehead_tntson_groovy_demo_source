{	
	event_inherited();
	
	_visible = true;
	visible = _visible;
	
	_startTimer = 0;
	
	_enmtype = -1;
	_codename = "st2_enm2";
	_enmtypes = global._enmtypes[? _codename];
	
	_battlezone = true;
	
	_active = false;
	
	_xspd = 0;
	_height = 0;
	_dispoffset = [0,0];
	
	_depthoffset = 48;
	
	_heightdiff = [28, 210];
	
	_damage = ATK_KO;
	_add_damage = 2;
	
	_breakpower = 1; //dh shield break pwoer
	
	_scale2 = [1,1];
	
	_candodge = {
		roll: false,
		down: false,
		atk: false
	}
	
	_canparry = false;
	_killedbyshield = false;
	
	_canhit = ["air"];
	_killoffscreen = false;
	
	_spawnenemy = true;
	_enemyspawned = false;
	
	_noenmindex = spr_st2_enm2_mtcycle2;
	
	_hpcolor = [make_color_rgb(208,122,17),make_color_rgb(197,29,24),make_color_rgb(125,96,202)];
	
	_shadsize = [1.12, 0.4];
	
	_activetimer = 0;
	
	_enminst = noone;
	
	function spawnenemy(hurt = false, xx = x, yy = y) {
		var inst = instance_create_depth(xx, yy, depth, obj_st2_enm2_mask);
		_enminst = inst;
		inst._ailevel += global._progress;
		inst._enmtype = _enmtype;
		inst._startTimer = 0;
		inst._dh = instance_nearest(x, y, obj_dh_mask);
		inst._spawnedfromobject = true;
		if(inst._dh != noone && instance_exists(inst._dh)){
			inst._curstate = STATE_FOLLOW;
			inst._walkto = [(inst._dh).x,(inst._dh).y];
		}
		inst._deleteid = self.id;
		
		if(hurt){
			inst._height = 64;
			inst._vspd = 16;
			inst._falling = true;
			inst._hp -= 6;
			inst._althp = true;
			inst._dmgfall = true
			
			with(obj_gui){
				ui_fade("enemy", 1);
			}
		} else {
			inst._battlezone = true;
			var dir = 1;
			if(_spawndir == "r"){
				inst._spawndir = "l";
				dir = -1;
			} else if(_spawndir == "l"){
				inst._spawndir = "r";
			}
			inst._offscreenpos = [xx+(180*dir),yy];
			inst._spawnpos = [xx,yy];
			inst._sequence_finished = false;
		}
	}
	
	function dead(){
		instance_destroy();
	}
	
	//projectile specific variables
	_bike = true;
	_fridge = false;
	_tip_active = false;
	
	visible = false;
	_mt_startposx = x;
	_mt_init = false;
	_mt_act = 0;
	_mt_timer = 0;
	_mt_scaleto = [_scale2[0],_scale2[1]];
	_mt_angle = 0;
	_mt_angleback = false;
	
	_mt_accel = 0.3;
	_mt_maxspd = 24;
	_mt_spd = 0;
	
	_mt_exhausttime = 0;
	
	_mt_active_timer = 0;
	_mt_alpha = 0;
	_mt_alpha_to = 0;
	
	_colorsinit = false;
	
	_maxcolors = global._maxcolors[? _codename];
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	_rep = "";
}