//
//  ResetPasswordViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/13.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "Define.h"
#import "UIButton+timer.h"
#import "NSString+XY.h"
@interface ResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifiedCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UIButton *timerBtn;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navHeight.constant = kNavigationStatusHeight();
    
}

- (IBAction)setSecureModeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.passWordTextField.secureTextEntry = sender.selected;
}
- (IBAction)popSelfViewAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getVerificationCodeAction:(UIButton *)sender {
    
    if ([NSString phoneFormatCheck:self.accountTextField.text]) {
        [self.timerBtn startWithTime:10 title:@"获取验证码" countDownTitle:@"秒"];
    }else{
        [MBProgressHUD showTextMessage:@"请输入正确的手机号码！"];
    }
    
}
- (IBAction)changedPasswordAction:(id)sender {
    
}
@end
