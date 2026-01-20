///function makecolors(og, rep)
function makecolors(og, rep, enemy = "") {
	_mult_colorinArray = [];
	_mult_coloroutArray = [];
	_mult_tolrArray = [];
	_mult_blendArray = [];
		
	var colorinArray = [];
	var coloroutArray = [];
	var tolrArray = [];
	var blendArray = [];
	
	var curarray = [];
	var reparray = [];
	var tolarray = [];
	
	if(enemy == ""){
		for(var j = 0; j < array_length(global._colors[? og][0]); j++){
			curarray[j] = global._colors[? og][0][j];
		}
		for(var j = 0; j < array_length(global._colors[? rep][0]); j++){
			reparray[j] = global._colors[? rep][0][j];
		}
		for(var j = 0; j < array_length(global._colors[? rep][1]); j++){
			tolarray[j] = global._colors[? rep][1][j];
		}
	} else {
		for(var j = 0; j < array_length(global._enemyColors[? enemy][? og][0]); j++){
			curarray[j] = global._enemyColors[? enemy][? og][0][j];
		}
		for(var j = 0; j < array_length(global._enemyColors[? enemy][? rep][0]); j++){
			reparray[j] = global._enemyColors[? enemy][? rep][0][j];
		}
		for(var j = 0; j < array_length(global._enemyColors[? enemy][? rep][1]); j++){
			tolarray[j] = global._enemyColors[? enemy][? rep][1][j];
		}
	}
	
	//replace colors in dark
	if(global._lightsout){
		var dsvar = "";
		if(variable_instance_exists(self.id, "_codename")){
			dsvar = _codename;
		} else if(variable_instance_exists(self.id, "_parentobj")){
			dsvar = _parentobj._codename;
		}
		if(ds_map_exists(global._lightcolors, dsvar)){
			for(var i = 0; i < array_length(reparray); i++){
				if(!array_contains(global._lightcolors[? dsvar], i)){
					reparray[i] = [0,0,0];
					tolarray[i] = [0.05,0.85,1,0.95];
				}
			}
		}
	}
	
	for(var i = 0; i < array_length(curarray); i++){
		colorinArray[i] = [curarray[i][0]/255.0,curarray[i][1]/255.0,curarray[i][2]/255.0,1.0];
		coloroutArray[i] = [reparray[i][0]/255.0,reparray[i][1]/255.0,reparray[i][2]/255.0,1.0];
		tolrArray[i] = tolarray[0];
		blendArray[i] = [global._colorblending,global._colorblending,global._colorblending,global._colorblending];
	}
	for(var j = 0; j < array_length(curarray); j++){
		for(var i = 0; i < 4; i++){
			_mult_colorinArray[array_length(_mult_colorinArray)] = colorinArray[j][i];
			_mult_coloroutArray[array_length(_mult_coloroutArray)] = coloroutArray[j][i];
			_mult_tolrArray[array_length(_mult_tolrArray)] = tolrArray[j][i];
			_mult_blendArray[array_length(_mult_blendArray)] = blendArray[j][i];
		}
	}
}