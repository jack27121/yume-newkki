/// EaseInOutElastic(inputvalue,outputmin,outputmax,inputmax)
function ease_in_out_elastic() {
	var t = argument[0]; // time
	var b = argument[1]; // begin
	var c = argument[2]; // change
	var d = argument[3]; // duration

	var _s = 1.70158;
	var _p = 0;
	var _a = c;

	if (t == 0 || _a == 0)
	{
	    return b;
	}

	t /= d*0.5;

	if (t == 2)
	{
	    return b+c; 
	}

	if (_p == 0)
	{
	    _p = d * (0.3 * 1.5);
	}

	if (_a < abs(c)) 
	{ 
	    _a = c; 
	    _s = _p * 0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (c / _a);
	}

	if (t < 1)
	{
	    return -0.5 * (_a * power(2, 10 * (--t)) * sin((t * d - _s) * (2 * pi) / _p)) + b;
	}

	return _a * power(2, -10 * (--t)) * sin((t * d - _s) * (2 * pi) / _p) * 0.5 + c + b;


}
