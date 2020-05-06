//
//  ScheduleCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/28.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 16;
    frame.size.width -= 2 * 16;
    [super setFrame:frame];
}

@end
