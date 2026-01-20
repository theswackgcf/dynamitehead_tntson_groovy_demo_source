{
	_init = false;
	
	_act = 0;
	_timer = 0;
	
	_text1pos = floor(HEIGHT/2);
	_text1lerp = floor(HEIGHT/2);
	
	_text2pos = HEIGHT*1.5;
	_text2lerp = HEIGHT*1.5;
	
	_cardpos = [(WIDTH*1.5), (WIDTH*1.5)+300, (WIDTH*1.5)+600];
	_cardlerp = [_cardpos[0],_cardpos[1],_cardpos[2]];
	_cardtext = [["TIPBAX",-94],["TIPBAX",-57],["TIPBAX",-61]];
	
	_confirmexit = false;
}