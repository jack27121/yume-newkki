/// @description
if (debug_mode){
	draw_set_font(f_pixel);
	draw_set_color(white);
	draw_set_halign(fa_left);
	
	draw_set_alpha(0.4);
	draw_text(0, 20, "step " + string(global.step));
	draw_text(0, 40, "steps " + string(global.steps));
	draw_text(0, 60, "process " + string(global.process));
	draw_text(0, 80, "on bar " + string(global.on_bar));
	draw_text(0, 100, "on half bar " + string(global.on_half_bar));
	draw_text(0, 120, "on beat " + string(global.on_beat));
	draw_text(0, 140, "on half beat " + string(global.on_half_beat));
	draw_text(0, 160, "on quarter beat " + string(global.on_quad_beat));
	draw_text(0, 180, "on eighth beat " + string(global.on_eighth_beat));
	draw_text(0, 200, "BPM " + string(global.bpm));
	draw_text(0, 220, "BPM_change " + string(global.bpm_change));
	draw_set_alpha(1);
}