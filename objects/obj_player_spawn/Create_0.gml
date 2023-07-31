/// @description moves player to position or spawns it in if it doesn't exist
if(instance_exists(obj_player)){
	obj_player.x = x;	
	obj_player.y = y;
} else {
	instance_create_layer(x,y,"instances",obj_player);	
	
}
instance_destroy();