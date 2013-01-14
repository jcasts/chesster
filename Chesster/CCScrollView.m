//
//  CCScrollView.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/12/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCScrollView.h"
#import "cocos2d.h"

@implementation CCScrollView

@synthesize isDragging = _isDragging;
@synthesize isScrolling = _isScrolling;
@synthesize decelerationRate = _decelerationRate;
@synthesize bounceSpeed = _bounceSpeed;

@dynamic contentOffset;
@dynamic reachedTop;
@dynamic reachedBottom;


+ (id) viewWithSize:(CGSize)size Node:(CCNode *)child {
    return [[self alloc] initWithSize:size Node:child];
}

- (id) initWithSize:(CGSize)size Node:(CCNode *)child {
    if(!(self = [self init])) return self;
    
    _size = size;
    self.contentSize = _size;
    
    _child = child;
    _child.anchorPoint = CGPointZero;
    _child.position = CGPointMake(_child.position.x,[self topY]);
    _decelerationRate = 0.95;
    _bounceSpeed = 0.1;
    _minDist = 0.1;
    _debug = NO;
    
    [self addChild:child];
    
    [self registerWithTouchDispatcher];
    return self;
}

- (BOOL) reachedTop {
    return (_child.position.y <= [self topY]);
}

- (BOOL) reachedBottom {
    return (_child.position.y >= [self bottomY]);
}

- (float) topY {
    return (_size.height-_child.contentSize.height);
}

- (float) bottomY {
    return 0.0;
}

- (float) travelDistanceWithLastDist:(float)lastDist {
    float travelDist = 0.0;
    
    if((lastDist > _minDist && self.reachedBottom) || (lastDist < -_minDist && self.reachedTop)){
        // went over, need to bounce back down, so decelerate faster
        float speed = _child.position.y - _targetY;
        if(speed == 0) speed = lastDist;
        if(speed > _size.height/3.0) speed = _size.height/3.0;
        if(speed < -_size.height/3.0) speed = -_size.height/3.0;
        
        float rateMod = speed * _bounceSpeed;
        travelDist = lastDist * (1.0/fabsf(rateMod));
        
    } else if(_isDragging) {
        // Do nothing
        travelDist = lastDist;
        
    } else if((lastDist >= _minDist && self.reachedTop) || (lastDist <= -_minDist && self.reachedBottom)) {
        // bouncing back
        if(fabsf(_child.position.y - _targetY) <= _minDist) {
            travelDist = _minDist;
            if(_targetY == [self bottomY]) travelDist = -travelDist;
        } else {
            travelDist = lastDist * _decelerationRate * _decelerationRate;
        }
        
    } else if((lastDist < _minDist && lastDist >= 0.0 && self.reachedBottom) || (lastDist > -_minDist && lastDist <= 0.0 && self.reachedTop)) {
        // when going over and slow enough, invert the rate
        travelDist = (_targetY - _child.position.y) * _bounceSpeed;
        if(_debug) NSLog(@"Bounce Init");
        
    } else {
        travelDist = lastDist * _decelerationRate;
    }
    
    if(_debug) NSLog(@"RATE %f", travelDist);
    return travelDist;
}

- (void) decelerateOverTime:(ccTime)dt {
    if(_isDragging || !_isScrolling){
        [self unschedule:@selector(decelerateOverTime:)];
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
    
    if(_debug && _child.position.y == _targetY) NSLog(@"HIT TARGET");
}

- (void) registerWithTouchDispatcher {
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kCCMenuHandlerPriority swallowsTouches:YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if(!self.visible || _touch) return NO;
    
    _touch = touch;
    _isDragging = YES;
    _isScrolling = YES;
    _touchStartPoint = [self convertTouchToNodeSpace:touch];
    _touchDist = 0.0;
    
    NSLog(@"TOUCHE");
    
    return YES;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    if(!self.visible || touch != _touch) return;
    
    _touchMoved = YES;
    
    CGPoint touchCurrPoint = [self convertTouchToNodeSpace:_touch];
    _touchDist = touchCurrPoint.y - _touchStartPoint.y;
    _touchStartPoint = touchCurrPoint;
    
    if(_touchDist > 0.0) {
        _targetY = [self bottomY];
    } else {
        _targetY = [self topY];
    }
    
    if (fabsf(_touchDist) <= _minDist) {
        _isScrolling = NO;
    } else {
        _touchDist = [self travelDistanceWithLastDist: _touchDist];
        _child.position = CGPointMake(_child.position.x, _child.position.y+_touchDist);
    }
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if(!self.visible || touch != _touch) return;
    
    if(_touchMoved) {
        if(fabsf(_touchDist) < _minDist) {
           _isScrolling = NO;
        } else {
            [self schedule:@selector(decelerateOverTime:)];
        }
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
