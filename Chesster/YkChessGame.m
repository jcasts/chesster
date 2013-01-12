//
//  YkChessGame.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessGame.h"
#import "YkChessMove.h"
#import "YkChessBoard.h"

@implementation YkChessGame

@synthesize moves     = _moves;
@synthesize playerOne = _playerOne;
@synthesize playerTwo = _playerTwo;
@synthesize board     = _board;
@synthesize playerOneColor = _playerOneColor;
@synthesize playerTwoColor = _playerTwoColor;
@synthesize currentPlayer  = _currentPlayer;
@synthesize lastMoveDesc   = _lastMoveDesc;

- (id) initWithPlayerOne: (YkChessPlayer *)playerOne PlayerTwo:(YkChessPlayer *)playerTwo {
    self = [super init];
    _playerOne = playerOne;
    _playerTwo = playerTwo;
    _playerOneColor = @"white";
    _playerTwoColor = @"black";
    _currentPlayer  = playerOne;
    _lastMoveDesc   = @"(First Move)";
    
    return self;
}

- (void) setupBoard {
    _board     = [[YkChessBoard alloc] init];
    _moves     = [NSMutableArray new];
}

- (void) finishTurn {
    if(_currentPlayer == _playerOne){
        _currentPlayer = _playerTwo;
    } else {
        _currentPlayer = _playerOne;
    }
}

@end
