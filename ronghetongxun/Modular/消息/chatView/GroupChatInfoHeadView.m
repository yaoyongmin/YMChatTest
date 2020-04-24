//
//  GroupChatInfoHeadView.m
//  ronghetongxun
//
//  Created by yym on 2020/4/24.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "GroupChatInfoHeadView.h"
#import <Masonry.h>
#import "UIColor+YM.h"
#import "YMButton.h"
@interface GroupChatInfoHeadView ()

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *groupChatTitleLab;
@property (nonatomic, strong) UIImageView *allIconImageView;
@property (nonatomic, strong) UILabel *groupChatSubTitleLab;
@property (nonatomic, strong) UIView *groupModularInfoView;

@property (nonatomic, strong) YMButton *noticeBtn;
@property (nonatomic, strong) YMButton *photoBtn;
@property (nonatomic, strong) YMButton *fileBtn;
@property (nonatomic, strong) YMButton *qrCodeBtn;


@end
@implementation GroupChatInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headView];
        [self addSubview:self.groupChatTitleLab];
        [self addSubview:self.allIconImageView];
        [self addSubview:self.groupChatSubTitleLab];
        [self addSubview:self.groupModularInfoView];
        [self setGroupModularInfoViewSubViews];
        [self.groupModularInfoView addSubview:self.noticeBtn];
        [self.groupModularInfoView addSubview:self.photoBtn];
        [self.groupModularInfoView addSubview:self.fileBtn];
        [self.groupModularInfoView addSubview:self.qrCodeBtn];
    }
    return self;
}


- (void)clickItemAction:(UIButton *)sender{
    
    NSString *eventName = @"";
    if (sender == self.noticeBtn) {
        eventName = YMRouterEventGroupInfoItemNoticeEventName;
    }
    if (sender == self.photoBtn) {
         eventName = YMRouterEventGroupInfoItemPhotoEventName;
     }
    if (sender == self.fileBtn) {
         eventName = YMRouterEventGroupInfoItemFileEventName;
     }
    if (sender == self.qrCodeBtn) {
         eventName = YMRouterEventGroupInfoItemQRCodeEventName;
     }
    [self routerEventWithName:eventName userInfo:@{}];
}


- (void)setGroupModularInfoViewSubViews{
    NSArray *titles = @[@"群公告",@"图片",@"文件",@"二维码"];
    NSArray *imageNames = @[@"icon_groupInfo_notice",@"icon_groupInfo_photo",@"icon_groupInfo_file",@"icon_groupInfo_qrcode"];
    for (int i = 0; i <titles.count; i++) {
        [self createButtonWithTitle:titles[i] image:imageNames[i]];
    }
}

- (void)layoutSubviews{
    
    [self.groupChatSubTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_centerY).inset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(11);
    }];
    [self.groupChatTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_centerY).inset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(16);
    }];
    [self.allIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.groupChatTitleLab.mas_trailing).inset(10);
        make.width.height.mas_equalTo(CGSizeMake(30, 15));
        make.centerY.mas_equalTo(self.groupChatTitleLab);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
        make.width.mas_equalTo(self.mas_height).multipliedBy(0.3);
        make.bottom.mas_equalTo(self.groupChatTitleLab.mas_top).inset(15);
    }];
    
    [self.groupModularInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.groupChatSubTitleLab.mas_bottom).inset(20);
        make.leading.mas_equalTo(self.mas_leading).inset(40);
        make.trailing.mas_equalTo(self.mas_trailing).inset(40);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [self.noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.groupModularInfoView);
        make.width.mas_equalTo(self.groupModularInfoView.mas_width).multipliedBy(0.25);
        make.top.bottom.mas_equalTo(self.groupModularInfoView);
    }];
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.noticeBtn.mas_trailing);
        make.width.mas_equalTo(self.groupModularInfoView.mas_width).multipliedBy(0.25);
        make.top.bottom.mas_equalTo(self.groupModularInfoView);
    }];
    [self.fileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.photoBtn.mas_trailing);
        make.width.mas_equalTo(self.groupModularInfoView.mas_width).multipliedBy(0.25);
        make.top.bottom.mas_equalTo(self.groupModularInfoView);
    }];
    [self.qrCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.fileBtn.mas_trailing);
        make.width.mas_equalTo(self.groupModularInfoView.mas_width).multipliedBy(0.25);
        make.top.bottom.mas_equalTo(self.groupModularInfoView);
    }];
}

- (UIImageView *)headView{
    if (!_headView) {
        _headView                       = [[UIImageView alloc] init];
        _headView.backgroundColor       = [UIColor redColor];
        _headView.layer.masksToBounds   = YES;
        _headView.layer.cornerRadius    = 5.f;
    }
    return _headView;
}
- (UILabel *)groupChatTitleLab{
    if (!_groupChatTitleLab) {
        _groupChatTitleLab           = [[UILabel alloc] init];
        _groupChatTitleLab.text      = @"融合通信";
        _groupChatTitleLab.font      = [UIFont systemFontOfSize:17.f];
        _groupChatTitleLab.textColor = [UIColor ym_colorFromHexString:@"#333333"];
    }
    return _groupChatTitleLab;
}
- (UIImageView *)allIconImageView{
    if (!_allIconImageView) {
        _allIconImageView                 = [[UIImageView alloc] init];
        _allIconImageView.image           = [UIImage imageNamed:@""];
        _allIconImageView.backgroundColor = [UIColor blueColor];
    }
    return _allIconImageView;
}
- (UILabel *)groupChatSubTitleLab{
    if (!_groupChatSubTitleLab) {
        _groupChatSubTitleLab           = [[UILabel alloc] init];
        _groupChatSubTitleLab.text      = @"青岛融合通信科技有限公司";
        _groupChatSubTitleLab.font      = [UIFont systemFontOfSize:12.f];
        _groupChatSubTitleLab.textColor = [UIColor ym_colorFromHexString:@"#999999"];
    }
    return _groupChatSubTitleLab;
}
- (UIView *)groupModularInfoView{
    if (!_groupModularInfoView) {
        _groupModularInfoView   = [[UIView alloc] init];
    }
    return _groupModularInfoView;
}

- (UIButton *)createButtonWithTitle:(NSString *)title image:(NSString *)name{
    YMButton *btn = [YMButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor ym_colorFromHexString:@"#666666"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    btn.imageView.contentMode = UIViewContentModeCenter;
    
    if ([title isEqualToString:@"群公告"]) {
        self.noticeBtn = btn;
    }
    if ([title isEqualToString:@"图片"]) {
        self.photoBtn = btn;
    }
    if ([title isEqualToString:@"文件"]) {
        self.fileBtn = btn;
    }
    if ([title isEqualToString:@"二维码"]) {
        self.qrCodeBtn = btn;
    }
    return btn;
}
@end
