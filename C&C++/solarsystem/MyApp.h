#pragma once

// GLM
#include <glm/glm.hpp>
#include <glm/gtc/type_ptr.hpp>
#include <glm/gtx/transform.hpp>

// GLEW
#include <GL/glew.h>

// SDL
#include <SDL2/SDL.h>
#include <SDL2/SDL_opengl.h>

// Utils
#include "Camera.h"
#include "CameraManipulator.h"
#include "GLUtils.hpp"

struct SUpdateInfo
{
	float ElapsedTimeInSec = 0.0f; // Program indulása óta eltelt idő
	float DeltaTimeInSec = 0.0f;   // Előző Update óta eltelt idő
};

struct PlanetData
{
	GLuint img;
	float size;
	float dist;
	float doles;
	float fordul;
	float kering;
};

struct Ray
{
	glm::vec3 origin;
	glm::vec3 direction;
};

struct Intersection
{
	glm::vec2 uv;
	float t;
};

class CMyApp
{
public:
	CMyApp();
	~CMyApp();

	bool Init();
	void Clean();

	void Update(const SUpdateInfo&);
	void DrawQuad(glm::mat4 world, GLuint texture);
	void DrawSphere(glm::mat4 world, GLuint texture);
	void DrawEarth(glm::mat4 world);
	void Render();
	void RenderGUI();

	void KeyboardDown(const SDL_KeyboardEvent&);
	void KeyboardUp(const SDL_KeyboardEvent&);
	void MouseMove(const SDL_MouseMotionEvent&);
	void MouseDown(const SDL_MouseButtonEvent&);
	void MouseUp(const SDL_MouseButtonEvent&);
	void MouseWheel(const SDL_MouseWheelEvent&);
	void Resize(int, int);

	void OtherEvent(const SDL_Event&);

protected:
	void SetupDebugCallback();

	//
	// Adat változók
	//

	float m_ElapsedTimeInSec = 0.0f;

	// Picking

	glm::ivec2 m_PickedPixel = glm::ivec2( 0, 0 );
	bool m_IsPicking = false;
	bool m_IsCtrlDown = false;

	glm::uvec2 m_windowSize = glm::uvec2(0, 0);

	Ray CalculatePixelRay(glm::vec2 pickerPos) const;


	// Kamera
	Camera m_camera;
	CameraManipulator m_cameraManipulator;

	//
	// OpenGL-es dolgok
	//

	// shaderekhez szükséges változók
	GLuint m_programID = 0; // shaderek programja

	// Shaderek inicializálása, és törlése
	void InitShaders();
	void CleanShaders();

	// Geometriával kapcsolatos változók

	void SetCommonUniforms();

	OGLObject m_cubeGPU = {};
	OGLObject m_quadGPU = {};
	OGLObject m_sphereGPU = {};

	// Geometria inicializálása, és törlése
	void InitGeometry();
	void CleanGeometry();

	// Textúrázás, és változói
	GLuint m_SamplerID = 0;
	GLuint m_SamplerNoMipmapID = 0;

	GLuint m_TextureID = 0;

	GLuint m_TextureSunID = 0;

	GLuint m_TextureMercuryID = 0;
	GLuint m_TextureVenusID = 0;
	GLuint m_TextureEarthID = 0;
	GLuint m_TextureMoonID = 0;
	GLuint m_TextureMarsID = 0;
	GLuint m_TextureJupiterID = 0;
	GLuint m_TextureSaturnID = 0;
	GLuint m_TextureUranusID = 0;
	GLuint m_TextureNeptuneID = 0;
	GLuint m_TexturePlutoID = 0;

	GLuint m_TextureKuiperRingID = 0;
	GLuint m_TextureUranusRingID = 0;
	GLuint m_TextureSaturnRingID = 0;
	GLuint m_TextureNeptuneRingID = 0;

	GLuint m_TextureEarthNightID = 0;
	GLuint m_TextureEarthSpecID = 0;

	struct PlanetData sun = { .img = m_TextureSunID, .size = 1.0, .dist = 1.0, .doles = 1.0, .fordul = 1.0, .kering = 1.0 };

	void InitTextures();
	void CleanTextures();

	//imgui
	float col[3] = { 1.0f, 0.0f, 0.2f };
	bool equator = false;
	bool stop_time = false;
	float speed = 1;
	float speed_planet = 1;
	float planet_time = 0;
};
