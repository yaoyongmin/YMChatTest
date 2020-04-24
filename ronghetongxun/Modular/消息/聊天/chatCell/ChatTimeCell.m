//
//  ChatTimeCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/24.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ChatTimeCell.h"

@implementation ChatTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMessageModel:(ICMessage *)messageModel{
    [super setMessageModel:messageModel];
    self.dateLab.text = messageModel.sendDate;
}

///复写父类长按事件
- (void)longPressRecognizer:(UILongPressGestureRecognizer *)recognizer{
}
@end
