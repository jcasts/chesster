//
//  YkChessPiece.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YkChessPlayer.h"
#import "YkChessGraphic.h"

@class YkChessSquare;
@class YkChessBoard;

@interface YkChessPiece : NSObject

- (id) initWithSquare: (YkChessSquare *)nSquare Player:(YkChessPlayer *)nPlayer Color:(NSString *)nColor;
- (NSArray *) availableSquares;
- (BOOL) moveToSquare:(YkChessSquare *)square;
- (BOOL) moveToCoord:(CGPoint)point;
- (BOOL) moveByCoord:(CGPoint)point;
- (BOOL) placeOnSquare: (YkChessSquare *)newSquare;
- (void) capture;
- (BOOL) isCheck;

@property (readonly, nonatomic) YkChessPlayer *player;
@property (readonly, nonatomic, retain) NSString *color;
@property BOOL isCaptured;

@property (readonly, nonatomic) YkChessBoard *board;
@property (nonatomic) YkChessSquare *square;
@property (readonly, nonatomic, retain) YkChessGraphic *graphicObject;
@property (nonatomic) BOOL firstMove;

@end