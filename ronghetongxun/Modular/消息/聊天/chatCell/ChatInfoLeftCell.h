//
//  ChatInfoLeftCell.h
//  ronghetongxun
//
//  Created by yym on 2020/4/16.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import "BaseChatCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChatInfoLeftCell : BaseChatCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@end

NS_ASSUME_NONNULL_END
