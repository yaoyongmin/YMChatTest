//
//  UIButton+timer.h
//  ronghetongxun
//
//  Created by yym on 2020/4/15.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (timer)

/**
 *  倒计时按钮
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle;

@end

NS_ASSUME_NONNULL_END
