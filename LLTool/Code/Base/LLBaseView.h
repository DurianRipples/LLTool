//
//  LLBaseView.h
//  LLTool
//
//  Created by ios on 2019/1/7.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLBaseView : UIView

#pragma mark - after [super init] [super initWithFrame:frame] [super initWithCoder:aDecoder]
- (void)initializeItems;
- (void)makeConstraints;
- (void)bindItemsAction;

@end

NS_ASSUME_NONNULL_END
