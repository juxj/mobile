//
//  zprUIButton.cpp
//  ZPR
//
//  Created by Neo01 on 11/2/11.
//  Copyright (c) 2011 Break Media. All rights reserved.
//

#import "zprUIButton.h"

#import "GameState.h"
#import "Canvas2D.h"
#import "Image.h"
#import "neoRes.h"
#import "Utilities.h"

ZprUIButton::ZprUIButton(const char *fileBtnNor, float w, float h, NeoRes* resMgr)
{
    for (int i = 0; i < ZPR_UI_BTN_IMG_MAX; i++)
    {
        _image[i] = NULL;
    }
    
    _isEnabled = true;
    _x = _y = 0.0f;     // anchor: center
    _sx = _sy = 1.0f;   // scale: 1.0f
    _state = ZPR_UI_BTN_NORMAL;
    
    // image clip size
    _w = w;
    _h = h;
	
    // This is the image for the button in the normal state.
    if (fileBtnNor != NULL)
    {
        resMgr->createImage(fileBtnNor, fileBtnNor, 0.0f, 0.0f, _w * IMG_RES_SCALE, _h * IMG_RES_SCALE, 0.0f, 0.0f);
        _image[ZPR_UI_BTN_IMG_NORMAL] = resMgr->getImage(fileBtnNor);
        _image[ZPR_UI_BTN_IMG_NORMAL]->makeCenterAsAnchor();
    }
    
    // Set the type
    if (_image[ZPR_UI_BTN_IMG_DISABLED] == NULL && 
        _image[ZPR_UI_BTN_IMG_PRESSED] == NULL)
    {
        _type = ZPR_UI_BTN_TYPE_1;
    }
    else if (_image[ZPR_UI_BTN_IMG_DISABLED] == NULL)
    {
        _type = ZPR_UI_BTN_TYPE_2;
    }
    else if (_image[ZPR_UI_BTN_IMG_PRESSED] == NULL)
    {
        _type = ZPR_UI_BTN_TYPE_3;
    }
    else
    {
        _type = ZPR_UI_BTN_TYPE_0;
    }
    
    // Set the button area according to the image size of the normal button if the params are 0.
    if (w > 0.0f) _w = w;
    else _w = _image[ZPR_UI_BTN_IMG_NORMAL]->mWidth;
    if (h > 0.0f) _h = h;
    else _h = _image[ZPR_UI_BTN_IMG_NORMAL]->mHeight;
    setBtnRect(_w, _h);
}

ZprUIButton::ZprUIButton(const char *imageName, NeoRes* resMgr)
{
    for (int i = 0; i < ZPR_UI_BTN_IMG_MAX; i++)
    {
        _image[i] = NULL;
    }
    
    _isEnabled = true;
    _x = _y = 0.0f;     // anchor: center
    _sx = _sy = 1.0f;   // scale: 1.0f
    _state = ZPR_UI_BTN_NORMAL;
	
    _image[ZPR_UI_BTN_IMG_NORMAL] = resMgr->getImage(imageName);
    _image[ZPR_UI_BTN_IMG_NORMAL]->makeCenterAsAnchor();
    _w = _image[ZPR_UI_BTN_IMG_NORMAL]->mWidth  / IMG_RES_SCALE;
    _h = _image[ZPR_UI_BTN_IMG_NORMAL]->mHeight/ IMG_RES_SCALE;
    
    _type = ZPR_UI_BTN_TYPE_1;
    
    setBtnRect(_w, _h);
}

ZprUIButton::ZprUIButton(const char *imgBtnNor, const char *imgBtnPre, const char *imgBtnDis, float w, float h, NeoRes* resMgr)
{
    for (int i = 0; i < ZPR_UI_BTN_IMG_MAX; i++)
    {
        _image[i] = NULL;
    }
    
    _isEnabled = true;
    _x = _y = 0.0f;     // anchor: center
    _sx = _sy = 1.0f;   // scale: 1.0f
    _state = ZPR_UI_BTN_NORMAL;
	
    // This is the image for the button in the normal state.
    if (imgBtnNor != NULL)
    {
        _image[ZPR_UI_BTN_IMG_NORMAL] = resMgr->getImage(imgBtnNor);
        _image[ZPR_UI_BTN_IMG_NORMAL]->makeCenterAsAnchor();
    }
    // This is the image for the button in the pressed state.
    if (imgBtnPre != NULL)
    {
        _image[ZPR_UI_BTN_IMG_PRESSED] = resMgr->getImage(imgBtnPre);
        _image[ZPR_UI_BTN_IMG_PRESSED]->makeCenterAsAnchor();
    }
    // This is the image for the button in the disabled state.
    if (imgBtnDis != NULL)
    {
        _image[ZPR_UI_BTN_IMG_DISABLED] = resMgr->getImage(imgBtnDis);
        _image[ZPR_UI_BTN_IMG_DISABLED]->makeCenterAsAnchor();
    }
    
    // Set the type
    if (_image[ZPR_UI_BTN_IMG_DISABLED] == NULL && 
        _image[ZPR_UI_BTN_IMG_PRESSED] == NULL)
    {
        _type = ZPR_UI_BTN_TYPE_1;
    }
    else if (_image[ZPR_UI_BTN_IMG_DISABLED] == NULL)
    {
        _type = ZPR_UI_BTN_TYPE_2;
    }
    else if (_image[ZPR_UI_BTN_IMG_PRESSED] == NULL)
    {
        _type = ZPR_UI_BTN_TYPE_3;
    }
    else
    {
        _type = ZPR_UI_BTN_TYPE_0;
    }
    
    // Set the button area according to the image size of the normal button if the params are 0.
    if (w > 0.0f) _w = w;
    else _w = _image[ZPR_UI_BTN_IMG_NORMAL]->mWidth;
    if (h > 0.0f) _h = h;
    else _h = _image[ZPR_UI_BTN_IMG_NORMAL]->mHeight;
    setBtnRect(_w, _h);
}

//ZprUIButton::ZprUIButton(const char *fileBtnNor, const char *fileBtnPre, const char *fileBtnDis, 
//                         float w, float h, NeoRes* resMgr)
//{
//    for (int i = 0; i < ZPR_UI_BTN_IMG_MAX; i++)
//    {
//        _image[i] = NULL;
//    }
//    
//    _isEnabled = true;
//    _x = _y = 0.0f;     // anchor: center
//    _sx = _sy = 1.0f;   // scale: 1.0f
//    _state = ZPR_UI_BTN_NORMAL;
//    
//    // image clip size
//    _w = w;
//    _h = h;
//	
//    // This is the image for the button in the normal state.
//    if (fileBtnNor != NULL)
//    {
//        resMgr->createImage(fileBtnNor, fileBtnNor, 0.0f, 0.0f, _w * IMG_RES_SCALE, _h * IMG_RES_SCALE, 0.0f, 0.0f);
//        _image[ZPR_UI_BTN_IMG_NORMAL] = resMgr->getImage(fileBtnNor);
//        _image[ZPR_UI_BTN_IMG_NORMAL]->makeCenterAsAnchor();
//    }
//    
//    // This is the image for the button in the pressed state.
//    if (fileBtnPre != NULL)
//    {
//        resMgr->createImage(fileBtnPre, fileBtnPre, 0.0f, 0.0f, _w * IMG_RES_SCALE, _h * IMG_RES_SCALE, 0.0f, 0.0f);
//        _image[ZPR_UI_BTN_IMG_PRESSED] = resMgr->getImage(fileBtnPre);
//        _image[ZPR_UI_BTN_IMG_PRESSED]->makeCenterAsAnchor();
//    }
//    
//    // This is the image for the button in the disabled state.
//    if (fileBtnDis != NULL)
//    {
//        resMgr->createImage(fileBtnDis, fileBtnDis, 0.0f, 0.0f, _w * IMG_RES_SCALE, _h * IMG_RES_SCALE, 0.0f, 0.0f);
//        _image[ZPR_UI_BTN_IMG_DISABLED] = resMgr->getImage(fileBtnDis);
//        _image[ZPR_UI_BTN_IMG_DISABLED]->makeCenterAsAnchor();
//    }
//    
//    // Set the type
//    if (_image[ZPR_UI_BTN_IMG_DISABLED] == NULL && 
//        _image[ZPR_UI_BTN_IMG_PRESSED] == NULL)
//    {
//        _type = ZPR_UI_BTN_TYPE_1;
//    }
//    else if (_image[ZPR_UI_BTN_IMG_DISABLED] == NULL)
//    {
//        _type = ZPR_UI_BTN_TYPE_2;
//    }
//    else if (_image[ZPR_UI_BTN_IMG_PRESSED] == NULL)
//    {
//        _type = ZPR_UI_BTN_TYPE_3;
//    }
//    else
//    {
//        _type = ZPR_UI_BTN_TYPE_0;
//    }
//    
//    // Set the button area according to the image size of the normal button if the params are 0.
//    if (w > 0.0f) _w = w;
//    else _w = _image[ZPR_UI_BTN_IMG_NORMAL]->mWidth;
//    if (h > 0.0f) _h = h;
//    else _h = _image[ZPR_UI_BTN_IMG_NORMAL]->mHeight;
//    setBtnRect(_w, _h);
//}

ZprUIButton::~ZprUIButton()
{
    for (int i = 0; i < ZPR_UI_BTN_IMG_MAX; i++)
    {
        _image[i] = NULL;
    }
}

void ZprUIButton::setBtnPos(float dx, float dy)
{
    _x = dx;
    _y = dy;
    setBtnRect(_w, _h);
}



void ZprUIButton::setBtnRect(float width, float height)
{
    _aw = width;
    _ah = height;
    _ax0 = _x - 0.5f * _aw;
    _ay0 = _y - 0.5f * _ah;
    _ax1 = _ax0 + _aw;
    _ay1 = _ay0 + _ah;
}

void ZprUIButton::setBtnRect(float x,float y,float width,float height){
    _ax0 = x;
    _ay0=y;
    _aw = width;
    _ah= height;
    _ax1 = _ax0+width;
    _ay1 = _ay0+height;
}

int  ZprUIButton::getButtonState()
{
    return _state;
}

void ZprUIButton::setButtonState(int btnState)
{
    _state = btnState;
}

void ZprUIButton::update()
{
}

void ZprUIButton::render(float ox, float oy)
{
    Canvas2D* canvas = Canvas2D::getInstance();
    if (_type == ZPR_UI_BTN_TYPE_0)
    {
        if (_state == ZPR_UI_BTN_PRESSED || _state == ZPR_UI_BTN_HOLDED)
        {
            _sx = _sy = 0.8f;
            if (_isEnabled)
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_PRESSED], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
            else
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_DISABLED], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
        else
        {
            _sx = _sy = 1.0f;
            if (_isEnabled)
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_NORMAL], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
            else
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_DISABLED], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
    }
    else if (_type == ZPR_UI_BTN_TYPE_1)
    {
        if (_state == ZPR_UI_BTN_PRESSED || _state == ZPR_UI_BTN_HOLDED)
        {
            _sx = _sy = 0.8f;
            canvas->drawImage(_image[ZPR_UI_BTN_IMG_NORMAL], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
        else
        {
            _sx = _sy = 1.0f;
            canvas->drawImage(_image[ZPR_UI_BTN_IMG_NORMAL], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
    }
    else if (_type == ZPR_UI_BTN_TYPE_2)
    {
        if (_state == ZPR_UI_BTN_PRESSED || _state == ZPR_UI_BTN_HOLDED)
        {
            _sx = _sy = 1.0f;
            canvas->drawImage(_image[ZPR_UI_BTN_IMG_PRESSED], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
        else
        {
            _sx = _sy = 1.0f;
            canvas->drawImage(_image[ZPR_UI_BTN_IMG_NORMAL], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
    }
    else if (_type == ZPR_UI_BTN_TYPE_3)
    {
        if (_state == ZPR_UI_BTN_PRESSED || _state == ZPR_UI_BTN_HOLDED)
        {
            _sx = _sy = 0.8f;
            if (_isEnabled)
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_NORMAL], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
            else
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_DISABLED], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
        else
        {
            _sx = _sy = 1.0f;
            if (_isEnabled)
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_NORMAL], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
            else
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_DISABLED], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
    } else if (_type == ZPR_UI_BTN_TYPE_4)
    {
        if (_state == ZPR_UI_BTN_PRESSED || _state == ZPR_UI_BTN_HOLDED)
        {
            _sx = _sy = 1.5f;
            if (_isEnabled)
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_NORMAL], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
            else
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_DISABLED], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
        else
        {
            _sx = _sy = 1.2f;
            if (_isEnabled)
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_NORMAL], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
            else
                canvas->drawImage(_image[ZPR_UI_BTN_IMG_DISABLED], (ox+_x), (oy+_y), 0.0f, _sx, _sy);
        }
    }


    
#ifdef DEBUG
    canvas->strokeRect(_ax0, _ay0,_aw,_ah);
#endif
}

bool ZprUIButton::onTouch(int state, float x, float y/*, float px, float py*/)
{
    bool ret = false;
    if (state == 1)
    {
        if (x > _ax0 && x < _ax1 && 
            y > _ay0 && y < _ay1)
        {
            _state = ZPR_UI_BTN_PRESSED;
            _tx = x;
            _ty = y;
            ret = true;
#ifdef DEBUG
            printf("The key is pressed.\n");
#endif
        }
    }
    else if (state == 2)
    {
        if (x > _ax0 && x < _ax1 && 
            y > _ay0 && y < _ay1 && 
            _tx > _ax0 && _tx < _ax1 && 
            _ty > _ay0 && _ty < _ay1)
        {
            _state = ZPR_UI_BTN_HOLDED;
            ret = true;
#ifdef DEBUG
            printf("The key is still pressed.\n");
#endif
        }
        else
        {
            _state = ZPR_UI_BTN_NORMAL;
        }
    }
    else if (state == 3)
    {
        if (x > _ax0 && x < _ax1 && 
            y > _ay0 && y < _ay1 && 
            _tx > _ax0 && _tx < _ax1 && 
            _ty > _ay0 && _ty < _ay1)
        {
            ret = true;
#ifdef DEBUG
            printf("The key is released.\n");
#endif
        }
        _state = ZPR_UI_BTN_RELEASED;
        _tx = -1.0f;
        _ty = -1.0f;
    }
    return ret;
}
