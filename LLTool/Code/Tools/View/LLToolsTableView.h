//
//  LLToolsTableView.h
//  LLTool
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLToolsCell.h"
#import "LLToolsDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLToolsTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) void (^didSelectRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath, LLTool *tool);

@end

NS_ASSUME_NONNULL_END
