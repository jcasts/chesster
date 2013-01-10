//
//  YkChessSquare.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YkChessPlayer.h"

@class YkChessSquare;
@class YkChessPiece;
@class YkChessBoard;

@interface YkChessSquare : NSManagedObject

- (id) initWithBoard:(YkChessBoard *)newBoard AndCoord:(CGPoint) newCoord;
- (YkChessSquare *) relativeSquareAtCoord:(CGPoint)newCoord;
- (YkChessSquare *) relativeSquareAtCoord:(CGPoint)newCoord ForPlayer: (YkChessPlayer *)player;
- (NSArray *) relativeSquaresInDirection:(CGPoint)dir;
- (NSArray *) relativeSquaresInDirection:(CGPoint)dir ForPlayer:(YkChessPlayer *)player;
- (BOOL) isCoveredByOpponentOfPlayer:(YkChessPlayer *)player;
- (BOOL) isCoveredByBothPlayers;
- (BOOL) isCoveredByBothPlayersExceptPiece: (YkChessPiece *)ePiece;

@property (readonly, nonatomic) CGPoint coord;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSObject *graphicObject;

@property (nonatomic) YkChessPiece *chessPiece;
@property (nonatomic) YkChessBoard *board;

@end
