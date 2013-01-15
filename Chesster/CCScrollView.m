//
//  CCScrollView.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/12/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCScrollView.h"
#import "CCScrollOverlay.h"
#import "cocos2d.h"

@implementation CCScrollView

@synthesize isDragging = _isDragging;
@synthesize isScrolling = _isScrolling;
@synthesize decelerationRate = _decelerationRate;
@synthesize bounceSpeed = _bounceSpeed;
@synthesize menus = _menus;

@dynamic contentOffset;
@dynamic reachedTop;
@dynamic reachedBottom;


+ (id) viewWithSize:(CGSize)size Node:(CCNode *)child {
    return [[self alloc] initWithSize:size Node:child];
}

- (id) initWithSize:(CGSize)size Node:(CCNode *)child {
    if(!(self = [self init])) return self;
    
    if(child.contentSize.height < size.height) size = CGSizeMake(size.height, child.contentSize.height);
    _size = size;
    self.contentSize = _size;
    self.anchorPoint = CGPointZero;
    
    _child = child;
    _child.anchorPoint = CGPointZero;
    _child.position = CGPointMake(_child.position.x,[self topY]);
    _decelerationRate = 0.95;
    _bounceSpeed = 0.15;
    _minDist = 0.1;
    _debug = NO;
    
    [self addChild:child z:1];
    
    CCScrollOverlay *overlay = [CCScrollOverlay overlayForView:self];
    overlay.contentSize = _size;
    [self addChild:overlay z:10];
    
    [self resetAnimationCount];
    [self registerWithTouchDispatcher];
    return self;
}

- (void) handleTouchForMenus:(NSArray *)menus {
    _menus = menus;
}

- (BOOL) reachedTop {
    return (_child.position.y <= [self topY]);
}

- (BOOL) reachedBottom {
    return (_child.position.y >= [self bottomY]);
}

- (float) topY {
    return (_size.height-(_child.contentSize.height*_child.scaleY));
}

- (float) bottomY {
    return 0.0;
}

- (float) travelDistanceWithLastDist:(float)lastDist {
    float travelDist = 0.0;
    if(!_isDragging && fabsf(_child.position.y - _targetY) <= _minDist * 2 && fabsf(lastDist) < _minDist * 3){
        // Stop on target
        travelDist = _targetY - _child.position.y;
        if(_debug) NSLog(@"Stopping");
        
    } else if((lastDist > _minDist && self.reachedBottom) || (lastDist < -_minDist && self.reachedTop)){
        // went over, need to bounce back down, so decelerate faster
        float dist = _child.position.y - _targetY;
        float distMax = _size.height/3.0;
        float distLeft = distMax - fabsf(dist);
        
        travelDist = lastDist * (distLeft / distMax);
        if(_debug) NSLog(@"Overshooting");
        
    } else if(_isDragging) {
        // Do nothing
        travelDist = lastDist;
        
    } else if([self needsBounceBack] && fabsf(lastDist) < fabsf((_targetY - _child.position.y) * _bounceSpeed)) {
        // Invert direction due to bounce
        travelDist = (_targetY - _child.position.y) * _bounceSpeed;
        if(_debug) NSLog(@"Bounce Init");
        
    } else if((lastDist < _minDist && self.reachedBottom) || (lastDist > -_minDist && self.reachedTop)) {
        // Bouncing back
        travelDist = lastDist * (1.0 - _bounceSpeed);
        if(_debug) NSLog(@"Bouncing Back");
        
    } else {
        travelDist = lastDist * _decelerationRate;
    }
    
    if(_debug) NSLog(@"RATE %f", travelDist);
    return travelDist;
}

- (void) decelerateOverTime:(ccTime)dt {
    int missingCount = [self updateAnimationCount];
    for(int i=0; i<missingCount; i++){
        if(_isDragging || !_isScrolling){
            [self unschedule:@selector(decelerateOverTime:)];
            [self resetAnimationCount];
            return;
        }
    
        if (fabsf(_touchDist) <= _minDist && fabsf(_child.position.y - _targetY) < _minDist){
            // clip to target
            _child.position = CGPointMake(_child.position.x, _targetY);
        } else {
            _touchDist = [self travelDistanceWithLastDist: _touchDist];
            _child.position = CGPointMake(_child.position.x, _child.position.y+_touchDist);
        }
    
        if (fabsf(_touchDist) <= _minDist && ![self needsBounceBack]){
            if(_debug) NSLog(@"DONE");
            _isScrolling = NO;
        }
    
        if(_child.position.y == _targetY){
            if(_debug) NSLog(@"HIT TARGET");
            break;
        }
    }
}

- (int) updateAnimationCount {
    float interval = [CCDirector sharedDirector].animationInterval;
    int missing = (1 + roundf(_timeCount / interval) - _animationCount);
    _animationCount = _animationCount + missing;
    if(missing == 0) return 1;
    return missing;
}

- (void) startAnimationCount {
    [self resetAnimationCount];
    [self schedule:@selector(countAnimation:)];
}

- (void) resetAnimationCount {
    _animationCount = 0;
    _timeCount = 0;
    [self unschedule:@selector(countAnimation:)];
}

- (void) countAnimation:(ccTime)dt {
    _timeCount += dt;
    _animationCount++;
}

- (void) registerWithTouchDispatcher {
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kCCMenuHandlerPriority swallowsTouches:NO];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if(!self.visible || _touch) return NO;
    
    _touch = touch;
    _isDragging = YES;
    _isScrolling = YES;
    _touchStartPoint = [self convertTouchToNodeSpace:touch];
    _touchDist = 0.0;
    
    return YES;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    if(!self.visible || touch != _touch) return;
    
    _touchMoved = YES;
    
    CGPoint touchCurrPoint = [self convertTouchToNodeSpace:_touch];
    _touchDist = touchCurrPoint.y - _touchStartPoint.y;
    _touchStartPoint = touchCurrPoint;
    
    if(![self needsBounceBack]){
        if(_touchDist > 0.0) {
            _targetY = [self bottomY];
        } else if(_touchDist < 0.0) {
            _targetY = [self topY];
        }
    }
    
    _touchDist = [self travelDistanceWithLastDist: _touchDist];
    _child.position = CGPointMake(_child.position.x, _child.position.y+_touchDist);
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if(!self.visible || touch != _touch) return;
    
    if(_touchMoved) {
        [self startAnimationCount];
        [self schedule:@selector(decelerateOverTime:)];
    }
    _touch = nil;
    _isDragging = NO;
    _touchMoved = NO;
}

- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    if(!self.visible || touch != _touch) return;
    _touch = nil;
    _isDragging = NO;
}

- (BOOL) needsBounceBack {
    return ((_child.position.y < [self topY]) || _child.position.y > [self bottomY]);
}

- (CGPoint) contentOffset {
    return _child.position;
}

- (void) setContentOffset:(CGPoint)offset {
    _child.position = offset;
}

@end
