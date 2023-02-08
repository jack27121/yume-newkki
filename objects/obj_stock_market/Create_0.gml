/// @description
menu_on = false;

//stocks
global.stocks = ds_map_create();
var price_graph = [10,10,10,10,10];
stocks_create("RPG",60,2.4,10,0,price_graph);
stocks_create("GARF",550,-1,40,0,price_graph);
stocks_create("HELL",11,34.2,10,0,price_graph);
stocks_create("CIGS",30,-2.4,7,0,price_graph);
stocks_create("TEST",20,2.4,3,0,price_graph);
stocks_create("EPIC",50,-2.2,4,0,price_graph);

//player stocks
invested = 0;
difference = 0;
//owned_stocks = ["RPG","GARF"];

//menu
collumn1 = 4;
collumn2 = 40;
collumn3 = 100;
collumn4 = 160;
collumn5 = 215;

selected_row = 0;
selected_collumn = 0;

time = 0;