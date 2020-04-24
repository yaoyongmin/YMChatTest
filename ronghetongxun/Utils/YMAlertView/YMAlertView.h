//
//  YMAlertView.h
//  ronghetongxun
//
//  Created by yym on 2020/4/21.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMAlertModel.h"
@class YMAlertView;
NS_ASSUME_NONNULL_BEGIN

@protocol YMAlertViewDelegate <NSObject>

/// 点击代理方法
/// @param alertView 当前视图
/// @param action 点击事件
- (void)YMAlertView:(YMAlertView *)alertView didSelectRowAtSEL:(SEL)action;

- (void)YMAlertViewClickCancelAction:(YMAlertView *)alertView;

@end
@interface YMAlertView : UIView

/// 内容列表
@property(nonatomic, strong) NSArray <YMAlertModel *>* dataList;
/// 标题
@property(nonatomic, copy) NSString *alertTitle;

@property (nonatomic, weak)id <YMAlertViewDelegate> delegate;

/// 初始化方法
/// @param title 标题
/// @param list 内容列表
+ (instancetype)alertControllerWithTitle:(NSString *)title
                                dataList:(NSArray <YMAlertModel *>*)list;

- (void)show;

-(void)show:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
