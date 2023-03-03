/// @description
obj_camera.bg_surf = surface_check_create(obj_camera.bg_surf,global.game_w,global.game_h);
surface_set_target(obj_camera.bg_surf);

x -= spd;
y -= spd;

draw_sprite_tiled(spr_bg_telephone,0,x,y);

surface_reset_target();