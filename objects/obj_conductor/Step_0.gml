/// @description keeps track of the beat

#region beats
if (global.playing){

	if (global.step >= 1) {
		//eighth beat
		global.on_eighth_beat = true;

		//quarter beat
		if((global.steps mod 2) == 0){
			global.on_quad_beat = true;
		}
		
		//half beat
		if((global.steps mod 4) == 0){
			global.on_half_beat = true;
		}
		//whole beat
		if((global.steps mod 8) == 0){
			global.on_beat = true;
		}
		//half bar
		if((global.steps mod 16) == 0){
			global.on_half_bar = true;
		}
		
		//whole bar
		if(global.steps == 0){
			global.on_bar = true;
		}
		global.step = frac(global.step);
		
		global.steps++;
		if (global.steps > 31)  {
			global.steps = 0;
		}	
	} else {
		global.on_eighth_beat = false;
		global.on_quad_beat = false;
		global.on_half_beat = false;
		global.on_beat = false;
		global.on_half_bar = false;
		global.on_bar = false;
	}
	//swing_delta = (sin(((global.process mod 8 /8)*2 - 0.5)*pi)*global.swing + 1);  
	
	var timedelta = delta_time/1000; //how many ms passed since last step
	var barstep = (timedelta*((global.bpm+global.bpm_change) / 60000 )*8)//How many bars have processed since the last step	
	
	global.process += barstep //How many steps have happened since the start of the track
	global.step += barstep; //* swing_delta;
}
#endregion