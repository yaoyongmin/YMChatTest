//
//  MeetingController.m
//  ronghetongxun
//
//  Created by yym on 2020/5/6.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MeetingController.h"
#import "AlreadyJoinedViewController.h"
#import "NotJoinedViewController.h"
#import "SecretKeyView.h"
#import "UIColor+YM.h"
#import <Masonry.h>
@interface MeetingController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *alreadyBtn;
@property (nonatomic, strong) UIButton *notBtn;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *allMuteBtn;

@property (nonatomic, strong)AlreadyJoinedViewController *alreadyJoinVC;
@property (nonatomic, strong)NotJoinedViewController *notJoinVC;

@end

@implementation MeetingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ym_colorFromHexString:@"F7F8F9"];
    
    [self setNavigationItemWithView:[self rightView] position:itemRight];
    
    [self.view addSubview:self.alreadyBtn];
    [self.view addSubview:self.notBtn];
    [self.view addSubview:self.bottomLineView];
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.addBtn];
    [self.view addSubview:self.allMuteBtn];
    [self addChildViewController:self.alreadyJoinVC];
    [self.mainScrollView addSubview:self.alreadyJoinVC.view];
    [self addChildViewController:self.notJoinVC];
    [self.mainScrollView addSubview:self.notJoinVC.view];
    
    [self.alreadyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(@43);
    }];
    [self.notBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(@43);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alreadyBtn.mas_bottom);
        make.height.mas_equalTo(@1.5);
        make.width.mas_equalTo(@45);
        make.leading.mas_equalTo(kScreenWidth()/4 - (45/2));
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(@45);
    }];
    [self.allMuteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(@45);
    }];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomLineView.mas_bottom).inset(2);
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.bottom.mas_equalTo(self.addBtn.mas_top);
        make.trailing.mas_equalTo(self.notJoinVC.view.mas_trailing);
    }];
    
    [self.alreadyJoinVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.mainScrollView.mas_leading);
        make.top.mas_equalTo(self.bottomLineView.mas_bottom).inset(2);
        make.width.mas_equalTo(kScreenWidth());
        make.bottom.mas_equalTo(self.addBtn.mas_top);
    }];
    [self.notJoinVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.alreadyJoinVC.view.mas_trailing);
        make.top.mas_equalTo(self.bottomLineView.mas_bottom).inset(2);
        make.width.mas_equalTo(kScreenWidth());
        make.bottom.mas_equalTo(self.addBtn.mas_top);
    }];
}

#pragma mark 顶部button点击事件
- (void)topButtonClickEvent:(UIButton *)sender{
    
    if (self.alreadyBtn == sender) {
        self.notBtn.selected = NO;
        self.alreadyBtn.selected = YES;
    }else{
        self.alreadyBtn.selected = NO;
        self.notBtn.selected = YES;
    }
    
    [self.mainScrollView setContentOffset:CGPointMake(sender.frame.origin.x*2, 0) animated:YES];
}
- (void)showSecretKeyView:(UIButton *)sender{
    
    SecretKeyView *keyView = [[SecretKeyView alloc] initWithFrame:self.view.bounds];
    
    [keyView show:self.view];
}

#pragma mark 底部button点击事件
- (void)bottomButtonClickEvent:(UIButton *)sender{
    
    NSLog(@"点击底部按钮！");
}

#pragma mark scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == kScreenWidth()) {
        self.notBtn.selected = YES;
        self.alreadyBtn.selected = NO;
    }else if(scrollView.contentOffset.x == 0){
        self.alreadyBtn.selected = YES;
        self.notBtn.selected = NO;
    }else{}
    [self.bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(scrollView.contentOffset.x/2 + kScreenWidth()/4 - (45/2));
    }];
}

- (UIView *)rightView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
    UIButton *allowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allowBtn setFrame:CGRectMake(0, 15, 60, 14)];
    [allowBtn setTitle:@"允许加入" forState:UIControlStateNormal];
    [allowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allowBtn.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    [allowBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(130/2, 14.5, 1, 15)];
    lineView.backgroundColor = [UIColor whiteColor];
    UIButton *passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordBtn setFrame:CGRectMake(130-50, 15, 50, 14)];
    [passwordBtn setTitle:@"入会口令" forState:UIControlStateNormal];
    [passwordBtn addTarget:self action:@selector(showSecretKeyView:) forControlEvents:UIControlEventTouchUpInside];
    [passwordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [passwordBtn.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    [passwordBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [view addSubview:allowBtn];
    [view addSubview:lineView];
    [view addSubview:passwordBtn];
    return view;
}

- (UIButton *)alreadyBtn{
    if (!_alreadyBtn) {
        _alreadyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alreadyBtn setTitle:@"已入会" forState:UIControlStateNormal];
        [_alreadyBtn setTitleColor:[UIColor ym_colorFromHexString:@"#3D8BEC"] forState:UIControlStateSelected];
        [_alreadyBtn setTitleColor:[UIColor ym_colorFromHexString:@"#666666"] forState:UIControlStateNormal];
        [_alreadyBtn setBackgroundColor:[UIColor whiteColor]];
        [_alreadyBtn addTarget:self action:@selector(topButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_alreadyBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        _alreadyBtn.selected = YES;
    }
    return _alreadyBtn;
}
- (UIButton *)notBtn{
    if (!_notBtn) {
        _notBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_notBtn setTitle:@"未入会" forState:UIControlStateNormal];
        [_notBtn setTitleColor:[UIColor ym_colorFromHexString:@"#3D8BEC"] forState:UIControlStateSelected];
        [_notBtn setTitleColor:[UIColor ym_colorFromHexString:@"#666666"] forState:UIControlStateNormal];
        [_notBtn setBackgroundColor:[UIColor whiteColor]];
        [_notBtn addTarget:self action:@selector(topButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_notBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    }
    return _notBtn;
}
- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor ym_colorFromHexString:@"#3D8BEC"];
    }
    return _bottomLineView;
}
- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}
- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"添加会议成员" forState:UIControlStateNormal];
        [_addBtn setBackgroundColor:[UIColor ym_colorFromHexString:@"#4C99F5"]];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(topButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    }
    return _addBtn;
}
- (UIButton *)allMuteBtn{
    if (!_allMuteBtn) {
        _allMuteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allMuteBtn setTitle:@"全员静音" forState:UIControlStateNormal];
        [_allMuteBtn setBackgroundColor:[UIColor ym_colorFromHexString:@"#ABC6F9"]];
        [_allMuteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_allMuteBtn addTarget:self action:@selector(topButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_allMuteBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    }
    return _allMuteBtn;
}

- (AlreadyJoinedViewController *)alreadyJoinVC{
    if (!_alreadyJoinVC) {
        _alreadyJoinVC = [[AlreadyJoinedViewController alloc] init];
    }
    return _alreadyJoinVC;
}
- (NotJoinedViewController *)notJoinVC{
    if (!_notJoinVC) {
        _notJoinVC = [[NotJoinedViewController alloc] init];
    }
    return _notJoinVC;
}
@end
