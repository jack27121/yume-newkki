/// @description initilises inventory, attacks, actions, and stats
//global.stats = {
//	"money": 0,
//	
//	
//}
//party members
//global.party = ds_list_create();

//var garfield = ds_map_create()
//ds_map_add(garfield,"player",obj_player);
//ds_map_add(garfield,"health",50);
//ds_map_add(garfield,"health_max",50);
//ds_map_add(garfield,"icon",spr_icon_garfield);
//ds_map_add(garfield,"instrument","piano");
//
//var nermal = ds_map_create()
//ds_map_add(nermal,"player",obj_nermal);
//ds_map_add(nermal,"follow",obj_player);
//ds_map_add(nermal,"follow_distance",16);
//ds_map_add(nermal,"health",50);
//ds_map_add(nermal,"health_max",50);
//ds_map_add(nermal,"icon",spr_icon_nermal);
//ds_map_add(nermal,"instrument","606");
//
//var odie = ds_map_create()
//ds_map_add(odie,"player",obj_odie);
//ds_map_add(odie,"follow",obj_player);
//ds_map_add(odie,"follow_distance",35);
//ds_map_add(odie,"health",50);
//ds_map_add(odie,"health_max",50);
//ds_map_add(odie,"icon",spr_icon_odie);
//ds_map_add(odie,"instrument","trumpet");
//
//
//ds_list_add(global.party,garfield,nermal,odie);
//for(var i = 0; i< ds_list_size(global.party);i++){
//	ds_list_mark_as_map(global.party,i);
//}
//money
//global.money = 200;

//items
//global.items = ds_list_create();
//	//Object id, name, amount held
//	item = [obj_item_canned_tuna,"canned tuna",10];
//	ds_list_add(global.items,item);
//			
//	//item = [obj_item_store_bought_lasagna,"storebought lasagna",6];
//	//ds_list_add(global.items,item);
//	
//	//item = [obj_item_lukewarm_spaghetti,"Lukewarm Spaghetti",5];
//	//ds_list_add(global.items,item);
	
//attacks
//global.attacks = ds_list_create();
//	//Object id, namef, player icons
//	var attack = [obj_attack_claw,"claw",[spr_icon_garfield]];
//	ds_list_add(global.attacks,attack);
//	
//	attack = [obj_attack_kick_odie ,"Kick Odie",[spr_icon_garfield, spr_icon_odie]];
//	ds_list_add(global.attacks,attack);
//	
//	//attack = [obj_attack_shoot,"shoot",[spr_icon_nermal]];
//	//ds_list_add(global.attacks,attack);
//	
//	//attack = [obj_attack_combo,"combo",[spr_icon_garfield,spr_icon_nermal]];
//	//ds_list_add(global.attacks,attack);

global.stats = {
	money: 0,
	qwerks: [
	
	],
	items: [
		{name: "bat"}
	],
	party:[
		{name: "Hoge Joden"}
	
	]
	
	
}

instance_destroy();