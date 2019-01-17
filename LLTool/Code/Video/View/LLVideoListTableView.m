//
//  LLVideoListTableView.m
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLVideoListTableView.h"

@interface LLVideoListTableView ()

@property (nonatomic, strong) LLVideoListDataSource *itemsDataSource;

@end

@implementation LLVideoListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0) {
    ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ceil(SCREEN_WIDTH/16*9);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LLVideoListItem *item = self.itemsDataSource.items[indexPath.row];
    if (self.didSelectRowAtIndexPath) self.didSelectRowAtIndexPath(tableView, indexPath, item);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsDataSource.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:[LLVideoListCell reuseID] forIndexPath:indexPath];
    return cell;
}

#pragma mark - lazyload
- (LLVideoListDataSource *)itemsDataSource {
    if (!_itemsDataSource) {
        _itemsDataSource = [LLVideoListDataSource new];
    }
    return _itemsDataSource;
}

@end
