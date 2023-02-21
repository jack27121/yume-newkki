/// @description

// Inherit the parent event
event_inherited();

state.step();

if(in_bed && input_check("action")){
	state.change("wake2");
}