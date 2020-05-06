//
//  BaseTabBar.m
//  YeMai
//
//  Created by edz on 2020/1/17.
//  Copyright © 2020 jacob. All rights reserved.
//

#import "BaseTabBar.h"
#import <UIView+MJExtension.h>
#import "UIColor+YM.h"
@interface BaseTabBar()
/** 发布按钮 */
@property (nonatomic, strong) UIView *publishButton;
@property (nonatomic, weak) UILabel *label;

@property (nonatomic, strong) UIView *whiteBackGroupView;
@property (nonatomic, strong) UIView *blueBackGroupView;
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
                self.whiteBackGroupView.frame = CGRectMake((btn.mj_w - (btn.mj_h+20)) /2, -27, btn.mj_h + 20, btn.mj_h + 20);
                self.whiteBackGroupView.layer.cornerRadius = (btn.mj_h + 20)/2;
                self.blueBackGroupView.frame = CGRectMake((self.whiteBackGroupView.mj_w-45) /2, 7, 45, 45);
                self.imageView.frame = CGRectMake((self.blueBackGroupView.mj_w - 20) / 2 , 13, 20, 20);
                
                [btn insertSubview:self.whiteBackGroupView atIndex:0];
                self.publishButton = btn;
            }
            btnIndex++;
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
   if (self.isHidden == NO) {
       CGPoint newP = [self convertPoint:point toView:self.whiteBackGroupView];
       //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
       if ( [self.whiteBackGroupView pointInside:newP withEvent:event]) {
           return self.publishButton;
       }else{ //如果点不在发布按钮身上，直接让系统处理就可以了
           return [super hitTest:point withEvent:event];
       }
   }
   else {  //tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
       return [super hitTest:point withEvent:event];
   }
}

- (UIView *)whiteBackGroupView{
    if (!_whiteBackGroupView) {
        _whiteBackGroupView = [[UIView alloc] init];
        _whiteBackGroupView.backgroundColor = [UIColor whiteColor];
        _whiteBackGroupView.layer.masksToBounds = YES;
        _whiteBackGroupView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _whiteBackGroupView.layer.shadowOffset = CGSizeMake(0, -1);
        _whiteBackGroupView.layer.shadowOpacity = 0.6;
        [_whiteBackGroupView addSubview:self.blueBackGroupView];
    }
    return _whiteBackGroupView;
}

- (UIView *)blueBackGroupView{
    if (!_blueBackGroupView) {
        _blueBackGroupView = [[UIView alloc] init];
        _blueBackGroupView.backgroundColor = [UIColor ym_colorFromHexString:@"#3D8BEC"];
        _blueBackGroupView.layer.masksToBounds = YES;
        _blueBackGroupView.layer.cornerRadius = 22.5;
        [_blueBackGroupView addSubview:self.imageView];
    }
    return _blueBackGroupView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_tabbar_maillist"]];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

@end
