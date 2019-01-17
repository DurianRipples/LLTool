//
//  LLVideoListDataSource.m
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLVideoListDataSource.h"

@implementation LLVideoListDataSource

- (instancetype)init {
    if (self = [super init]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSUInteger i = 0; i < 10; i++) {
            LLVideoListItem *item = [LLVideoListItem new]; item.thumbnail = @""; item.title = @""; item.videoURL = @""; item.pathID = @"videopage";
            [array addObject:item];
        }
        _items = [NSArray arrayWithArray:array];
    }
    return self;
}

@end
