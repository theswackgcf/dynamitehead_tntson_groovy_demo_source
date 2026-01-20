room_set_width(room, WIDTH);
room_set_height(room, HEIGHT);

if(mouse_check_button_pressed(mb_left) && window_has_focus()){
	room_goto(r_loading);
}