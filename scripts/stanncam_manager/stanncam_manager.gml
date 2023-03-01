/// @function stanncam_init(game_w,game_h,resolution_w,resolution_h,gui_w,gui_h)
/// @description set game dimensions, display resolution, and gui dimensions, it's the same as game scale by default
function stanncam_init(game_w,game_h,resolution_w=game_w,resolution_h=game_h,gui_w=game_w,gui_h=game_h){
	instance_create_layer(0,0,"instances",obj_stanncam_manager);
	global.stanncams = array_create(8,-1);
	global.game_w = game_w;
	global.game_h = game_h;
	global.gui_w = gui_w;
	global.gui_h = gui_h;
	global.res_w = resolution_w;
	global.res_h = resolution_h;
	
	for (var i = 0; i < array_length(view_camera); ++i) {
	    camera_destroy(view_camera[i]);
	}
	
	application_surface_draw_enable(false);
	__stanncam_update_resolution();
}

/// @function stanncam_set_resolution(resolution_w,resolution_h);
/// @description updates the camera resolution, change view_w view_h and upscale to see changes
function stanncam_set_resolution(resolution_w,resolution_h){	
	global.res_w = resolution_w;
	global.res_h = resolution_h;
	__stanncam_update_resolution();
}

/// @function stanncam_toggle_fullscreen()
/// @description toggle fullscreen on off
function stanncam_toggle_fullscreen(){
	window_set_fullscreen(!window_get_fullscreen());
	__stanncam_update_resolution();
}

/// @function stanncam_toggle_stretching()
/// @description toggle display stretching
function stanncam_toggle_stretching(){
	obj_stanncam_manager.stretching = !obj_stanncam_manager.stretching;
	__stanncam_update_resolution();
}

/// @function stanncam_get_stretching()
/// @description get wheter the display is stretching
function stanncam_get_stretching(){
	return obj_stanncam_manager.stretching;
}

//if fullscreen and not stretching it offsets the x value so the render is in the middle
function fullscreen_stretch_compensate(){
	if(!stanncam_get_stretching() && window_get_fullscreen()){
		return (display_get_width() - obj_stanncam_manager.display_res_w)/2;
	} else return 0;
}

/// @function stanncam_set_gui_resolution(gui_w,gui_h)
/// @description set the gui resolution
function stanncam_set_gui_resolution(gui_w,gui_h){
	global.gui_w = gui_w;
	global.gui_h = gui_h;
	__stanncam_update_resolution();
}

/// @function stanncam_get_gui_scale_x()
/// @description gets how much bigger gui is from game
function stanncam_get_gui_scale_x(){
	return global.gui_w / global.game_w;
}

/// @function stanncam_get_gui_scale_y()
/// @description gets how much bigger gui is from game
function stanncam_get_gui_scale_y(){
	return global.gui_h / global.game_h;
}

/// @function stanncam_get_res_scale_x()
/// @description gets how much bigger res is from game
function stanncam_get_res_scale_x(){
	return obj_stanncam_manager.display_res_w / global.game_w;
}

/// @function stanncam_get_res_scale_y()
/// @description gets how much bigger res is from game
function stanncam_get_res_scale_y(){
	return obj_stanncam_manager.display_res_h / global.game_h;
}

/// @function __stanncam_update_resolution();
/// @description updates the camera resolution
function __stanncam_update_resolution(){		
	if(window_get_fullscreen())	{
		if(obj_stanncam_manager.stretching){
			obj_stanncam_manager.display_res_w = display_get_width();
			obj_stanncam_manager.display_res_h = display_get_height();
		} else {
			var ratio = global.game_w / global.game_h;
			obj_stanncam_manager.display_res_w = display_get_height() * ratio;
			obj_stanncam_manager.display_res_h = display_get_height();
		}
	} else {
		if(obj_stanncam_manager.stretching){
			obj_stanncam_manager.display_res_w = global.res_w;
			obj_stanncam_manager.display_res_h = global.res_h;
		} else {
			var ratio = global.game_w / global.game_h;
			obj_stanncam_manager.display_res_w = global.res_h * ratio;
			obj_stanncam_manager.display_res_h = global.res_h;
		}
		
		window_set_size(obj_stanncam_manager.display_res_w, obj_stanncam_manager.display_res_h);
		//call_later(5,time_source_units_frames,function(){
		//	window_center();
		//});
	}
	
	var gui_x_scale = obj_stanncam_manager.display_res_w / global.gui_w;
	var gui_y_scale = obj_stanncam_manager.display_res_h / global.gui_h;
	
	display_set_gui_maximize(gui_x_scale,gui_y_scale,fullscreen_stretch_compensate());
	surface_resize(application_surface, display_get_gui_width(), display_get_gui_height())
	
	for (var i = 0; i < array_length(global.stanncams); ++i) {  
		if (global.stanncams[i] == -1) continue;
		global.stanncams[i].__update_resolution();
	}
}