//
//  LLVideoPageViewController.m
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLVideoPageViewController.h"
#import "LLAVPlayerViewController.h"

@interface LLVideoPageViewController ()

@property (nonatomic, strong) LLAVPlayerViewController *player;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation LLVideoPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)initializeItems {
    [self.view addSubview:self.player.view];
    [self.view addSubview:self.backButton];
    [self.view bringSubviewToFront:self.backButton];
}

- (void)makeConstraints {
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(ceil(SCREEN_WIDTH/16*9));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(LLFloat(45), 45));
    }];
}

- (void)bindItemsAction {
    @weakify(self);
    [self.backButton bk_addEventHandler:^(id sender) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - lazyload
- (LLAVPlayerViewController *)player {
    if (!_player) {
        _player = [[LLAVPlayerViewController alloc] initWithURL:[NSURL URLWithString:@"http://120.52.51.96/vjs.zencdn.net/v/oceans.mp4"]];
    }
    return _player;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setBackgroundImage:[UIImage octicon_imageWithIcon:[NSString octicon_iconDescriptionForEnum:OCTIconArrowSmallLeft] backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] iconScale:1 andSize:CGSizeMake(LLFloat(45), LLFloat(45))] forState:UIControlStateNormal];
    }
    return _backButton;
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
