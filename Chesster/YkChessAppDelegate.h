//
//  YkChessAppDelegate.h
//  Chesster
//
//  Created by Jeremie Castagna on 1/7/13.
//  Copyright (c) 2013 Yaks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YkChessGame.h"
#import "cocos2d.h"

@interface YkChessAppDelegate : UIResponder <UIApplicationDelegate, CCDirectorDelegate>{
    BOOL _isIPhone;
}

@property (strong, nonatomic) UIWindow *window;
@property CCDirectorIOS *director;
@property (readonly) UINavigationController *navController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic) NSArray *games;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)showMainMenu;
- (void)showSettingsMenu;
- (void)showGame: (YkChessGame *)game;
- (void)startNewGame;

@end
