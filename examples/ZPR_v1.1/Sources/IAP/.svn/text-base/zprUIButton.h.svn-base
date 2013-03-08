//
//  zprUIButton.h
//  ZPR
//
//  Created by Neo01 on 11/2/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#ifndef __ZPR_UI_BUTTON_H__
#define __ZPR_UI_BUTTON_H__

#define ZPR_UI_BTN_NORMAL   0
#define ZPR_UI_BTN_PRESSED  1
#define ZPR_UI_BTN_HOLDED   2
#define ZPR_UI_BTN_RELEASED 3
#define ZPR_UI_BTN_DISABLED 4

#define ZPR_UI_BTN_IMG_NORMAL   0
#define ZPR_UI_BTN_IMG_PRESSED  1
#define ZPR_UI_BTN_IMG_DISABLED 2
#define ZPR_UI_BTN_IMG_MAX      3

#define ZPR_UI_BTN_TYPE_0       0
#define ZPR_UI_BTN_TYPE_1       1   // only normal btn image
#define ZPR_UI_BTN_TYPE_2       2   // no disabled btn image
#define ZPR_UI_BTN_TYPE_3       3   // no pressed btn image
#define ZPR_UI_BTN_TYPE_4       4   // bigger pressed btn image

#import "GameState.h"
#include <string>
class Image;
class NeoRes;

class ZprUIButton
{
public:
    ZprUIButton(const char *fileBtnNor, float w = 0.0f, float h = 0.0f, NeoRes* resMgr = g_MenuResMgr);
    ZprUIButton(const char *imageName, NeoRes* resMgr = g_MenuResMgr);
    ZprUIButton(const char *imgBtnNor, const char *imgBtnPre, const char *imgBtnDis, float w, float h, NeoRes* resMgr = g_MenuResMgr);
    ~ZprUIButton();
    
    void setBtnPos(float dx, float dy);
    void setBtnRect(float width, float height);
    void setBtnRect(float x,float y,float width,float height);
    int  getButtonState();
    void setButtonState(int btnState);
    
    void update();
    void render(float ox = 0.0f, float oy = 0.0f);
    bool onTouch(int state, float x, float y/*, float px, float py*/);
    
    Image *_image[ZPR_UI_BTN_IMG_MAX];
    
    float _x, _y;   // anchor: center
    float _w, _h;
    
    float _ax0, _ay0;
    float _ax1, _ay1;
    float _aw, _ah;
    
    float _tx, _ty; // touch start point
    
    float _sx, _sy;  // scale
    
    int   _state;

    int   _type;
    bool  _isEnabled;


};

#endif  //__ZPR_UI_BUTTON_H__
