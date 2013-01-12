//
//  YkChessMainMenuItem.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/11/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCMenuItem.h"
#import "CCMenu.h"

@interface YkChessMainMenuItem : CCMenuItem {
    CCMenuItemFont *_titleNode;
    CCMenuItemFont *_descriptionNode;
}

- (id) initWithTarget:(id)target Selector:(SEL)selector Filename:(NSString *)filename;
- (void) setTitle:(NSString *)title;
- (void) setDescription:(NSString *)description;

@property (readonly, nonatomic) CCSprite *sprite;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *description;
@property (nonatomic) NSInteger priority;

@end
