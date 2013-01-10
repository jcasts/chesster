//
//  YkChessPieceKing.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/8/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessPiece.h"

@interface YkChessPieceKing : YkChessPiece

- (NSArray *) uncheckedAvailableSquares;
- (BOOL) isCloseCastlingOk;
- (BOOL) isFarCastlingOk;

- (YkChessSquare *) castleCloseSquare;
- (YkChessSquare *) castleFarSquare;

- (void) castleClose;
- (void) castleFar;

@end
