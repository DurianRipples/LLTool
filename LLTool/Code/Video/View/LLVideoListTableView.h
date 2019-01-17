//
//  LLVideoListTableView.h
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLVideoListCell.h"
#import "LLVideoListDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLVideoListTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) void (^didSelectRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath, LLVideoListItem *item);

@end

NS_ASSUME_NONNULL_END
