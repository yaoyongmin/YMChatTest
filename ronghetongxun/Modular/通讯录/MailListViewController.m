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
@interface MailListViewController ()

@end

@implementation MailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)testAction:(id)sender {
    
    [[SocketModel share] disConnect];

    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [[LoginViewController alloc]init]];
}


@end
