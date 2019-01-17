//
//  LLGZIPViewController.m
//  LLTool
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLGZIPViewController.h"

@interface LLGZIPViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *sendTextView;
@property (nonatomic, strong) NSTextContainer *container;
@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextStorage *textStorage;

@end

@implementation LLGZIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)assignmentNavigation {
    self.title = @"GZIP";
}

- (void)initializeItems {
    [self.view addSubview:self.sendTextView];
}

- (void)makeConstraints {
    [self.sendTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LLFloat(10));
        make.left.equalTo(self.view).offset(LLFloat(10));
        make.right.equalTo(self.view).offset(LLFloat(-10));
        make.height.mas_equalTo(LLFloat(150));
    }];
}

#pragma mark - lazyload
- (UITextView *)sendTextView {
    if (!_sendTextView) {
        [self.layoutManager addTextContainer:self.container];
        [self.textStorage addLayoutManager:self.layoutManager];
        _sendTextView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:self.container];
        _sendTextView.backgroundColor = [UIColor clearColor];
        _sendTextView.delegate = self;
        _sendTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);    //左右间距
        _sendTextView.layoutManager.allowsNonContiguousLayout = NO;         //TextView折行抖动
        _sendTextView.font = [UIFont systemFontOfSize:LLFloat(15) weight:UIFontWeightRegular];
    }
    return _sendTextView;
}

- (NSTextContainer *)container {
    if (!_container) {
        _container = [[NSTextContainer alloc] initWithSize:CGSizeMake(SCREEN_WIDTH-LLFloat(20), CGFLOAT_MAX)];
        _container.lineFragmentPadding = 0.f; //顶部间距
    }
    return _container;
}

- (NSLayoutManager *)layoutManager {
    if (!_layoutManager) {
        _layoutManager = [[NSLayoutManager alloc] init];
    }
    return _layoutManager;
}

- (NSTextStorage *)textStorage {
    if (!_textStorage) {
        _textStorage = [[NSTextStorage alloc] init];
    }
    return _textStorage;
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
