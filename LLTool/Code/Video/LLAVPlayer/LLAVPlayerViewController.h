//
//  LLAVPlayerViewController.h
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLAVPlayerViewController : UIViewController

/**
 单个视频播放

 @param URL 视频URL
 @return 播放器
 */
- (instancetype)initWithURL:(NSURL *)URL;

/**
 多个视频联播

 @param URLs 视频URLs
 @return 播放器
 */
- (instancetype)initWithURLs:(NSArray *)URLs;

- (void)play;

@end

NS_ASSUME_NONNULL_END
