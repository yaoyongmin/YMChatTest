//
//  LoginViewController.m
//  ronghetongxun
//
//  Created by yym on 2020/4/13.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "RootTabBarController.h"
#import "ResetPasswordViewController.h"
#import "AppDelegate.h"
#import "UIColor+YM.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *secureModeBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.passwordTextField addTarget:self action:@selector(textFieldEditChanged:)forControlEvents:UIControlEventEditingChanged];
}

#pragma makr textFieldDelegate
- (BOOL)textFieldEditChanged:(UITextField *)textField{
    
    if (textField) {        
        if (textField.text.length >0) {
            [self.loginBtn setBackgroundColor:[UIColor ym_colorFromHexString:@"#3D8BEC"]];
        }else{
            [self.loginBtn setBackgroundColor:[UIColor ym_colorFromHexString:@"C6C6C8"]];
        }
    }
    return YES;
}


- (IBAction)setSecureModeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.passwordTextField.secureTextEntry = sender.selected;
}
- (IBAction)loginAction:(UIButton *)sender {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[RootTabBarController alloc]init];
}
- (IBAction)resetPassWordAction:(id)sender {
    
    [self.navigationController pushViewController:[[ResetPasswordViewController alloc]init] animated:YES];
}

@end
