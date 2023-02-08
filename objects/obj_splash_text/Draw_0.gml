/// @description draws the text and moves up slowly and fades it out

if (t >= wait*room_speed)
{
	y-= 10/room_speed;
	alpha = clamp(alpha - (1/room_speed), 0, 1);
	if alpha == 0 instance_destroy();
}

t++;

draw_set_font(f_bebas);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

//shakes it when it first spawns
var shakeX = shake(shakeT,5,20);
var shakeY = shake(shakeT,5,20);
shakeT++;

draw_text_color(x+shakeX,y+shakeY,text,color,color,color,color,alpha);