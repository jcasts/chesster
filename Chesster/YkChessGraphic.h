//
//  YkChessGraphic.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface YkChessGraphic : NSManagedObject

- (CGPoint) coord;
- (void) reset;
- (void) select;
- (void) highlight;
- (void) moveToCoord: (CGPoint)coord;

@property (nonatomic) NSObject *chessObject;

@end
