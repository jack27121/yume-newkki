/// @description
t = 0;
duration = room_speed;

in_out = 0;

switch (transition_type_) {
    case transition_type.pixelate:
		cell_size = 100;
        u_cell_size = shader_get_uniform(sh_pixelate, "g_CellSize");
		u_dimensions = shader_get_uniform(sh_pixelate, "gm_pSurfaceDimensions");
		
		obj_camera.post_processing = function(){
			shader_set(sh_pixelate);
			shader_set_uniform_f(u_dimensions, global.game_w,global.game_h);
			shader_set_uniform_f(u_cell_size,((t / duration)*cell_size));
		}
		
        break;
    case transition_type.fade:
        
        u_fade = shader_get_uniform(sh_fade, "g_Fade");		
		obj_camera.post_processing = function(){
			shader_set(sh_fade);
			shader_set_uniform_f(u_fade,1-(t / duration));
		}
        break;
}
