//
//  LLToolsTableView.m
//  LLTool
//
//  Created by ios on 2019/1/8.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLToolsTableView.h"

@interface LLToolsTableView ()

@property (nonatomic, strong) LLToolsDataSource *toolsDataSource;

@end

@implementation LLToolsTableView

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
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LLTool *tool = self.toolsDataSource.tools[indexPath.row];
    if (self.didSelectRowAtIndexPath) self.didSelectRowAtIndexPath(tableView, indexPath, tool);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.toolsDataSource.tools count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLToolsCell *cell = [tableView dequeueReusableCellWithIdentifier:[LLToolsCell reuseID] forIndexPath:indexPath];
    LLTool *tool = self.toolsDataSource.tools[indexPath.row];
    cell.textLabel.text = tool.name;
    cell.imageView.image = [UIImage octicon_imageWithIcon:[NSString octicon_iconDescriptionForEnum:tool.icon] backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] iconScale:1 andSize:CGSizeMake(LLFloat(20), LLFloat(20))];
    return cell;
}

#pragma mark - lazyload
- (LLToolsDataSource *)toolsDataSource {
    if (!_toolsDataSource) {
        _toolsDataSource = [LLToolsDataSource new];
    }
    return _toolsDataSource;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
