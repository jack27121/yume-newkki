/// @description
var game_res = global.resLib[RES_LIB.DESKTOP_4_3_320_X_240];
var display_res = global.resLib[global.settings.resolution];
stanncam_init(game_res.width,game_res.height,display_res.width,display_res.height);

stanncam_set_window_mode(global.settings.window_mode);
stanncam_set_keep_aspect_ratio(global.settings.keep_aspect_ratio)

global.camera = new stanncam(0,0,global.game_w,global.game_h);
cam_cor = global.camera.clone();
cam_hor = global.camera.clone();
cam_ver = global.camera.clone();

global.room_wrap = false;

post_processing = -1;

bg_surf = -1;

//backgrounds are scaled up so they can parralax smoother
global.bg_scale = 4;