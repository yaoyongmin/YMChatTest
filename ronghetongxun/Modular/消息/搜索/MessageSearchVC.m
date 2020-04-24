//
//  MessageSearchVC.m
//  ronghetongxun
//
//  Created by yym on 2020/4/14.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MessageSearchVC.h"
#import "UIColor+YM.h"

@interface MessageSearchVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MessageSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ym_colorFromHexString:@"F3F4F8"];
    
    [self.textField addTarget:self
                       action:@selector(textFieldEditChanged:)
             forControlEvents:UIControlEventEditingChanged];
    
}

#pragma makr textFieldDelegate
- (BOOL)textFieldEditChanged:(UITextField *)textField{
    
    NSLog(@"开始搜索：%@",textField.text);
    return YES;
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
