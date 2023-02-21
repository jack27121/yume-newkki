/// @description
event_inherited();
hspd = 0;
vspd = 0;
dir = 270;
spd = 1;

flip = 1;

animate = 1;

state = new SnowState("idle");

subimg = 0;
xscale = 1;
yscale = 1;

choose_direction = function (){
	if (dir == 0)		 sprite_index = right;
	else if (dir == 90)  sprite_index = back;
	else if (dir == 180) sprite_index = left;
	else if (dir == 270) sprite_index = forward;	
}

state.add("idle", {
	enter: function(){
		animate = false;
		subimg = 1;
		hspd = 0;
		vspd = 0;
		call_later(irandom_range(1,4),time_source_units_seconds,function(){
			state.change("roam");
		});
	},
	step: function(){
		collision(hspd,vspd); //movement and collision
	}
});

state.add("roam", {
	enter: function(){
		animate = true;
		timer = call_later(irandom_range(1,8),time_source_units_seconds,function(){
			state.change("idle");
		});
		hspd = irandom_range(-1,1);
		vspd = irandom_range(-1,1);
	},
	step: function(){
		choose_direction();
		var col = collision(hspd,vspd); //movement and collision
		if(col || (hspd == 0 && vspd == 0)){
			call_cancel(timer);
			state.change("idle");
		}
	}
});
