/// @description
obj_camera.bg_surf = surface_check_create(obj_camera.bg_surf,global.game_w*global.bg_scale,global.game_h*global.bg_scale);
surface_set_target(obj_camera.bg_surf);

x -= spd;
y -= spd;

draw_sprite_tiled_ext(spr_bg_telephone,0,x,y,global.bg_scale,global.bg_scale,-1,1);

surface_reset_target();