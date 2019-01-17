//
//  LLToolsDataSource.h
//  LLTool
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLToolsDataSource : NSObject

@property (nonatomic, strong, readonly) NSArray <LLTool *> *tools;

@end

NS_ASSUME_NONNULL_END
