/// @description toggles menu on off
if(global.tabKeyPressed && !instance_exists(obj_dialogue)){
	if(!menu_on){
		menu_on = true;
		plane_init()
		plane_move(0);
	}else{
		menu_on = false;
		plane_kill()
	}
}
//interaction
if(menu_on){
	if global.uKeyPressed selected_row--;
	if global.dKeyPressed selected_row++;
	if global.lKeyPressed selected_collumn--;
	if global.rKeyPressed selected_collumn++;
	
	if(selected_collumn < 0) selected_collumn = 2;
	else if(selected_collumn > 2) selected_collumn = 0;
	
	if(selected_row < 0) selected_row = ds_map_size(global.stocks)-1;
	else if(selected_row > ds_map_size(global.stocks)-1) selected_row = 0;
	
	if(global.xKeyPressed){
		var stock_array = ds_map_keys_to_array(global.stocks);
		var stock = global.stocks[?stock_array[selected_row]];
		var price = stock[?"price"];
		var player_bought = stock[?"player_bought"];
		if(selected_collumn == 0 && global.money >= price){ //BUY
			global.money -= price;
			global.stocks[?stock_array[selected_row]][?"player_bought"]++;
			global.stocks[?stock_array[selected_row]][?"bought"]++;
		}
		else if(selected_collumn == 1 && player_bought > 0){ //SELL
			global.money += price;
			global.stocks[?stock_array[selected_row]][?"player_bought"]--;
			global.stocks[?stock_array[selected_row]][?"bought"]--;
		}
	}
}

//change
if(time != global.minute){
	time = global.minute;
	invested = 0;
	difference = 0;
	var stock_array = ds_map_keys_to_array(global.stocks);
	for (var i = 0; i < ds_map_size(global.stocks); ++i) {
		var stock = global.stocks[?stock_array[i]];
		var price = stock[?"price"];
		var change = random_range(-1.0,1.0);
		
		global.stocks[?stock_array[i]][?"change"] = change;
		global.stocks[?stock_array[i]][?"price"] += (change/price);
		
		var player_bought = stock[?"player_bought"];
		if(player_bought > 0){
			invested += stock[?"price"] * player_bought;
			difference += stock[?"change"] * player_bought;
		}
	}
}