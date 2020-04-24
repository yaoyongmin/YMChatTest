//
//  MessageMoreView.h
//  ronghetongxun
//
//  Created by yym on 2020/4/13.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageMoreView;
NS_ASSUME_NONNULL_BEGIN

@protocol MessageMoreViewDelegate <NSObject>

/// 更多菜单点击事件
/// @param moreView 当前视图
/// @param index 点击第几个按钮
- (void)messageMoreView:(MessageMoreView *)moreView didSelectRowAtIndex:(NSInteger)index;

@end

@interface MessageMoreView : UIView

@property (nonatomic,strong)UIView *moreView;

/// 显示视图
/// @param superView 父视图
- (void)show:(UIView *)superView;

/// 移除视图
- (void)dismiss;

@property (nonatomic, weak)id <MessageMoreViewDelegate>delegate;

///是否正在显示  getter修饰词 不会调用get方法
@property (nonatomic, assign ,readonly) BOOL isShowState;

@end

NS_ASSUME_NONNULL_END
