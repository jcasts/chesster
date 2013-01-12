//
//  CCScrollView.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/11/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCScrollView.h"
#import "CCDirector.h"

@implementation CCScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if(!self.dragging) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if(!self.dragging) {
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
}

// Override
- (void)setContentOffset:(CGPoint)contentOffset {
	// UIScrollView uses UITrackingRunLoopMode.
	// NSLog([[NSRunLoop currentRunLoop] currentMode]);
    
	// If we're dragging, mainLoop is going to freeze.
	if (self.dragging && !self.decelerating) {
        
		// Make sure we haven't already created our timer.
		if (timer == nil) {
            
			// Schedule a new UITrackingRunLoopModes timer, to fill in for CCDirector while we drag.
			timer = [NSTimer scheduledTimerWithTimeInterval:[[CCDirector sharedDirector] animationInterval] target:self selector:@selector(animateWhileDragging) userInfo:nil repeats:YES];
            
            // This could also be NSRunLoopCommonModes
			[[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
		}
	}
    
	// If we're decelerating, mainLoop is going to stutter.
	if (self.decelerating && !self.dragging) {
        
		// Make sure we haven't already created our timer.
		if (timer == nil) {
            
			// Schedule a new UITrackingRunLoopMode timer, to fill in for CCDirector while we decellerate.
			timer = [NSTimer scheduledTimerWithTimeInterval:[[CCDirector sharedDirector] animationInterval] target:self selector:@selector(animateWhileDecellerating) userInfo:nil repeats:YES];
			[[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
		}
	}
    
	[super setContentOffset:contentOffset];
}

- (void)animateWhileDragging {
    
	// Draw.
	[[CCDirector sharedDirector] drawScene];
    
	if (!self.dragging) {
        
		// Don't need this timer anymore.
		[timer invalidate];
		timer = nil;
	}
}

- (void)animateWhileDecellerating {
    
	// Draw.
	[[CCDirector sharedDirector] drawScene];
    
	if (!self.decelerating) {
        
		// Don't need this timer anymore.
		[timer invalidate];
		timer = nil;
	}
}

@end
