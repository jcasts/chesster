//
//  CCScrollOverlay.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/13/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCScrollOverlay.h"
#import "cocos2d.h"

@implementation CCScrollOverlay

+ (id) node {
    CCScrollOverlay *inst = [super node];
    inst.enabled = YES;
    return inst;
}

+ (id) overlayForView:(CCScrollView *)scroller {
    return [[self alloc] initForView:scroller];
}

- (id) initForView:(CCScrollView *)scroller {
    if(!(self = [self init])) return self;
    
    _view = scroller;
    
    [self registerWithTouchDispatcher];
    
    return self;
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"OVERLAY!");
    [_view ccTouchBegan:touch withEvent:event];
    return YES;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    [_view ccTouchMoved:touch withEvent:event];
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    [_view ccTouchEnded:touch withEvent:event];
}

- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
    [_view ccTouchCancelled:touch withEvent:event];
}

- (void) registerWithTouchDispatcher {
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kCCMenuHandlerPriority swallowsTouches:NO];
}
@end
