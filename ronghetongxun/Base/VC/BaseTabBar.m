//
//  BaseTabBar.m
//  YeMai
//
//  Created by edz on 2020/1/17.
//  Copyright © 2020 jacob. All rights reserved.
//

#import "BaseTabBar.h"
#import <UIView+MJExtension.h>
@interface BaseTabBar()
/** 发布按钮 */
@property (nonatomic, strong) UIView *publishButton;
@property (nonatomic, weak) UILabel *label;

@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation BaseTabBar

- (void)layoutSubviews{
    [super layoutSubviews];
    Class class = NSClassFromString(@"UITabBarButton");
    int btnIndex = 0;
    for (UIView *btn in self.subviews){
        if ([btn isKindOfClass:class]) {
            if (btnIndex == 2) {
                self.imageView.frame = CGRectMake(5, -25, btn.mj_w - 10, btn.mj_h + 17);
                [btn insertSubview:self.imageView atIndex:0];
                self.publishButton = btn;
            }
            btnIndex++;
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
   if (self.isHidden == NO) {
       CGPoint newP = [self convertPoint:point toView:self.imageView];
       //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
       if ( [self.imageView pointInside:newP withEvent:event]) {
           return self.publishButton;
       }else{ //如果点不在发布按钮身上，直接让系统处理就可以了
           return [super hitTest:point withEvent:event];
       }
   }
   else {  //tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
       return [super hitTest:point withEvent:event];
   }
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabBar_publish_icon"]];
    }
    return _imageView;
}

@end
