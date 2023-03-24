#pragma header

uniform float angle;
uniform float distance;
uniform vec4 rimlightColor;

uniform vec2 pixelSize;
uniform vec4 bounds;

void main(){
	vec4 textureColor = flixel_texture2D(bitmap, openfl_TextureCoordv);
	float overlapAlpha;

	vec2 distanceScaled = vec2(cos(radians(angle)) * pixelSize.x * distance, sin(radians(angle)) * pixelSize.y * distance);

	vec2 overlapCoord = vec2(openfl_TextureCoordv.x + distanceScaled.x, openfl_TextureCoordv.y - distanceScaled.y);
	if(overlapCoord.x < bounds.x || overlapCoord.x > bounds.z || overlapCoord.y < bounds.y || overlapCoord.y > bounds.w){
		overlapAlpha = 0;
	}
	else{
		overlapAlpha = flixel_texture2D(bitmap, overlapCoord).a;
	}

	vec3 outColor = mix(rimlightColor.rgb, textureColor.rgb / textureColor.a, overlapAlpha * rimlightColor.a);

	gl_FragColor = vec4(outColor.rgb * textureColor.a, textureColor.a);
}