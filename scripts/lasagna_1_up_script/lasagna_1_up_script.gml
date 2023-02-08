function lasagna_1_up_script() {
	instance_create_depth(obj_player.x,obj_player.y - 10,-10000,obj_lasagna_1_up);
	screen_shake(10,120);
	instance_destroy(inst_3E61A5D7);


}
