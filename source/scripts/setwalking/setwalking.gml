// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function setwalking(){
	_walkTo = [median((global._cameraX+210), x+random_range(-_randwalkdist, _randwalkdist), (global._cameraX+WIDTH-210)), median((global._cameraY+210), y+random_range(-_randwalkdist, _randwalkdist), (global._cameraY+HEIGHT-210))];
}