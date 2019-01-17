//
//  LLToolsViewController.m
//  LLTool
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLToolsViewController.h"
#import "LLToolsTableView.h"
#import "LLDispatchCenter.h"

@interface LLToolsViewController ()

@property (nonatomic, strong) LLToolsTableView *toolsTableView;

@end

@implementation LLToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initializeItems {
    [self.view addSubview:self.toolsTableView];
}

- (void)bindItemsAction {
    @weakify(self);
    self.toolsTableView.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, LLTool * _Nonnull tool) {
        @strongify(self);
        [self.navigationController pushViewController:[[LLDispatchCenter sharedInstance] controllerForPathID:tool.pathID] animated:YES];
    };
}

#pragma mark - lazyload
- (LLToolsTableView *)toolsTableView {
    if (!_toolsTableView) {
        _toolsTableView = [[LLToolsTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_toolsTableView registerClass:[LLToolsCell class] forCellReuseIdentifier:[LLToolsCell reuseID]];
    }
    return _toolsTableView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
