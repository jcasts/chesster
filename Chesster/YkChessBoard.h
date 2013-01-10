//
//  YkChessBoard.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YkChessGame.h"

@class YkChessPiece;
@class YkChessPiecePawn;
@class YkChessSquare;

@interface YkChessBoard : NSManagedObject

- (id) initWithGame: (YkChessGame *)game;
- (YkChessSquare *) squareAtCoord: (CGPoint)coord;
- (void) removeChessPiece: (YkChessPiece *)chessPiece;
- (void) promoteChessPiece: (YkChessPiecePawn *)pawn;

@property (readonly, nonatomic) YkChessGame *game;
@property (readonly, nonatomic) NSMutableDictionary *squares;
@property (readonly, nonatomic) NSMutableDictionary *squaresByName;
@property (readonly, nonatomic) NSMutableArray *chessPieces;

@end
