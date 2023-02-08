//special thanks to Deerbell Games for helping making the foundation of this shader
//and flyingsaucerinvasion for showing the simplified math
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float scale;
uniform float tilt;
uniform float pan;
uniform float rows;

// set first value to change the perspective, the example texture is 256x128 pixels by the way
// set second value to change how many lanes are visible

void main()
{
    vec2 uv = v_vTexcoord; // don't alter varyings directly, we have this variable to make any changes
	float tilt_bottom = 0.0;
	if(tilt > 0.0) { tilt_bottom = 1.0; };
	
    uv.x = (uv.x - 0.5) / ((1.0 - (uv.y*-tilt)-tilt*tilt_bottom) / rows*scale); // change the fragment based on the y position & scalar
    uv.x += pan*rows; // shift everything based on the pan value we passed along from the previous part (vertex)
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv); // map our texture and multiply it by the color to get the final data
}