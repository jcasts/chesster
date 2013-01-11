//
//  YkChessGame.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YkChessPlayer.h"

@class YkChessBoard;

@interface YkChessGame : NSManagedObject

- (id) initWithPlayerOne: (YkChessPlayer *)playerOne PlayerTwo: (YkChessPlayer *)playerTwo;

- (BOOL) isPlayerOneCheck;
- (BOOL) isPlayerOneCheckMate;

- (BOOL) isPlayerTwoCheck;
- (BOOL) isPlayerTwoCheckMate;

- (BOOL) isStaleMate;
- (BOOL) isDraw;

- (void) playerOneOfferDraw;
- (void) playerTwoOfferDraw;

- (void) playerOneAcceptDraw;
- (void) playerTwoAcceptDraw;

- (void) playerOneGiveUp;
- (void) playerTwoGiveUp;

- (void) finishTurn;

@property (readonly, nonatomic, retain) NSString *playerOneColor;
@property (readonly, nonatomic, retain) NSString *playerTwoColor;
@property (readonly, nonatomic) YkChessPlayer *currentPlayer;

@property (readonly, nonatomic, retain) YkChessPlayer *playerOne;
@property (readonly, nonatomic, retain) YkChessPlayer *playerTwo;
@property (readonly, nonatomic, retain) NSMutableArray *moves;
@property (readonly, nonatomic, retain) YkChessBoard *board;

@end
