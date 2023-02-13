/// @description

//which portal is closest
dist = point_distance(x, y, obj_player.x, obj_player.y);

with(portal2){
	dist = point_distance(x, y, obj_player.x, obj_player.y);
}

closest = self;
farthest = portal2;

if(dist > portal2.dist){
	closest = portal2;
	farthest = self;
}

new_x = farthest.x - closest.x;
new_y = farthest.y - closest.y;

portal_cam.move(global.camera.x+new_x,global.camera.y+new_y);

//teleport player when they touch the portal
if(closest.dist < 1 && !teleported){
	teleported = true;	
	
	obj_player.x += new_x;
	obj_player.y += new_y;

	global.camera.move(global.camera.x+new_x,global.camera.y+new_y,0);
} else if(closest.dist > 1 && teleported){
	teleported = false;
}