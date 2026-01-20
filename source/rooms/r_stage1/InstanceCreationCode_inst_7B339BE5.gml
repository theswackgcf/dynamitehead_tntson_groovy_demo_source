_cutscene = instance_nearest(x, y, obj_st1_cutscene);

_enemies = [
	[
		["c",[(WIDTH/2)-abs(x-obj_idiotblock.x),(HEIGHT/2)-abs(y-obj_idiotblock.y)],0, "enm1_n"],
	],
	[
		["c",[256, (HEIGHT/2)+120],0, ["enm1_n",0], false, 1],
		["c",[410, HEIGHT-128],0, ["enm2_n",1], false, 1],
		["c",[960, (HEIGHT/2)+160],0, ["enm1_n",1], false, 1],
		["c",[820, HEIGHT-170],0, ["enm3_n",0], false, 1],
	],
]
_resize = true;