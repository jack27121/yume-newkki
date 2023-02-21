/// @description
obj_camera.bg_surf = surface_check_create(obj_camera.bg_surf,global.game_w,global.game_h);
surface_set_target(obj_camera.bg_surf);

var x_ = -global.camera.get_x() - (room_width/2 - global.camera.x)*0.2;
var y_ = -global.camera.get_y() - (room_height/2 - global.camera.y)*0.2;

draw_sprite(spr_bg_nexus,0,x_,y_);


surface_reset_target();