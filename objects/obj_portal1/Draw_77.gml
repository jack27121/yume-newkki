/// @description
portal_surf = surface_check_create(portal_surf,global.game_w,global.game_h);
surface_set_target(portal_surf);
draw_clear_alpha(black,0);

var dir = point_direction(obj_player.x,obj_player.y,closest.x,closest.y);
var radius = clamp(500 / closest.dist,0,2000);

var x_ = closest.x + lengthdir_x(radius-4,dir) - global.camera.get_x();
var y_ = closest.y + lengthdir_y(radius-4,dir) - global.camera.get_y();

draw_circle(x_,y_,radius,0);
surface_reset_target();

surface_set_target(portal_cam.surface);
gpu_set_blendmode_ext(bm_zero,bm_src_alpha);
draw_surface(portal_surf,0,0);

surface_reset_target();
gpu_set_blendmode(bm_normal);

//draw_surface_stretched(portal_surf,0,0,global.camera.__display_width,global.camera.__display_height);


draw_surface_stretched(portal_cam.surface,stanncam_fullscreen_ratio_compensate(),0,__obj_stanncam_manager.display_res_w,__obj_stanncam_manager.display_res_h);
