//
//  BaseViewController.h
//  ronghetongxun
//
//  Created by yym on 2020/4/10.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
typedef NS_ENUM(NSInteger,ItemPosition){
    itemLeft = 0,
    itemRight = 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

- (void)setNavigationItem:(NSString *)title imageName:(NSString *)name position:(ItemPosition)position addTarget:(nullable id)target action:(SEL)action ;

- (void)setNavigationItemWithButton:(UIButton *)button position:(ItemPosition)position;

@end

NS_ASSUME_NONNULL_END
