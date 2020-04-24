//
//  YMAlertViewCell.h
//  ronghetongxun
//
//  Created by yym on 2020/4/21.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMAlertModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YMAlertViewCell : UITableViewCell

@property (nonatomic, strong)UIButton *itemBtn;
@property (nonatomic, strong)UIView *lineView;

- (void)setData:(YMAlertModel *)model;

@end

NS_ASSUME_NONNULL_END
