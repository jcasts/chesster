//
//  YkChessSquare.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessSquare.h"
#import "YkChessPiece.h"
#import "YkChessPieceKing.h"
#import "YkChessBoard.h"

@implementation YkChessSquare

@synthesize coord         = _coord;
@synthesize name          = _name;
@synthesize board         = _board;
@synthesize chessPiece    = _chessPiece;
@synthesize graphicObject = _graphicObject;

- (id) initWithBoard:(YkChessBoard *)newBoard AndCoord:(CGPoint) newCoord {
    self = [super init];
    _board = newBoard;
    _coord = newCoord;
    
    NSArray *letters = [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", "@H", nil];
    NSString *letter = [letters objectAtIndex: (int)_coord.x];
    
    _name = [NSString stringWithFormat:@"%@%i", letter, (int)_coord.y+1];
    
    //TODO: initialize graphicObject
    return self;
}

//TODO: support En-Passant foresight - some squares are only dangerous for pawns :(

- (BOOL) isCoveredByOpponentOfPlayer:(YkChessPlayer *)player {
    // TODO: only look at one player's pieces
    // TODO: cache who and what covers what
    for(YkChessPiece *piece in _board.chessPieces){
        if(piece.player == player) continue;
        
        if([piece isKindOfClass:[YkChessPieceKing class]]){
            if([[(YkChessPieceKing *)piece uncheckedAvailableSquares] containsObject:self]) return YES;
        } else {
            if([[piece availableSquares] containsObject:self]) return YES;
        }
    }
    return NO;
}

- (BOOL) isCoveredByBothPlayers {
    // TODO: isCoveredByBothPlayersExceptPiece: (YkChessPiece *)piece
    if([self isCoveredByOpponentOfPlayer: _board.game.playerOne] && [self isCoveredByOpponentOfPlayer:_board.game.playerTwo]) return YES;
    return NO;
}

- (BOOL) isCoveredByBothPlayersExceptPiece: (YkChessPiece *)ePiece {
    // TODO: cache who and what covers what
    BOOL playerOneCovered = NO;
    BOOL playerTwoCovered = NO;
    
    for(YkChessPiece *piece in _board.chessPieces){
        if(piece == ePiece) continue;
        
        if([piece isKindOfClass:[YkChessPieceKing class]]){
            if(![[(YkChessPieceKing *)piece uncheckedAvailableSquares] containsObject:self]) continue;
        } else {
            if(![[piece availableSquares] containsObject:self]) continue;
        }
        
        if(piece.player == _board.game.playerOne){
            playerOneCovered = YES;
        } else {
            playerTwoCovered = YES;
        }
        
        if(playerOneCovered && playerTwoCovered) return YES;
    }
    return NO;
}

- (YkChessSquare *) relativeSquareAtCoord:(CGPoint)newCoord {
    return [_board squareAtCoord: CGPointMake(_coord.x+newCoord.x, _coord.y+newCoord.y)];
}

- (YkChessSquare *) relativeSquareAtCoord:(CGPoint)newCoord ForPlayer: (YkChessPlayer *)player {
    YkChessSquare *sq = [self relativeSquareAtCoord: newCoord];
    if(!sq) return nil;
    
    if(!sq.chessPiece || sq.chessPiece.player != player){
        return sq;
    } else {
        return nil;
    }
}

- (NSArray *) relativeSquaresInDirection:(CGPoint)dir {
    NSMutableArray *ary = [NSMutableArray array];
    
    YkChessSquare *sq = nil;
    CGPoint point = dir;
    
    while((sq = [self relativeSquareAtCoord:point])){
        [ary addObject:sq];
        if(sq.chessPiece) break;
        point = CGPointMake(point.x + dir.x, point.y + dir.y);
    }
    
    return ary;
}

- (NSArray *) relativeSquaresInDirection:(CGPoint)dir ForPlayer:(YkChessPlayer *)player {
    NSMutableArray *ary = [NSMutableArray array];
    
    YkChessSquare *sq = nil;
    CGPoint point = dir;
    
    while((sq = [self relativeSquareAtCoord:point ForPlayer:player])){
        [ary addObject:sq];
        if(sq.chessPiece) break;
        point = CGPointMake(point.x + dir.x, point.y + dir.y);
    }
    
    return ary;
}

@end
