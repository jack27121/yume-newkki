function surface_check_create(surface,w,h){
	if(!surface_exists(surface)) return surface_create(w,h);
	else return surface;
}