//
//  LLBaseTabBarController.m
//  LLTool
//
//  Created by ios on 2019/1/7.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLBaseTabBarController.h"
#import "LLToolsViewController.h"
#import "LLProgramViewController.h"

@interface LLBaseTabBarController () <UITabBarControllerDelegate>

@property (nonatomic, strong) LLToolsViewController *tools;
@property (nonatomic, strong) LLProgramViewController *program;
@property (nonatomic, strong) UIBarButtonItem *setting;

@end

@implementation LLBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.translucent = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [self viewLoadSuccessful];
}

- (void)viewLoadSuccessful {
    self.navigationItem.title = @"LLUtils";
    self.navigationItem.rightBarButtonItem = self.setting;
    self.viewControllers = @[self.tools, self.program];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    ;
}

#pragma mark - lazyload
- (LLToolsViewController *)tools {
    if (!_tools) {
        _tools = [LLToolsViewController new];
        _tools.tabBarItem.title = @"工具";
        _tools.tabBarItem.image = [UIImage octicon_imageWithIcon:[NSString octicon_iconDescriptionForEnum:OCTIconTools] backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] iconScale:1 andSize:CGSizeMake(LLFloat(20), LLFloat(20))];
    }
    return _tools;
}

- (LLProgramViewController *)program {
    if (!_program) {
        _program = [LLProgramViewController new];
        _program.tabBarItem.title = @"程序";
        _program.tabBarItem.image = [UIImage octicon_imageWithIcon:[NSString octicon_iconDescriptionForEnum:OCTIconSquirrel] backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] iconScale:1 andSize:CGSizeMake(LLFloat(20), LLFloat(20))];
    }
    return _program;
}

- (UIBarButtonItem *)setting {
    if (!_setting) {
        _setting = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage octicon_imageWithIcon:[NSString octicon_iconDescriptionForEnum:OCTIconGear] backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] iconScale:1 andSize:CGSizeMake(LLFloat(20), LLFloat(20))] style:UIBarButtonItemStylePlain handler:^(id sender) {
            ;
        }];
    }
    return _setting;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
