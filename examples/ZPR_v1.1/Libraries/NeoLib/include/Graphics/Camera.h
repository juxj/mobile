/*
 *  Camera.h
 *  NeoFramework
 *
 *  Created by Neo01 on 7/11/11.
 *
 */

#ifndef __CAMERA_H__
#define __CAMERA_H__

class Canvas2D;

class Camera {
public:
	Camera();
	~Camera();
	
	void reset();
	void update(float dt);
	
//	void setCamera(float lookatX, float lookatY, float scale);
	void setCamera(float transX, float transY, float scaleX = 1.0f, float scaleY = 1.0f);
	
	void setGameFPS(float fps);
	void moveCameraTo(float x, float y, float scaleX = 1.0f, float scaleY = 1.0f, float time = 1000.0f);
	void moveCameraTo(float x, float y, float scaleX = 1.0f, float scaleY = 1.0f, int frames = 30);
	void restore();
//	void getLookat(float& x, float& y);
	float getTransX();
	float getTransY();
	float getScaleX();
	float getScaleY();
	
	static Camera* getInstance();
	void destroy();
	
private:
	static Camera* mInstance;
	
//	float _lookatX;
//	float _lookatY;
//	float _scaleX;
//	float _scaleY;
	float transX;
	float transY;
	float scaleX;
	float scaleY;
	
	float mTimer;
	float timeCount;
	float timeCount0;
	int   frameCount;
	int   step;
	float currentX;
	float currentY;
	float delta;
	float gFPS;
};

#endif //__CAMERA_H__
