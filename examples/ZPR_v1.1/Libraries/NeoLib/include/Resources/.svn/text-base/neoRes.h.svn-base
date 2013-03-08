/*
 *  neoRes.h
 *  MonsterWar
 *
 *  Created by Neo01 on 5/30/2011.
 *
 */

//#ifndef __NEO_RES_H__
//#define __NEO_RES_H__

#include <vector>
#include <map>
#include <string>

using namespace std;

//namespace neolib {

	#define INVALID_ID				-1

//	class Res
//	{
//	public:
//		Res(): _refCount(1) {}
//		virtual ~Res() {};
//		
//		void addRef() {
//			++_refCount;
//		}
//		void release() {
//			--_refCount;
//			if (_refCount == 0) delete this;
//		}
//		
//	private:
//		int _refCount;
//	};

	class Texture;
	class Image;
	class Sprite;

	class NeoRes
	{
	public:
//		static NeoRes* getInstance();
//		static void destroy();
		
		int  loadRes(const char* resName, const char* directory = NULL, float scale = 1.0f, int rootDirectory = 0);
		void unloadRes();
		
		int createSprite(Sprite* sprite, const char* resName, const char* directory = NULL, float scaleX = 1.0f, float scaleY = 1.0f, int rootDirectory = 0);
		
		int createTexture(const char* textureName, const char* directory = NULL, int rootDirectory = 0);
		Texture* getTexture(const char* textureName);
		Texture* getTexture(int id);
		
		int createImage(const char* imageName, const char* textureName, float x, float y, float width, float height, float xOffset, float yOffset, int rootDirectory = 0);
		Image* getImage(const char* imageName);
		Image* getImage(int imageId);
		
public://	protected:
		NeoRes();
		~NeoRes();
		
	private:
//		static NeoRes *mInstance;
		
		vector<Texture *> mTextureList;
		map<string, int> mTextureMap;
		
		vector<Image *> mImageList;
		map<string, int> mImageMap;
	};

//} //namespace neolib

//#endif//__NEO_RES_H__
