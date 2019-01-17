//
//  LLDispatchCenter.h
//  LLTool
//
//  Created by ios on 2019/1/9.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLDispatchCenter : NSObject

SGR_SINGLETION(LLDispatchCenter);

- (LLBaseViewController *)controllerForPathID:(NSString *)pathID;

@end

NS_ASSUME_NONNULL_END
