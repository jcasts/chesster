//
//  YkChessPlayer.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface YkChessPlayer : NSManagedObject

- (Class) promotePrompt;

@property (nonatomic, retain) NSString *name;

@end
