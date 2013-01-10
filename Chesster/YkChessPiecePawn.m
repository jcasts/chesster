//
//  YkChessPiecePawn.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessPiecePawn.h"
#import "YkChessBoard.h"
#import "YkChessSquare.h"
#import "YkChessMove.h"

@implementation YkChessPiecePawn

- (id) initWithSquare: (YkChessSquare *)nSquare Player:(YkChessPlayer *)nPlayer Color:(NSString *)nColor {
    self = [super initWithSquare: nSquare Player:nPlayer Color:nColor];
    
    if(self.player == self.board.game.playerOne){
        _dir = 1.0;
    } else {
        _dir = -1.0;
    }
    
    return self;
}

- (NSArray *) availableSquares {
    if(!self.square) return [NSArray array];
    
    YkChessSquare *sq = nil;
    NSMutableArray *ary = [NSMutableArray array];
    
    // Forward 1
    sq    = [self.square relativeSquareAtCoord:CGPointMake(0.0, 1.0*_dir)];
    if(sq && !sq.chessPiece) [ary addObject: sq];
    
    // Forward 2 on first turn
    if(self.firstMove && sq && !sq.chessPiece){
        sq    = [self.square relativeSquareAtCoord:CGPointMake(0.0, 2.0*_dir)];
        if(sq && !sq.chessPiece) [ary addObject: sq];
    }
    
    // Capture right
    sq    = [self.square relativeSquareAtCoord:CGPointMake(1.0, 1.0*_dir) ForPlayer:self.player];
    if(sq && sq.chessPiece && sq.chessPiece.player != self.player) [ary addObject:sq];
    
    // Capture left
    sq    = [self.square relativeSquareAtCoord:CGPointMake(-1.0, 1.0*_dir) ForPlayer:self.player];
    if(sq && sq.chessPiece && sq.chessPiece.player != self.player) [ary addObject:sq];
    
    return ary;
}

- (BOOL) twoSquaresLastMove {
    YkChessMove *move = [self.board.game.moves lastObject];
    if(move.chessPiece == self && (fabsf)(self.square.coord.y - move.startSquare.coord.y) == 2.0) return YES;
    return NO;
}

- (BOOL) isRightEnPassantOk {
    YkChessPiece *piece = [self.square relativeSquareAtCoord:CGPointMake(1.0, 0.0)].chessPiece;
    if(piece && [piece isKindOfClass:[YkChessPiecePawn class]]) {
        return [(YkChessPiecePawn *)piece twoSquaresLastMove];
    }
    
    return NO;
}

- (BOOL) isLeftEnPassantOk {
    YkChessPiece *piece = [self.square relativeSquareAtCoord:CGPointMake(-1.0, 0.0)].chessPiece;
    if(piece && [piece isKindOfClass:[YkChessPiecePawn class]]) {
        YkChessMove *move = [self.board.game.moves lastObject];
        if(move.chessPiece == piece && (fabsf)(piece.square.coord.y - move.startSquare.coord.y) == 2.0) return YES;
    }
    
    return NO;
}

- (YkChessSquare *) rightEnPassantSquare {
    return [self.square relativeSquareAtCoord:CGPointMake(1.0, 1.0*_dir)];
}

- (YkChessSquare *) leftEnPassantSquare {
    return [self.square relativeSquareAtCoord:CGPointMake(-1.0, 1.0*_dir)];
}

- (void) rightEnPassant {
    if(![self isRightEnPassantOk]) return;
    [self moveToSquare:[self rightEnPassantSquare]];
    YkChessPiece *piece = [self.square relativeSquareAtCoord:CGPointMake(0.0, -1.0*_dir)].chessPiece;
    if(piece) [piece capture];
}

- (void) leftEnPassant {
    if(![self isLeftEnPassantOk]) return;
    [self moveToSquare:[self leftEnPassantSquare]];
    YkChessPiece *piece = [self.square relativeSquareAtCoord:CGPointMake(0.0, -1.0*_dir)].chessPiece;
    if(piece) [piece capture];
}

- (NSArray *) promotionSquares {
    NSMutableArray *squares = [NSMutableArray array];
    
    float y = 7.0;
    if(_dir == -1.0) y = 0.0;
    
    for(YkChessSquare *square in [self availableSquares]){
        if(square.coord.y == y) [squares addObject:square];
    }
    
    return squares;
}

- (BOOL) promotionOk {
    return (self.square.coord.y == 7.0 || self.square.coord.y == 0.0);
}

- (void) promote {
    if([self promotionOk]) [self.board promoteChessPiece:self];
}

@end
