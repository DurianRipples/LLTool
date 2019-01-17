//
//  LLBaseView.m
//  LLTool
//
//  Created by ios on 2019/1/7.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLBaseView.h"

@implementation LLBaseView

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self initializeItems];
    [self makeConstraints];
    [self bindItemsAction];
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
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
