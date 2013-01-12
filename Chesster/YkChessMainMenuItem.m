//
//  YkChessMainMenuItem.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/11/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessMainMenuItem.h"
#import "CCSprite.h"
#import "CCLabelAtlas.h"

@implementation YkChessMainMenuItem

@synthesize sprite = _sprite;
@synthesize title = _title;
@synthesize description = _description;


- (id) initWithTarget:(id)target Selector:(SEL)selector Filename:(NSString *)filename {
    if(!(self = [super initWithTarget:target selector:selector])) return self;
    
    _sprite = [CCSprite spriteWithFile:filename];
    _sprite.anchorPoint = CGPointMake(0.0,0.0);
    _sprite.scaleX = 112.0 / _sprite.contentSize.width;
    _sprite.scaleY = 112.0 / _sprite.contentSize.height;
    [self addChild:_sprite];

    [self updateContentSize];
    
    return self;
}

- (void) updateContentSize {
    CGRect srect = [_sprite boundingBox];
    
    if(_titleNode || _descriptionNode){
        self.contentSize = CGSizeMake(346.0, srect.size.height);
    } else {
        self.contentSize = srect.size;
    }
}

- (void) setTitle:(NSString *)title {
    if(_titleNode) [self removeChild:_titleNode cleanup:NO];
    
    _title = title;
    _titleNode = [CCMenuItemFont itemWithString:title];
    [_titleNode setFontName:@"HelveticaNeue-Medium"];
    [_titleNode setFontSize:20];
    [_titleNode setColor:ccc3(0,0,0)];
    _titleNode.anchorPoint = CGPointMake(0.0,0.0);
    
    CGRect rect = [_sprite boundingBox];
    [_titleNode setPosition:CGPointMake(rect.size.width+10.0, rect.size.height-_titleNode.contentSize.height)];
    [self addChild:_titleNode];
    [self updateContentSize];
}

- (void) setDescription:(NSString *)description {
    if(_descriptionNode) [self removeChild:_descriptionNode cleanup:NO];
    
    _description = description;
    _descriptionNode = [CCMenuItemFont itemWithString:description];
    [_descriptionNode setFontName:@"HelveticaNeue-Light"];
    [_descriptionNode setFontSize:20];
    [_descriptionNode setColor:ccc3(0,0,0)];
    _descriptionNode.anchorPoint = CGPointMake(0.0,0.0);
    
    float y;
    float x;
    
    if(_titleNode){
        CGRect rect = [_titleNode boundingBox];
        y = rect.origin.y - rect.size.height;
        x = rect.origin.x;
    } else {
        CGRect rect = [_sprite boundingBox];
        y = rect.origin.y;
        x = rect.origin.x + 10.0;
    }
    
    [_descriptionNode setPosition:CGPointMake(x,y)];
    [self addChild:_descriptionNode];
    [self updateContentSize];
}

- (void) selected {
    self.position = CGPointMake(self.position.x+2.0, self.position.y-2.0);
}

- (void) unselected {
    self.position = CGPointMake(self.position.x-2.0, self.position.y+2.0);
}
@end
