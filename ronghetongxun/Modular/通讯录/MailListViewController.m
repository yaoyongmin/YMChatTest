//
//  MailListViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MailListViewController.h"
#import "LoginViewController.h"
#import "SocketModel.h"
#import "JoinMeetingPopupView.h"
@interface MailListViewController ()

@end

@implementation MailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[YMRequest sharedManager] postRequest:kGetUserMemeberList params:@{@"memberName":@"",@"pageNum":@(1),@"pageSize":@(10)} success:^(NSInteger code, NSString * _Nullable message, id  _Nullable data) {
//
//        NSLog(@"通讯录：%@",data);
//    } failure:^(NSError * _Nullable error) {
//
//    }];
    
    JoinMeetingPopupView *joinView = [[JoinMeetingPopupView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth(), kScreenHeight())];
    joinView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:joinView];
}

@end
