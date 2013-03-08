/*
 *  Background.cpp
 *  Zombie Dash
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "Background.h"
#include "ObjLayer.h"

#include "Wrapper.h"
#include "neoRes.h"
#include "Image.h"
#include "tinyxml.h"

#import "GameState.h"
#import "Stage.h"

Background::Background()
{
	width = 0;
	height = 0;
	tileWidth = 0;
	tileHeight = 0;
	nLayer = 0;
	
	mBaseX = 0.0f;
	mBaseY = 0.0f;
	mLoopNum = DEFAULT_LOOP_NUM;
	length = DEFAULT_SCREEN_WIDTH;
//	mVelocityX = 0.0f;
}

//Background::Background(float length, float velocity)
//{
//	mBaseX = 0.0f;
//	mBaseY = 0.0f;
//	mLoopNum = DEFAULT_LOOP_NUM;
//	mLength = length;
//	mVelocityX = velocity;
//	
//	mLoopNum = 1;
//	if (mLength <= DEFAULT_SCREEN_WIDTH) {
//		while (mLength * mLoopNum <= DEFAULT_SCREEN_WIDTH) {
//			++mLoopNum;
//		}
//	}
//}

Background::~Background()
{
	nLayer = 0;
	
	for(int i = 0; i < layers.size(); i++)
	{
        delete layers[i];
		layers[i] = NULL;
	}
	layers.clear();
	
	params.clear();
	
	//layers.clear();
	imageMap.clear();
}

bool Background::loadData(const char *resName, const char *directory, int rootDirectory)
{
    const char *path = (rootDirectory == READ_DIR_BUNDLE)?GetPath(resName, directory):GetDocPath(resName, directory);
	
	int tbTileIdx = 0;
	float bgTile[8];
	
	TiXmlDocument doc(path);
	if (!doc.LoadFile())
		return false;
	
//	NeoRes* neoRes = NeoRes::getInstance();
	
	TiXmlNode* _map = 0;
	TiXmlNode* node = 0;
	TiXmlNode* group = 0;
	TiXmlElement* element = 0;
	int iValue = 0;
	float fValue = 0.0f;
	
	_map = doc.FirstChild("map");
	if (!_map)
		return false;
	
	// fill the block info.
	element = _map->ToElement();
	if (element->QueryIntAttribute("width", &iValue) == TIXML_SUCCESS)
		width = iValue;
	if (element->QueryIntAttribute("height", &iValue) == TIXML_SUCCESS)
		height = iValue;
	if (element->QueryIntAttribute("tilewidth", &iValue) == TIXML_SUCCESS)
		tileWidth = iValue;
	if (element->QueryIntAttribute("tileheight", &iValue) == TIXML_SUCCESS)
		tileHeight = iValue;
	
	bgTile[tbTileIdx] = tileWidth;
	++tbTileIdx;
	bgTile[tbTileIdx] = tileHeight;
	++tbTileIdx;
	
	// "tileset"
	for (group = _map->FirstChild("tileset"); group; group = group->NextSibling("tileset"))
	{
		element = group->ToElement();
		int _firstgid = 0;
		int _tileWidth = 1;     // no 0
		int _tileHeight = 1;    // no 0
		const char *_name;
		if (element != NULL)
		{
			_name = element->Attribute("name");
			
			if (element->QueryIntAttribute("firstgid", &iValue) == TIXML_SUCCESS)
				_firstgid = iValue;
			if (element->QueryIntAttribute("tilewidth", &iValue) == TIXML_SUCCESS)
				_tileWidth = iValue;
			if (element->QueryIntAttribute("tileheight", &iValue) == TIXML_SUCCESS)
				_tileHeight = iValue;
			
			bgTile[tbTileIdx] = _tileWidth;
			++tbTileIdx;
			bgTile[tbTileIdx] = _tileHeight;
			++tbTileIdx;
		}
		// "image"
		for (node = group->FirstChild(); node; node = node->NextSibling())
		{
			element = node->ToElement();
			if (element != NULL)
			{
				const char *_source = element->Attribute("source");
				
				// texture full size
				int _width = 0;
				int _height = 0;
				if (element->QueryIntAttribute("width", &iValue) == TIXML_SUCCESS)
					_width = iValue;
				if (element->QueryIntAttribute("height", &iValue) == TIXML_SUCCESS)
					_height = iValue;
				
				// make tiles
				int col = _width / _tileWidth;
				int row = _height / _tileHeight;
				int cnt = row * col;
				
				int _x = 0;
				int _y = 0;
#ifndef VERSION_IPAD
				float offsetX = 0.0f;
				float offsetY = 0.0f;
#endif
				for (int i = 0; i < cnt; i++)
				{
					_x = _tileWidth * (i % col);
					_y = _tileHeight * (i / col);
					
					// create image
					map<int, int>::iterator itr = imageMap.find((_firstgid + i));
					if (itr == imageMap.end())
					{
//						int imageId = g_GcResMgr->createImage(genFrameName(_name, (_firstgid + i)), _source, 
//														  _x * IMG_RES_SCALE, _y * IMG_RES_SCALE, _tileWidth * IMG_RES_SCALE, _tileHeight * IMG_RES_SCALE, offsetX * IMG_RES_SCALE, offsetY * IMG_RES_SCALE);
#ifdef VERSION_IPAD
						int imageId = g_GcResMgr->createImage(genFrameName(_name, (_firstgid + i)), _source, 
										0.0f, 0.0f, 512.0f, 512.0f, 0.0f, 0.0f);
#else
                        int imageId = g_GcResMgr->createImage(genFrameName(_name, (_firstgid + i)), _source, 
                                                              _x * IMG_RES_SCALE, _y * IMG_RES_SCALE, 
                                                              _tileWidth * IMG_RES_SCALE, _tileHeight * IMG_RES_SCALE, 
                                                              offsetX * IMG_RES_SCALE, offsetY * IMG_RES_SCALE);
#endif
						imageMap[(_firstgid + i)] = imageId;
						
//						printf("create image %d (%d).\n", (_firstgid + i), imageId);
					}
					else
					{
//						printf("image %d (%d) exists.\n", (_firstgid + i), itr->second);
					}
				}
			}
		}
		
//		printf("one tile set.\n");
	}
	
	// "objectgroup" -> Layer
	for (group = _map->FirstChild("objectgroup"); group; group = group->NextSibling("objectgroup"))
	{
		element = group->ToElement();
		ObjLayer* layer = 0;
		if (element != NULL)
		{
			//			const char *_name = element->Attribute("name");
			int _width = 0;
			int _height = 0;
			if (element->QueryIntAttribute("width", &iValue) == TIXML_SUCCESS)
				_width = iValue;
			if (element->QueryIntAttribute("height", &iValue) == TIXML_SUCCESS)
				_height = iValue;
			
			// create a layer
			layer = new ObjLayer(LAYER_BG+nLayer, 
								 bgTile[2+2*nLayer], 
								 bgTile[3+2*nLayer], 
								 0);
//			layer = new ObjLayer(nLayer, 
//								 g_GcResMgr->getImage(getImage(nLayer+1))->getWidth(), 
//								 g_GcResMgr->getImage(getImage(nLayer+1))->getHeight(), 
//								 0);
//			++nLayer;
			
			// Fill the parammeters
			BgParam bgParam;
			bgParam.posX = 0.0f;
			bgParam.posY = 0.0f;
			bgParam.length = bgTile[2+2*nLayer];
//			bgParam.length = g_GcResMgr->getImage(getImage(nLayer+1))->getWidth();
//			printf("length = %f\n", bgParam.length);
			bgParam.renderCount = 2;
			if (bgParam.length <= DEFAULT_SCREEN_WIDTH) {
				while (bgParam.length * bgParam.renderCount <= DEFAULT_SCREEN_WIDTH) {
					bgParam.renderCount = 1 + bgParam.renderCount;
				}
			}
			//bgParam.renderCount = 1;
//			if (nLayer == 0)
//			{
//				bgParam.renderCount = 1;
//			}
			params.push_back(bgParam);
		}
		else
		{
			continue;
		}
		
		// "object"
		for (node = group->FirstChild(); node; node = node->NextSibling())
		{
			element = node->ToElement();
			if (element != NULL)
			{
				int gid = 0;
				float x = 0.0f;
				float y = 0.0f;
				
				if (element->QueryIntAttribute("gid", &iValue) == TIXML_SUCCESS)
					gid = iValue;
				
				if (element->QueryFloatAttribute("x", &fValue) == TIXML_SUCCESS)
					x = fValue;
				
				if (element->QueryFloatAttribute("y", &fValue) == TIXML_SUCCESS)
					y = fValue;
				
				layer->addObj(gid, x, y - bgTile[3+2*nLayer], 
							  bgTile[2+2*nLayer], 
							  bgTile[3+2*nLayer], 
							  getImage(gid));
//				layer->addObj(gid, x, y - g_GcResMgr->getImage(getImage(gid))->getHeight(), 
//							  g_GcResMgr->getImage(getImage(gid))->getWidth(), 
//							  g_GcResMgr->getImage(getImage(gid))->getHeight(), 
//							  getImage(gid));
			}
		}
		
		layers.push_back(layer);
		
		++nLayer;
	}
//	printf("nLayer = %d\n", nLayer);
	return true;
}

int Background::getImage(int objId)
{
	map<int, int>::iterator it = imageMap.find(objId);
	if (it != imageMap.end())
	{
//		printf("catch image %d (%d).\n", objId, it->second);
		return it->second;
	}
	return 0;
}
