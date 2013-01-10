//
//  YkChessMove.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YkChessSquare.h"
#import "YkChessPlayer.h"

@interface YkChessMove : NSManagedObject

- (YkChessPlayer *) player;

@property (nonatomic) YkChessPiece *chessPiece;
@property (nonatomic) YkChessPiece *capturedChessPiece;
@property (nonatomic) YkChessSquare *startSquare;
@property (nonatomic) YkChessSquare *endSquare;

@end
