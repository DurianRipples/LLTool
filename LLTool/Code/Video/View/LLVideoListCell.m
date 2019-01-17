//
//  LLVideoListCell.m
//  LLTool
//
//  Created by ios on 2019/1/15.
//  Copyright © 2019 LiuLian. All rights reserved.
//

#import "LLVideoListCell.h"

@implementation LLVideoListCell

+ (NSString *)reuseID {
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
