{
	enum LOAD {
		enum_lode_editor,
		enum_lode_game,
	};
	
	_minigames = [
		["lode","lode runner",LOAD.enum_lode_game],
		["lode","lode runner (EDITOR)",LOAD.enum_lode_editor],
		["peggle","Peggle"],
		["whack","Whack-a-Badhead"],
	];
	
	_curopt = 0;
}