//
//  YkChessBoard.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessBoard.h"
#import "YkChessPiece.h"

#import "YkChessPiecePawn.h"
#import "YkChessPieceKnight.h"
#import "YkChessPieceRook.h"
#import "YkChessPieceBishop.h"
#import "YkChessPieceQueen.h"
#import "YkChessPieceKing.h"

#import "YkChessSquare.h"
#import "YkChessPlayer.h"

@implementation YkChessBoard

@synthesize chessPieces   = _chessPieces;
@synthesize squares       = _squares;
@synthesize squaresByName = _squaresByName;
@synthesize game          = _game;

- (id) initWithGame: (YkChessGame *)game {
    self = [super init];
    _squares       = [NSMutableDictionary dictionary];
    _squaresByName = [NSMutableDictionary dictionary];
    _chessPieces   = [NSMutableArray array];
    _game          = game;
    
    for(int y=0; y < 8; y++){
        for(int x=0; x < 8; x++){
            NSString *key = [NSString stringWithFormat: @"%i-%i", x, y];
            YkChessSquare *square = [[YkChessSquare alloc] init];
            [_squares setValue:square forKey:key];
            [_squaresByName setValue:square forKey:square.name];
        }
    }
    
    // Make chess pieces
    for(YkChessPlayer *player in [NSArray arrayWithObjects:_game.playerOne, _game.playerTwo, nil]){
        float y = 0.0;
        NSString *color = _game.playerOneColor;
        
        if(player == _game.playerTwo){
            y = 7.0;
            color = _game.playerTwoColor;
        }
        
        YkChessSquare *square;
        
        NSArray *pieces = [NSArray arrayWithObjects:[YkChessPieceRook class], [YkChessPieceKnight class], [YkChessPieceBishop class], [YkChessPieceQueen class], [YkChessPieceKing class], [YkChessPieceBishop class], [YkChessPieceKnight class], [YkChessPieceRook class], nil];
        
        for(int i = 0; i<8; i++){
            square = [self squareAtCoord:CGPointMake((float)i, y)];
            Class klass = [pieces objectAtIndex:i];
            [[klass alloc] initWithSquare:square Player:player Color:color];
        }
        
        y = 1.0;
        if(player == _game.playerTwo) y=6.0;
        
        for(int i = 0; i<8; i++){
            square = [self squareAtCoord:CGPointMake((float)i, y)];
            [[YkChessPiecePawn alloc] initWithSquare:square Player:player Color:color];
        }
    }
    
    return self;
}

- (void) removeChessPiece: (YkChessPiece *)chessPiece {
    chessPiece.square.chessPiece = nil;
    chessPiece.square = nil;
    [_chessPieces removeObject:chessPiece];
    // TODO: update display
}

- (YkChessSquare *) squareAtCoord: (CGPoint)coord {
    NSString *key = [NSString stringWithFormat: @"%i-%i", (int)coord.x, (int)coord.y];
    return [_squares valueForKey: key];
}

- (void) promoteChessPiece: (YkChessPiecePawn *)pawn {
    YkChessPiece *newPiece = [[[pawn.player promotePrompt] alloc] initWithSquare:pawn.square Player:pawn.player Color:pawn.color];
    [newPiece placeOnSquare:pawn.square];
}

@end
