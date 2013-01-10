//
//  YkChessPieceRook.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/8/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessPieceRook.h"
#import "YkChessSquare.h"

@implementation YkChessPieceRook

- (NSArray *) availableSquares {
    if(!self.square) return [NSArray array];
    
    NSMutableArray *ary = [NSMutableArray array];
    
    // Move left
    [ary addObjectsFromArray:[self.square relativeSquaresInDirection:CGPointMake(-1.0, 0.0) ForPlayer:self.player]];
    
    // Move right
    [ary addObjectsFromArray:[self.square relativeSquaresInDirection:CGPointMake(1.0, 0.0) ForPlayer:self.player]];
    
    // Move up
    [ary addObjectsFromArray:[self.square relativeSquaresInDirection:CGPointMake(0.0, 1.0) ForPlayer:self.player]];
    
    // Move down
    [ary addObjectsFromArray:[self.square relativeSquaresInDirection:CGPointMake(0.0, -1.0) ForPlayer:self.player]];
    
    return ary;
}

@end
