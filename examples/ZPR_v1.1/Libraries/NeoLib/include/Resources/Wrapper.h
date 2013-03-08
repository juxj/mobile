//
//  Wrapper.h
//
//  Created by Neo01 on 5/30/2011.
//

//namespace neolib {

#define READ_DIR_BUNDLE		0
#define READ_DIR_DOCUMENT	1

class Texture;

int getUiUserInterfaceIdiom();

const char* GetPath(const char *filename, const char *directory = 0);
const char* GetDocPath(const char *filename, const char *directory = 0);
Texture* CreateTexture(const char *filename, bool isFullpath = false);
Texture* FontTextureCreate(float w, float h, float size, float *charWidths, float *actualHeight);

extern char gStr[32];
const char* genFrameName(const char* src, int num);

bool getMem(double & free2, double & total2);
//} //namespace neolib
