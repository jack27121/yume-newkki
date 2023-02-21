/// @description
stanncam_init(320,240,320*3,240*3);

global.camera = new stanncam(0,0,global.game_w,global.game_h);
cam_cor = global.camera.clone();
cam_hor = global.camera.clone();
cam_ver = global.camera.clone();

global.room_wrap = false;

post_processing = -1;

bg_surf = -1;