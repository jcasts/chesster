//
//  YkChessMove.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessMove.h"
#import "YkChessPiece.h"

@implementation YkChessMove

@synthesize chessPiece;
@synthesize capturedChessPiece;
@synthesize startSquare;
@synthesize endSquare;

- (YkChessPlayer *) player {
    return self.chessPiece.player;
}

@end
