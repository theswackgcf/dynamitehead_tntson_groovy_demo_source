{
	_storedebug = 0;
	
	_bgcolor = c_purple;
	
	_introtext = false;
	
	_getdata = false;
	
	_fontsprite = -1;
	_font_init = 0;
	_fontwidth = 0;
	_fontheight = 0;
	_subimg = 0;
	
	_doglyph = false;
	
	_lowestx = [];
	_highestx = [];
	_startw = 0;
	_endw = 0;
	
	_monospace = false;
	_monospace_w = 0;
	_spacew = 0;
	_accuracy = 1;
	
	_fontdata = ds_map_create();
	_loadeddata = false;
	
	_clipboard = false;
	_widthclip = 0;
	
	_glyphsurface = surface_create(WIDTH, HEIGHT);
	
	_maxsize = WIDTH*2;
	
	_fontsurface_dim = [_maxsize,_maxsize];
	_fontsurface = surface_create(_fontsurface_dim[0], _fontsurface_dim[1]);
	
	_defpos = [32,170];
	_drawpos = [_defpos[0],_defpos[1]];
	_spacing = 12;
	_hborder = 720;
	
	_charset_string = "global._charset[? \"ascii\"]";
	_charset = global._charset[? "ascii"];
	_test_string = "The quick brown fox jumps over the lazy dog.";
	_string_spacing = 0;
	
	_drag = false;
	_dragoffset = [0,0];
	_surfscale = 1;
	
	_exportdata = ds_map_create();
	_dir = "font_export\\";
	_exportval = false;
	
	_modifyexport = true;
	
	_savepopup = false;
	_popuptimer = 0;
}