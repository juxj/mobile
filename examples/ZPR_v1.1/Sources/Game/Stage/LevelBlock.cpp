/*
 *  LevelBlock.cpp
 *  ZPR
 *
 *  Created by Neo01 on 6/27/11.
 *  Copyright 2011 Break Media. All rights reserved.
 *
 */

#include "LevelBlock.h"
#include "ObjLayer.h"
#include "ObjRect.h"
#include "Opponent.h"
#include "Item.h"

#include "Wrapper.h"
#include "neoRes.h"
#include "Image.h"
#include "tinyxml.h"

#include "GameAchieve.h"

#import "GameState.h"

#include "Stage.h"

#include "Runner.h"

Block::Block()
{
	width = 0;
	height = 0;
	tileWidth = 0;
	tileHeight = 0;
	length = 0;
	nLayer = 0;
	
	mBaseX = mBaseY = 0.0f;
	mStartX = mStartY = 0.0f;
	
	bRain = false;
	bChase = false;
	
	star1 = 100;
	star2 = 200;
	star3 = 300;
	
	nCheckPoint = 0;
#ifdef SET_CHKPT
    idxChkpt = -1;
#endif
}

Block::~Block()
{
	nLayer = 0;
	
	for(int i = 0; i < layers.size(); i++)
	{
        delete layers[i];
		layers[i] = NULL;
	}
	layers.clear();
	
	imageMap.clear();
}

bool Block::loadData(const char *resName, const char *directory, int rootDirectory)
{
	const char *path = (rootDirectory == READ_DIR_BUNDLE)?GetPath(resName, directory):GetDocPath(resName, directory);
	
	TiXmlDocument doc(path);
	if (!doc.LoadFile())
	{
		return false;
	}
	
	TiXmlNode* _map = 0;
	TiXmlNode* node = 0;
	TiXmlNode* group = 0;
	TiXmlElement* element = 0;
	TiXmlNode* properties = 0;
	TiXmlNode* property = 0;
	bool  bValue = 0;
	int   iValue = 0;
	float fValue = 0.0f;
	
	_map = doc.FirstChild("map");
	if (!_map)
	{
		return false;
	}
	
	// map basic tile data (block info.)
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
	
	// map properties
	// player's start position
	properties = _map->FirstChild("properties");
	property = NULL;
	if (properties != NULL)
	{
		const char *propName = NULL;
		cameraY = 0.0f;
		for (property = properties->FirstChild("property"); property; property = property->NextSibling("property"))
		{
			element = property->ToElement();
			if (element != NULL)
			{
				propName = element->Attribute("name");
				if (strcmp(propName, "startX") == 0)
				{
					if (element->QueryFloatAttribute("value", &fValue) == TIXML_SUCCESS)
					{
						mStartX = fValue;
					}
				}
				else if (strcmp(propName, "star1") == 0)
				{
					if (element->QueryIntAttribute("value", &iValue) == TIXML_SUCCESS)
					{
						star1 = iValue;
					}
				}
				else if (strcmp(propName, "star2") == 0)
				{
					if (element->QueryIntAttribute("value", &iValue) == TIXML_SUCCESS)
					{
						star2 = iValue;
					}
				}
				else if (strcmp(propName, "star3") == 0)
				{
					if (element->QueryIntAttribute("value", &iValue) == TIXML_SUCCESS)
					{
						star3 = iValue;
					}
				}
				else if (strcmp(propName, "startY") == 0)
				{
					if (element->QueryFloatAttribute("value", &fValue) == TIXML_SUCCESS)
					{
						mStartY = fValue;
					}
				}
				else if (strcmp(propName, "rain") == 0)
				{
					bValue = false;
					if (element->QueryBoolAttribute("value", &bValue) == TIXML_SUCCESS)
					{
						bRain = bValue;
					}
				}
				else if (strcmp(propName, "chase") == 0)
				{
					bValue = false;
					if (element->QueryBoolAttribute("value", &bValue) == TIXML_SUCCESS)
					{
						bChase = bValue;
					}
				}
#ifdef SET_CHKPT
                else if (strcmp(propName, "chkpt") == 0)
				{
                    idxChkpt = -1;
					if (element->QueryIntAttribute("value", &iValue) == TIXML_SUCCESS)
					{
						idxChkpt = iValue;
					}
				}
#endif
//				else if (strcmp(propName, "zCameraY") == 0)
//				{
//					fValue = 0.0f;
//					if (element->QueryFloatAttribute("value", &fValue) == TIXML_SUCCESS)
//					{
//						cameraY = fValue;
////						setDefaultCamY(cameraY);
////						defaultCamera();
////						mStartY -= cameraY;
//					}
//				}
			}
		}
//		setDefaultCamY(cameraY);
//		defaultCamera();
//		mStartY -= cameraY;
//		printf("startX = %f\nstartY = %f\n", mStartX, mStartY);
	}
	
	// tilesets
	for (group = _map->FirstChild("tileset"); group; group = group->NextSibling("tileset"))
	{
		element = group->ToElement();
		int _firstgid = 0;
		int _tileWidth = 0;
		int _tileHeight = 0;
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
				float offsetX = 0.0f;
				float offsetY = 0.0f;
				for (int i = 0; i < cnt; i++)
				{
					_x = _tileWidth * (i % col);
					_y = _tileHeight * (i / col);
					
					// create image
//					char imgName[16] = {0};
//					memset(imgName, '\0', sizeof(imgName));
//					sprintf(imgName, "%s_%d", _name, (_firstgid + i));
					map<int, int>::iterator itr = imageMap.find((_firstgid + i));
					if (itr == imageMap.end())
					{
						int imageId = g_GcResMgr->createImage(genFrameName(_name, (_firstgid + i)), // image name
															  _source, // image file
															  _x * IMG_RES_SCALE, _y * IMG_RES_SCALE, 
															  _tileWidth * IMG_RES_SCALE, _tileHeight * IMG_RES_SCALE, 
															  offsetX * IMG_RES_SCALE, offsetY * IMG_RES_SCALE);
						imageMap[(_firstgid + i)] = imageId;
//						printf("create image %d (%d).\n", (_firstgid + i), imageId);
					}
#ifdef DEBUG
					else
					{
//						printf("image %d (%d) exists.\n", (_firstgid + i), itr->second);
					}
#endif
				}
			}
		}
//		printf("one tileset is set.\n");
	}
	
	// objectgroups -> layers
	nLayer = 0;
	for (group = _map->FirstChild("objectgroup"); group; group = group->NextSibling("objectgroup"))
	{
		element = group->ToElement();
		
		// Layer
		ObjLayer* layer = NULL;
		if (element != NULL)
		{
			int _width  = 0;
			int _height = 0;
			if (element->QueryIntAttribute("width", &iValue) == TIXML_SUCCESS)
			{
				_width  = iValue;
			}
			if (element->QueryIntAttribute("height", &iValue) == TIXML_SUCCESS)
			{
				_height = iValue;
			}
			// create the layer
			layer = new ObjLayer(nLayer, _width, _height, 1);
		}
		else
		{
			// ignore the empty layer
			printf("___Empty Layer!!!___\n");
			continue;
		}
		
		// Objects
		for (node = group->FirstChild("object"); node; node = node->NextSibling("object"))
		{
			element = node->ToElement();
			if (element != NULL)
			{
				int   gid = 0;
				int   tid = -1;
				float x = 0.0f;
				float y = 0.0f;
				float w = 0.0f;
				float h = 0.0f;
				
				if (element->QueryIntAttribute("gid", &iValue) == TIXML_SUCCESS)
					gid = iValue;
				if (element->QueryFloatAttribute("x", &fValue) == TIXML_SUCCESS)
					x = fValue;
				if (element->QueryFloatAttribute("y", &fValue) == TIXML_SUCCESS)
					y = fValue;
				if (element->QueryFloatAttribute("width", &fValue) == TIXML_SUCCESS)
					w = fValue;
				if (element->QueryFloatAttribute("height", &fValue) == TIXML_SUCCESS)
					h = fValue;
				
				int tempGid = gid;
				
				// object with properties
				properties = node->FirstChild("properties");
				property = NULL;
				if (properties != NULL)
				{
					const char *propName = NULL;
					for (property = properties->FirstChild("property"); property; property = property->NextSibling("property"))
					{
						element = property->ToElement();
						if (element != NULL)
						{
							propName = element->Attribute("name");
							if (strcmp(propName, "tid") == 0)
							{
								if (element->QueryIntAttribute("value", &iValue) == TIXML_SUCCESS)
								{
									tid = iValue;
								}
							}
							// ......
						}
					}
				}
				
				// add objects
				if (nLayer == LAYER_TERRAIN)
				{
					gid = tid;
					
					// Get the check point
					if (gid == BLOCK_CHECK_POINT)
					{
						mCheckPoint[CHECK_POINT_DATA_ELEMENTS*nCheckPoint]   = x;
						mCheckPoint[CHECK_POINT_DATA_ELEMENTS*nCheckPoint+1] = y;
						mCheckPoint[CHECK_POINT_DATA_ELEMENTS*nCheckPoint+2] = h;
#if DEBUG
						printf("Get CheckPoint[%d] = %f, %f, %f\n", 
							   nCheckPoint, 
							   mCheckPoint[CHECK_POINT_DATA_ELEMENTS*nCheckPoint], 
							   mCheckPoint[CHECK_POINT_DATA_ELEMENTS*nCheckPoint+1], 
							   mCheckPoint[CHECK_POINT_DATA_ELEMENTS*nCheckPoint+2]);
#endif
						gid += nCheckPoint;	// gid = 200 + n
						++nCheckPoint;
					}
					
					// get the dimention again from the image
					float tempW = ((w==0.0f)?(g_GcResMgr->getImage(getImage(gid))->getWidth() * (2.0f / GLOBAL_CANVAS_SCALE)):w);
					float tempH = ((h==0.0f)?(g_GcResMgr->getImage(getImage(gid))->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE)):h);
					layer->addObj(gid, x, y, 
								  tempW, 
								  tempH, 
								  0);	// without image id
				}
#ifdef V_1_1_0
                else if (nLayer == LAYER_BILLBOARD)
                {
                    if (tid >= 0)
					{
                        gid = 300 + tid;
#ifdef VERSION_IPAD
                        layer->addObj(gid, x, y - (g_GcResMgr->getImage(getImage(tempGid))->getHeight()), 
									  ((w==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->getWidth()):w), 
									  ((h==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->getHeight()):h), 
									  0, 
									  (void *)(new Item(gid, x, y)), 1);
#else
                        layer->addObj(gid, x, y - (g_GcResMgr->getImage(getImage(tempGid))->mHeight), 
									  ((w==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->mWidth):w), 
									  ((h==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->mHeight):h), 
									  0, 
									  (void *)(new Item(gid, x, y)), 1);
#endif
                    }
                }
#endif
				else if (nLayer == LAYER_TREASURE)
				{
					if (tid < 0)
					{
						tid = 100;
						++nCoinsInCurrentLevel;
					}


//						layer->addObj(gid, x, y - g_GcResMgr->getImage(getImage(gid))->mHeight, 
//									  ((w==0.0f)?g_GcResMgr->getImage(getImage(gid))->mWidth:w), 
//									  ((h==0.0f)?g_GcResMgr->getImage(getImage(gid))->mHeight:h), 
//									  getImage(gid));
//						printf("%d - %f, %f\n", gid, g_GcResMgr->getImage(getImage(gid))->mWidth, 
//							   g_GcResMgr->getImage(getImage(gid))->mHeight);
					gid = tid;
					if (gid == 24)
					{
#ifdef VERSION_IPAD
						layer->addObj(gid, x, y - (g_GcResMgr->getImage(getImage(tempGid))->mHeight * 0.5f), 
									  ((w==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->mWidth):w), 
									  ((h==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->mHeight):h), 
									  0, 
									  (void *)(new Item(gid, x, y)), 1);
#else
                        layer->addObj(gid, x, y - (g_GcResMgr->getImage(getImage(tempGid))->mHeight), 
									  ((w==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->mWidth):w), 
									  ((h==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->mHeight):h), 
									  0, 
									  (void *)(new Item(gid, x, y)), 1);
#endif
					}
					else
					{
						layer->addObj(gid, x, y - (g_GcResMgr->getImage(getImage(tempGid))->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE)), 
									  ((w==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->getWidth() * (2.0f / GLOBAL_CANVAS_SCALE)):w), 
									  ((h==0.0f)?(g_GcResMgr->getImage(getImage(tempGid))->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE)):h), 
									  0, 
									  (void *)(new Item(gid, x, y)), 1);
					}
//					printf("%d, %d - %f, %f\n", gid, tempGid, 
//						   g_GcResMgr->getImage(getImage(tempGid))->mWidth, 
//						   g_GcResMgr->getImage(getImage(tempGid))->mHeight);
					
//					layer->addObj(gid, x, y - g_GcResMgr->getImage(getImage(gid))->mHeight, 
//								  ((w==0.0f)?g_GcResMgr->getImage(getImage(gid))->mWidth:w), 
//								  ((h==0.0f)?g_GcResMgr->getImage(getImage(gid))->mHeight:h), 
//								  getImage(gid));
//					printf("c %f, %f\n", ((w==0.0f)?g_GcResMgr->getImage(getImage(gid))->mWidth:w), 
//						   ((h==0.0f)?g_GcResMgr->getImage(getImage(gid))->mHeight:h));
				}
				else if (nLayer == LAYER_ZOMBIE)
				{
					gid = tid;
					layer->addObj(gid, x, y, 
								  ((w==0.0f)?(g_GcResMgr->getImage(getImage(gid))->getWidth() * (2.0f / GLOBAL_CANVAS_SCALE)):w), 
								  ((h==0.0f)?(g_GcResMgr->getImage(getImage(gid))->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE)):h), 
								  0, 
								  (void *)(new Opponent(gid, x, y)), 0);
				}
				else
				{
					layer->addObj(gid, x, y - (g_GcResMgr->getImage(getImage(gid))->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE)), 
								  ((w==0.0f)?(g_GcResMgr->getImage(getImage(gid))->getWidth() * (2.0f / GLOBAL_CANVAS_SCALE)):w), 
								  ((h==0.0f)?(g_GcResMgr->getImage(getImage(gid))->getHeight() * (2.0f / GLOBAL_CANVAS_SCALE)):h), 
								  getImage(gid));
				}
			}
		}
		
		layers.push_back(layer);
		++nLayer;
	}
	return true;
}

int Block::getImage(int objId)
{
	map<int, int>::iterator it = imageMap.find(objId);
	if (it != imageMap.end())
	{
		return it->second;
	}
	return 0;
}
