{
	_allsounds = ds_map_create();
	
	_losertext = "LOSER! WHAT A LOSER... LOSER! WHAT A LOSER... LOSER! WHAT A LOSER... LOSER! WHAT A LOSER... WHAT A LOSER... LOSER! WHAT A LOSER... WHAT A LOSER... LOSER! WHAT A LOSER... ";	_drawloser = 0;
	_drawloserPos = [0,WIDTH];
	_loseralpha = 0;
	
	_loseOpt = 0;
	_loseOpts = ["TRY AGAIN?","GIVE IT UP..."];
	
	_retry = false;
	_retrymenu = false;
	_retrytimer = 0;
}