{	
	_bztimer = 0;
	_bzmousepos = [0,0];
	_bz_mousestart = [0,0];
	_bzone_enm = noone;
	_hover_enm = noone;
	_last_enm = noone;
	_hovertimer = 0;
	_bzpopup = false;
	_popupopt = -1;
	
	global._bzenemies = [
		{
			maskname: "badhead",
			codename: "",
			dispname: "Enemy template",
			masksprite: "",
			disp: "",
			obj: false,
			alts: false,
		},
		{
			maskname: "st2_enm1",
			codename: "",
			dispname: "Henchie",
			masksprite: "",
			disp: "",
			obj: false,
			alts: true,
		},
		{
			maskname: "st2_enm2",
			codename: "",
			dispname: "Yolo-Bones",
			masksprite: "",
			disp: "",
			obj: false,
			alts: true,
		},
		{
			maskname: "st2_enm2_mtcycle",
			codename: "st2_enm2",
			dispname: "Yolo-Bike",
			masksprite: "spr_st2_enm2_mtcycle1",
			disp: "spr_st2_enm2_mtcycle1",
			obj: true,
			alts: true,
		},
		{
			maskname: "st2_enm3",
			codename: "",
			dispname: "Gostlik",
			masksprite: "",
			disp: "",
			obj: false,
			alts: true,
		},
		{
			maskname: "boss2",
			codename: "",
			dispname: "Lanky Larry",
			masksprite: "",
			disp: "",
			obj: false,
			alts: false,
		},
		{
			maskname: "moneypickup",
			codename: "",
			dispname: "Money Pickup",
			masksprite: "spr_moneypickup",
			disp: ["spr_moneypickup",3],
			obj: true,
			alts: false,
		},
		{
			maskname: "st2_gostlikbag",
			codename: "",
			dispname: "Gostlik Bag",
			masksprite: "spr_st2_gostlikbag",
			disp: "spr_st2_gostlikbag",
			obj: true,
			alts: false,
		},
		{
			maskname: "fridge",
			codename: "",
			dispname: "Fridge",
			masksprite: "",
			disp: "",
			obj: false,
			alts: false,
		},
	];
}