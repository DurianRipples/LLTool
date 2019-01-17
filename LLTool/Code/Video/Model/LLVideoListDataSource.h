//
//  LLVideoListDataSource.h
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLVideoListItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLVideoListDataSource : NSObject

@property (nonatomic, strong, readonly) NSArray <LLVideoListItem *> *items;

@end

NS_ASSUME_NONNULL_END
