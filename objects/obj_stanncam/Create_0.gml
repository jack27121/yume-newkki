/// @description
#macro cam view_camera[0]
#macro cam_hor view_camera[1] //for drawing outside the border of the room, when wrapping around
#macro cam_ver view_camera[2]
#macro cam_cor view_camera[3]

//view_set_camera(0, cam);
//view_set_camera(1, cam_hor);
//view_set_camera(2, cam_ver);
//view_set_camera(3, cam_cor);

//surfaces to be drawn to
app_surf = -1;
outbounds_hor = -1;
outbounds_ver = -1;
outbounds_cor = -1;

#region change these global variables to whatever you need.
//if you change resolution or scale at runtime, run stanncam_update_resolution() after
global.view_w = 320; //game resolution width
global.view_h = 240; //game resolution height
global.gui_w = 320;  //gui  resolution width
global.gui_h = 240;  //gui  resolution height
global.upscale = 3; //how much the game should be upscaled

global.camera_follow = obj_player; //what object the camera should follow
spd = 10; //how fast the camera follows an object
spd_threshold = 50; //the minimum distance the camera is away, for the speed to be in full effect
camera_constrain = false; //if camera should be constrained to the room size
//the camera bounding box, for the followed object to leave before the camera starts moving
bounds_w = 20;
bounds_h = 20;
#endregion

#region inits neccesary variables
//zoom
zoom = 1;
zoom_x = 0;
zoom_y = 0;
zooming = false;

//screen shake
shake_length = 0;
shake_magnitude = 0;
shake_time = 0;
shake_x = 0;
shake_y = 0;

moving = false;
#endregion

//for drawing rooms wrapped
hor = 0;
ver = 0;

application_surface_draw_enable(false);

stanncam_update_resolution();