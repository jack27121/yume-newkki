/// @description
#region wraps around room
if(global.room_wrap){
	if(global.camera.follow != undefined){
		var cam_x = global.camera.x;
		var cam_y = global.camera.y;
		//right
		if(global.camera.follow.x > room_width){
			global.camera.follow.x -= room_width;
			cam_x = global.camera.x - room_width;
		}
		//left
		if(global.camera.follow.x < 0){
			global.camera.follow.x += room_width;
			cam_x = global.camera.x + room_width;
		}
		//down
		if(global.camera.follow.y > room_height){
			global.camera.follow.y -= room_height;
			cam_y = global.camera.y - room_height;
		}
		//up
		if(global.camera.follow.y < 0){
			global.camera.follow.y += room_height;
			cam_y = global.camera.y + room_height;
		}
		global.camera.move(cam_x,cam_y,0);
	}
	#endregion
	
	#region draws stuff beyond the room bounds
	var edge_x1 = global.camera.get_x();
	var edge_y1 = global.camera.get_y();
	var edge_x2 = edge_x1+global.game_w;
	var edge_y2 = edge_y1+global.game_h;
	
	//check if it's gone out of bounds on the left or right, top or bottom
	hor = 0;
	ver = 0;
	
	if(edge_x1 < 0) hor = -1;
	else if(edge_x2 > room_width) hor = 1;
	
	if(edge_y1 < 0) ver = -1;
	else if(edge_y2 > room_height) ver = 1;
	
	if(hor != 0 && ver != 0){
		cam_cor.move(cam_x-(room_width*hor),cam_y-(room_height*ver),0);
	}
	if(hor != 0){
		cam_hor.move(cam_x-(room_width*hor),cam_y,0);
	}
	if(ver != 0){
		cam_ver.move(cam_x,cam_y-(room_height*ver),0);
	}
}
#endregion