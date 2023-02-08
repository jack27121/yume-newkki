//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 surface_size;
uniform vec2 random_r;
uniform vec2 random_g;
uniform vec2 random_b;

void main()
{
	vec2 position;
	vec4 new_color = texture2D( gm_BaseTexture, v_vTexcoord );
	position.x = v_vTexcoord.x + (random_r.x/surface_size.x);
	position.y = v_vTexcoord.y + (random_r.y/surface_size.y);
	new_color.r = texture2D( gm_BaseTexture, position ).r;
	
	position.x = v_vTexcoord.x + (random_g.x/surface_size.x);
	position.y = v_vTexcoord.y + (random_g.y/surface_size.y);
	new_color.g = texture2D( gm_BaseTexture, position ).g;
	
	position.x = v_vTexcoord.x + (random_b.x/surface_size.x);
	position.y = v_vTexcoord.y + (random_b.y/surface_size.y);
	new_color.b = texture2D( gm_BaseTexture, position ).b;
	
	gl_FragColor = v_vColour * new_color;
}
