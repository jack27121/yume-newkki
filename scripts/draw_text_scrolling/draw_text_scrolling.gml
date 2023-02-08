/// @func draw_text_scrolling(x, y, text, speed, char_count)
/// @description draws text scrolling
/// @param	x
/// @param	y
/// @param	text
/// @param	speed
/// @param	char_count
function draw_text_scrolling(argument0, argument1, argument2, argument3, argument4) {
	var x_ = argument0;
	var y_ = argument1;
	var text = argument2 + " ";
	var t = floor((argument3 / 1000 * current_time) mod string_length(text));
	var char_count = argument4;//how many letters should display

	var text_new = string_delete(text,1,t) + string_copy(text,1,t);

	draw_set_halign(fa_left)
	draw_text(x_,y_,string_copy(text_new,1,char_count));


}
