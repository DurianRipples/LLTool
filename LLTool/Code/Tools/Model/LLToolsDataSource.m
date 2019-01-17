//
//  LLToolsDataSource.m
//  LLTool
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLToolsDataSource.h"

@implementation LLToolsDataSource

- (instancetype)init {
    if (self = [super init]) {
        LLTool *gzip = [LLTool new]; gzip.name = @"GZIP"; gzip.icon = OCTIconFileZip; gzip.pathID = @"gzip";
        LLTool *video = [LLTool new]; video.name = @"VIDEO"; video.icon = OCTIconDeviceCameraVideo; video.pathID = @"video";
        LLTool *lottie = [LLTool new]; lottie.name = @"Lottie"; lottie.icon = OCTIconGift; lottie.pathID = @"lottie";
        _tools = @[gzip, video, lottie];
    }
    return self;
}

@end
