#version 430

// pipeline-ból bejövő per-fragment attribútumok
in vec3 vs_out_pos;
in vec3 vs_out_norm;
in vec2 vs_out_tex;

// kimenő érték - a fragment színe
out vec4 fs_out_col;

// textúra mintavételező objektum
uniform sampler2D texImage;
uniform sampler2D nightImage;
uniform sampler2D waterImage;

uniform vec3 cameraPos;
uniform vec3 lightDir = vec3(0,0,0);

uniform vec3 La = vec3( 0.0125, 0.0125, 0.0125 );
uniform vec3 Ld = vec3(0.85, 0.8, 0.8);
uniform vec3 Ls = vec3(0.9, 0.9, 0.9);

uniform vec3 Ka = vec3( 0.0125, 0.0125, 0.0125 );
uniform vec3 Kd = vec3( 1.0, 1.0, 1.0 );
uniform vec3 Ks = vec3( 1.0, 1.0, 1.0 );

uniform float r = 1;
uniform float g = 1;
uniform float b = 1;

uniform float shininess = 80;

uniform int type = 0;
uniform int equator = 0;

void main()
{
	//0 bolgyók, 1 öv, 2 nap, 3 föld
	vec3 texColor = texture( texImage, vs_out_tex ).xyz;
	if (equator == 1 && (type == 0 || type == 2 || type == 3)){
		if (vs_out_tex.y > 0.49 && vs_out_tex.y < 0.51){
			texColor = vec3(r,g,b);
		}
	}

	vec3 ambient = texColor * La * Ka;

	vec3 norm = normalize(vs_out_norm);
	vec3 toLight = normalize(lightDir - vs_out_pos);
	float diffuseStrength = clamp(dot(norm, toLight),0,1);
	vec3 diffuse = texColor * Ld * Kd * diffuseStrength;

	vec3 toCamera = normalize(cameraPos - vs_out_pos);
	vec3 reflectionDir = reflect(-toLight, norm);
	float specularStrength = pow(clamp(dot(toCamera, reflectionDir),0,1),shininess);
	vec3 specular = texColor * Ls * Ks * specularStrength;

	fs_out_col = vec4(ambient + diffuse + specular,1);

	if (type == 3){
		vec3 earthambient = ambient;
		vec3 earthdiffuse = diffuse;
		vec3 earthspecular = specular;
		if(texture(waterImage, vs_out_tex).x == 0){	//szaraz
			earthspecular = vec3(0,0,0);
		}
		if(texture(nightImage, vs_out_tex).x == 1){	//ejjel
			earthdiffuse += (1 - earthdiffuse) * 2;
		}
		fs_out_col = vec4(earthambient + earthdiffuse + earthspecular,1);
	}

	if (type == 1){
		if(texture(texImage, vs_out_tex).a < 0.5)
			discard;
	}

	if (type == 2 || type == 1){
		ambient = texColor * vec3(1,1,1);
		fs_out_col = vec4(ambient,1);
	}
}
