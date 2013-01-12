//
//  CCScrollNode.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/12/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCScrollNode.h"
#import "CCScrollView.h"
#import "cocos2d.h"

@implementation CCScrollNode

@synthesize scrollView = _scrollView;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = [scrollView contentOffset];
    [self setPosition:contentOffset];
}

- (void)onEnter
{
    [super onEnter];
    [[[CCDirector sharedDirector] view] addSubview:_scrollView];
}

- (void)onExit
{
    [super onExit];
    [_scrollView removeFromSuperview];
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if(self) {
        CGRect frame = [[[CCDirector sharedDirector] view] frame];
        _scrollView = [[[CCScrollView alloc] initWithFrame:frame] retain];
        _scrollView.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [super dealloc];
}

@end
