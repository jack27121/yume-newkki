/// @function stocks_create(name,price,change,bought,player_bought,graph)
/// @description creates a new stock

function stocks_create(name,price,change,bought,player_bought,graph){
	var stock = ds_map_create()
	ds_map_add(stock,"name",name);
	ds_map_add(stock,"price",price);
	ds_map_add(stock,"change",change);
	ds_map_add(stock,"bought",bought);
	ds_map_add(stock,"player_bought",player_bought);
	ds_map_add(stock,"graph",graph);
	
	ds_map_add(global.stocks,stock[?"name"],stock);
}