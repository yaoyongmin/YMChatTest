//
//  MessageViewCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/13.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MessageViewCell.h"
@interface MessageViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *unReadLab;


@end
@implementation MessageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setGroup:(YMGroup *)group{
    _group = group;
    
    self.usernameLabel.text = group.gName;
    self.dateLabel.text = @"11:20";
    self.messageLabel.text = group.lastMsgString;
    self.unReadLab.text = [NSString stringWithFormat:@"%d",group.unReadCount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
