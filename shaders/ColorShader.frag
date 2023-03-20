#pragma header

uniform float amount;

void main() {
	vec4 textureColor = flixel_texture2D(bitmap, openfl_TextureCoordv);
	textureColor.rgb = textureColor.rgb + vec3(amount);
	gl_FragColor = vec4(textureColor.rgb * textureColor.a, textureColor.a);
}