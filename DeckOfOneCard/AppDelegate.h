//
//  AppDelegate.h
//  DeckOfOneCard
//
//  Created by Haley Jones on 5/21/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

