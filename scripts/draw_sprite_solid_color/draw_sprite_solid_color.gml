///@param sprite
///@param subimg
///@param x
///@param y
///@param xscale
///@param yscale
///@param rot
///@param col
///@param alpha
function draw_sprite_solid_color(_spr, _img, _x, _y, _xs, _ys, _ang, _col, _a) {
	gpu_set_fog(true,_col,-16000,16000);
	draw_sprite_ext(_spr,_img,_x,_y,_xs,_ys,_ang,_col,_a);
	gpu_set_fog(false,0,0,0);
}