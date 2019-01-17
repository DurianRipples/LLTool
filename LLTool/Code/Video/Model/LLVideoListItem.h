//
//  LLVideoListItem.h
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLVideoListItem : NSObject

@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, strong) NSString *pathID;

@end

NS_ASSUME_NONNULL_END
