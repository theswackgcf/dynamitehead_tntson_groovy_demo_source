{
	//color replacement stuff
	global._colors = ds_map_create();
	global._lightcolors = ds_map_create();
	global._colors[? "def"] = [
		[
			[255,0,255], //head, torso
			[50,255,255], //gloves, sunglasses
			[0,0,255], //limbs
			[0,255,0], //boots
		],
		[
			[0,0,0,0] //tolerance
		]
	];
	global._lightcolors[? "dh"] = [1]; //gloves
	
	global._colors[? "st0"] = [
		[
			[201,33,11], //head, torso
			[242,191,131], //gloves, sunglasses
			[79,43,60], //limbs
			[201,121,62], //boots
		],
		[
			[0.12,0.4,0.83,0.87] //tolerance
		]
	];
	
	global._colors[? "st1"] = [
		[
			[255,4,0], //head, torso
			[217,240,75], //gloves, sunglasses
			[30,41,89], //limbs
			[255,102,0], //boots
		],
		[
			[0.1,0.65,1,0.88] //tolerance
		]
	];
	
	global._colors[? "st2"] = [
		[
			[172,0,45], //head, torso
			[91,110,197], //gloves, sunglasses
			[29,20,88], //limbs
			[187,58,20], //boots
		],
		[
			[0.05,0.85,1,0.95] //tolerance
		]
	];
	
	global._colors[? "st3"] = [
		[
			[212,11,0], //head, torso
			[255,162,32], //gloves, sunglasses
			[55,36,104], //limbs
			[255,59,0], //boots
		],
		[
			[0.07,0.66,1,0.42] //tolerance
		]
	];
	
	//enemy colors
	global._enemyColors = ds_map_create();
	
	//saurosaur
	global._enemyColors[? "enm1"] = ds_map_create();
	global._enemyColors[? "enm1"][? "def"] = [
		[
			[0,0,0], //outline
			[138,60,145], //skin
			[249,204,51], //eyes
			[53,40,68], //eyelids
		],
		[
			[0,0,0,0] //tolerance
		]
	];
	global._enemyColors[? "enm1"][? "toxic"] = [
		[
			[0,0,0], //outline
			[130,217,43], //skin
			[240,98,13], //eyes
			[32,108,49], //eyelids
		],
		[
			[0.05,0.06,0.9,0.93] //tolerance
		]
	];
	global._enemyColors[? "enm1"][? "hazard"] = [
		[
			[0,0,0], //outline
			[249,204,51], //skin
			[255,21,21], //eyes
			[255,145,9], //eyelids
		],
		[
			[0.08,0.65,1,0.95] //tolerance
		]
	];
	
	//musclethug
	global._enemyColors[? "enm2"] = ds_map_create();
	global._enemyColors[? "enm2"][? "def"] = [
		[
			[0,0,0], //outline
			[238,71,15], //skin
			[77,114,174], //limbs
			[255,153,0], //eyes
			[243,191,71], //teeth
		],
		[
			[0,0,0,0] //tolerance
		]
	];
	global._enemyColors[? "enm2"][? "apple"] = [
		[
			[0,0,0], //outline
			[223,10,104], //skin
			[240,85,11], //limbs
			[255,255,51], //eyes
			[255,239,213], //teeth
		],
		[
			[0.33,0.05,0.67,0.75] //tolerance
		]
	];
	global._enemyColors[? "enm2"][? "rock"] = [
		[
			[0,0,0], //outline
			[154,95,153], //skin
			[194,173,218], //limbs
			[255,28,28], //eyes
			[255,28,28], //teeth
		],
		[
			[0.05,0.15,0.82,0.66] //tolerance
		]
	];
	
	//bagdiot
	global._enemyColors[? "enm3"] = ds_map_create();
	global._enemyColors[? "enm3"][? "def"] = [
		[
			[0,0,0], //outline
			[243,65,20], //bag
			[48,109,57], //bottom
			[225,185,89], //gloves
		],
		[
			[0,0,0,0] //tolerance
		]
	];
	global._enemyColors[? "enm3"][? "cycliot"] = [
		[
			[0,0,0], //outline
			[225,185,89], //bag
			[243,65,20], //bottom
			[48,109,57], //gloves
		],
		[
			[0.09,0.24,0.93,0.37] //tolerance
		]
	];
	global._enemyColors[? "enm3"][? "crawler"] = [
		[
			[0,0,0], //outline
			[142,99,197], //bag
			[142,99,197], //bottom
			[142,99,197], //gloves
		],
		[
			[0.08,0.28,0.96,0.16] //tolerance
		]
	];
	
	global._enemyColors[? "st2_enm1"] = ds_map_create();
	global._lightcolors[? "st2_enm1"] = [3]; //outline, teeth
	global._enemyColors[? "st2_enm1"][? "def"] = [
		[
			[0,0,0], //outline
			[198,55,102], //pink mask
			[56,36,66], //greyish suit
			[202,132,28], //teeth
			[165,115,225], //bone arm
		],
		[
			[0,0,0,0] //tolerance
		]
	];
	global._enemyColors[? "st2_enm1"][? "ringmaster"] = [
		[
			[255,204,51], //outline
			[0,0,0], //pink mask
			[0,0,0], //greyish suit
			[0,0,0], //teeth
			[0,0,0], //bone arm
		],
		[
			[0.57,0.13,0.96,0.55] //tolerance
		]
	];
	global._enemyColors[? "st2_enm1"][? "grasshopper"] = [
		[
			[0,0,0], //outline
			[83,132,66], //pink mask
			[47,70,72], //greyish suit
			[205,37,37], //teeth
			[83,132,66], //bone arm
		],
		[
			[0.82,0.07,0.58,0.82] //tolerance
		]
	];
	
	global._enemyColors[? "st2_enm2"] = ds_map_create();
	global._lightcolors[? "st2_enm2"] = [2,3]; //boots eyes
	global._enemyColors[? "st2_enm2"][? "def"] = [
		[
			[126,96,168], //skull
			[51,22,80], //clothes
			[208,122,17], //boots
			[252,136,255] //eyes
		],
		[
			[0,0,0,0] //tolerance
		]
	];
	global._enemyColors[? "st2_enm2"][? "redcap"] = [
		[
			[193,116,94], //skull
			[95,22,53], //clothes
			[197,29,24], //boots
			[244,111,157] //eyes
		],
		[
			[0.03,0.13,0.96,0.73] //tolerance
		]
	];
	global._enemyColors[? "st2_enm2"][? "milkman"] = [
		[
			[141,156,173], //skull
			[176,177,217], //clothes
			[125,96,202], //boots
			[255,255,255] //eyes
		],
		[
			[0.25,0.25,0.56,0.66] //tolerance
		]
	];
	
	global._enemyColors[? "st2_enm3"] = ds_map_create();
	global._lightcolors[? "st2_enm3"] = [1]; //tongue
	global._enemyColors[? "st2_enm3"][? "def"] = [
		[
			[103,154,211], //body
			[190,63,177], //tongue
			[61,41,97], //arms
			[57,68,117], //smoke outline
		],
		[
			[0,0,0,0] //tolerance
		]
	];
	global._enemyColors[? "st2_enm3"][? "grinzy"] = [
		[
			[113,157,53], //body
			[215,168,81], //tongue
			[121,66,43], //arms
			[57,63,37], //smoke outline
		],
		[
			[0.25,0.75,0.28,0.45] //tolerance
		]
	];
	global._enemyColors[? "st2_enm3"][? "inty"] = [
		[
			[210,66,135], //body
			[87,108,196], //tongue
			[50,51,88], //arms
			[85,37,103], //smoke outline
		],
		[
			[0.04,0.8,0.6,0.6] //tolerance
		]
	];
}