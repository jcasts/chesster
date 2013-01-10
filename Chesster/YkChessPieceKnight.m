//
//  YkChessPieceKnight.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/8/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessPieceKnight.h"
#import "YkChessSquare.h"

@implementation YkChessPieceKnight

- (NSArray *) availableSquares {
    if(!self.square) return [NSArray array];
    
    NSMutableArray *ary = [NSMutableArray array];
    
    NSArray *locs = [NSArray arrayWithObjects:
                     [NSValue valueWithCGPoint:CGPointMake(-2.0, 1.0)],
                     [NSValue valueWithCGPoint:CGPointMake(-1.0, 2.0)],
                     [NSValue valueWithCGPoint:CGPointMake(1.0, 2.0)],
                     [NSValue valueWithCGPoint:CGPointMake(2.0, 1.0)],
                     [NSValue valueWithCGPoint:CGPointMake(2.0, -1.0)],
                     [NSValue valueWithCGPoint:CGPointMake(1.0, -2.0)],
                     [NSValue valueWithCGPoint:CGPointMake(-1.0, -2.0)],
                     [NSValue valueWithCGPoint:CGPointMake(-2.0, -1.0)],
                     nil];
    
    for (NSValue *val in locs) {
        CGPoint point;
        [val getValue:&point];
        YkChessSquare *sq = [self.square relativeSquareAtCoord:point ForPlayer:self.player];
        if(sq) [ary addObject:sq];
    }
    
    return ary;
}

@end
