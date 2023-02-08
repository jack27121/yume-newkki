/// @description
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_bebas);
draw_text(view_w / 2, (view_h / 2)-10, string(sound[sound_selected]));
draw_text(view_w / 2, (view_h / 2)+10, "<-  x  ->");

draw_set_valign(fa_bottom);
draw_text(view_w / 2, (view_h), "volume: "+ string(volume));
