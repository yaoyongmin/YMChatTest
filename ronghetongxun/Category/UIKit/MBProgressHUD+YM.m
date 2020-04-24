//
//  MBProgressHUD+YM.m
//  ronghetongxun
//
//  Created by yym on 2020/4/17.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "MBProgressHUD+YM.h"

@implementation MBProgressHUD (YM)

+(void)showTextMessage:(NSString *)message{
    [self MBProgressHUDWithTextMessage:message];
    return;
}

+(void)showError:(NSString *)message integer:(NSInteger )ErrorCode{
    
    NSString *Error = [NSString stringWithFormat:@"%@（%ld）",message,(long)ErrorCode];

    [self MBProgressHUDWithTextMessage:Error];
    return;
}

+ (void)showWaitMessage:(NSString *)message showView:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    [hud showAnimated:YES];
}

+(void)hideWaitViewAnimated:(UIView *)view{
    
//    [self hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    [self hideHUDForView:view animated:YES];
}

+(void)MBProgressHUDWithTextMessage:(NSString *)message {
    if ([UIApplication sharedApplication].keyWindow) {
         
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = message;
    hud.mode = MBProgressHUDModeText;
    
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
    
    return;
}



@end
