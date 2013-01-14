//
//  CCScrollOverlay.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/13/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCScrollOverlay.h"

@implementation CCScrollOverlay

+ (id) overlayForView:(CCScrollView *)scroller {
    return [[self alloc] initForView:scroller];
}

- (id) initForView:(CCScrollView *)scroller {
    if(!(self = [self init])) return self;
    
    _view = scroller;
    
    [self registerWithTouchDispatcher];
    
    return self;
}

- (void) blockMenusWithTouch:(UITouch*)touch andEvent:(UIEvent*)event{
    if(_blocking || !_view.menus) return;
    
    for(CCMenu *menu in _view.menus){
        for(CCMenuItem *item in menu.children){
            [item setIsEnabled:NO];
        }
    }
    
    _blocking = YES;
}

- (void) unblockMenus {
    if(!_blocking || !_view.menus) return;
    
    for(CCMenu *menu in _view.menus){
        for(CCMenuItem *item in menu.children){
            [item setIsEnabled:YES];
        }
    }
    
    _blocking = NO;
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    BOOL useTouch = [_view ccTouchBegan:touch withEvent:event];
    if(useTouch) _touch = touch;
    return useTouch;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    if(touch == _touch){
        [self blockMenusWithTouch:touch andEvent:event];
        [_view ccTouchMoved:touch withEvent:event];
    }
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    if(touch == _touch) {        
        [self unblockMenus];
        [_view ccTouchEnded:touch withEvent:event];
    }
}

- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event{
    if(touch == _touch){
        [self unblockMenus];
        [_view ccTouchCancelled:touch withEvent:event];
    }
}

- (void) registerWithTouchDispatcher {
    CCTouchDispatcher *dispatcher = [[CCDirector sharedDirector] touchDispatcher];
    [dispatcher removeDelegate:self];
	[dispatcher addTargetedDelegate:self priority:kCCMenuHandlerPriority swallowsTouches:NO];
}
@end
