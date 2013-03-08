/*
 *  Sprite.h
 *
 *  Created by Neo01 on 5/30/2011.
 *
 */

#ifndef __SPRITE_H__
#define __SPRITE_H__

// When making the DEBUG build, 
// these variables should be useful.
// 1. dbgDrawFrame = true;
//    There'll be a frame(rectangle) around the sprite.
// 2. dbgDrawInfo = true;
//    Show id, name, position and others beside the sprite.

#include <vector>

#define DEFAULT_DURATION 0.1f

class Image;
class Canvas2D;

using namespace std;

// Frame
// 4*4bytes=16bytes, 128bits
struct Frame
{
//	vector<Image*> mImages;
	Image *mImage;
	float mDuration;
	float xOffset;
	float yOffset;
};

// Action
// 
struct Action
{
	int   mType;
	int   mFrameS;
	int   mFrameC;
	int   mFrameL;
	float mDuration;
};

//struct Animation {
//	int   mType;
//	int   mFrameBegin;
//	int   mFrameEnd;
//	float mDuration;
//};

class Sprite
{
public:
	enum ANIMATION_TYPE
	{
		ANIMATION_TYPE_LOOPING,			// Repeat playing (Default).
		ANIMATION_TYPE_ONCE_AND_STAY,	// Play to the end and stay at last frame
		ANIMATION_TYPE_ONCE_AND_BACK,	// Play to the end and then stay at first frame.
		ANIMATION_TYPE_ONCE_AND_GONE,	// Play animation once only.
		ANIMATION_TYPE_PINGPONG,		// Play forward then backward and repeat.
		ANIMATION_TYPE_MIX_1_PLUS_LOOP	// Play the starter and loop the rest.
	};
	
	// constructor & destructor
	Sprite();
	~Sprite();
	
	void addRef();
	void release();
	
	Sprite(Sprite &sprite);
	
	// update/render
	void update(float dt);
	void render();
	void render(float x, float y, float angle = 0.0f, float xScale = 1.0f, float yScale = 1.0f);
	void render(float x, float y, float r, float g, float b, float a, float angle = 0.0f, float xScale = 1.0f, float yScale = 1.0f);
	
	// get/set animition type
	int  getAnimationType();
	void setAnimationType(int type);
	
	// is/set active
	void setActive(bool f);
	bool isActive();
	
	// get/set id
	int  getId();
	void setId(int id);
	
	// set flipping
	void setFlip(bool flip, int index = -1);
	
	// add/remove frames
	int  getFrameCount();
	void addFrame(Image *frame, float duration = DEFAULT_DURATION, float xOffset = 0, float yOffset = 0, bool flipped = false, int anchorType = 0, float anchorOffsetX = 0.0f, float anchorOffsetY = 0.0f);
//	void addFrame(int frameIndex, Image *frame, float duration = DEFAULT_DURATION, float xOffset = 0, float yOffset = 0, bool flipped = false);
	void removeFrames();
	
	// set duration
	void setDuration(int frame, float duration);
	
	// get/set frame index
	int  getCurrentFrameIndex();
	void setCurrentFrameIndex(int frame);
	
	// get frame
	Image* getCurrentFrame();
	Image* getFrame(int index);
	
	// start/stop animation
	bool isAnimating();
	void startAnimation();
	void stopAnimation();
	void restartAnimation();
	
	// positioning
	void move(float dx, float dy);
	void setPosition(float x, float y);
	float getX();
	float getY();
	void setX(float x);
	void setY(float y);
	
	// set action
	void addAction(int aid, int type, int fs, int fc, float duration);
	void addAction(int aid, int type, int fs, int fc, int fl, float duration);
	void removeActions();
	int  getCurrentAction();
	void setCurrentAction(int aid);
	int  getCurrentActionStart();
	void setCurrentActionStart(int fidx);
	int  getCurrentActionFrameCount();
	void setCurrentActionFrameCount(int fcnt);
	void startAction();
	void stopAction();
	void restartAction();
	bool isLastMoveInAction();
	
	void setFrameAnchor(float x, float y);
	
	// simple collosion
	void setAABBBox(float dx, float dy, float dw, float dh);
	bool isHit(float px, float py);
	float mBx, mBy, mBw, mBh;
	
private:
	int   mId;
	bool  mActive;
	float mX;
	float mY;
	
	static Canvas2D* canvas;
	
	float mTimer;
	
	int   mAnimationType;
	int   mDelta;
	
	int   mFrameStart;
	int   mFrameCount;
	int   mCurrentFrame;
	int   mFrameLoopPoint;
	
	int   _refCnt;
	
public:
	vector<Frame> mFrames;
//	map<string, Animation> mAnimations;
	
	int   mActionCount;
	int   mCurrentAction;
public:
	vector<Action> mActions;
	
	
	bool  mAnimating;
	
#ifdef DEBUG
public:
	bool dbgDrawFrame;
	bool dbgDrawInfo;
#endif
};

#endif
