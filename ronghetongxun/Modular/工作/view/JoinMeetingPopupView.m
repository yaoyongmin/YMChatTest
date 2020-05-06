//
//  JoinMeetingPopupView.m
//  ronghetongxun
//
//  Created by yym on 2020/5/6.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "JoinMeetingPopupView.h"
#import "XLPasswordInputView.h"
#import "UIColor+YM.h"
#import <Masonry.h>
@interface JoinMeetingPopupView ()

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIButton *dismissBtn;
@property (nonatomic, strong) XLPasswordInputView *passwordInputView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, copy) NSString *password;

@end

@implementation JoinMeetingPopupView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
        [self addSubview:self.mainView];
        [self.mainView addSubview:self.titleLab];
        [self.mainView addSubview:self.dismissBtn];
        [self.mainView addSubview:self.passwordInputView];
        [self.mainView addSubview:self.confirmBtn];
    }
    return self;
}

- (void)confirmAction{
    if (self.password.length <6) {
        [MBProgressHUD showTextMessage:@"请输入正确的密码格式！"];
        return;
    }
    [self dismiss];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(joinMeetingPopupViewWithConfirmAction:)]) {
        [self.delegate joinMeetingPopupViewWithConfirmAction:self.password];
    }
}

- (void)show:(UIView *)superView{
    if (superView) {
        [superView addSubview:self];
    }
}

- (void)dismiss{
    [self removeFromSuperview];
}

- (void)layoutSubviews{
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.leading.trailing.mas_equalTo(self).inset(40);
        make.height.mas_equalTo(self.mas_width).multipliedBy(0.6);
    }];
    [self.dismissBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.mainView.mas_trailing).inset(15);
        make.width.height.mas_equalTo(11);
        make.top.mas_equalTo(self.mainView.mas_top).inset(15);
    }];
    [self.passwordInputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.mainView);
        make.leading.trailing.mas_equalTo(self.mainView).inset(30);
        make.height.mas_equalTo(@40);
    }];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainView.mas_top);
        make.bottom.mas_equalTo(self.passwordInputView.mas_top);
        make.centerX.mas_equalTo(self.mainView.mas_centerX);
    }];
    [self.confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mainView.mas_bottom).inset(20);
        make.leading.trailing.mas_equalTo(self.mainView).inset(40);
        make.height.mas_equalTo(40);
    }];
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.layer.masksToBounds = YES;
        _mainView.layer.cornerRadius = 10.f;
    }
    return _mainView;
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor ym_colorFromHexString:@"#333333"];
        _titleLab.font = [UIFont systemFontOfSize:14.f];
        _titleLab.text = @"加入会议";
    }
    return _titleLab;
}

- (UIButton *)dismissBtn{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissBtn setImage:[UIImage imageNamed:@"icon_meeting_dismiss"] forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

- (XLPasswordInputView *)passwordInputView{
    if (!_passwordInputView) {
        WeakSelf
        _passwordInputView = [XLPasswordInputView passwordInputViewWithPasswordLength:6];
        _passwordInputView.gridLineColor = [UIColor ym_colorFromHexString:@"#E5E5E5"];
        _passwordInputView.dotColor = [UIColor blackColor];
        _passwordInputView.passwordBlock = ^(NSString *password) {
            weakSelf.password = password;
        };
    }
    return _passwordInputView;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.backgroundColor = [UIColor ym_colorFromHexString:@"#3D8BEC"];
        [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.layer.cornerRadius = 20.f;
        [_confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

@end
