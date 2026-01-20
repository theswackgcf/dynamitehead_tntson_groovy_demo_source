{
	visible = false;
	
	//enable camera and make it follow player
	_setPlayer = false;
	_objectTarget = noone;
	_battleTarget = noone;
	_battlezone = noone;
	_finalhitTarget = noone;
	_init = false;
	
	_spd = [0.12, 0.12];
	
	_mode = 0;
	_lockX = false;
	_lockY = false;
	_lockobj = noone;
	
	global._camera = camera_create_view(0, 0, WIDTH, HEIGHT);
	global._cameraX = 0;
	global._cameraY = 0;
	global._defCamZoom = 1;
	if(global._state == "game"){
		global._defCamZoom = 1.15;
	}
	_cameraZoom = global._defCamZoom;
	global._cameraZoom = global._defCamZoom;
	global._defaultCamSpd = 0.07;
	global._camZoomSpd = global._defaultCamSpd;
	global._defCamOffset = [0, -42];
	global._cameraOffset = [global._defCamOffset[0], global._defCamOffset[1]];
	_cameraoffsetLerp = [0,0];
	
	_ampY = 0;
	_ampX = 0;
	
	_saveAmp = [0,0];
	
	_camLocked = false;
	_once = false;
	
	_random = 0;
	
	_cameraview = [global._cameraX,global._cameraY];
	global._camerasize = [camera_get_view_width(global._camera)*global._defCamZoom,camera_get_view_height(global._camera)*global._defCamZoom];
	_cameraborders = [0, 0, room_width-global._camerasize[0], room_height-global._camerasize[1]];
	
	camera_set_view_border(global._camera, WIDTH, HEIGHT);
	camera_set_view_target(global._camera, id);
	
	view_enabled = true;
	view_visible[global._view] = true;
	view_set_camera(global._view, global._camera);
	
	//adjust surface
	if(!global._adjustSurface){
		if(global._buildver == WINDOWS){
			window_set_size(global._res[global._curres][0],global._res[global._curres][1]);
		} else if(global._buildver == HTML){
			window_set_size(WIDTH,HEIGHT);
		}
		alarm_set(0, 1);

		scr_adjustguiscale();
		global._adjustSurface = true;
	}
}
