scr_textrender_halign("center");
scr_textrender_type(WIDTH / 2, 24, "LOCALIZATION TEST");

//in the final game we should not read the json every frame. it should be stored in a global or something
//we need extended charsets for languages with extra letters
var languagejson = scr_read_json(working_directory + "/languages/" + _languages[_curlanguage] + ".json");

scr_textrender_type(WIDTH / 2, 96, + "keycode@LEFTkeycode " + languagejson[$ "language"] + " (" + _languages[_curlanguage] + ") keycode@RIGHTkeycode");

if(keyboard_check_pressed(vk_left)){
	_curlanguage--;
}
else if(keyboard_check_pressed(vk_right)){
	_curlanguage++;
}

if(_curlanguage < 0){
	_curlanguage = array_length(_languages) - 1;
}
else if(_curlanguage > array_length(_languages) - 1){
	_curlanguage = 0;
}

var numberidx = ["numberOne", "numberTwo", "numberThree", "numberFour", "numberFive"];
var animals = ["dog", "cat", "horse"];

scr_textrender_halign("left");

//numbers
scr_textrender_type((WIDTH / 4) - 64, 192, languagejson[$ "titles"][$ "numbers"]);
for(var i = 0; i < 5; i++){
    scr_textrender_type((WIDTH / 4) - 64, 240 + (48 * i), string(i + 1) + ": " + languagejson[$ "numbers"][$ numberidx[i]]);
}

//animals
scr_textrender_type(WIDTH / 2 + (WIDTH / 4) - 128, 192, languagejson[$ "titles"][$ "animals"]);
for(var i = 0; i < array_length(animals); i++){
    scr_textrender_type(WIDTH / 2 + (WIDTH / 4) - 128, 240 + (48 * i), animals[i] + ": " + languagejson[$ "animals"][$ animals[i]]);
}