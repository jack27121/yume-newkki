/// @description
if(ping_pong) draw_sprite_ext(sprite_index,PingPongImage(sprite_index,subimg),x,y,image_xscale*xscale,image_yscale*yscale,0,-1,1);
else draw_sprite_ext(sprite_index,subimg,x,y,image_xscale*xscale,image_yscale*yscale,0,-1,1);

state.draw();