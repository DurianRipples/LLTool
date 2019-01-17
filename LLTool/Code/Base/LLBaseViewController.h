//
//  LLBaseViewController.h
//  LLTool
//
//  Created by ios on 2019/1/7.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLBaseViewController : UIViewController

#pragma mark - initialize the navigation
- (void)assignmentNavigation;

#pragma mark - after [super viewDidLoad]
- (void)initializeItems;
- (void)makeConstraints;
- (void)bindItemsAction;

@end

NS_ASSUME_NONNULL_END
