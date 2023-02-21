/// @description

if(post_processing != -1) post_processing();

//draws background
if(surface_exists(bg_surf)){
	draw_surface_stretched(bg_surf,0,0,obj_stanncam_manager.display_res_w,obj_stanncam_manager.display_res_h);
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

