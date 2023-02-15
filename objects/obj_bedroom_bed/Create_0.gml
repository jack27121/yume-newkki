/// @description

// Inherit the parent event
event_inherited();

in_bed = false;
sleep_countdown = -1;
draw_top = false;

script = function(){
	sleep1();
}

sleep1 = function(){
	obj_player.state.change("normal");
	with(obj_player){
		xDest = x;
		yDest = y;
		controlled = false;
	}
	call_later(0.1,time_source_units_seconds,function(){
		sleep2();
	});
}

sleep2 = function(){
	with(obj_player){
		xDest = other.x;
		yDest = other.y+14;
	}
	draw_top = true;
	mask_index = spr_blank;
	timer = call_later(0.1,time_source_units_seconds,function(){
		if(obj_player.x == obj_player.xDest){
			call_cancel(timer);
			sleep3();
		}
	},true);
	
}

sleep3 = function(){
	obj_player.visible = false;
	image_index = 1;
	in_bed = true;
	sleep_countdown = call_later(2,time_source_units_seconds,function(){
		transition(rm_nexus,room_speed*1);
	});
}

wake1 = function(){
	with(obj_player){
		visible = true;
		xDest = other.x-24;
		yDest = other.y+14;
	}
	in_bed = false;
	image_index = 0;
	timer = call_later(0.1,time_source_units_seconds,function(){
		if(obj_player.x == obj_player.xDest){
			call_cancel(timer);
			mask_index = spr_bedroom_bed;
			obj_player.controlled = true;
			draw_top = false;
		}
	},true);
}