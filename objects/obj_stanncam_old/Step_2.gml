/*
/// @description
if (instance_exists(global.camera_follow)){
	
	#region wraps around room
	//right
	if(global.camera_follow.x > room_width){
		global.camera_follow.x -= room_width;
		x-= room_width;
	}
	//left
	if(global.camera_follow.x < 0){
		global.camera_follow.x += room_width;
		x+= room_width;
	}
	//down
	if(global.camera_follow.y > room_height){
		global.camera_follow.y -= room_height;
		y-= room_height;
	}
	//up
	if(global.camera_follow.y < 0){
		global.camera_follow.y += room_height;
		y+= room_height;
	}
	#endregion
	
	//update destination
	xTo = global.camera_follow.x;
	yTo = global.camera_follow.y;
	
	var dist_w = max(bounds_w,abs(xTo - x)) - bounds_w;
	var dist_h = max(bounds_h,abs(yTo - y)) - bounds_h;
	
	//update camera position
	if (abs(xTo - x) > bounds_w){
		var _spd = (dist_w/spd_threshold)*spd;
		if (x < xTo) x+=_spd;
		else if (x > xTo) x-=_spd;
	}
	
	if (abs(y - yTo) > bounds_h){
		var _spd = (dist_h/spd_threshold)*spd;
		if (y < yTo) y+=_spd;
		else if (y > yTo) y-=_spd;
	}
	
} else if(moving){
	//gradually moves camera into position based on duration
	x = ease_in_out(t,xStart,xTo-xStart,duration);
	y = ease_in_out(t,yStart,yTo-yStart,duration);

	t++;
	if(x == xTo && y == yTo) moving = false;
}

#region screen-shake
var stanncam_shake_ = shake(shake_time++,shake_magnitude,shake_length);
shake_x = stanncam_shake_;
shake_y = stanncam_shake_;
var vibration = stanncam_shake_ / 20;
gamepad_set_vibration(0,vibration,vibration);
#endregion

#region constrains camera to room bounds
if(camera_constrain){
	x = clamp(x,(global.game_w/2),room_width -(global.game_w/2));
	y = clamp(y,(global.game_h/2),room_height-(global.game_h/2));
}
#endregion

#region zooming
if(zooming){
	//gradually zooms camera
	zoom = ease_in_out(t_zoom,zoomStart,zoomTo-zoomStart,zoom_duration);
	t_zoom++;
	if(zoom == zoomTo) zooming = false;
	camera_set_view_size(cam,global.game_w*zoom,global.game_h*zoom);
	zoom_x = ((global.game_w*zoom) - global.game_w)/2;
	zoom_y = ((global.game_h*zoom) - global.game_h)/2;
}
#endregion

//update camera view
var new_x = x - (global.game_w / 2 + shake_x + zoom_x);
var new_y = y - (global.game_h / 2 + shake_y + zoom_y);

camera_set_view_pos(cam, new_x, new_y);

app_surf = surface_check_create(app_surf,global.game_w,global.game_h);
view_set_surface_id(0,app_surf);

#region draws stuff beyond the room bounds
var edge_x1 = stanncam_x();
var edge_y1 = stanncam_y();
var edge_x2 = edge_x1+global.game_w;
var edge_y2 = edge_y1+global.game_h;

//check if it's gone out of bounds on the left or right, top or bottom
hor = 0;
ver = 0;

if(edge_x1 < 0) hor = -1;
else if(edge_x2 > room_width) hor = 1;

if(edge_y1 < 0) ver = -1;
else if(edge_y2 > room_height) ver = 1;

view_visible[1] = false;
view_visible[2] = false;
view_visible[3] = false;

if(hor != 0 && ver != 0){
	view_visible[3] = true;
	camera_set_view_pos(cam_cor,new_x-(room_width*hor),new_y-(room_height*ver));
	camera_set_view_size(cam_cor,global.game_w*obj_stanncam.zoom,global.game_h*obj_stanncam.zoom);
	outbounds_cor = surface_check_create(outbounds_cor,global.game_w,global.game_h);
	view_set_surface_id(3,outbounds_cor);
}
if(hor != 0){
	view_visible[1] = true;
	camera_set_view_pos(cam_hor,new_x-(room_width*hor),new_y);
	camera_set_view_size(cam_hor,global.game_w*obj_stanncam.zoom,global.game_h*obj_stanncam.zoom);
	outbounds_hor = surface_check_create(outbounds_hor,global.game_w,global.game_h);
	view_set_surface_id(1,outbounds_hor);
}
if(ver != 0){
	view_visible[2] = true;
	camera_set_view_pos(cam_ver,new_x,new_y-(room_height*ver));
	camera_set_view_size(cam_ver,global.game_w*obj_stanncam.zoom,global.game_h*obj_stanncam.zoom);
	outbounds_ver = surface_check_create(outbounds_ver,global.game_w,global.game_h);
	view_set_surface_id(2,outbounds_ver);
}
#endregion