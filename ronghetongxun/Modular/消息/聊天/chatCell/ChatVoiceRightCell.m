//
//  ChatVoiceRightCell.m
//  ronghetongxun
//
//  Created by yym on 2020/4/27.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ChatVoiceRightCell.h"
#import "ICRecordManager.h"

@implementation ChatVoiceRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageAction:)];
    [self.contentView addGestureRecognizer:tapGes];
}

- (void)setMessageModel:(ICMessage *)messageModel{
    [super setMessageModel:messageModel];
    
    self.voiceLab.text = [NSString stringWithFormat:@"%ld秒",[[ICRecordManager shareManager] durationWithVideoPath:messageModel.voicePath]];
}
- (void)clickImageAction:(UITapGestureRecognizer *)tap{
    
    [self routerEventWithName:YMRouterEventVoiceTapEventName userInfo:@{@"voicePath":self.messageModel.voicePath}];
}
- (UIView *)getContentView{
    return self.backGroundView;
}

@end
