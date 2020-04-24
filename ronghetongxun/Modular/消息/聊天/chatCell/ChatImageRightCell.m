//
//  ChatImageRightCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/23.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ChatImageRightCell.h"

@implementation ChatImageRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageAction:)];
    [self.photoView addGestureRecognizer:tapGes];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageAction:)];
        [self.photoView addGestureRecognizer:tapGes];
    }
    return self;
}

- (void)setMessageModel:(ICMessage *)messageModel{
    [super setMessageModel:messageModel];

    self.photoView.image = messageModel.image;
}


- (void)clickImageAction:(UITapGestureRecognizer *)tap{
    
    [self routerEventWithName:YMRouterEventImageTapEventName userInfo:@{@"msgModel":self.messageModel}];
}
- (UIView *)getContentView{
    return self.photoView;
}
@end
