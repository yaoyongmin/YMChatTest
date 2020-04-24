//
//  MBProgressHUD+YM.h
//  ronghetongxun
//
//  Created by yym on 2020/4/17.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (YM)

///正在加载-不自动消失
+ (void)showWaitMessage:(NSString *)message showView:(UIView *)view;
///手动取消
+(void)hideWaitViewAnimated:(UIView *)view;

///定时提示窗 默认1.5秒
+(void)showTextMessage:(NSString *)message;
///错误信息
+(void)showError:(NSString *)message integer:(NSInteger )ErrorCode;

@end

NS_ASSUME_NONNULL_END
