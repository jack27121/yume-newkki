/// @description
var game_res = global.resLib[RES_LIB.DESKTOP_4_3_320_X_240];
var display_res = global.resLib[global.settings.resolution];
stanncam_init(game_res.width,game_res.height,display_res.width,display_res.height);

if(global.settings.fullscreen == true && window_get_fullscreen() == false){
	stanncam_toggle_fullscreen();
}

if(global.settings.stretching == true && stanncam_get_stretching() == false){
	stanncam_toggle_stretching();
}

global.camera = new stanncam(0,0,global.game_w,global.game_h);
cam_cor = global.camera.clone();
cam_hor = global.camera.clone();
cam_ver = global.camera.clone();

global.room_wrap = false;

post_processing = -1;

bg_surf = -1;