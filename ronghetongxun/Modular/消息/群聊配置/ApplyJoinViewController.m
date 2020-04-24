//
//  ApplyJoinViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/23.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ApplyJoinViewController.h"
#import "UIColor+YM.h"
@interface ApplyJoinViewController ()

@end

@implementation ApplyJoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人介绍";
    self.view.backgroundColor = [UIColor ym_colorFromHexString:@"#F7F8F9"];
    
    [self setNavigationItem:@"发送" imageName:@"" position:itemRight addTarget:self action:@selector(sendAction)];
    
    
}

- (void)sendAction{
    ///网络请求
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"发送申请！");
}

@end
