//
//  UIView+RoundedBorder.m
//  ronghetongxun
//
//  Created by yym on 2020/4/29.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "UIView+RoundedBorder.h"

@implementation UIView (RoundedBorder)

- (void)setRoundedWithBorder{
    ///阴影圆角共存
    self.clipsToBounds = NO;
    self.layer.cornerRadius = 5.f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1,1);
    self.layer.shadowRadius = 4;
    self.layer.shadowOpacity = 0.2;
}
@end
