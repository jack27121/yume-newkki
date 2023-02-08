/// @description
if(menu_on){
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	plane_y = obj_plane.boxY + 12;
	
	#region player money
	draw_set_font(f_bebas);
	draw_set_color(white);
	draw_text(2,plane_y,"owned:");
	draw_set_color(orange);
	draw_text(50,plane_y,string(global.money)+"$");
	
	draw_set_color(white);
	draw_text(150,plane_y,"invested:");
	var color, up;
	if(difference < 0){
		color = red;
		up = 1;
	} else{
		color = green;	
		up = -1;
	}
	draw_sprite_ext(spr_stock_triangle,0,215,plane_y+10,1,up,0,color,1);
	draw_set_color(color);
	draw_text(235,plane_y,string(difference)+"% "+string(invested)+"$");
	#endregion
	
	//seperator
	draw_set_color(white);
	draw_line_width(-1,plane_y+22,view_w,plane_y+22,1);

	//Info text
	draw_set_font(f_pixel);
	draw_text(collumn1,plane_y+26,"Bought");
	draw_text(collumn2,plane_y+26,"Stock");
	draw_text(collumn3,plane_y+26,"Change");
	draw_text(collumn4,plane_y+26,"Price");
	
	
	#region stocks
	draw_set_font(f_bebas);
	var stock_array = ds_map_keys_to_array(global.stocks);
	for (var i = 0; i < ds_map_size(global.stocks); ++i) {
		var stock_y = plane_y+35+(20*i);
		
		//selected
		if(selected_row == i){
			draw_set_color(orange);
			draw_set_alpha(0.2);
			draw_rectangle(-1,stock_y,view_w,stock_y+18,0);
			draw_set_alpha(0.3);
			
			draw_line_width(-1,stock_y,view_w,stock_y,1);
			draw_line_width(-1,stock_y+18,view_w,stock_y+18,1);
			draw_set_alpha(1);
			
		}
		
		var stock = global.stocks[?stock_array[i]];
		var player_bought = stock[?"player_bought"];
		var name = stock[?"name"];
		var change = stock[?"change"];
		var price = stock[?"price"];
		
		draw_set_color(white);
		draw_text(collumn1,stock_y,string(player_bought));
		
		if(change < 0){
			color = red;
			up = 1;
		} else{
			color = green;	
			up = -1;
		}
		draw_sprite_ext(spr_stock_triangle,0,collumn2,stock_y+10,1,up,0,color,1);
		draw_set_color(color);
	    draw_text(collumn2+20,stock_y,name);
		
		draw_text(collumn3,stock_y,string(change)+"%");
		
		draw_text(collumn4,stock_y,string(price)+"$");
		
		//BUTTONS
		draw_set_color(white);
		var subimg;
		//buy
		if(price > global.money) draw_set_alpha(0.5) else draw_set_alpha(1);
		
		if(selected_collumn == 0 && selected_row == i) subimg = 1 else subimg = 0;
		draw_sprite(spr_stock_buy,subimg,collumn5,stock_y+2);
		
		//sell
		if(player_bought == 0) draw_set_alpha(0.5) else draw_set_alpha(1);
		if(selected_collumn == 1 && selected_row == i) subimg = 1 else subimg = 0;
		draw_sprite(spr_stock_sell,subimg,collumn5+20,stock_y+2);
		draw_set_alpha(1);
	}
	#endregion
}