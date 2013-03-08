//
//  EAGLView.m
//  ZPR
//
//  Created by Neo01 on 5/27/11.
//  Copyright 2011 Break Media. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "EAGLView.h"

// NeoLib Core
#import "neoApp.h"
#import "Canvas2D.h"

// Game
#import "GameState.h"


@interface EAGLView (PrivateMethods)
- (void)createFramebuffer;
- (void)deleteFramebuffer;
@end

@implementation EAGLView

@dynamic context;

// You must implement this method
+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

//The EAGL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:.
- (id)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
	if (self)
    {
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking,
                                        kEAGLColorFormatRGB565, kEAGLDrawablePropertyColorFormat,//kEAGLColorFormatRGBA8
                                        nil];
    }
    
    return self;
}

- (void)dealloc
{
    [self deleteFramebuffer];    
    [context release];
    
    [super dealloc];
}

- (EAGLContext *)context
{
    return context;
}

- (void)setContext:(EAGLContext *)newContext
{
    if (context != newContext)
    {
        [self deleteFramebuffer];
        
        [context release];
        context = [newContext retain];
        
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)createFramebuffer
{
    if (context && !defaultFramebuffer)
    {
        [EAGLContext setCurrentContext:context];
        
        // Create default framebuffer object.
        glGenFramebuffers(1, &defaultFramebuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
        
        // Create color render buffer and allocate backing store.
        glGenRenderbuffers(1, &colorRenderbuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
        [context renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer];
        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &framebufferWidth);
        glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &framebufferHeight);
        
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
        
        if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
            NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
    }
}

- (void)deleteFramebuffer
{
    if (context)
    {
        [EAGLContext setCurrentContext:context];
        
        if (defaultFramebuffer)
        {
            glDeleteFramebuffers(1, &defaultFramebuffer);
            defaultFramebuffer = 0;
        }
        
        if (colorRenderbuffer)
        {
            glDeleteRenderbuffers(1, &colorRenderbuffer);
            colorRenderbuffer = 0;
        }
    }
}

- (void)setFramebuffer
{
    if (context)
    {
        [EAGLContext setCurrentContext:context];
        
        if (!defaultFramebuffer)
		{
            [self createFramebuffer];
			Canvas2D *canvas = Canvas2D::getInstance();
			canvas->reset();
        }
        glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
        
        glViewport(0, 0, framebufferWidth, framebufferHeight);
    }
}

- (BOOL)presentFramebuffer
{
    BOOL success = FALSE;
    
    if (context)
    {
        [EAGLContext setCurrentContext:context];
        
        glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
        
        success = [context presentRenderbuffer:GL_RENDERBUFFER];
    }
    
    return success;
}

- (void)layoutSubviews
{
    // The framebuffer will be re-created at the beginning of the next setFramebuffer method call.
    [self deleteFramebuffer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//	NSLog(@"Began !");
	UITouch *touchA;
	//UITouch *touchB;
	CGPoint pointA;
	//CGPoint pointB;
	// Let the super handle touch computations.
	//[super touchesBegan:touches withEvent:event];
	// This struct now contains parsed touch data.
	//info = [self getTouchInfo];
	
	if ([touches count] == 1)
	{
		touchA = [[touches allObjects] objectAtIndex:0];
		pointA = [touchA locationInView:self];
		
		g_fButtonXY[0] = pointA.x;
		g_fButtonXY[1] = pointA.y;
//		g_fButtonXY[0] = pointA.y;
//		g_fButtonXY[1] = neolib::App::getConfig().width - pointA.x;
		
		g_nButtonPress = 1;
		UpdateTouches(1, g_fButtonXY[0], g_fButtonXY[1]);
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touchA;
	UITouch *touchB;
	CGPoint pointA; 
	CGPoint pointB;
//	CGPoint pointC;
//	CGPoint pointD;
	
	if ([touches count] == 1)
	{		touchA = [[touches allObjects] objectAtIndex:0];
		pointA = [touchA locationInView:self];
		pointB = [touchA previousLocationInView:self];
		
		g_fButtonXY[0] = pointB.x;
		g_fButtonXY[1] = pointB.y;
//		g_fButtonXY[0] = pointB.y;
//		g_fButtonXY[1] = neolib::App::getConfig().width - pointB.x;
		
		UpdateTouches(2, pointA.x, pointA.y);
//		UpdateTouches(2, pointA.y, neolib::App::getConfig().width - pointA.x);
	}
	else if ([touches count] == 2)
	{
		touchA = [[touches allObjects] objectAtIndex:0];
		touchB = [[touches allObjects] objectAtIndex:1];
		
		pointA = [touchA locationInView:self];
		pointB = [touchB locationInView:self];
		//printf("pointA.x=%f,pointA.y=%f\n",pointA.x,pointA.y);
	//	printf("pointB.x=%f,pointB.y=%f\n",pointB.x,pointB.y);
//		
//		CGSize delta = CGSizeMake(pointA.x-pointB.x, pointA.y-pointB.y);
//		float currDistance = sqrt(delta.width*delta.width + delta.height*delta.height);
//		
//		pointC = [touchA previousLocationInView:self];
//		pointD = [touchB previousLocationInView:self];
//		
//		CGSize delta2 = CGSizeMake(pointC.x-pointD.x, pointC.y-pointD.y);
//		float prevDistance = sqrt(delta2.width*delta2.width + delta2.height*delta2.height);	`//		
//		MultiTouch(2, prevDistance, currDistance);
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

	UITouch *touchA;
	CGPoint pointA;
	
	touchA = [[touches allObjects] objectAtIndex:0];
	pointA = [touchA locationInView:self];
	
	// Place the tile by drag and drop or rotate the tile by tapping
	if ([touches count] == 1)
	{
		//g_fButtonXY[0] = pointA.x;
		//g_fButtonXY[1] = pointA.y;
		g_nButtonPress = 0; 
		UpdateTouches(3, g_fButtonXY[0], g_fButtonXY[1]);
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

	UITouch *touchA;
	CGPoint pointA;
	
	touchA = [[touches allObjects] objectAtIndex:0];
	pointA = [touchA locationInView:self];
	
	// Place the tile by drag and drop or rotate the tile by tapping
	if ([touches count] == 1)
	{
		//g_fButtonXY[0] = pointA.x;
		//g_fButtonXY[1] = pointA.y;
		
		g_nButtonPress = 0; 
		UpdateTouches(3, g_fButtonXY[0], g_fButtonXY[1]);
	}
}

@end
