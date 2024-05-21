shader_type spatial;

uniform float wind_speed = 1.0;
uniform vec2 wind_direction = vec2(1.0, 0.0);
//uniform sampler2D voronoi_noise;

vec2 random2(vec2 p) {
	return fract(sin(vec2(
		dot(p, vec2(127.32, 231.4)),
		dot(p, vec2(12.3, 146.3))
	)) * 231.23);
}

float worley2(vec2 p) {
	float dist = 1.0;
	
	// We take our integer part
	vec2 i_p = floor(p);
	
	// And our fractional part
	vec2 f_p = fract(p);
	
	// We loop from [-1, 1] (3 times) to include UV space
	for (int y = -1; y <= 1; y++) {
		for (int x= -1; x <= 1; x++) {
			// For every pixel this will make a N for a 3x3 grid
			vec2 n = vec2(float(x), float(y));
			vec2 diff = n + random2(i_p + n) - f_p;
			dist = min(dist, length(diff));
		}
	}
	
	return dist;
}

void vertex() {
}

void fragment() {
	//ALBEDO = texture(voronoi_noise, UV+ (TIME * wind_direction * wind_speed)).xyz;
	ALBEDO = vec3(worley2((UV * 4.0) + (TIME * wind_direction * wind_speed)));
}
