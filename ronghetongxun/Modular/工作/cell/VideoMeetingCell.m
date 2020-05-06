//
//  VideoMeetingCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/29.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "VideoMeetingCell.h"

@implementation VideoMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds;

    self.layer.cornerRadius;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
