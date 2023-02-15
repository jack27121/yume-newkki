/// @description
t = 0;
duration = room_speed;
cell_size = 100;

in_out = 0;

u_cell_size = shader_get_uniform(sh_pixelate, "g_CellSize");
u_dimensions = shader_get_uniform(sh_pixelate, "gm_pSurfaceDimensions");
