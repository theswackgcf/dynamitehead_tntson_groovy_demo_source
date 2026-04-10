function scr_enemyscript_startsequence(){
	//set sequence direction
	if(ds_map_exists(global._sequenceLayers, _seqid) && layer_exists(global._sequenceLayers[? _seqid]) && layer_sequence_exists(global._sequenceLayers[? _seqid], _sequence)){
		if(_spawndir == "l"){
			_curdir = DIR_R;
		} else if(_spawndir == "r"){
			_curdir = DIR_L;
		}
		layer_sequence_xscale(_sequence, -_curdir);
		layer_sequence_yscale(_sequence, _seq_yscale);
	}
	scr_enemyscript_dir();
				
	//check if sequence finished just in case
	if(_sequence_act > 0 && ((ds_map_exists(global._sequenceLayers, _seqid) && layer_exists(global._sequenceLayers[? _seqid]) && !layer_sequence_exists(global._sequenceLayers[? _seqid], _sequence)) || layer_sequence_get_headpos(_sequence) >= layer_sequence_get_length(_sequence)-2)){
		_nohopobj = true;
		_sequence_finished = true;
	}
	switch(_sequence_act){
		case 0:
			if(_colorsinit){
				//setup sequence
				global._sequenceLayers[? _seqid] = layer_create(_displayobj.depth, _seqid);
				global._sequenceColors[? _seqid] = [
					_codename,
					_enmtype,
					
					_maxcolors,
					_mult_colorinArray,
					_mult_coloroutArray,
					_mult_tolrArray,
					_mult_blendArray,
					
					_docolors,
				];
				
				_sequence = layer_sequence_create(global._sequenceLayers[? _seqid], _offscreenpos[0], _offscreenpos[1], _sequence_id);
			
				if(!global._tutorial){
					if(_battlezone && !_spawnedfromobject){
						var near = instance_create_depth(-WIDTH,-HEIGHT,-6000,obj_gui_enemynear);
						near._parentobj = self;
						near._dir = _spawndir;
						near._codename = _codename;
						near._enmtype = _enmtype;
						near._hpcolor = _hpcolor[_enmtype+1];
						near._maxcolors = _maxcolors;
						near._mult_colorinArray = _mult_colorinArray;
						near._mult_coloroutArray = _mult_coloroutArray;
						near._mult_tolrArray = _mult_tolrArray;
						near._mult_blendArray =_mult_blendArray;
					}
				}
			
				/*var keys_ = ds_map_keys_to_array(global._sequenceLayers);
				show debug message([keys_, array_length(layer_get_all())]);*/
			
				_sequence_act = 1;
			}
		break;
		case 1:
			if(ds_map_exists(global._sequenceLayers, _seqid) && layer_exists(global._sequenceLayers[? _seqid])){
				layer_depth(global._sequenceLayers[? _seqid], -((y-global._cameraY)-global._sequenceInfo[? _sequence_id].sdepth));
				if(place_meeting(x,y-100,obj_st2_graves)){
					var gr = instance_place(x,y-100,obj_st2_graves);
					if(instance_exists(gr)){
						layer_depth(global._sequenceLayers[? _seqid],gr.depth-32);
					}
				}
			}
			
			if(layer_sequence_get_headpos(_sequence) >= layer_sequence_get_length(_sequence)){
				layer_sequence_headpos(_sequence, layer_sequence_get_length(_sequence)-1);
				layer_sequence_pause(_sequence);
			}
			
			if(!global._sequenceInfo[? _sequence_id].anim_finish || _seq_forcehop){
				//check hopping frame
				if(_seq_forcehop){
					layer_sequence_headpos(_sequence,layer_sequence_get_length(_sequence));
					layer_sequence_x(_sequence,-(WIDTH*2));
					layer_sequence_y(_sequence,-(HEIGHT*2));
				}
				if(layer_sequence_get_headpos(_sequence) >= global._sequenceInfo[? _sequence_id].hop_frame || _seq_forcehop){
					//set hopping only for the hop object
					if(ds_map_exists(global._sequenceLayers, _seqid) && layer_exists(global._sequenceLayers[? _seqid])){
						_nohopobj = false;
						_sequence_hop_obj = instance_create_layer(_offscreenpos[0],_offscreenpos[1], global._sequenceLayers[? _seqid], obj_seq_enmhop);
						_sequence_hop_obj._parentobj = self;
						_sequence_hop_obj._dir = sign(_displayobj.image_xscale);
						_sequence_hop_obj._startFade = _startFade;
						
						_startFade = false;
						
						if(!_seq_forcehop){
							_sequence_hop_obj._walking = !global._sequenceInfo[? _sequence_id].do_arc;
						} else {
							if(_spawndir == "l"){
								_sequence_hop_obj._dir = DIR_R;
							} else if(_spawndir == "r"){
								_sequence_hop_obj._dir = DIR_L;
							}
							_sequence_hop_obj._walking = false;
						}
						
						if(!_sequence_hop_obj._walking){
							_sequence_hop_obj.sprite_index = global._sequenceInfo[? _sequence_id].hop_sprite;
						} else {
							_sequence_hop_obj.sprite_index = global._sequenceInfo[? _sequence_id].walk_sprite;
						}
						
						var vdir = layer_sequence_get_yscale(_sequence);
						
						_sequence_hop_obj.x += global._sequenceInfo[? _sequence_id].seqoffs[0]*_sequence_hop_obj._dir;
						_sequence_hop_obj.y += global._sequenceInfo[? _sequence_id].seqoffs[1]*vdir;
						
						_sequence_hop_obj._hop_startpos = [_sequence_hop_obj.x,_sequence_hop_obj.y];
						_sequence_hop_obj._hop_base_y = _sequence_hop_obj.y;
						
						_sequence_hop_obj._depth = _displayobj.depth;
						if(_seq_forcedepth <> -1){
							_sequence_hop_obj._depth = _seq_forcedepth;
						}
						_sequence_hop_obj._hop_arcstart = false;
						_sequence_hop_obj._hop_arc = 0;
						_sequence_hop_obj._hop_time = 0;
						
						_sequence_hop_obj._jumptopos = [_spawnpos[0],_spawnpos[1]];
							
						_sequence_hop_obj._sequence_id = _sequence_id;
						_sequence_hop_obj._seqhop_archeight = _seqhop_archeight;
						_sequence_hop_obj._seqhop_spd = _seqhop_spd;
						
						_sequence_hop_obj._glass = _glass;
						
						_sequence_hop_obj._codename = _codename;
						if(variable_instance_exists(self.id, "_enmtypes")){
							_sequence_hop_obj._enmtypes = _enmtypes;
						}
						_sequence_hop_obj._enmtype = _enmtype;
						
						_sequence_hop_obj._rep = _rep;
						_sequence_hop_obj._maxcolors = _maxcolors;
								
						_sequence_act = 2;
					}
				}
			}
			//otherwise end sequence as soon as animation ends
		break;
		case 2:
			//do position only with "the main object"
			if(_sequence_hop_obj != noone && instance_exists(_sequence_hop_obj)){
				if(global._sequenceInfo[? _sequence_id].do_arc || _seq_forcehop){
					//finish arc
					if(_sequence_hop_obj._hop_arcstart && _sequence_hop_obj._hop_arc >= 0){
						_nohopobj = true;
						
						with(obj_camera){
							_ampY = 18;
						}
									
						sfx_play_proximity(snd_fall_soft);
						sfx_pitch(snd_fall_soft, 0.77, 1.35);
									
						if(ds_map_exists(global._sequenceLayers, _seqid) && layer_exists(global._sequenceLayers[? _seqid]) && layer_sequence_exists(global._sequenceLayers[? _seqid], _sequence)){
							layer_sequence_destroy(_sequence);
							layer_destroy(global._sequenceLayers[? _seqid]);
							ds_map_delete(global._sequenceLayers, _seqid);
							ds_map_delete(global._sequenceColors, _seqid);
						}
						_sequence_finished = true;
					}
				} else {
					//finish moving
					var minsize = 6;
					if(diff_abs(_sequence_hop_obj.x, _sequence_hop_obj._jumptopos[0]) <= minsize && diff_abs(_sequence_hop_obj.y, _sequence_hop_obj._jumptopos[1]) <= minsize){
						_nohopobj = true;
						x = _sequence_hop_obj.x;
						y = _sequence_hop_obj.y;
						_displayobj.image_index = _sequence_hop_obj.image_index;
						
						if(ds_map_exists(global._sequenceLayers, _seqid) && layer_exists(global._sequenceLayers[? _seqid]) && layer_sequence_exists(global._sequenceLayers[? _seqid], _sequence)){
							layer_sequence_destroy(_sequence);
							layer_destroy(global._sequenceLayers[? _seqid]);
							ds_map_delete(global._sequenceLayers, _seqid);
							ds_map_delete(global._sequenceColors, _seqid);
						}
						_sequence_finished = true;
					}
				}
			}
		break;
	}
}