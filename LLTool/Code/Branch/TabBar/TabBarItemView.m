//
//  TabBarItemView.m
//  LLTool
//
//  Created by ios on 2019/1/7.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "TabBarItemView.h"

@interface TabBarItemView ()

@property (nonatomic, strong) UIImageView *icon;

@end

@implementation TabBarItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        ;
    }
    return self;
}

- (void)initializeItems {
    [self addSubview:self.icon];
}

- (void)makeConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LLFloat(40), LLFloat(40)));
        make.center.equalTo(self);
    }];
}

- (void)updateItem:(NSString *)name {
    self.icon.image = [UIImage octicon_imageWithIcon:name backgroundColor:[UIColor clearColor] iconColor:RGBHEX(f54343) iconScale:1 andSize:self.icon.bounds.size];
}

#pragma mark - lazyload
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _icon.userInteractionEnabled = YES;
    }
    return _icon;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
