/// @description

// Inherit the parent event
event_inherited();

in_bed = false;
draw_top = false;

script = function(){
	state.change("sleep1");
}

state = new SnowState("idle");

state.add("idle"){
	
};

state.add("sleep1" ,{
	enter: function(){
		with(obj_player){
			state.change("normal");
			xDest = x;
			yDest = y;
			controlled = false;
		}
		t = 0;
	},
	step: function(){
		if(t++ == room_speed * 0.1) state.change("sleep2");
	}
});

state.add("sleep2",{
	enter: function(){
		with(obj_player){
			xDest = other.x;
			yDest = other.y+14;
		}
		t = 0;
		draw_top = true;
		mask_index = spr_blank;
	},
	step: function(){
		if(t++ == room_speed * 0.1) state.change("sleep3");
	}
});

state.add("sleep3",{
	enter: function(){
		obj_player.visible = false;
		image_index = 1;
		in_bed = true;
		t = 0;
	},
	step: function(){
		if(t++ == room_speed * 2){
			transition(rm_balcony_dream,,,transition_type.pixelate);
		}
	}
});

state.add("wake1",{
	enter: function(){
		with(obj_player){
			state.change("normal");
			x = other.x;
			y = other.y+14;
			visible = false;
			controlled = false;
		}
		draw_top = true;
		mask_index = spr_blank;
		image_index = 1;
		t = 0;
	},
	step: function(){
		if(t++ == room_speed * 2){
			state.change("wake2");
		}
	}
});

state.add("wake2",{
	enter: function(){
		with(obj_player){
			visible = true;
			xDest = other.x-24;
			yDest = other.y+14;
		}
		in_bed = false;
		image_index = 0;
	},
	step: function(){
		if(obj_player.x == obj_player.xDest){
			mask_index = spr_bedroom_bed;
			obj_player.controlled = true;
			draw_top = false;
			state.change("idle");
		}
	}
});