//
//  YkChessPiece.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessPiece.h"
#import "YkChessBoard.h"
#import "YkChessSquare.h"
#import "YkChessMove.h"

@implementation YkChessPiece

@synthesize color         = _color;
@synthesize isCaptured    = _isCaptured;
@synthesize graphicObject = _graphicObject;
@synthesize square        = _square;
@synthesize board         = _board;
@synthesize player        = _player;
@synthesize firstMove     = _firstMove;


- (id) initWithSquare: (YkChessSquare *)nSquare Player:(YkChessPlayer *)nPlayer Color:(NSString *)nColor {
    self = [super init];
    _board     = nSquare.board;
    _player    = nPlayer;
    _color     = nColor;
    _isCaptured   = NO;
    _firstMove = YES;
    
    [self placeOnSquare:nSquare];
    
    return self;
}

- (NSArray *) availableSquares {
    // Must be implemented in subclass!
    return [NSArray init];
}

- (BOOL) isCheck {
    return [self.square isCoveredByOpponentOfPlayer: self.player];
}

- (void) capture {
    _isCaptured = YES;
    [_board removeChessPiece: self];
    
    // TODO: update display
}

- (BOOL) moveToCoord:(CGPoint)point {
    YkChessSquare *sq = [_board squareAtCoord:point];
    if(!sq) return NO;
    return [self moveToSquare: sq];
}

- (BOOL) moveByCoord:(CGPoint)point {
    YkChessSquare *sq = [self.square relativeSquareAtCoord:point];
    if(!sq) return NO;
    return [self moveToSquare: sq];
}

- (BOOL) moveToSquare: (YkChessSquare *)newSquare {
    if ([[self availableSquares] containsObject: newSquare]){
        
        YkChessMove *move = [[YkChessMove alloc] init];
        move.startSquare = _square;
        move.endSquare = newSquare;
        
        // Take opponent piece.
        if(newSquare.chessPiece){
            if(newSquare.chessPiece.player != _player){
                move.capturedChessPiece = newSquare.chessPiece;
                [newSquare.chessPiece capture];
            } else {
                return NO;
            }
        }
        
        if(_square) _square.chessPiece = nil;
        _square = newSquare;
        _square.chessPiece = self;
        if(_firstMove) _firstMove = NO;
        
        if(move.startSquare) [_board.game.moves addObject:move];

        // TODO: update display
        
        return YES;
    } else {
        return NO;
    }
}

- (BOOL) placeOnSquare: (YkChessSquare *)newSquare {
    if(_square) _square.chessPiece = nil;
    
    if(newSquare.chessPiece) [_board removeChessPiece:newSquare.chessPiece];
    self.square = newSquare;
    self.square.chessPiece = self;
    
    // TODO: update display
    
    return YES;
}

@end
