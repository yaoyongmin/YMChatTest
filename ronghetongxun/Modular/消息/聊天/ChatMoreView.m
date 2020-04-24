//
//  ChatMoreView.m
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ChatMoreView.h"
#import "Define.h"
#import <UIView+MJExtension.h>
@interface ChatMoreView ()
{
    UITapGestureRecognizer *tapGes1;
    UITapGestureRecognizer *tapGes2;
    UITapGestureRecognizer *tapGes3;
    UITapGestureRecognizer *tapGes4;
}
@end
@implementation ChatMoreView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        
        tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        tapGes2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        tapGes3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];
        tapGes4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClickAction:)];

        [self.photoView addGestureRecognizer:tapGes1];
        [self.shotView addGestureRecognizer:tapGes2];
        [self.videoView addGestureRecognizer:tapGes3];
        [self.phoneView addGestureRecognizer:tapGes4];

        self.bottomLayout.constant -= kHomeIndicatorHeight();
        self.heightLayout.constant += kHomeIndicatorHeight();
    }
    return self;
}

- (void)itemClickAction:(UITapGestureRecognizer *)ges{
    
    NSInteger index = 0;
    
    if (ges == tapGes1) {
        index = 1;
    }
    if (ges == tapGes2) {
        index = 2;
    }
    if (ges == tapGes3) {
        index = 3;
    }
    if (ges == tapGes4) {
        index = 4;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ChatMoreView:didSelectRowAtIndex:)]) {
        [self.delegate ChatMoreView:self didSelectRowAtIndex:index];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch.view == self) {
        [self dismiss];
    }
}
- (void)show{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [view addSubview:self];
    
    [UIView animateWithDuration:1.f animations:^{
        self.bottomLayout.constant = 0;
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:1.f animations:^{
        self.bottomLayout.constant -= self.heightLayout.constant;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
