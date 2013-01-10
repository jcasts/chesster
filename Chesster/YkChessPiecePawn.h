//
//  YkChessPiecePawn.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YkChessPiece.h"

@interface YkChessPiecePawn : YkChessPiece {
    float _dir;
}

- (BOOL) twoSquaresLastMove;

- (BOOL) isRightEnPassantOk;
- (BOOL) isLeftEnPassantOk;

- (YkChessSquare *) rightEnPassantSquare;
- (YkChessSquare *) leftEnPassantSquare;

- (void) rightEnPassant;
- (void) leftEnPassant;

- (NSArray *) promotionSquares;
- (BOOL) promotionOk;
- (void) promote;

@end
