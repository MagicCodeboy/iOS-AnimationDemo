//
//  AppDelegate.h
//  简单的绘图应用
//
//  Created by lalala on 2017/11/22.
//  Copyright © 2017年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

