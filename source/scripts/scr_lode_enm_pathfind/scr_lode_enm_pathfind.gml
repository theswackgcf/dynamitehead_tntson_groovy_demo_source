function scr_lode_enm_pathfind(){
	//find nearest path point
	var safetimer = 0;
	var steps = 0;
	if(_force_path <= 0){
		while(_path_step < 2 && safetimer <= WIDTH*2){
			safetimer ++;

			var targetpos = [0,0];
			targetpos = [_target._tilepos[0],_target._tilepos[1]+_target_tileoffset];
			
			//retreat
			if(_target.object_index == obj_lode_plr){
				if(place_meeting(_target.x,_target.y-3,obj_lode_flyblock)){
					targetpos = [_tiles_init[0],_tiles_init[1]];
				}
				if((_target._jump_power > 0 || _target._tnt_activation || _target._tnt_power > 0) && distance_to_object(_target) <= 190 && _state != LODE_STATE_ROPE){
					targetpos = [_tiles_init[0],_tiles_init[1]];
				}
			}
		
			if(_behaviortype == LODE_ENM_NEAR){
				var centerpos = _target._tilepos[1];
			
				if(targetpos[0] < 1){
					targetpos[0] = 1;
				}
				if(targetpos[0] > array_length(global._stage_layout[1])-2){
					targetpos[0] = array_length(global._stage_layout[1])-2;
				}
			
				if(targetpos[1] < 1){
					targetpos[1] = 1;
				}
				if(targetpos[1] > array_length(global._stage_layout[1][0])-2){
					targetpos[1] = array_length(global._stage_layout[1][0])-2;
				}
			
				var safetimer2 = 0;
				while(global._stage_layout[1][targetpos[0]][targetpos[1]] != LTILE_AIR && safetimer2 < 6){
					if(targetpos[0] < 1){
						targetpos[0] = 1;
					}
					if(targetpos[0] > array_length(global._stage_layout[1])-2){
						targetpos[0] = array_length(global._stage_layout[1])-2;
					}
			
					if(targetpos[1] < 1){
						targetpos[1] = 1;
					}
					if(targetpos[1] > array_length(global._stage_layout[1][0])-2){
						targetpos[1] = array_length(global._stage_layout[1][0])-2;
					}
				
					safetimer2 ++;
				
					if(targetpos[0] > centerpos){
						targetpos[0] --;
					}
					if(targetpos[0] < centerpos){
						targetpos[0] ++;
					}
				}
			}
			
			if(_path_step == 0){
				var startpos = [_tilepos[0],_tilepos[1]]; //vertical, horizontal
				
				var nodepos = [startpos[0],startpos[1]];
				if(_curnode != -1){
					nodepos = [_curnode[0],_curnode[1]];
				}
				
				var dirs = [
					[0,-1,"l"], //left
					[0,1,"r"], //right
					[-1,0,"u"], //top
					[1,0,"d"], //bottom
				];
					
				var stoptiles = [LTILE_SOL,LTILE_SOL2,LTILE_SOL_DEL,LTILE_SPR,LTILE_ENMCOL,LTILE_BOL];
		
				for(var i = 0; i < array_length(dirs); i++){
					//make points
					var curpos = [nodepos[0]+dirs[i][0],nodepos[1]+dirs[i][1]];
					var hcost = round(getcelldist(startpos,curpos)*10);
					var gcost = round(getcelldist(targetpos,curpos)*10);
					
					var canmakeacell = true;
					if(curpos[0] < 0 || curpos[1] < 0){
						canmakeacell = false;
					}
					if(curpos[0] >= array_length(_path_array)){
						canmakeacell = false;
					} else {
						if(curpos[0] >= 0 && curpos[1] >= array_length(_path_array[curpos[0]])){
							canmakeacell = false;
						}
					}
					
					if(canmakeacell){
						if(global._stage_layout[1][curpos[0]][curpos[1]] == LTILE_LDR || global._stage_layout[1][curpos[0]][curpos[1]] == LTILE_LDR2){
							gcost *= 0.5;
						}
						if(global._stage_layout[1][curpos[0]][curpos[1]] == LTILE_ROP){
							gcost *= 0.5;
						}
						
						if(array_contains(stoptiles, global._stage_layout[1][curpos[0]][curpos[1]])){
							canmakeacell = false;
						}
					}
							
					if(canmakeacell){
						if(_path_array[curpos[0]][curpos[1]] == -1){
							_path_array[curpos[0]][curpos[1]] = {
								hcost: hcost,
								gcost: gcost,
								fcost: hcost+gcost,
								closed: false,
								parent: [nodepos[0],nodepos[1]],
							};
						}
					}
				}
					
				//neighboring directional cells
				var neighborcells = [];
				for(var i = 0; i < array_length(dirs); i++){
					var curpos = [nodepos[0]+dirs[i][0],nodepos[1]+dirs[i][1]];
					var caneditcell = true;
					if(curpos[0] < 0 || curpos[1] < 0){
						caneditcell = false;
					}
					if(curpos[0] >= array_length(_path_array)){
						caneditcell = false;
					} else {
						if(curpos[0] >= 0 && curpos[1] >= array_length(_path_array[curpos[0]])){
							caneditcell = false;
						}
					}
						
					if(caneditcell){
						array_push(neighborcells,[curpos[0],curpos[1],dirs[i][2]]);
					}
				}
					
				var deletedir = ["u","d"];
				var soltiles = [LTILE_SOL,LTILE_SOL2,LTILE_SOL_DEL,LTILE_LDR,LTILE_LDR2,LTILE_SPR,LTILE_ENMCOL,LTILE_BOL];
					
				if(nodepos[0] < 0){
					nodepos[0] = 0;
				}
				if(nodepos[1] < 0){
					nodepos[1] = 0;
				}
				if(nodepos[0] > array_length(global._stage_layout[1])-1){
					nodepos[0] = array_length(global._stage_layout[1])-1;
				}
				if(nodepos[1] > array_length(global._stage_layout[1][0])-1){
					nodepos[1] = array_length(global._stage_layout[1][0])-1;
				}
					
				var nodetile = global._stage_layout[1][nodepos[0]][nodepos[1]];
				for(var i = 0; i < array_length(neighborcells); i++){
					var thispos = [neighborcells[i][0],neighborcells[i][1]];
					var thisdir = neighborcells[i][2];
						
					var thistile = global._stage_layout[1][thispos[0]][thispos[1]];
						
					//lode runner logic
					if(nodetile == LTILE_ROP){
						deletedir = ["u"];
					}
					if((thistile == LTILE_LDR || thistile == LTILE_LDR2 || thistile == LTILE_ROP) && thisdir == "d"){
						deletedir = ["u"];
					}
					if(nodetile == LTILE_AIR && (!array_contains(soltiles,thistile) && thisdir == "d")){
						deletedir = ["l","r","u"];
					}
					if((thistile == LTILE_STAL) && thisdir == "d"){
						deletedir = ["u","d"];
					}
					if(nodetile == LTILE_LDR || nodetile == LTILE_LDR2){
						deletedir = [];
					}
				}
					
				//clear unallowed cells
				for(var o = 0; o < array_length(deletedir); o++){
					for(var i = 0; i < array_length(neighborcells); i++){
						if(neighborcells[i][2] == deletedir[o]){
							if(_path_array[neighborcells[i][0]][neighborcells[i][1]] != -1){
								if(!_path_array[neighborcells[i][0]][neighborcells[i][1]].closed){
									_path_array[neighborcells[i][0]][neighborcells[i][1]] = -1;
								}
							}
						}
					}
				}
				
				_path_step = 1;
			} else if(_path_step == 1){
				//close shortest node
				var nodes = [];
				for(var yy = 0; yy < array_length(_path_array); yy++){
					for(var xx = 0; xx < array_length(_path_array[yy]); xx++){
						var curcell = _path_array[yy][xx];
						if(curcell != -1 && curcell != 0 && !curcell.closed){
							array_push(nodes,[curcell.fcost,curcell.hcost,[yy,xx]]);
						}
					}
				}
				if(array_length(nodes) > 0){
					//sort through nodes, shortest starting first
					array_sort(nodes, function(a,b){
						return a[0]-b[0];
					});
						
					var lowest_hcost = nodes[0][0];
					var hcost_array = [];
					for(var d = 0; d < array_length(nodes); d++){
						if(nodes[d][0] == lowest_hcost){
							array_push(hcost_array,[nodes[d][0],nodes[d][1],nodes[d][2]]);
						}
					}
						
					//if shortest cost is more than one, sort by hcost
					if(array_length(hcost_array) > 1){
						array_sort(hcost_array, function(a,b){
							return a[1]-b[1];
						});
					}
					if(array_length(hcost_array) > 0){
						_curnode = [hcost_array[0][2][0],hcost_array[0][2][1]];
							
						//finish pathfinding if current cell is right next to the target
						if(steps < 64){
							if(targetpos[0] == _curnode[0] && targetpos[1] == _curnode[1]){
								safetimer = 0;
								_path_step = 2;
								break;
							} else {
								//back to finding neighboring cells
								_path_array[_curnode[0]][_curnode[1]].closed = true;
								_path_step = 0;
							}
						} else {
							_path_step = 0;
							_pathinit = false;
							_ignore_pathfinding = 120;
							_force_path = 120;
						}
					} else {
						_curnode = -1;
						_pathinit = false;
						_path_step = 0;
						break;
					}
				} else {
					_curnode = -1;
					_pathinit = false;
					_path_step = 0;
					break;
				}
			}
		}
			
		while(_path_step == 2 && safetimer <= WIDTH){
			safetimer ++;
				
			if(_path_step == 2){
				var followbox = noone;
				if(instance_number(obj_lode_followbox) <= 96){
					followbox = instance_create_depth(_curnode[1]*global._lode_tilesize,_curnode[0]*global._lode_tilesize,0,obj_lode_followbox);
					followbox._parentobj = self;
				}
				
				if(_path_array[_curnode[0]][_curnode[1]] != -1){
					var parent = _path_array[_curnode[0]][_curnode[1]].parent;
					_curnode = [parent[0],parent[1]];
					steps ++;
				} else {
					break;
				}
				
				//reached start position
				if(_curnode[0] == _tilepos[0] && _curnode[1] == _tilepos[1]){
					if(followbox != noone){
						_nearpoint = followbox;
					} else {
						_nearpoint = self;
					}
						
					_curnode = -1;
					_path_step = 3;
					_path_array = [];
					break;
				}	
			}
		}
	}
}