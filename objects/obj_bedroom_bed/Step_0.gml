/// @description

// Inherit the parent event
event_inherited();

if(in_bed && input_check("action")){
	call_cancel(sleep_countdown);
	wake1();
}