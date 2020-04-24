//
//  ChatVideoRightCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/23.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ChatVideoRightCell.h"

@implementation ChatVideoRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageAction:)];
    [self.videoPhotoView addGestureRecognizer:tapGes];
}

- (void)setMessageModel:(ICMessage *)messageModel{
    [super setMessageModel:messageModel];
    
    self.videoPhotoView.image = [UIImage imageNamed:@""];
}
- (void)clickImageAction:(UITapGestureRecognizer *)tap{
    
    [self routerEventWithName:YMRouterEventVideoTapEventName userInfo:@{@"videoPath":self.messageModel.videoPath}];
}
- (UIView *)getContentView{
    return self.videoPhotoView;
}
@end
