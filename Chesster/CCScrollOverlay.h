//
//  CCScrollOverlay.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/13/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCScrollView.h"
#import "cocos2d.h"

@interface CCScrollOverlay : CCMenu {
    CCScrollView *_view;
    UITouch *_touch;
    BOOL _blocking;
}

+ (id) overlayForView:(CCScrollView *)scroller;
- (id) initForView:(CCScrollView *)scroller;

@end
