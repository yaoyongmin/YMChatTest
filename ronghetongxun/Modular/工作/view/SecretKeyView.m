//
//  SecretKeyView.m
//  ronghetongxun
//
//  Created by yym on 2020/5/6.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "SecretKeyView.h"

@implementation SecretKeyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];    
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.view == self) {
        [self dismiss:nil];
    }
}
- (IBAction)copyAction:(id)sender {
    
    UIPasteboard *pasteboard  = [UIPasteboard generalPasteboard];
    pasteboard.string         = self.secretKeyLab.text;
    [MBProgressHUD showTextMessage:@"复制成功！"];
}

- (void)show:(UIView *)superView{
    if (superView) {
        [superView addSubview:self];
    }
}

- (IBAction)dismiss:(id)sender{
    [self removeFromSuperview];
}


@end
