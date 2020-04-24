//
//  BaseChatCell.h
//  ronghetongxun
//
//  Created by yym on 2020/4/22.
//  Copyright © 2020 DongDu Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICMessage.h"
#import "UIResponder+GXRouter.h"
@class BaseChatCell;

NS_ASSUME_NONNULL_BEGIN
@protocol BaseChatCellDelegate <NSObject>

///长按手势事件
- (void)longPress:(UILongPressGestureRecognizer *)longRecognizer;

@end

@interface BaseChatCell : UITableViewCell

@property (nonatomic, strong) ICMessage *messageModel;

@property (nonatomic, weak) id<BaseChatCellDelegate> longPressDelegate;

/// 长按手势
- (void)longPressRecognizer:(UILongPressGestureRecognizer *)recognizer;

/// 获取内容视图frame
- (UIView *)getContentView;

@end

NS_ASSUME_NONNULL_END
