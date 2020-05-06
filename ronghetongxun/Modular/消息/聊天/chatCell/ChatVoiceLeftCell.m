//
//  ChatVoiceLeftCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/27.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ChatVoiceLeftCell.h"
@implementation ChatVoiceLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageAction:)];
    [self.contentView addGestureRecognizer:tapGes];
}

- (void)clickImageAction:(UITapGestureRecognizer *)tap{
    
    [self routerEventWithName:YMRouterEventVoiceTapEventName userInfo:@{@"voicePath":self.messageModel.voicePath}];
}
- (UIView *)getContentView{
    return self.contentView;
}

@end
