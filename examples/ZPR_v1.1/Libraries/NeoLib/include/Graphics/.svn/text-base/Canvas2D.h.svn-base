/*
 *  Canvas2D.h
 *
 *  Created by Neo01 on 5/30/2011.
 *
 */

#ifndef __CANVAS_2D_H__
#define __CANVAS_2D_H__

// HTML5 Canvas2D Ref. http://dev.w3.org/html5/canvas-api/canvas-2d-api.html

#import <OpenGLES/ES1/gl.h>

#define MAX_VERTEX_BUFFER 2048

#define CANVAS_SCALE	1.0f

class Texture;
class Image;

//namespace neolib {

	class Canvas2D {
	public:
		enum ScreenOrientation
		{
			ORIENTATION_NORMAL,			// Normal orientation (Default).
			ORIENTATION_LEFT,			// Rotated left.
			ORIENTATION_RIGHT,			// Rotated right.
			ORIENTATION_UPSIDE_DOWN,	// Upside down.
		};
		
		// constructor & destructor
		Canvas2D();
		~Canvas2D();
		
		// canvas2d instance
		static Canvas2D* getInstance();
		static void destroy();
		
		// setting screen parameters
		void setOrientation(int orientation);
		int  getOrientation();
		
		void setCanvasWidthAndHeight(float width, float height);
		
		float getCanvasWidth();
		float getCanvasHeight();
		
		void  setCanvasScale(float scaleX, float scaleY);
//		void  setRetinaCanvas(bool isRetina);
//		float getCanvasScaleX();
//		float getCanvasScaleY();
		
		void reset();
		
		void RenderBegin();
		void RenderEnd();
		
		void SwitchTo2D();
		
		// state
		void restore();	// pop state stack and restore state
		void save();	// push state on state stack
		
		// transformations (default transform is the identity matrix)
		void rotate(float angle);
		void scale(float x, float y);
		void setTransform(float m11, float m12, float m21, float m22, float dx, float dy);
		void transform(float m11, float m12, float m21, float m22, float dx, float dy);
		void translate(float x, float y);
        
		// compositing
		float globalAlpha;				// (default 1.0)
		int globalCompositeOperation;	// (default source-over)
        
		// colors and styles
		int fillStyle;		// (default black)
		int strokeStyle;	// (default black)
		void setColor(float r, float g, float b, float a);
		
		// clipping rectangle
		void setClip(int x, int y, int width, int height);
		void clearClip();
		
		// rects
		void clearRect(float x, float y, float w, float h);
		void fillRect(float x, float y, float w, float h);
		void strokeRect(float x, float y, float w, float h, float anchorX = 0.0f, float anchorY = 0.0f, float angle = 0.0f, float scaleX = 1.0f, float scaleY = 1.0f);
		
		// drawing images
		void flush();
		void bindTexture(Texture* texture);
		void drawImage(Image* image, float xo, float yo, float angle = 0.0f, float xScale = 1.0f, float yScale = 1.0f);
		void drawQuadImage(Image* quad, float xo, float yo, const float* quadp, const float* uvsp, float angle = 0.0f, float xScale = 1.0f, float yScale = 1.0f);
		void enableColorPointer(bool flag);
		
		// loading textures
		Texture* loadTexture(const char *filename, const char *directory = 0, int rootDirectory = 0);
		
	protected:
		void StartUp();
		void ShutDown();
		
	private:
		static Canvas2D* mInstance;
		
		GLuint mCurrentTexture;
		bool   mLinearFiltering;
		bool   mUseColorPointer;
	
	public:
		float  mScreenWidth;
		float  mScreenHeight;
		float  mAspect;
		int    mOrientation;
		
		float _canvasWidth;
		float _canvasHeight;
		
		float _canvasScaleX;
		float _canvasScaleY;
//		int   _retinaCanvas;
		
#ifdef DEBUG
#endif
	};

//} //namespace neolib

#endif//__CANVAS_2D_H__