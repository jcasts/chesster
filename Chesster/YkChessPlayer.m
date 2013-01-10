//
//  YkChessPlayer.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessPlayer.h"
#import "YkChessPieceQueen.h"

@implementation YkChessPlayer

@synthesize name;

- (Class) promotePrompt {
    // TODO: Implement
    return [YkChessPieceQueen class];
}

@end
