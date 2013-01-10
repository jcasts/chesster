//
//  YkChessPieceKing.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/8/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessPieceKing.h"
#import "YkChessSquare.h"
#import "YkChessBoard.h"


@implementation YkChessPieceKing

- (NSArray *) availableSquares {
    if(!self.square) return [NSArray array];
    
    NSMutableArray *ary = [NSMutableArray array];
    
    for (YkChessSquare *sq in [self uncheckedAvailableSquares]) {
        if([sq isCoveredByOpponentOfPlayer:self.player]) [ary addObject:sq];
    }
    
    return ary;
}

- (NSArray *) uncheckedAvailableSquares {
    NSMutableArray *ary = [NSMutableArray array];
    
    NSArray *locs = [NSArray arrayWithObjects:
                     [NSValue valueWithCGPoint:CGPointMake(-1.0, 1.0)],
                     [NSValue valueWithCGPoint:CGPointMake(0.0, 1.0)],
                     [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)],
                     [NSValue valueWithCGPoint:CGPointMake(1.0, 0.0)],
                     [NSValue valueWithCGPoint:CGPointMake(1.0, -1.0)],
                     [NSValue valueWithCGPoint:CGPointMake(0.0, -1.0)],
                     [NSValue valueWithCGPoint:CGPointMake(-1.0, -1.0)],
                     [NSValue valueWithCGPoint:CGPointMake(-1.0, 0.0)],
                     nil];
    
    for (NSValue *val in locs) {
        CGPoint point;
        [val getValue:&point];
        YkChessSquare *sq = [self.square relativeSquareAtCoord:point ForPlayer:self.player];
        if(sq) [ary addObject:sq];
    }
    
    return ary;
}

- (BOOL) isCheckMate {
    if([self isCheck] && [[self availableSquares] count] == 0) return YES;
    return NO;
}

- (BOOL) isCloseCastlingOk {
    if(!self.firstMove) return NO;
    
    YkChessSquare *sq = [self.board squareAtCoord: CGPointMake(7.0, self.square.coord.y)];
    if(!sq || !sq.chessPiece || !sq.chessPiece.firstMove) return NO;
    
    for(YkChessSquare *tsq in [sq relativeSquaresInDirection: CGPointMake(1.0, 0.0)]){
        if((tsq.chessPiece && tsq.coord.x != 7.0) || [tsq isCoveredByOpponentOfPlayer:self.player]) return NO;
    }
    
    return YES;
}

- (BOOL) isFarCastlingOk {
    if(!self.firstMove) return NO;
    
    YkChessSquare *sq = [self.board squareAtCoord: CGPointMake(0.0, self.square.coord.y)];
    if(!sq || !sq.chessPiece || !sq.chessPiece.firstMove) return NO;
    
    for(YkChessSquare *tsq in [sq relativeSquaresInDirection: CGPointMake(-1.0, 0.0)]){
        if((tsq.chessPiece && tsq.coord.x != 0.0) || [tsq isCoveredByOpponentOfPlayer:self.player]) return NO;
    }
    
    return YES;
}

- (YkChessSquare *) castleCloseSquare {
    return [self.square relativeSquareAtCoord:CGPointMake(2.0, 0.0)];
}

- (YkChessSquare *) castleFarSquare {
    return [self.square relativeSquareAtCoord:CGPointMake(-2.0, 0.0)];
}

- (void) castleClose {
    if (![self isCloseCastlingOk]) return;
    YkChessPiece *rook = [self.board squareAtCoord: CGPointMake(7.0, 0.0)].chessPiece;
    
    [rook moveByCoord:CGPointMake(-2.0, 0.0)];
    [self moveToSquare:[self castleCloseSquare]];
}

- (void) castleFar {
    if (![self isCloseCastlingOk]) return;
    YkChessPiece *rook = [self.board squareAtCoord: CGPointMake(0.0, self.square.coord.y)].chessPiece;
    
    [rook moveByCoord:CGPointMake(3.0, 0.0)];
    [self moveToSquare:[self castleFarSquare]];
}

@end
