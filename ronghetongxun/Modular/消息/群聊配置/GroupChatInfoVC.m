//
//  GroupChatInfoVC.m
//  ronghetongxun
//
//  Created by yym on 2020/4/23.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "GroupChatInfoVC.h"
#import "GroupNoticeViewController.h"
#import "GroupPhotoViewController.h"
#import "GroupFileViewController.h"
#import "GroupQRCodeViewController.h"
#import "GroupMemberListVC.h"

#import "GroupChatInfoHeadView.h"
#import "GroupChatInfoMemberView.h"

#import "UIColor+YM.h"
#import <Masonry.h>

@interface GroupChatInfoVC ()

@property (nonatomic, strong) UIScrollView *mainView;
@property (nonatomic, strong) GroupChatInfoHeadView *headView;
@property (nonatomic, strong) GroupChatInfoMemberView *memberView;
@property (nonatomic, strong) UILabel *autographLab;
@property (nonatomic, strong) UIButton *autographBtn;
@property (nonatomic, strong) UIButton *clearAllBtn;
@property (nonatomic, strong) UIButton *signOutBtn;

@end

@implementation GroupChatInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天信息";
    
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.headView];
    [self.mainView addSubview:self.memberView];
    [self.mainView addSubview:self.autographLab];
    [self.mainView addSubview:self.autographBtn];
    [self.mainView addSubview:self.clearAllBtn];
    [self.mainView addSubview:self.signOutBtn];
    
    [self setSubViewsLayout];
    
    [self.memberView setMembersData:@[@"",@"",@"",@"",@"",@"",@"",@"",@""]];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    if ([eventName isEqualToString: YMRouterEventGroupInfoItemNoticeEventName]) {
        GroupNoticeViewController *noticeVC = [[GroupNoticeViewController alloc] init];
        [self.navigationController pushViewController:noticeVC animated:YES];
    }
    if ([eventName isEqualToString: YMRouterEventGroupInfoItemPhotoEventName]) {
        GroupPhotoViewController *photoVC = [[GroupPhotoViewController alloc] init];
        [self.navigationController pushViewController:photoVC animated:YES];
    }
    if ([eventName isEqualToString: YMRouterEventGroupInfoItemFileEventName]) {
        GroupFileViewController *fileVC = [[GroupFileViewController alloc] init];
        [self.navigationController pushViewController:fileVC animated:YES];
    }
    if ([eventName isEqualToString: YMRouterEventGroupInfoItemQRCodeEventName]) {
        GroupQRCodeViewController *qrCodeVC = [[GroupQRCodeViewController alloc] init];
        [self.navigationController pushViewController:qrCodeVC animated:YES];
    }
    if ([eventName isEqualToString:YMRouterEventGroupInfoMemberListEventName]) {
        GroupMemberListVC *listVc = [[GroupMemberListVC alloc] init];
        [self.navigationController pushViewController:listVc animated:YES];
    }
}

- (void)editGroupNoticeAction{
 
    NSLog(@"群签名！");
}

- (void)clearAllRecordAction{
    
    NSLog(@"清空聊天记录");
}

- (void)setSubViewsLayout{
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.signOutBtn.mas_bottom);
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mainView.mas_top);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.33);
    }];
    [self.memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom).inset(10);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(@80);
    }];
    [self.autographLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.memberView.mas_bottom).inset(10);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(@40);
    }];
    [self.autographBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view.mas_trailing).inset(10);
        make.centerY.mas_equalTo(self.autographLab.mas_centerY);
        make.height.mas_equalTo(@40);
    }];
    [self.clearAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.autographLab.mas_bottom).inset(10);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(@40);
    }];
    [self.signOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clearAllBtn.mas_bottom).inset(10);
        make.leading.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(@40);
    }];
}

- (UIScrollView *)mainView{
    if (!_mainView) {
        _mainView = [[UIScrollView alloc] init];
        _mainView.showsHorizontalScrollIndicator = NO;
        _mainView.showsVerticalScrollIndicator = NO;
        _mainView.scrollsToTop = NO;
        _mainView.backgroundColor = [UIColor ym_colorFromHexString:@"#F7F8F9"];
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _mainView;
}

- (GroupChatInfoMemberView *)memberView{
    if (!_memberView) {
        _memberView                 = [[GroupChatInfoMemberView alloc] init];
        _memberView.backgroundColor = [UIColor whiteColor];
    }
    return _memberView;
}
- (GroupChatInfoHeadView *)headView{
    if (!_headView) {
        _headView                   = [[GroupChatInfoHeadView alloc] init];
        _headView.backgroundColor   = [UIColor whiteColor];
    }
    return _headView;
}
- (UILabel *)autographLab{
    if (!_autographLab) {
        _autographLab                   = [[UILabel alloc] init];
        _autographLab.text              = @"  群签名";
        _autographLab.font              = [UIFont systemFontOfSize:14.f];
        _autographLab.backgroundColor   = [UIColor whiteColor];
    }
    return _autographLab;
}
- (UIButton *)autographBtn{
    if (!_autographBtn) {
        _autographBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_autographBtn setTitleColor:[UIColor ym_colorFromHexString:@"#666666"] forState:UIControlStateNormal];
        [_autographBtn setTitle:@"欢迎加入融合通信" forState:UIControlStateNormal];
        [_autographBtn.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [_autographBtn addTarget:self action:@selector(editGroupNoticeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _autographBtn;
}
- (UIButton *)clearAllBtn{
    if (!_clearAllBtn) {
        _clearAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearAllBtn setTitle:@"  清除聊天记录" forState:UIControlStateNormal];
        [_clearAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clearAllBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_clearAllBtn setBackgroundColor:[UIColor whiteColor]];
        [_clearAllBtn addTarget:self action:@selector(clearAllRecordAction) forControlEvents:UIControlEventTouchUpInside];
        _clearAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _clearAllBtn;
}
- (UIButton *)signOutBtn{
    if (!_signOutBtn) {
        _signOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signOutBtn setTitle:@"退出群聊" forState:UIControlStateNormal];
        [_signOutBtn setTitleColor:[UIColor ym_colorFromHexString:@"#666666"] forState:UIControlStateNormal];
        [_signOutBtn setBackgroundColor:[UIColor whiteColor]];
        _signOutBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return _signOutBtn;
}

@end
