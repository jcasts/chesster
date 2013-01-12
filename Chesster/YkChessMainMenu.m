//
//  YkChessMainMenu.m
//  Chesster
//
//  Created by Jeremie Castagna on 1/11/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import "YkChessMainMenu.h"
#import "YkChessMainMenuItem.h"
#import "YkChessAppDelegate.h"
#import "CCMenuAdvanced.h"
#import "CCMenu.h"
#import "CCScrollNode.h"

@implementation YkChessMainMenu

+(id) menuWithGames:(NSArray *)games ForRect:(CGRect)rect {
    return [[self alloc] initWithGames:(NSArray *)games ForRect:rect];
}

- (id) initWithGames:(NSArray *)games ForRect:(CGRect)rect {
    if(!(self=[super init])) return self;
    
    _smallScreen = NO;
    if(rect.size.width == 320.0) _smallScreen = YES;

    
    CCLayer *sublayer = [[CCLayer alloc] init];
    
    float y = 0.0;//rect.size.height/2.0;
    float h = 0.0;
    
    CCMenu *menu = [self menu];
    menu.position = CGPointMake(menu.position.x, y);
    y = y + menu.contentSize.height;
    h = h + menu.contentSize.height;
    [sublayer addChild:menu];
    
    CCMenu *gmenu = [self gamesMenu:games];
    if(gmenu){
        y = y + 30.0;
        h = h + gmenu.contentSize.height + 30.0;
        gmenu.position = CGPointMake(gmenu.position.x, y);
        
        [sublayer addChild:gmenu];
    }
    
    sublayer.contentSize = CGSizeMake(sublayer.contentSize.width, h);
    
    if(_smallScreen){
        [self setScaleX:0.85];
        [self setScaleY:0.85];
    }
    
    
    if([sublayer boundingBox].size.height > rect.size.height){
        sublayer.position = CGPointMake(sublayer.position.x, (rect.size.height)-(sublayer.contentSize.height));
        
        CCScrollNode *scroller = [CCScrollNode node];
        scroller.scrollView.showsVerticalScrollIndicator = NO;
        [scroller addChild:sublayer];
        
        scroller.scrollView.contentSize = sublayer.contentSize;
        [self addChild: scroller];
    } else {
        sublayer.position = CGPointMake(sublayer.position.x, (rect.size.height/2.0)-(sublayer.contentSize.height/2.0));
        [self addChild: sublayer];
    }
    
    return self;
}

-(CCMenu *)gamesMenu:(NSArray *)games {
    NSMutableArray *ary = [NSMutableArray array];
    float y = 0.0;
    
    for(YkChessGame *game in games){
        YkChessMainMenuItem *item = [[YkChessMainMenuItem alloc] initWithTarget:self
                                                                       Selector:@selector(resumeGame:)
                                                                       Filename:@"board_icon_b.png"];
        
        [item setTitle:[NSString stringWithFormat:@"%@'s turn", game.currentPlayer.name]];
        [item setDescription:game.lastMoveDesc];
        item.position = CGPointMake(item.position.x, y);
        y = y + 10.0 + item.contentSize.height;
        [ary addObject:item];
    }
    
    if([ary count] == 0) return nil;
    
    CCMenu *menu = [CCMenu menuWithArray:ary];
    menu.isTouchEnabled = YES;
    menu.contentSize = CGSizeMake(menu.contentSize.width, y-10.0);
    return menu;
}


-(CCMenu *)menu {
    YkChessMainMenuItem *newGameButton = [[YkChessMainMenuItem alloc] initWithTarget:self
                                                                            Selector:@selector(newGame:)
                                                                            Filename:@"new_game_icon.png"];
    
    YkChessMainMenuItem *newOnlineGameButton = [[YkChessMainMenuItem alloc] initWithTarget:self
                                                                                  Selector:@selector(newOnlineGame:)
                                                                                  Filename:@"new_game_icon_o.png"];
    
    YkChessMainMenuItem *settingsButton = [[YkChessMainMenuItem alloc] initWithTarget:self
                                                                             Selector:@selector(settings:)
                                                                             Filename:@"settings_icon.png"];
    
    
    CCMenu *menu = [CCMenu menuWithItems:newGameButton, newOnlineGameButton, settingsButton, nil];
    menu.isTouchEnabled = YES;
    menu.contentSize = CGSizeMake(menu.contentSize.width, newGameButton.contentSize.height);
    
    [menu alignItemsHorizontally];
    
    return menu;
}


-(void) newGame:(id)sender {
    NSLog(@"CLICKED NEW GAME");
    CCDirectorIOS *director = (CCDirectorIOS*)[CCDirector sharedDirector];
    [(YkChessAppDelegate*)(director.delegate) startNewGame];
}

-(void) newOnlineGame:(id)sender {
    NSLog(@"CLICKED NEW ONLINE GAME");
    // TODO: Implement
}

-(void) resumeGame:(id)sender {
    NSLog(@"CLICK RESUME GAME");
}

-(void) settings:(id)sender {
    NSLog(@"CLICKED SETTINGS");
    // TODO: Implement
}


@end
