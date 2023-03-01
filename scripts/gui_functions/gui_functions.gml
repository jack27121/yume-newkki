/// @function                 draw_box
/// @param x_				  pos
/// @param y_				  pos
/// @param w				  width
/// @param h				  height
/// @param subimg			  
/// @description              draws a box
function draw_box(x_,y_,w,h,subimg = 0){
	
	draw_sprite_stretched(spr_menu_bg,subimg,x_+1,y_+1,w-2,h-2);
	draw_sprite_stretched(spr_menu_frame,subimg,x_+1,y_+1,w-2,h-2);

}

/// @function                 draw_selection
/// @param x_				  pos
/// @param y_				  pos
/// @param w				  width
/// @param h				  height
/// @param alpha			  for pulsing rectangle
/// @param alpha2			  for sprite
/// @description              draws a selection rectangle that pulses
function draw_selection(x_,y_,w,h = text_height,alpha = 0.5,alpha2 = 0.8){
	
	draw_set_color(purple_light);
	draw_set_alpha(sine_between(global.t,30,0.2*alpha,0.30*alpha));
	draw_rectangle(x_+6,y_+7,x_+w-9,y_+22,0);
	
	draw_set_alpha(alpha2);
	draw_sprite_stretched(spr_selection,0,x_+3,y_+7,w-8,15);
	
	draw_reset_color();
	
	
}

/// @function               draw_text_style
/// @param x_				
/// @param y_				
/// @param text
/// @param color_top		  
/// @param color_bottom
/// @param alpha
/// @description            draws styled text
function draw_text_style(x_,y_,text,color_top,color_bottom,alpha = 1){
	
	var offset = 8;
	draw_set_color(black);
	draw_set_alpha(0.5 * alpha);
	draw_text(x_+offset+1,y_+offset+1,text);
	draw_reset_color();
	draw_text_color(x_+offset,y_+offset,text,color_top,color_top,color_bottom,color_bottom,alpha);
	
}

/// @function               draw_reset_color
/// @description            resets color and alpha
function draw_reset_color(){
	draw_set_alpha(1);
	draw_set_color(white);
}