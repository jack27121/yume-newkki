/*
/// @description
	surface_set_target(app_surf);
	draw_clear_alpha(black,0);
	surface_reset_target();


if(hor!= 0){
	surface_set_target(outbounds_hor);
	draw_clear_alpha(black,0);
	surface_reset_target();
}

if(ver!= 0){
	surface_set_target(outbounds_ver);
	draw_clear_alpha(black,0);
	surface_reset_target();
}

if(hor!= 0 && ver !=0){
	surface_set_target(outbounds_cor);
	draw_clear_alpha(black,0);
	surface_reset_target();
}