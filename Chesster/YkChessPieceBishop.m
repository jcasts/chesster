//
//  YkChessPieceBishop.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/8/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessPieceBishop.h"
#import "YkChessSquare.h"

@implementation YkChessPieceBishop

- (NSArray *) availableSquares {
    if(!self.square) return [NSArray array];
    
    NSMutableArray *ary = [NSMutableArray array];
    
    // Move left-up
    [ary addObjectsFromArray:[self.square relativeSquaresInDirection:CGPointMake(-1.0, 1.0) ForPlayer:self.player]];
    
    // Move right-up
    [ary addObjectsFromArray:[self.square relativeSquaresInDirection:CGPointMake(1.0, 1.0) ForPlayer:self.player]];
    
    // Move left-down
    [ary addObjectsFromArray:[self.square relativeSquaresInDirection:CGPointMake(-1.0, -1.0) ForPlayer:self.player]];
    
    // Move right-down
    [ary addObjectsFromArray:[self.square relativeSquaresInDirection:CGPointMake(1.0, -1.0) ForPlayer:self.player]];
    
    return ary;
}

@end
