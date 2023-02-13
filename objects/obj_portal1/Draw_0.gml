/// @description draws player at other portal position
draw_self();
with(obj_player){
	var x_ = x;
	var y_ = y;
	x = x + other.new_x;
	y = y + other.new_y;
	event_perform(ev_draw,ev_draw_normal);
	x = x_;
	y = y_;
}











