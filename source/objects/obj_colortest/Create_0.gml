{
	_rep = "";
	
	_entities = ["dh","st2_enm1","st2_enm2","st2_enm3","enm1","enm2","enm3"];
	
	_addsprite = ds_map_create();
	_addsprite[? "st2_enm1"] = spr_st2_enm1_entD_boneloop;
	
	_curent = 0;
	_names = ds_map_create();
	_names[? "dh"] = [
		["def","in engine colors"],
		["st0","tutorial colors"],
		["st1","toxic trenches colors"],
		["st2","groovy graveyard colors"],
		["st3","hellish havoc colors"]
	];
	
	_names[? "enm1"] = [
		["def","sourosaur"],
		["toxic","toxicsaur"],
		["hazard","hazardsaur"],
	];
	_names[? "enm2"] = [
		["def","musclethug"],
		["apple","applethug"],
		["rock","ROCKHARD"],
	];
	_names[? "enm3"] = [
		["def","bagdiot"],
		["cycliot","cycliot"],
		["crawler","night crawler"],
	];
	
	_names[? "st2_enm1"] = [
		["def","Henchie"],
		["ringmaster","Ringmaster"],
		["grasshopper","Grasshopper"],
	];
	_names[? "st2_enm2"] = [
		["def","Yolo-Bones"],
		["redcap","Red Cap"],
		["milkman","Milkman"],
	];
	_names[? "st2_enm3"] = [
		["def","Gostlik"],
		["grinzy","Grinzy"],
		["inty","Inty"],
	];
	_curname = 0;

	_curtolindex = 0;

	_zoom = 1;
	
	_init = false;
	
	//colors
	
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
	
	function drawrect (xx, yy, colind, array) {
		var curarray = [];
		if(array == 0){
			curarray = _mult_colorinArray;
		} else if(array == 1){
			curarray = _mult_coloroutArray;
		}
		var col = make_color_rgb(curarray[colind]*255,curarray[colind+1]*255,curarray[colind+2]*255);
		draw_set_color(col);
		draw_rectangle(xx,yy,xx+16,yy+16,false);
		draw_set_color(#FFFFFF);
	}
}