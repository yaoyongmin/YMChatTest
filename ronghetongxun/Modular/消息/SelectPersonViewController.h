//
//  SelectPersonViewController.h
//  ronghetongxun
//
//  Created by yym on 2020/4/13.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ foundGroupChatBlock)(id data);

@interface SelectPersonViewController : BaseViewController

/// 选择完成后 回调数据
@property (nonatomic, copy)foundGroupChatBlock foundBlock;

@end

NS_ASSUME_NONNULL_END
