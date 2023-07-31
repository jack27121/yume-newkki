/// @description

if(post_processing != -1) post_processing();

//draws background
if(surface_exists(bg_surf)){
	//draw_surface_stretched(bg_surf,stanncam_fullscreen_ratio_compensate(),0,__obj_stanncam_manager.display_res_w,__obj_stanncam_manager.display_res_h);
	global.camera.draw_surf(bg_surf,0,0,1/global.bg_scale,1/global.bg_scale);
}

if(global.room_wrap){
	if(hor!= 0){
		cam_hor.draw(0,0);
	}
	
	if(ver!= 0){
		cam_ver.draw(0,0);
	}
	
	if(hor!= 0 && ver !=0){
		cam_cor.draw(0,0);
	}
}

global.camera.draw(0,0);

shader_reset();

if(global.window_mode != STANNCAM_WINDOW_MODE.windowed){
	var ratio = sprite_get_width(spr_fullscreen_banner_left) / sprite_get_height(spr_fullscreen_banner_left);
	var height = display_get_height();
	var width = height*ratio;
	
	sprite_get_height(spr_fullscreen_banner_left)
	
	draw_sprite_stretched(spr_fullscreen_banner_left,0,stanncam_fullscreen_ratio_compensate_x()-width,0,width,height);
	draw_sprite_stretched(spr_fullscreen_banner_right,0,display_get_width()-stanncam_fullscreen_ratio_compensate_x(),0,width,height);
}

