//
//  LLDispatchCenter.m
//  LLTool
//
//  Created by ios on 2019/1/9.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLDispatchCenter.h"

@interface LLDispatchCenter ()

@property (nonatomic, strong, readonly) NSDictionary *pathMap;

@end

@implementation LLDispatchCenter

SGR_DEF_SINGLETION(LLDispatchCenter)

- (instancetype)init {
    if (self = [super init]) {
        _pathMap = @{@"gzip":@"LLGZIPViewController",
                     @"video":@"LLVideoListViewController",
                     @"videopage":@"LLVideoPageViewController",
                     @"lottie":@"LLLottieImageViewController",
                     };
    }
    return self;
}

- (LLBaseViewController *)controllerForPathID:(NSString *)pathID {
    NSString *controllerName = [_pathMap objectForKey:pathID];
    if (controllerName) {
        LLBaseViewController *controller = [[NSClassFromString(controllerName) alloc] init];
        if (controller) return controller;
    }
    return nil;
}

@end
