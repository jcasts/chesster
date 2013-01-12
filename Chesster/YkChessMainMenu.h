//
//  YkChessMainMenu.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/11/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "CCLayer.h"

@interface YkChessMainMenu : CCLayer {
    BOOL _smallScreen;
}

+(id) menuWithGames:(NSArray *)games ForRect:(CGRect)rect;
-(id) initWithGames:(NSArray *)games ForRect:(CGRect)rect;

-(void) newGame:(id)sender;
-(void) newOnlineGame:(id)sender;
-(void) settings:(id)sender;

@end
