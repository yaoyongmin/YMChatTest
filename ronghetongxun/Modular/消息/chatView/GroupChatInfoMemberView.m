//
//  GroupChatInfoMemberView.m
//  ronghetongxun
//
//  Created by yym on 2020/4/24.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "GroupChatInfoMemberView.h"
#import "ICMessageConst.h"
#import "UIColor+YM.h"
#import <Masonry.h>
@interface GroupChatInfoMemberView ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *allMembersBtn;
@property (nonatomic, strong) UIView *membersView;

@end
@implementation GroupChatInfoMemberView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.allMembersBtn];
        [self addSubview:self.membersView];
    }
    return self;
}

- (void)lookGroupMemberListAction{
    [self routerEventWithName:YMRouterEventGroupInfoMemberListEventName userInfo:@{}];
}

- (void)layoutSubviews{
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13);
        make.leading.mas_equalTo(10);
        make.height.mas_equalTo(13);
    }];
    [self.allMembersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
        make.trailing.mas_equalTo(self.mas_trailing).inset(10);
        make.height.mas_equalTo(13);
    }];
    [self.membersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).inset(18);
        make.leading.trailing.mas_equalTo(10);
        make.bottom.mas_equalTo(self.mas_bottom).inset(10);
    }];
}

- (void)setMembersData:(NSArray *)members{
    if (members.count>0) {
        CGFloat h = (kScreenWidth()-100) / 9;
        NSInteger count = members.count > 9 ? 9: members.count;
        for (int i =0; i<count; i++) {
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.backgroundColor = [UIColor yellowColor];
            [self.membersView addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.membersView.mas_leading).inset(i*10 + i*h);
                make.width.height.mas_equalTo(h);
                make.centerY.mas_equalTo(self.membersView.mas_centerY);
            }];
        }
    }
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"群成员";
        _titleLab.font = [UIFont systemFontOfSize:14.f];
    }
    return _titleLab;
}
- (UIButton *)allMembersBtn{
    if (!_allMembersBtn) {
        _allMembersBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allMembersBtn setTitle:@"全部成员" forState:UIControlStateNormal];
        [_allMembersBtn.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [_allMembersBtn setTitleColor:[UIColor ym_colorFromHexString:@"#666666"] forState:UIControlStateNormal];
        [_allMembersBtn addTarget:self action:@selector(lookGroupMemberListAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allMembersBtn;
}

- (UIView *)membersView{
    if (!_membersView) {
        _membersView = [[UIView alloc] init];
    }
    return _membersView;
}
@end
