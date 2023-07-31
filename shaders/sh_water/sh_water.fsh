//
// watery shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float Offset;
uniform float Time;
uniform vec2 Texel;
uniform sampler2D Mask;

const float x_speed = 0.002;
const float x_freq = 200.0;
const float x_size = 6.0;
const float alpha = 1.0;

void main()
{
	
	float mask_value = texture2D( Mask, v_vTexcoord).r;	
	
	float x_wave = sin(Time*x_speed + v_vTexcoord.y*x_freq) * (x_size*Texel.x*mask_value) * (v_vTexcoord.y);
	
    vec4 base_col = texture2D( gm_BaseTexture, v_vTexcoord + vec2(x_wave, 0.0) );
	gl_FragColor = vec4(base_col.rgb,base_col.a * (1.0 - mask_value) * alpha);
}
