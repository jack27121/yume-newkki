/// @description tracks time
if(global.time_active){
	//moves time into place with stockmarket
	offset_y = ease_in_out(offset_t,0,offset_y_dest,room_speed/2);
	if(obj_stock_market.menu_on && offset_y < offset_y_dest) offset_t++
	else if(!obj_stock_market.menu_on && offset_y > 0) offset_t--
	
	var dt = (delta_time / 1000000) * time_multiplier;
	
	//second
	second += dt;
	
	//minute
	if(second > 59){
		global.minute++;	
		second = second mod 59;
		
		//hour
		if(global.minute > 59){
			global.minute = 0;
			global.hour++
			
			//day
			if(global.hour > 23){
				global.hour = 0;
				global.day++;
			}
		}
	}
}