//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float g_Fade;

void main()
{
    gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord ) * g_Fade;
}
