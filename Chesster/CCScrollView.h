//
//  CCScrollView.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/12/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCLayer.h"

@interface CCScrollView : CCLayer <CCTargetedTouchDelegate> {
    CCNode *_child;
    CGSize _size;
    UITouch *_touch;
    CGPoint _touchStartPoint;
    BOOL _touchMoved;
    float _touchDist;
    float _targetY;
    float _minDist;
    int _animationCount;
    float _timeCount;
    BOOL _debug;
}

+ (id) viewWithSize:(CGSize)size Node:(CCNode *)child;
- (id) initWithSize:(CGSize)size Node:(CCNode *)child;

- (void) setContentOffset:(CGPoint)offset;
- (void) handleTouchForMenus:(NSArray *)menus;

@property (readonly, nonatomic) CGPoint contentOffset;
@property (readonly, nonatomic) BOOL reachedTop;
@property (readonly, nonatomic) BOOL reachedBottom;
@property (readonly, nonatomic) BOOL isDragging;
@property (readonly, nonatomic) BOOL isScrolling;
@property (readonly, nonatomic) NSArray *menus;
@property (nonatomic) float decelerationRate;
@property (nonatomic) float bounceSpeed;
@end
