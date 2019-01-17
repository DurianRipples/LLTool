//
//  LLBaseViewController.m
//  LLTool
//
//  Created by ios on 2019/1/7.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLBaseViewController.h"

@interface LLBaseViewController ()

@end

@implementation LLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self assignmentNavigation];
    [self initializeItems];
    [self makeConstraints];
    [self bindItemsAction];
}

- (void)assignmentNavigation {
    
}

- (void)initializeItems {
    ;
}

- (void)makeConstraints {
    ;
}

- (void)bindItemsAction {
    ;
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
