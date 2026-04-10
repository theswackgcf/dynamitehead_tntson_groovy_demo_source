///@function scr_draw_outline(sprite, subimg, xx, yy, xscale, yscale, rot, col, alpha, outcolor = [255,255,255], outdist = 4){
function scr_draw_outline(sprite, subimg, xx, yy, xscale, yscale, rot, col, alpha, outcolor = [255,255,255], outdist = 4){
	var outcoord = [
		[-1,0],
		[-1,-1],
		[0,-1],
		[1,1],
		[1,0],
	];
	var dist = outdist;
				
	shader_set(shd_solidcolor);
	shader_set_uniform_f(shader_get_uniform(shd_solidcolor, "u_color"), outcolor[0]/255, outcolor[1]/255, outcolor[2]/255, 1);
	for(var o = 0; o < array_length(outcoord); o++){
		draw_sprite_ext(sprite, subimg, xx+(outcoord[o][0]*dist), yy+(outcoord[o][1]*dist), xscale, yscale, rot, col, alpha);
	}
	shader_reset();
}