//
//  ChatInfoLeftCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/16.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ChatInfoLeftCell.h"

@implementation ChatInfoLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
- (void)setMessageModel:(ICMessage *)messageModel{
    
    self.contentLab.text = messageModel.content;
    
    switch (messageModel.deliveryState) {
        case ICMessageDeliveryState_Delivering:

            break;
        case ICMessageDeliveryState_Delivered:
            self.activityView.hidden = YES;
            break;
        case ICMessageDeliveryState_Failure:
            self.activityView.hidden = YES;
            break;
        default:
            break;
    }
}

- (UIView *)getContentView{
    return self.contentLab;
}
@end
