//
//  ChatViewController.h
//  ronghetongxun
//
//  Created by yym on 2020/4/21.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "YMGroup.h"
#import "YMUser.h"
#import "ICMessage.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ChatViewController : BaseViewController

@property (nonatomic, strong)YMGroup *group;

@end

NS_ASSUME_NONNULL_END
