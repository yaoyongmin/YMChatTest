//
//  YMAlertModel.h
//  ronghetongxun
//
//  Created by yym on 2020/4/21.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMAlertModel : NSObject

/// 显示的内容
@property(nonatomic, copy , nonnull) NSString *content;

/// 图片名
@property(nonatomic, copy) NSString *imageName;

/// 点击事件
@property(nonatomic, assign)SEL action;

///对齐方式
@property(nonatomic) UIControlContentHorizontalAlignment contentHorizontalAlignment;

@end

NS_ASSUME_NONNULL_END
