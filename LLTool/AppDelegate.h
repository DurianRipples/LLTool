//
//  AppDelegate.h
//  LLTool
//
//  Created by ios on 2019/1/7.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLBaseNavigationController.h"
#import "LLBaseTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LLBaseNavigationController *rootNavigation;
@property (strong, nonatomic) LLBaseTabBarController *rootTabBar;

@end

