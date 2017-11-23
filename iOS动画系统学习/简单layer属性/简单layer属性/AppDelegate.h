//
//  AppDelegate.h
//  简单layer属性
//
//  Created by lalala on 2017/11/15.
//  Copyright © 2017年 吕山虎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

