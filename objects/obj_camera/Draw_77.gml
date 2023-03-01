/// @description

if(post_processing != -1) post_processing();

//draws background
if(surface_exists(bg_surf)){
	draw_surface_stretched(bg_surf,fullscreen_stretch_compensate(),0,obj_stanncam_manager.display_res_w,obj_stanncam_manager.display_res_h);
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

if(window_get_fullscreen()){
	var ratio = sprite_get_width(spr_fullscreen_banner_left) / sprite_get_height(spr_fullscreen_banner_left);
	var height = display_get_height();
	var width = height*ratio;
	
	sprite_get_height(spr_fullscreen_banner_left)
	
	draw_sprite_stretched(spr_fullscreen_banner_left,0,fullscreen_stretch_compensate()-width,0,width,height);
	draw_sprite_stretched(spr_fullscreen_banner_right,0,display_get_width()-fullscreen_stretch_compensate(),0,width,height);
}

