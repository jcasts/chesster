//
//  CCScrollNode.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/12/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCNode.h"

@interface CCScrollNode : CCNode <UIScrollViewDelegate>

@property (nonatomic, readonly) UIScrollView *scrollView;

@end
