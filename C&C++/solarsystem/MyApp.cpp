#include "MyApp.h"
#include "ObjParser.h"
#include "SDL_GLDebugMessageCallback.h"

#include <imgui.h>

CMyApp::CMyApp()
{
}

CMyApp::~CMyApp()
{
}

void CMyApp::SetupDebugCallback()
{
	// engedélyezzük és állítsuk be a debug callback függvényt ha debug context-ben vagyunk 
	GLint context_flags;
	glGetIntegerv(GL_CONTEXT_FLAGS, &context_flags);
	if (context_flags & GL_CONTEXT_FLAG_DEBUG_BIT) {
		glEnable(GL_DEBUG_OUTPUT);
		glEnable(GL_DEBUG_OUTPUT_SYNCHRONOUS);
		glDebugMessageControl(GL_DONT_CARE, GL_DONT_CARE, GL_DEBUG_SEVERITY_NOTIFICATION, 0, nullptr, GL_FALSE);
		glDebugMessageControl(GL_DONT_CARE, GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR, GL_DONT_CARE, 0, nullptr, GL_FALSE);
		glDebugMessageCallback(SDL_GLDebugMessageCallback, nullptr);
	}
}

void CMyApp::InitShaders()
{
	m_programID = glCreateProgram();
	AttachShader(m_programID, GL_VERTEX_SHADER, "Shaders/Vert_PosNormTex.vert");
	AttachShader(m_programID, GL_FRAGMENT_SHADER, "Shaders/Frag_ZH.frag");
	LinkProgram(m_programID);
}

void CMyApp::CleanShaders()
{
	glDeleteProgram(m_programID);
}

MeshObject<Vertex> createCube()
{
	MeshObject<Vertex> mesh;

	mesh.vertexArray = {
		// Front face
		{{-0.5f, -0.5f, 0.5f}, {0.0f, 0.0f, 1.0f}, {0.0f, 0.0f}}, // Bottom-left
		{{0.5f, -0.5f, 0.5f}, {0.0f, 0.0f, 1.0f}, {1.0f, 0.0f}},  // Bottom-right
		{{0.5f, 0.5f, 0.5f}, {0.0f, 0.0f, 1.0f}, {1.0f, 1.0f}},   // Top-right
		{{-0.5f, 0.5f, 0.5f}, {0.0f, 0.0f, 1.0f}, {0.0f, 1.0f}},  // Top-left

		// Back face
		{{0.5f, -0.5f, -0.5f}, {0.0f, 0.0f, -1.0f}, {0.0f, 0.0f}}, // Bottom-left
		{{-0.5f, -0.5f, -0.5f}, {0.0f, 0.0f, -1.0f}, {1.0f, 0.0f}},// Bottom-right
		{{-0.5f, 0.5f, -0.5f}, {0.0f, 0.0f, -1.0f}, {1.0f, 1.0f}}, // Top-right
		{{0.5f, 0.5f, -0.5f}, {0.0f, 0.0f, -1.0f}, {0.0f, 1.0f}},  // Top-left

		// Left face
		{{-0.5f, -0.5f, -0.5f}, {-1.0f, 0.0f, 0.0f}, {0.0f, 0.0f}}, // Bottom-left
		{{-0.5f, -0.5f, 0.5f}, {-1.0f, 0.0f, 0.0f}, {1.0f, 0.0f}}, // Bottom-right
		{{-0.5f, 0.5f, 0.5f}, {-1.0f, 0.0f, 0.0f}, {1.0f, 1.0f}},  // Top-right
		{{-0.5f, 0.5f, -0.5f}, {-1.0f, 0.0f, 0.0f}, {0.0f, 1.0f}}, // Top-left

		// Right face
		{{0.5f, -0.5f, 0.5f}, {1.0f, 0.0f, 0.0f}, {0.0f, 0.0f}},  // Bottom-left
		{{0.5f, -0.5f, -0.5f}, {1.0f, 0.0f, 0.0f}, {1.0f, 0.0f}}, // Bottom-right
		{{0.5f, 0.5f, -0.5f}, {1.0f, 0.0f, 0.0f}, {1.0f, 1.0f}},  // Top-right
		{{0.5f, 0.5f, 0.5f}, {1.0f, 0.0f, 0.0f}, {0.0f, 1.0f}},   // Top-left

		// Top face
		{{-0.5f, 0.5f, 0.5f}, {0.0f, 1.0f, 0.0f}, {0.0f, 0.0f}},  // Bottom-left
		{{0.5f, 0.5f, 0.5f}, {0.0f, 1.0f, 0.0f}, {1.0f, 0.0f}},   // Bottom-right
		{{0.5f, 0.5f, -0.5f}, {0.0f, 1.0f, 0.0f}, {1.0f, 1.0f}},  // Top-right
		{{-0.5f, 0.5f, -0.5f}, {0.0f, 1.0f, 0.0f}, {0.0f, 1.0f}}, // Top-left

		// Bottom face
		{{-0.5f, -0.5f, -0.5f}, {0.0f, -1.0f, 0.0f}, {0.0f, 0.0f}}, // Bottom-left
		{{0.5f, -0.5f, -0.5f}, {0.0f, -1.0f, 0.0f}, {1.0f, 0.0f}}, // Bottom-right
		{{0.5f, -0.5f, 0.5f}, {0.0f, -1.0f, 0.0f}, {1.0f, 1.0f}},  // Top-right
		{{-0.5f, -0.5f, 0.5f}, {0.0f, -1.0f, 0.0f}, {0.0f, 1.0f}}, // Top-left
	};

	mesh.indexArray = {// Front face
					   0, 1, 2, 2, 3, 0,
					   // Back face
					   4, 5, 6, 6, 7, 4,
					   // Left face
					   8, 9, 10, 10, 11, 8,
					   // Right face
					   12, 13, 14, 14, 15, 12,
					   // Top face
					   16, 17, 18, 18, 19, 16,
					   // Bottom face
					   20, 21, 22, 22, 23, 20 };

	return mesh;
}

// Quad 
MeshObject<Vertex> createQuad()
{
	MeshObject<Vertex> quadMeshCPU;

	quadMeshCPU.vertexArray =
	{
		{ glm::vec3( -0.5, 0 ,  0.5),glm::vec3( 0.0, 0.0, 1.0 ), glm::vec2( 0.0, 0.0 ) },
		{ glm::vec3(  0.5, 0 ,  0.5),glm::vec3( 0.0, 0.0, 1.0 ), glm::vec2( 1.0, 0.0 ) },
		{ glm::vec3( -0.5, 0 , -0.5),glm::vec3( 0.0, 0.0, 1.0 ), glm::vec2( 0.0, 1.0 ) },
		{ glm::vec3(  0.5, 0 , -0.5),glm::vec3( 0.0, 0.0, 1.0 ), glm::vec2( 1.0, 1.0 ) }
	};

	quadMeshCPU.indexArray =
	{
		0, 1, 2,
		1, 3, 2,
		2,3,1,
		2,1,0
	};

	return quadMeshCPU;
}

void CMyApp::InitGeometry()
{
	const std::initializer_list<VertexAttributeDescriptor> vertexAttribList =
	{
		{0, offsetof(Vertex, position), 3, GL_FLOAT},
		{1, offsetof(Vertex, normal), 3, GL_FLOAT},
		{2, offsetof(Vertex, texcoord), 2, GL_FLOAT},
	};

	m_cubeGPU = CreateGLObjectFromMesh(createCube(), vertexAttribList);
	m_quadGPU = CreateGLObjectFromMesh(createQuad(), vertexAttribList);
	m_sphereGPU = CreateGLObjectFromMesh(ObjParser::parse("Assets/Sphere.obj"), vertexAttribList);
}

void CMyApp::CleanGeometry()
{
	CleanOGLObject(m_cubeGPU);
}

void CMyApp::InitTextures()
{
	glCreateSamplers(1, &m_SamplerID);
	glSamplerParameteri(m_SamplerID, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glSamplerParameteri(m_SamplerID, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	glSamplerParameteri(m_SamplerID, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
	glSamplerParameteri(m_SamplerID, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

	glCreateSamplers(1, &m_SamplerNoMipmapID);
	glSamplerParameteri(m_SamplerNoMipmapID, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glSamplerParameteri(m_SamplerNoMipmapID, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	glSamplerParameteri(m_SamplerNoMipmapID, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glSamplerParameteri(m_SamplerNoMipmapID, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

	ImageRGBA image = ImageFromFile("Assets/Color_checkerboard.png");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureID);
	glTextureStorage2D(m_TextureID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	image = ImageFromFile("Assets/earth.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureEarthID);
	glTextureStorage2D(m_TextureEarthID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureEarthID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureEarthID);

	image = ImageFromFile("Assets/jupiter.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureJupiterID);
	glTextureStorage2D(m_TextureJupiterID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureJupiterID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureJupiterID);

	image = ImageFromFile("Assets/mars.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureMarsID);
	glTextureStorage2D(m_TextureMarsID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureMarsID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureMarsID);

	image = ImageFromFile("Assets/mercury.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureMercuryID);
	glTextureStorage2D(m_TextureMercuryID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureMercuryID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureMercuryID);

	image = ImageFromFile("Assets/moon.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureMoonID);
	glTextureStorage2D(m_TextureMoonID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureMoonID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureMoonID);

	image = ImageFromFile("Assets/neptune.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureNeptuneID);
	glTextureStorage2D(m_TextureNeptuneID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureNeptuneID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureNeptuneID);

	image = ImageFromFile("Assets/pluto.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TexturePlutoID);
	glTextureStorage2D(m_TexturePlutoID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TexturePlutoID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TexturePlutoID);

	image = ImageFromFile("Assets/saturn.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureSaturnID);
	glTextureStorage2D(m_TextureSaturnID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureSaturnID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureSaturnID);

	image = ImageFromFile("Assets/sun.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureSunID);
	glTextureStorage2D(m_TextureSunID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureSunID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureSunID);

	image = ImageFromFile("Assets/uranus.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureUranusID);
	glTextureStorage2D(m_TextureUranusID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureUranusID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureUranusID);

	image = ImageFromFile("Assets/venus.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureVenusID);
	glTextureStorage2D(m_TextureVenusID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureVenusID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureVenusID);

	image = ImageFromFile("Assets/kuiper.png");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureKuiperRingID);
	glTextureStorage2D(m_TextureKuiperRingID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureKuiperRingID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureKuiperRingID);

	image = ImageFromFile("Assets/neptune-ring.png");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureNeptuneRingID);
	glTextureStorage2D(m_TextureNeptuneRingID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureNeptuneRingID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureNeptuneRingID);

	image = ImageFromFile("Assets/saturn-ring.png");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureSaturnRingID);
	glTextureStorage2D(m_TextureSaturnRingID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureSaturnRingID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureSaturnRingID);

	image = ImageFromFile("Assets/uranus-ring.png");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureUranusRingID);
	glTextureStorage2D(m_TextureUranusRingID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureUranusRingID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureUranusRingID);

	image = ImageFromFile("Assets/earth-night.jpg");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureEarthNightID);
	glTextureStorage2D(m_TextureEarthNightID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureEarthNightID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureEarthNightID);

	image = ImageFromFile("Assets/earth-spec.png");

	glCreateTextures(GL_TEXTURE_2D, 1, &m_TextureEarthSpecID);
	glTextureStorage2D(m_TextureEarthSpecID, NumberOfMIPLevels(image), GL_RGBA8, image.width, image.height);
	glTextureSubImage2D(m_TextureEarthSpecID, 0, 0, 0, image.width, image.height, GL_RGBA, GL_UNSIGNED_BYTE, image.data());

	glGenerateTextureMipmap(m_TextureEarthSpecID);

}

void CMyApp::CleanTextures()
{
	glDeleteTextures(1, &m_TextureID);
	glDeleteTextures(1, &m_TextureMercuryID);
	glDeleteTextures(1, &m_TextureVenusID);
	glDeleteTextures(1, &m_TextureEarthID);
	glDeleteTextures(1, &m_TextureMarsID);
	glDeleteTextures(1, &m_TextureJupiterID);
	glDeleteTextures(1, &m_TextureSaturnID);
	glDeleteTextures(1, &m_TextureUranusID);
	glDeleteTextures(1, &m_TextureNeptuneID);
	glDeleteTextures(1, &m_TexturePlutoID);
	glDeleteTextures(1, &m_TextureMoonID);
	glDeleteTextures(1, &m_TextureSunID);
	glDeleteTextures(1, &m_TextureKuiperRingID);
	glDeleteTextures(1, &m_TextureSaturnRingID);
	glDeleteTextures(1, &m_TextureUranusRingID);
	glDeleteTextures(1, &m_TextureNeptuneRingID);

	glDeleteTextures(1, &m_TextureEarthNightID);
	glDeleteTextures(1, &m_TextureEarthSpecID);
}

bool CMyApp::Init()
{
	SetupDebugCallback();

	// törlési szín legyen kékes
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);

	InitShaders();
	InitGeometry();
	InitTextures();

	//
	// egyéb inicializálás
	//

	glEnable(GL_CULL_FACE); // kapcsoljuk be a hátrafelé néző lapok eldobását
	glCullFace(GL_BACK);    // GL_BACK: a kamerától "elfelé" néző lapok, GL_FRONT: a kamera felé néző lapok

	glEnable(GL_DEPTH_TEST); // mélységi teszt bekapcsolása (takarás)

	// kamera
	m_camera.SetView(
		glm::vec3(0.0, 5.0, -10.0),  // honnan nézzük a színteret	   - eye
		glm::vec3(0.0, 0.0, 0.0),  // a színtér melyik pontját nézzük - at
		glm::vec3(0.0, 1.0, 0.0)); // felfelé mutató irány a világban - up

	m_cameraManipulator.SetCamera(&m_camera);

	return true;
}

void CMyApp::Clean()
{
	CleanShaders();
	CleanGeometry();
	CleanTextures();
}

static bool HitPlane(const Ray& ray, const glm::vec3& planeQ, const glm::vec3& planeI, const glm::vec3& planeJ, Intersection& result)
{
	// sík parametrikus egyenlete: palneQ + u * planeI + v * planeJ
	glm::mat3 A(-ray.direction, planeI, planeJ);
	glm::vec3 B = ray.origin - planeQ;

	if (fabsf(glm::determinant(A)) < 1e-6) return false;
	glm::vec3 X = glm::inverse(A) * B;

	if (X.x < 0.0) {
		return false;
	}
	result.t = X.x;
	result.uv.x = X.y;
	result.uv.y = X.z;

	return true;
}


static bool HitSphere(const glm::vec3& rayOrigin, const glm::vec3& rayDir, const glm::vec3& sphereCenter, float sphereRadius, float& t)
{
	glm::vec3 p_m_c = rayOrigin - sphereCenter;
	float a = glm::dot(rayDir, rayDir);
	float b = 2.0f * glm::dot(rayDir, p_m_c);
	float c = glm::dot(p_m_c, p_m_c) - sphereRadius * sphereRadius;

	float discriminant = b * b - 4.0f * a * c;

	if (discriminant < 0.0f)
	{
		return false;
	}

	float sqrtDiscriminant = sqrtf(discriminant);

	// Mivel 2*a, es sqrt(D) mindig pozitívak, ezért tudjuk, hogy t0 < t1
	float t0 = (-b - sqrtDiscriminant) / (2.0f * a);
	float t1 = (-b + sqrtDiscriminant) / (2.0f * a);

	if (t1 < 0.0f) // mivel t0 < t1, ha t1 negatív, akkor t0 is az
	{
		return false;
	}

	if (t0 < 0.0f)
	{
		t = t1;
	}
	else
	{
		t = t0;
	}

	return true;
}

Ray CMyApp::CalculatePixelRay(glm::vec2 pixel) const
{
	// NDC koordináták kiszámítása
	glm::vec3 pickedNDC = glm::vec3(
		2.0f * (pixel.x + 0.5f) / m_windowSize.x - 1.0f,
		1.0f - 2.0f * (pixel.y + 0.5f) / m_windowSize.y, 0.0f);

	// A világ koordináták kiszámítása az inverz ViewProj mátrix segítségével
	glm::vec4 pickedWorld = glm::inverse(m_camera.GetViewProj()) * glm::vec4(pickedNDC, 1.0f);
	pickedWorld /= pickedWorld.w; // homogén osztás
	Ray ray;

	// Raycasting kezdőpontja a kamera pozíciója
	ray.origin = m_camera.GetEye();
	// Iránya a kamera pozíciójából a kattintott pont világ koordinátái felé
	// FIGYELEM: NEM egység hosszúságú vektor!
	ray.direction = glm::vec3(pickedWorld) - ray.origin;
	return ray;
}

void CMyApp::Update(const SUpdateInfo& updateInfo)
{
	m_ElapsedTimeInSec = updateInfo.ElapsedTimeInSec;
	if (!stop_time) {
		speed_planet = speed * updateInfo.DeltaTimeInSec * 2;
		planet_time += speed_planet;
	}

	if (m_IsPicking) {
		// a felhasználó Ctrl + kattintott, itt kezeljük le
		// sugár indítása a kattintott pixelen át
		Ray ray = CalculatePixelRay(glm::vec2(m_PickedPixel.x, m_PickedPixel.y));
		
        m_IsPicking = false;
	}

	glProgramUniform1i(m_programID, ul(m_programID, "equator"), equator ? 1 : 0);
	glProgramUniform1f(m_programID, ul(m_programID, "r"), col[0]);
	glProgramUniform1f(m_programID, ul(m_programID, "g"), col[1]);
	glProgramUniform1f(m_programID, ul(m_programID, "b"), col[2]);
	m_cameraManipulator.Update(updateInfo.DeltaTimeInSec);
}

void CMyApp::SetCommonUniforms()
{
	// - Uniform paraméterek

	// view és projekciós mátrix
	glProgramUniformMatrix4fv(m_programID, ul(m_programID, "viewProj"), 1, GL_FALSE, glm::value_ptr(m_camera.GetViewProj()));

	// - Fényforrások beállítása
	glProgramUniform3fv(m_programID, ul(m_programID, "cameraPos"), 1, glm::value_ptr(m_camera.GetEye()));
	//glProgramUniform4fv(m_programID, ul(m_programID, "lightPos"), 1, glm::value_ptr(m_lightPos));
	//
	//glProgramUniform3fv(m_programID, ul(m_programID, "La"), 1, glm::value_ptr(m_La));
	//glProgramUniform3fv(m_programID, ul(m_programID, "Ld"), 1, glm::value_ptr(m_Ld));
	//glProgramUniform3fv(m_programID, ul(m_programID, "Ls"), 1, glm::value_ptr(m_Ls));
	//
	//glProgramUniform1f(m_programID, ul(m_programID, "lightConstantAttenuation"), m_lightConstantAttenuation);
	//glProgramUniform1f(m_programID, ul(m_programID, "lightLinearAttenuation"), m_lightLinearAttenuation);
	//glProgramUniform1f(m_programID, ul(m_programID, "lightQuadraticAttenuation"), m_lightQuadraticAttenuation);
}


void CMyApp::DrawQuad(glm::mat4 world, GLuint texture)
{
	SetCommonUniforms();

	glUseProgram(m_programID);

	glProgramUniformMatrix4fv(m_programID, ul(m_programID, "world"), 1, GL_FALSE, glm::value_ptr(world));
	glProgramUniformMatrix4fv(m_programID, ul(m_programID, "worldIT"), 1, GL_FALSE, glm::value_ptr(glm::transpose(glm::inverse(world))));

	glProgramUniform1i(m_programID, ul(m_programID, "texImage"), 0);

	glBindVertexArray(m_quadGPU.vaoID);

	glBindTextureUnit(0, texture);
	glBindSampler(0, m_SamplerID);

	glDrawElements(GL_TRIANGLES, m_quadGPU.count, GL_UNSIGNED_INT, nullptr);

	glBindTextureUnit(0, 0);
	glBindSampler(0, 0);

	glBindVertexArray(0);
	// shader kikapcsolasa
	glUseProgram(0);
}

void CMyApp::DrawSphere(glm::mat4 world, GLuint texture)
{
	SetCommonUniforms();

	glUseProgram(m_programID);

	glProgramUniformMatrix4fv(m_programID, ul(m_programID, "world"), 1, GL_FALSE, glm::value_ptr(world));
	glProgramUniformMatrix4fv(m_programID, ul(m_programID, "worldIT"), 1, GL_FALSE, glm::value_ptr(glm::transpose(glm::inverse(world))));

	glProgramUniform1i(m_programID, ul(m_programID, "texImage"), 0);

	glBindVertexArray(m_sphereGPU.vaoID);

	glBindTextureUnit(0, texture);
	glBindSampler(0, m_SamplerID);

	glDrawElements(GL_TRIANGLES, m_sphereGPU.count, GL_UNSIGNED_INT, nullptr);

	glBindTextureUnit(0, 0);
	glBindSampler(0, 0);

	glBindVertexArray(0);
	// shader kikapcsolasa
	glUseProgram(0);
}
void CMyApp::DrawEarth(glm::mat4 world)
{
	SetCommonUniforms();

	glUseProgram(m_programID);

	glProgramUniformMatrix4fv(m_programID, ul(m_programID, "world"), 1, GL_FALSE, glm::value_ptr(world));
	glProgramUniformMatrix4fv(m_programID, ul(m_programID, "worldIT"), 1, GL_FALSE, glm::value_ptr(glm::transpose(glm::inverse(world))));

	glProgramUniform1i(m_programID, ul(m_programID, "texImage"), 0);
	glProgramUniform1i(m_programID, ul(m_programID, "waterImage"), 1);
	glProgramUniform1i(m_programID, ul(m_programID, "nightImage"), 2);

	glBindVertexArray(m_sphereGPU.vaoID);

	glBindTextureUnit(0, m_TextureEarthID);
	glBindSampler(0, m_SamplerNoMipmapID);

	glBindTextureUnit(1, m_TextureEarthSpecID);
	glBindSampler(1, m_SamplerNoMipmapID);

	glBindTextureUnit(2, m_TextureEarthNightID);
	glBindSampler(2, m_SamplerNoMipmapID);

	glDrawElements(GL_TRIANGLES, m_sphereGPU.count, GL_UNSIGNED_INT, nullptr);

	glBindTextureUnit(0, 0);
	glBindSampler(0, 0);

	glBindVertexArray(0);
	// shader kikapcsolasa
	glUseProgram(0);
}

void CMyApp::Render()
{
	// töröljük a frampuffert (GL_COLOR_BUFFER_BIT)...
	// ... és a mélységi Z puffert (GL_DEPTH_BUFFER_BIT)
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);


	glProgramUniform1i(m_programID, ul(m_programID, "type"), 2);
	glm::mat4 center = glm::identity<glm::mat4>();
	glm::mat4 sun = center * rotate((float)glm::radians(7.25), glm::vec3(0, 0, -1)) * rotate((float)(planet_time * M_PI / 27), glm::vec3(0, 1, 0)) * scale(glm::vec3{0.5,0.5,0.5});
	DrawSphere(sun, m_TextureSunID);
	glProgramUniform1i(m_programID, ul(m_programID, "type"), 0);
	glm::vec3 keringmercury = glm::vec3(cosf(planet_time * M_PI / 89) * 1, 0, sinf(planet_time * M_PI / 89) * 1);
	glm::mat4 mercury = glm::translate(keringmercury) *
		rotate((float)glm::radians(0.01), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / 58.7), glm::vec3(0, 1, 0)) *
		scale(glm::vec3(0.075f, 0.075f, 0.075f));
	DrawSphere(mercury, m_TextureMercuryID);
	glm::vec3 keringvenus = glm::vec3(cosf(planet_time * M_PI / 243) * 2, 0, sinf(planet_time * M_PI / 243) * 2);
	glm::mat4 venus = glm::translate(keringvenus) *
		rotate((float)glm::radians(177.4), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / 255), glm::vec3(0, 1, 0)) *
		scale(glm::vec3(0.065f, 0.065f, 0.065f));
	DrawSphere(venus, m_TextureVenusID);
	glm::vec3 keringearth = glm::vec3(cosf(planet_time * M_PI / 365) * 3, 0, sinf(planet_time * M_PI / 365) * 3);
	glm::mat4 earth = glm::translate(keringearth) *
		rotate((float)glm::radians(23.44), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / 1), glm::vec3(0, 1, 0)) *
		scale(glm::vec3(0.1f, 0.1f, 0.1f));
	glProgramUniform1i(m_programID, ul(m_programID, "type"), 3);
	DrawEarth(earth);
	glProgramUniform1i(m_programID, ul(m_programID, "type"), 0);
	glm::vec3 keringmars = glm::vec3(cosf(planet_time * M_PI / 687) * 4, 0, sinf(planet_time * M_PI / 687) * 4);
	glm::mat4 mars = glm::translate(keringmars) *
		rotate((float)glm::radians(25.19), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / 1.04), glm::vec3(0, 1, 0)) *
		scale(glm::vec3(0.095f, 0.095f, 0.095f));
	DrawSphere(mars, m_TextureMarsID);
	glm::vec3 keringjupiter = glm::vec3(cosf(planet_time * M_PI / 4329) * 5, 0, sinf(planet_time * M_PI / 4329) * 5);
	glm::mat4 jupiter = glm::translate(keringjupiter) *
		rotate((float)glm::radians(3.13), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / 0.42), glm::vec3(0, 1, 0)) *
		scale(glm::vec3(0.2f, 0.2f, 0.2f));
	DrawSphere(jupiter, m_TextureJupiterID);
	glm::vec3 keringsaturn = glm::vec3(cosf(planet_time * M_PI / 10753) * 6, 0, sinf(planet_time * M_PI / 10753) * 6);
	glm::mat4 saturn = glm::translate(keringsaturn) *
		rotate((float)glm::radians(26.73), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / 0.46), glm::vec3(0, 1, 0)) *
		scale(glm::vec3(0.175f, 0.175f, 0.175f));
	DrawSphere(saturn, m_TextureSaturnID);
	glm::vec3 keringuranus = glm::vec3(cosf(planet_time * M_PI / 30664) * 7, 0, sinf(planet_time * M_PI / 30664) * 7);
	glm::mat4 uranus = glm::translate(keringuranus) *
		rotate((float)glm::radians(97.77), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / 0.71), glm::vec3(0, 1, 0)) *
		scale(glm::vec3(0.125f, 0.125f, 0.125f));
	DrawSphere(uranus, m_TextureUranusID);
	glm::vec3 keringneptune = glm::vec3(cosf(planet_time * M_PI / 60148) * 8, 0, sinf(planet_time * M_PI / 60148) * 8);
	glm::mat4 neptune = glm::translate(keringneptune) *
		rotate((float)glm::radians(28.32), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / 0.67), glm::vec3(0, 1, 0)) *
		scale(glm::vec3(0.13f, 0.13f, 0.13f));
	DrawSphere(neptune, m_TextureNeptuneID);
	glm::vec3 keringpluto = glm::vec3(cosf(planet_time * M_PI / 90520) * 9, 0, sinf(planet_time * M_PI / 90520) * 9);
	glm::mat4 pluto = glm::translate(keringpluto) *
		rotate((float)glm::radians(119.61), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / 6.37), glm::vec3(0, 1, 0)) *
		scale(glm::vec3(0.05f, 0.05f, 0.05f));
	DrawSphere(pluto, m_TexturePlutoID);

	glm::vec3 keringmoon = glm::vec3(cosf(planet_time * M_PI / (365/12)) * 0.2, 0, sinf(planet_time * M_PI / (365 / 12)) * 0.2);
	glm::mat4 moon = glm::translate(keringearth) * glm::translate(keringmoon) *
		rotate((float)glm::radians(1.54), glm::vec3(0, 0, -1)) *
		rotate((float)(planet_time * M_PI / (365/12)), glm::vec3(0, -1, 0)) *
		scale(glm::vec3(0.033f, 0.033f, 0.033f));
	DrawSphere(moon, m_TextureMoonID);

	glProgramUniform1i(m_programID, ul(m_programID, "type"), 1);
	DrawQuad(translate(keringneptune), m_TextureNeptuneRingID);
	DrawQuad(translate(keringuranus), m_TextureUranusRingID);
	DrawQuad(translate(keringsaturn), m_TextureSaturnRingID);
	DrawQuad(translate(glm::vec3{ 0,-0.05,0 }) * scale(glm::vec3{ 24,24,24 }), m_TextureKuiperRingID);
}

void CMyApp::RenderGUI()
{
	//ImGui::ShowDemoWindow();
	if (ImGui::Begin("Szia")) {
		ImGui::Checkbox("equator", &equator);
		ImGui::ColorEdit3("szin", col);
		ImGui::Checkbox("stop time", &stop_time);
		ImGui::SliderFloat("sebesség", &speed, 0.25, 10);
	}
	ImGui::End();
}

// https://wiki.libsdl.org/SDL2/SDL_KeyboardEvent
// https://wiki.libsdl.org/SDL2/SDL_Keysym
// https://wiki.libsdl.org/SDL2/SDL_Keycode
// https://wiki.libsdl.org/SDL2/SDL_Keymod

void CMyApp::KeyboardDown(const SDL_KeyboardEvent& key)
{
	if (key.repeat == 0) // Először lett megnyomva
	{
		if (key.keysym.sym == SDLK_F5 && key.keysym.mod & KMOD_CTRL)
		{
			CleanShaders();
			InitShaders();
		}
		if (key.keysym.sym == SDLK_F1)
		{
			GLint polygonModeFrontAndBack[2] = {};
			// https://registry.khronos.org/OpenGL-Refpages/gl4/html/glGet.xhtml
			glGetIntegerv(GL_POLYGON_MODE, polygonModeFrontAndBack); // Kérdezzük le a jelenlegi polygon módot! Külön adja a front és back módokat.
			GLenum polygonMode = (polygonModeFrontAndBack[0] != GL_FILL ? GL_FILL : GL_LINE); // Váltogassuk FILL és LINE között!
			// https://registry.khronos.org/OpenGL-Refpages/gl4/html/glPolygonMode.xhtml
			glPolygonMode(GL_FRONT_AND_BACK, polygonMode); // Állítsuk be az újat!
		}

		if (key.keysym.sym == SDLK_LCTRL || key.keysym.sym == SDLK_RCTRL)
		{
			m_IsCtrlDown = true;
		}
	}
	m_cameraManipulator.KeyboardDown(key);
}

void CMyApp::KeyboardUp(const SDL_KeyboardEvent& key)
{
	m_cameraManipulator.KeyboardUp(key);
	if (key.keysym.sym == SDLK_LCTRL || key.keysym.sym == SDLK_RCTRL)
	{
		m_IsCtrlDown = false;
	}
}

// https://wiki.libsdl.org/SDL2/SDL_MouseMotionEvent

void CMyApp::MouseMove(const SDL_MouseMotionEvent& mouse)
{
	m_cameraManipulator.MouseMove(mouse);
}

// https://wiki.libsdl.org/SDL2/SDL_MouseButtonEvent

void CMyApp::MouseDown(const SDL_MouseButtonEvent& mouse)
{
	if ( m_IsCtrlDown )
	{
		m_IsPicking = true;
	}
	m_PickedPixel = { mouse.x, mouse.y };
}

void CMyApp::MouseUp(const SDL_MouseButtonEvent& mouse)
{
}

// https://wiki.libsdl.org/SDL2/SDL_MouseWheelEvent

void CMyApp::MouseWheel(const SDL_MouseWheelEvent& wheel)
{
	m_cameraManipulator.MouseWheel(wheel);
}

// a két paraméterben az új ablakméret szélessége (_w) és magassága (_h)
// található
void CMyApp::Resize(int _w, int _h)
{
	glViewport(0, 0, _w, _h);
	m_windowSize = glm::uvec2(_w, _h);
	m_camera.SetAspect(static_cast<float>(_w) / _h);
}

// Le nem kezelt, egzotikus esemény kezelése
// https://wiki.libsdl.org/SDL2/SDL_Event

void CMyApp::OtherEvent(const SDL_Event& ev)
{

}