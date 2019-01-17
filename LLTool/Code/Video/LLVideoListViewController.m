//
//  LLVideoListViewController.m
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLVideoListViewController.h"
#import "LLVideoListTableView.h"
#import "LLDispatchCenter.h"

@interface LLVideoListViewController ()

@property (nonatomic, strong) LLVideoListTableView *listTableView;

@end

@implementation LLVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)assignmentNavigation {
    self.title = @"VIDEO";
}

- (void)initializeItems {
    [self.view addSubview:self.listTableView];
}

- (void)bindItemsAction {
    @weakify(self);
    self.listTableView.didSelectRowAtIndexPath = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, LLVideoListItem * _Nonnull item) {
        @strongify(self);
        [self.navigationController pushViewController:[[LLDispatchCenter sharedInstance] controllerForPathID:item.pathID] animated:YES];
    };
}

#pragma mark - lazyload
- (LLVideoListTableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[LLVideoListTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_listTableView registerClass:[LLVideoListCell class] forCellReuseIdentifier:[LLVideoListCell reuseID]];
    }
    return _listTableView;
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
