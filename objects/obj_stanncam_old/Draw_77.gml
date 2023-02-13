/*
/// @description draws the actual game

//if you want a special background or foreground drawn, you can draw them with stretched surfaces before and after the application surface
//or if you want to use specific shaders, you can wrap the application surface inside it

if(hor!= 0){
	draw_surface_stretched(outbounds_hor,display_offset,0,display_width,display_height);
	surface_free(outbounds_hor);
}

if(ver!= 0){
	draw_surface_stretched(outbounds_ver,display_offset,0,display_width,display_height);
	surface_free(outbounds_ver);
}

if(hor!= 0 && ver !=0){
	draw_surface_stretched(outbounds_cor,display_offset,0,display_width,display_height);
	surface_free(outbounds_cor);
}

draw_surface_stretched(app_surf,display_offset,0,display_width,display_height);