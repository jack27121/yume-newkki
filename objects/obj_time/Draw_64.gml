/// @description draws clock
if(global.time_active){
	draw_set_valign(fa_top);
	draw_set_halign(fa_right);
	draw_set_font(f_bebas);
	draw_set_color(white);
	
	//convert 24 to 12 hour
	var hour, am_pm;
	if( global.hour < 12){
		am_pm = " AM";
		hour = global.hour;
	} else {
		am_pm = " PM";
		hour = global.hour - 12;
	}
	if (hour == 0) hour = 12;
	
	hour = string_replace(string_format(hour,2,0)," ","0");
	var minute = string_replace(string_format(global.minute,2,0)," ","0");
	draw_text(view_w-5,offset_y, hour+":"+minute+am_pm);
}