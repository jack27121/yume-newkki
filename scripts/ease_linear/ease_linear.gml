/// @func ease_linear(time, start, change, duration)
/// @description = ease_linear
/// @param	time
/// @param	begin
/// @param	change 
/// @param	duration
function ease_linear() {

	var t = argument[0]; // time
	var b = argument[1]; // begin
	var c = argument[2]; // change
	var d = argument[3]; // duration

	t /= d;

	return c*t+ b;




}
